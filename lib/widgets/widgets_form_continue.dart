import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Form field + continue CTA (checkout flow screens).
class WidgetsFormContinue extends StatelessWidget {
  const WidgetsFormContinue({
    required this.field,
    required this.continueLabel,
    required this.nextRoute,
    super.key,
  });

  final Widget field;
  final String continueLabel;
  final String nextRoute;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        field,
        SizedBox(height: CoreSpacing.xl(context)),
        WidgetsButton(
          label: continueLabel,
          onPressed: () => context.push(nextRoute),
        ),
      ],
    );
  }
}
