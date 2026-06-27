import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';
import 'package:virtual_keypad/virtual_keypad.dart';

const double _textKeypadHeight = 280;
const double _compactNumericKeypadHeight = 200;

/// Wraps cashier content with [VirtualKeypadScope] and a floating on-screen keyboard.
class CashierVirtualKeypadShell extends StatelessWidget {
  const CashierVirtualKeypadShell({
    super.key,
    required this.isAr,
    required this.child,
  });

  final bool isAr;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return VirtualKeypadScope(
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          Align(
            alignment: Alignment.bottomCenter,
            child: CashierVirtualKeypadPanel(isAr: isAr),
          ),
        ],
      ),
    );
  }
}

/// Floating on-screen keyboard strip for cashier touch POS.
class CashierVirtualKeypadPanel extends StatefulWidget {
  const CashierVirtualKeypadPanel({
    super.key,
    required this.isAr,
    this.height = _textKeypadHeight,
  });

  final bool isAr;
  final double height;

  @override
  State<CashierVirtualKeypadPanel> createState() =>
      _CashierVirtualKeypadPanelState();
}

class _CashierVirtualKeypadPanelState extends State<CashierVirtualKeypadPanel> {
  VirtualKeypadScopeState? _scope;
  bool _keyboardVisible = false;
  late String _keyboardLanguage;
  String? _languageBeforeNumeric;

