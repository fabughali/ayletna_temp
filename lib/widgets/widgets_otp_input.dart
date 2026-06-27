import 'package:ayletna_restaurant_app/core/core_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Six-digit OTP fields.
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

  void _onChanged(int index, String value) {
    if (value.length == 1 && index < _length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    final code = _controllers.map((c) => c.text).join();
    if (code.length == _length) {
      widget.onCompleted(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gap = CoreSpacing.sm(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_length, (i) {
        return Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: i == 0 ? 0 : gap / 2,
              end: i == _length - 1 ? 0 : gap / 2,
            ),
            child: TextField(
              controller: _controllers[i],
              focusNode: _focusNodes[i],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(counterText: ''),
              onChanged: (v) => _onChanged(i, v),
            ),
          ),
        );
      }),
    );
  }
}
