import 'package:ayletna_restaurant_app/core/app_config.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_demo_mode_banner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Primary action on demo / ops screens — shows info feedback instead of fake success.
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
    final l10n = AppLocalizations.of(context)!;
    final path = GoRouterState.of(context).uri.path;
    final isDemo =
        AppConfig.demoModeEnabled && WidgetsDemoModeBanner.showsForPath(path);
    final displayLabel = isDemo ? '$label · ${l10n.demoActionTag}' : label;

    return WidgetsAppButton(
      label: displayLabel,
      icon: icon,
      variant: isDemo ? WidgetsAppButtonVariant.outline : variant,
      fullWidth: fullWidth,
      onPressed:
          enabled
              ? () {
                if (isDemo) {
                  UtilityMockFeedback.showInfo(context, l10n.demoModeBanner);
                  return;
                }
                UtilityMockFeedback.showSuccess(context, message);
                onAfterAction?.call();
              }
              : null,
    );
  }
}
