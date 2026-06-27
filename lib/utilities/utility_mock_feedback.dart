import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:flutter/material.dart';

/// Front-end-only feedback helpers for mock flows.
abstract final class UtilityMockFeedback {
  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(context, message, Icons.check_circle_outline);
  }

  static void showInfo(BuildContext context, String message) {
    _showSnackBar(context, message, Icons.info_outline);
  }

  static void showWarning(BuildContext context, String message) {
    _showSnackBar(context, message, Icons.warning_amber_outlined);
  }

  static void showError(BuildContext context, String message) {
    _showSnackBar(context, message, Icons.error_outline);
  }

  static Future<bool> confirm({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    WidgetsAppButtonVariant confirmVariant = WidgetsAppButtonVariant.primary,
    IconData icon = Icons.help_outline,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final scheme = Theme.of(dialogContext).colorScheme;

        return AlertDialog(
          backgroundColor: scheme.surface,
          surfaceTintColor: scheme.surfaceTint,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
          ),
          icon: Icon(icon, color: scheme.primary),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: CoreTypography.headlineSmall(
              dialogContext,
              scheme.onSurface,
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: CoreTypography.bodyMedium(
              dialogContext,
              scheme.onSurfaceVariant,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            WidgetsAppButton(
              label: cancelLabel,
              onPressed: () => Navigator.of(dialogContext).pop(false),
              variant: WidgetsAppButtonVariant.ghost,
            ),
            WidgetsAppButton(
              label: confirmLabel,
              onPressed: () => Navigator.of(dialogContext).pop(true),
              variant: confirmVariant,
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  static Future<void> showActionSheet({
    required BuildContext context,
    required String title,
    required String message,
    required List<MockSheetAction> actions,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        final scheme = Theme.of(sheetContext).colorScheme;

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              CoreSpacing.lg(sheetContext),
              CoreSpacing.sm(sheetContext),
              CoreSpacing.lg(sheetContext),
              CoreSpacing.lg(sheetContext),
            ),
            child: WidgetsAppCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: CoreTypography.headlineSmall(
                            sheetContext,
                            scheme.onSurface,
                          ),
                        ),
                      ),
                      WidgetsIconButton(
                        onPressed: () => Navigator.of(sheetContext).pop(),
                        icon: Icons.close,
                        tooltip:
                            MaterialLocalizations.of(
                              sheetContext,
                            ).closeButtonTooltip,
                      ),
                    ],
                  ),
                  SizedBox(height: CoreSpacing.sm(sheetContext)),
                  Text(
                    message,
                    style: CoreTypography.bodyMedium(
                      sheetContext,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: CoreSpacing.lg(sheetContext)),
                  for (final action in actions) ...[
                    WidgetsAppButton(
                      label: action.label,
                      onPressed: () {
                        Navigator.of(sheetContext).pop();
                        action.onSelected();
                      },
                      icon: action.icon,
                      variant: action.variant,
                      fullWidth: true,
                    ),
                    SizedBox(height: CoreSpacing.sm(sheetContext)),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void _showSnackBar(
    BuildContext context,
    String message,
    IconData icon,
  ) {
    final messenger = ScaffoldMessenger.of(context);
    final scheme = Theme.of(context).colorScheme;

    messenger
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: scheme.inverseSurface,
          content: Row(
            children: [
              Icon(icon, color: scheme.onInverseSurface),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  message,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onInverseSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}

class MockSheetAction {
  const MockSheetAction({
    required this.label,
    required this.onSelected,
    this.icon,
    this.variant = WidgetsAppButtonVariant.primary,
  });

  final String label;
  final VoidCallback onSelected;
  final IconData? icon;
  final WidgetsAppButtonVariant variant;
}
