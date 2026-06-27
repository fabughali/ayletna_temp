import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:flutter/material.dart';

/// Primary / filled CTA — styling from theme only.
class WidgetsButton extends StatelessWidget {
  const WidgetsButton({
    required this.label,
    required this.onPressed,
    this.icon,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppButton(label: label, onPressed: onPressed, icon: icon);
  }
}