  @override
  void initState() {
    super.initState();
    _keyboardLanguage = widget.isAr ? 'ar' : 'en';
    KeyboardLayoutProvider.instance.addListener(_onLanguageChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scope = VirtualKeypadScope.of(context);
    if (_scope != scope) {
      _scope?.removeActiveControllerListener(_onActiveFieldChanged);
      _scope = scope;
      _scope?.addActiveControllerListener(_onActiveFieldChanged);
      _syncNumericLanguage(force: true);
    }
  }

  @override
  void dispose() {
    _scope?.removeActiveControllerListener(_onActiveFieldChanged);
    KeyboardLayoutProvider.instance.removeListener(_onLanguageChanged);
    super.dispose();
  }

  bool get _isNumericField =>
      isCashierNumericKeyboardType(_scope?.activeKeyboardType);

  double get _keypadHeight =>
      _isNumericField ? _compactNumericKeypadHeight : widget.height;

  void _onLanguageChanged() {
    if (!mounted || _isNumericField) return;
    final code = KeyboardLayoutProvider.instance.currentLanguageCode;
    if (code != _keyboardLanguage) {
      setState(() => _keyboardLanguage = code);
    }
  }

  void _onActiveFieldChanged() {
    _syncNumericLanguage(force: false);
    if (mounted) setState(() {});
  }

  void _syncNumericLanguage({required bool force}) {
    if (_isNumericField) {
      _languageBeforeNumeric ??=
          KeyboardLayoutProvider.instance.currentLanguageCode;
      if (force ||
          KeyboardLayoutProvider.instance.currentLanguageCode != 'en') {
        KeyboardLayoutProvider.instance.setLanguage('en', userInitiated: false);
      }
      if (mounted) setState(() => _keyboardLanguage = 'en');
      return;
    }

    if (_languageBeforeNumeric != null) {
      final restore = _languageBeforeNumeric!;
      _languageBeforeNumeric = null;
      KeyboardLayoutProvider.instance.setLanguage(
        restore,
        userInitiated:
            KeyboardLayoutProvider.instance.hasExplicitLanguageSelection,
      );
      if (mounted) setState(() => _keyboardLanguage = restore);
    }
  }

  void _selectLanguage(String code) {
    if (code == _keyboardLanguage || _isNumericField) return;
    KeyboardLayoutProvider.instance.setLanguage(code, userInitiated: true);
    setState(() => _keyboardLanguage = code);
  }

  VirtualKeypadTheme _theme(BuildContext context, {required bool compact}) {
    final scheme = Theme.of(context).colorScheme;
    return VirtualKeypadTheme(
      backgroundColor: scheme.surfaceContainerHighest,
      keyColor: scheme.surface,
      actionKeyColor: scheme.surfaceContainerHigh,
      keyTextColor: scheme.onSurface,
      keyBorderRadius: CoreSpacing.radiusButton,
      keyTextSize: compact ? 22 : 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final showLanguageBar = _keyboardVisible && !_isNumericField;

    return IgnorePointer(
      ignoring: !_keyboardVisible,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _keyboardVisible ? 1 : 0,
        child: Material(
          elevation: _keyboardVisible ? 16 : 0,
          color: scheme.surface,
          shadowColor: scheme.shadow.withValues(alpha: 0.28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showLanguageBar)
                TextFieldTapRegion(
                  child: _CashierKeyboardLanguageBar(
                    selectedCode: _keyboardLanguage,
                    onSelected: _selectLanguage,
                  ),
                ),
              VirtualKeypad(
                availableLanguages:
                    _isNumericField ? const ['en'] : const ['en', 'ar'],
                initialLanguage:
                    _isNumericField ? 'en' : (widget.isAr ? 'ar' : 'en'),
                onLanguageChanged: (code) {
                  if (!_isNumericField) {
                    setState(() => _keyboardLanguage = code);
                  }
                },
                hideWhenUnfocused: true,
                onVisibilityChanged: (visible) {
                  if (_keyboardVisible != visible) {
                    setState(() => _keyboardVisible = visible);
                  }
                },
                theme: _theme(context, compact: _isNumericField),
                height: _keypadHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CashierKeyboardLanguageBar extends StatelessWidget {
  const _CashierKeyboardLanguageBar({
    required this.selectedCode,
    required this.onSelected,
  });

  final String selectedCode;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerHighest,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: CoreSpacing.md(context),
          vertical: CoreSpacing.xs(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LanguageChip(
              label: 'English',
              selected: selectedCode == 'en',
              onTap: () => onSelected('en'),
            ),
            SizedBox(width: CoreSpacing.sm(context)),
            _LanguageChip(
              label: 'العربية',
              selected: selectedCode == 'ar',
              onTap: () => onSelected('ar'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: selected ? scheme.primary : scheme.surface,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
      child: InkWell(
        onTap: onTap,
        canRequestFocus: false,
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CoreSpacing.md(context),
            vertical: CoreSpacing.xs(context),
          ),
          child: Text(
            label,
            style: CoreTypography.bodyMedium(
              context,
              selected ? scheme.onPrimary : scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}

bool isCashierNumericKeyboardType(KeyboardType? type) {
  return switch (type) {
    KeyboardType.number ||
    KeyboardType.numberSigned ||
    KeyboardType.numberDecimal ||
    KeyboardType.phone ||
    KeyboardType.datetime => true,
    _ => false,
  };
}

KeyboardType cashierKeyboardType(TextInputType? type) {
  if (type == null) return KeyboardType.text;
  if (type == TextInputType.text) return KeyboardType.text;
  if (type == TextInputType.multiline) return KeyboardType.multiline;
  if (type == TextInputType.number) return KeyboardType.number;
  if (type == const TextInputType.numberWithOptions(signed: true)) {
    return KeyboardType.numberSigned;
  }
  if (type == const TextInputType.numberWithOptions(decimal: true)) {
    return KeyboardType.numberDecimal;
  }
  if (type == TextInputType.phone) return KeyboardType.phone;
  if (type == TextInputType.datetime) return KeyboardType.datetime;
  if (type == TextInputType.emailAddress) return KeyboardType.emailAddress;
  if (type == TextInputType.url) return KeyboardType.url;
  if (type == TextInputType.visiblePassword) {
    return KeyboardType.visiblePassword;
  }
  if (type == TextInputType.name) return KeyboardType.name;
  if (type == TextInputType.streetAddress) return KeyboardType.streetAddress;
  if (type == TextInputType.none) return KeyboardType.none;
  return KeyboardType.text;
}

/// Touch field wired to [VirtualKeypadScope]. Requires [VirtualKeypadController].
class CashierTouchTextField extends StatelessWidget {
  const CashierTouchTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.textInputAction,
    this.textDirection,
    this.onChanged,
    this.onSubmitted,
    this.onInputAction,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final void Function(KeyAction action, String text)? onInputAction;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    assert(
      controller is VirtualKeypadController,
      'CashierTouchTextField requires a VirtualKeypadController.',
    );
    final keypadController = controller as VirtualKeypadController;

    final field = VirtualKeypadTextField(
      controller: keypadController,
      keyboardType: cashierKeyboardType(keyboardType),
      textInputAction: textInputAction,
      maxLines: maxLines,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onInputAction: onInputAction,
      decoration: CoreDecorations.input(
        context,
        label: label,
        icon: prefixIcon,
      ).copyWith(labelText: label, hintText: hintText),
    );

    if (textDirection == null) return field;
    return Directionality(textDirection: textDirection!, child: field);
  }
}
