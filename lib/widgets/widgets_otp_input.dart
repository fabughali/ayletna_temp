import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Six-digit OTP fields — each cell is a strict 1:1 square.
///
/// Typing a digit advances focus to the next cell. Completing all six digits
/// calls [onCompleted] once.
class WidgetsOtpInput extends StatefulWidget {
  const WidgetsOtpInput({required this.onCompleted, super.key});

  final ValueChanged<String> onCompleted;

  @override
  State<WidgetsOtpInput> createState() => _WidgetsOtpInputState();
}

class _WidgetsOtpInputState extends State<WidgetsOtpInput> {
  static const _length = 6;

  final _controllers = List.generate(_length, (_) => TextEditingController());
  final _focusNodes = List.generate(_length, (_) => FocusNode());
  bool _mutating = false;
  String? _lastCompleted;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNodes.first.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _setControllerText(int index, String text) {
    _mutating = true;
    _controllers[index].value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
    _mutating = false;
  }

  void _onChanged(int index, String value) {
    if (_mutating) {
      return;
    }

    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length > 1) {
      _distributeDigits(index, digitsOnly);
      return;
    }

    if (digitsOnly != value) {
      _setControllerText(index, digitsOnly);
    }

    if (digitsOnly.length == 1 && index < _length - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    _emitIfComplete();
  }

  void _distributeDigits(int startIndex, String digits) {
    final capped = digits.length > _length - startIndex
        ? digits.substring(0, _length - startIndex)
        : digits;
    for (var i = 0; i < capped.length; i++) {
      _setControllerText(startIndex + i, capped[i]);
    }
    final nextIndex = startIndex + capped.length;
    if (nextIndex >= _length) {
      _focusNodes[_length - 1].unfocus();
    } else {
      _focusNodes[nextIndex].requestFocus();
    }
    _emitIfComplete();
  }

  void _emitIfComplete() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length != _length || _controllers.any((c) => c.text.isEmpty)) {
      _lastCompleted = null;
      return;
    }
    if (_lastCompleted == code) {
      return;
    }
    _lastCompleted = code;
    widget.onCompleted(code);
  }

  void _onBackspace(int index) {
    if (index <= 0) {
      return;
    }
    _focusNodes[index - 1].requestFocus();
    _setControllerText(index - 1, '');
    _lastCompleted = null;
  }

  double _gapForWidth(BuildContext context, double maxWidth, double cellWidth) {
    if (cellWidth >= CoreOtpStyle.cellSizeOf(context)) {
      return CoreSpacing.sm(context);
    }
    return CoreSpacing.xs(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final idealCell = CoreOtpStyle.cellSizeOf(context);

        if (!maxWidth.isFinite || maxWidth <= 0) {
          return _OtpRow(
            cellWidth: idealCell,
            gap: CoreSpacing.xs(context),
            controllers: _controllers,
            focusNodes: _focusNodes,
            onChanged: _onChanged,
            onBackspace: _onBackspace,
          );
        }

        var gap = _gapForWidth(context, maxWidth, idealCell);
        var cellWidth = (maxWidth - gap * (_length - 1)) / _length;

        if (cellWidth > idealCell) {
          cellWidth = idealCell;
          gap = _gapForWidth(context, maxWidth, cellWidth);
          cellWidth = (maxWidth - gap * (_length - 1)) / _length;
        }

        cellWidth = cellWidth.clamp(28.0, idealCell).toDouble();

        return _OtpRow(
          cellWidth: cellWidth,
          gap: gap,
          controllers: _controllers,
          focusNodes: _focusNodes,
          onChanged: _onChanged,
          onBackspace: _onBackspace,
        );
      },
    );
  }
}

class _OtpRow extends StatelessWidget {
  const _OtpRow({
    required this.cellWidth,
    required this.gap,
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
    required this.onBackspace,
  });

  final double cellWidth;
  final double gap;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final void Function(int index, String value) onChanged;
  final void Function(int index) onBackspace;

  static const _length = 6;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_length, (index) {
        return Padding(
          padding: EdgeInsets.only(
            right: index == _length - 1 ? 0 : gap,
          ),
          child: SizedBox(
            width: cellWidth,
            child: AspectRatio(
              aspectRatio: 1,
              child: _OtpCell(
                index: index,
                controller: controllers[index],
                focusNode: focusNodes[index],
                onChanged: (value) => onChanged(index, value),
                onBackspace: () => onBackspace(index),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _OtpCell extends StatefulWidget {
  const _OtpCell({
    required this.index,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onBackspace,
  });

  final int index;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspace;

  @override
  State<_OtpCell> createState() => _OtpCellState();
}

class _OtpCellState extends State<_OtpCell> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChanged);
    widget.controller.addListener(_handleTextChanged);
  }

  @override
  void didUpdateWidget(covariant _OtpCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      oldWidget.focusNode.removeListener(_onFocusChanged);
      widget.focusNode.addListener(_onFocusChanged);
    }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_handleTextChanged);
      widget.controller.addListener(_handleTextChanged);
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChanged);
    widget.controller.removeListener(_handleTextChanged);
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {});
    if (widget.focusNode.hasFocus && widget.controller.text.isNotEmpty) {
      widget.controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: widget.controller.text.length,
      );
    }
  }

  void _handleTextChanged() {
    widget.onChanged(widget.controller.text);
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    if (event.logicalKey == LogicalKeyboardKey.backspace &&
        widget.controller.text.isEmpty) {
      widget.onBackspace();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final inputTheme = Theme.of(context).inputDecorationTheme;
    final focused = widget.focusNode.hasFocus;
    final borderSide =
        focused
            ? BorderSide(
                color: scheme.primary,
                width: UtilitySizer.of(context, 2),
              )
            : BorderSide(color: scheme.outline.withValues(alpha: 0.55));

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth;
        final fontSize = (size * 0.46).clamp(16.0, 27.0);
        final digitStyle = CoreTypography.headlineSmall(
          context,
          scheme.onSurface,
        ).copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          height: 1,
          letterSpacing: 0,
        );

        return DecoratedBox(
          decoration: BoxDecoration(
            color: inputTheme.fillColor,
            borderRadius: BorderRadius.circular(CoreSpacing.radiusInputOf(context)),
            border: Border.fromBorderSide(borderSide),
          ),
          child: GestureDetector(
            onTap: widget.focusNode.requestFocus,
            behavior: HitTestBehavior.opaque,
            child: Focus(
              onKeyEvent: _handleKey,
              child: SizedBox(
                width: size,
                height: size,
                child: Center(
                  child: EditableText(
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    style: digitStyle,
                    cursorColor: scheme.primary,
                    backgroundCursorColor: scheme.onSurface.withValues(
                      alpha: 0.15,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      // Allow paste of a full code; [_onChanged] keeps one digit
                      // per cell and advances focus.
                      LengthLimitingTextInputFormatter(6),
                    ],
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    maxLines: 1,
                    enableInteractiveSelection: false,
                    spellCheckConfiguration:
                        const SpellCheckConfiguration.disabled(),
                    selectionControls: materialTextSelectionControls,
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
