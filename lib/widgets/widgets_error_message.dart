import 'package:ayletna_restaurant_app/core/core_colors.dart';
import 'package:ayletna_restaurant_app/core/core_typography.dart';
import 'package:flutter/material.dart';

/// Financial / validation errors — selectable red text (project rules).
class WidgetsErrorMessage extends StatelessWidget {
  const WidgetsErrorMessage({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: message,
        style: CoreTypography.bodyMedium(context, CoreColors.semanticError),
      ),
    );
  }
}
