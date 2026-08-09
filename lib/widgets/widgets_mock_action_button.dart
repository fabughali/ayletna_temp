import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:flutter/material.dart';

/// Primary action button with success feedback (works with in-memory or API).
class WidgetsMockActionButton extends StatelessWidget {
  const WidgetsMockActionButton({
    required this.label,
    required this.message,
    this.icon,
    this.variant = WidgetsAppButtonVariant.primary,
    this.fullWidth = true,
    this.enabled = true,
    this.onAfterAction,
    super.key,
  });

  final String label;
  final String message;
  final IconData? icon;
  final WidgetsAppButtonVariant variant;
  final bool fullWidth;
  final bool enabled;
  final VoidCallback? onAfterAction;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppButton(
      label: label,
      icon: icon,
      variant: variant,
      fullWidth: fullWidth,
      onPressed:
          enabled
              ? () {
                UtilityMockFeedback.showSuccess(context, message);
                onAfterAction?.call();
              }
              : null,
    );
  }
}
