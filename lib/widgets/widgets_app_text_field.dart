import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Unified text/search/amount/lookup field.
///
/// Single-line fields share [CoreThemeExtensions.buttonMinHeight] with
/// [WidgetsAppButton] / [WidgetsIconButton] so side-by-side rows align.
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
    this.minLines,
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
  /// When set with [maxLines] > 1, the field starts at this height and grows.
  final int? minLines;
  final int maxLines;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    // Single-line fields lock to the shared control height (matches buttons).
    // Multiline keeps a min first-row height but may grow with content.
    final isSingleLine = maxLines == 1;
    final matchControlHeight = isSingleLine || (minLines ?? 1) == 1;
    final controlH = context.coreTheme.buttonMinHeight;

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
      minLines: minLines,
      maxLines: maxLines,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      style: CoreTypography.bodyMedium(
        context,
        Theme.of(context).colorScheme.onSurface,
      ),
      decoration: CoreDecorations.input(
        context,
        label: label,
        icon: prefixIcon,
        showLabel: showLabel,
        matchControlHeight: matchControlHeight,
      ).copyWith(
        labelText: showLabel ? label : null,
        hintText: hintText,
        suffixIcon: suffixIcon,
        // Lock single-line outline height so suffix icons (e.g. password
        // visibility) cannot stretch one field above another.
        constraints:
            isSingleLine
                ? BoxConstraints(minHeight: controlH, maxHeight: controlH)
                : matchControlHeight
                ? BoxConstraints(minHeight: controlH)
                : null,
        // Default Material prefix/suffix icon slots are 48px and force the
        // field taller than the sizer-scaled [buttonMinHeight] (~44 on phone).
        prefixIconConstraints:
            prefixIcon != null && matchControlHeight
                ? BoxConstraints.tightFor(width: controlH, height: controlH)
                : null,
        suffixIconConstraints:
            suffixIcon != null && matchControlHeight
                ? BoxConstraints.tightFor(width: controlH, height: controlH)
                : null,
      ),
    );
  }
}
