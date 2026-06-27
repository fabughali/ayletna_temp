import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Unified text/search/amount/lookup field.
class WidgetsAppTextField extends StatelessWidget {
  const WidgetsAppTextField({
    required this.label,
    this.controller,
    this.initialValue,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.showLabel = true,
    this.textDirection,
    this.maxLines = 1,
    this.focusNode,
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool obscureText;
  final bool showLabel;
  final TextDirection? textDirection;
  final int maxLines;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      readOnly: readOnly,
      showCursor: true,
      enableInteractiveSelection: true,
      obscureText: obscureText,
      textDirection: textDirection,
      maxLines: maxLines,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      decoration: CoreDecorations.input(
        context,
        label: label,
        icon: prefixIcon,
      ).copyWith(
        labelText: showLabel ? label : null,
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
