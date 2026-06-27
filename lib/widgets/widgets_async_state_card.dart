import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:flutter/material.dart';

/// Shared empty / error panel for async customer screens.
class WidgetsAsyncStateCard extends StatelessWidget {
  const WidgetsAsyncStateCard({
    required this.title,
    required this.message,
    this.icon = Icons.info_outline,
    this.tone = WidgetsInfoBannerTone.info,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  factory WidgetsAsyncStateCard.error({
    required String title,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return WidgetsAsyncStateCard(
      title: title,
      message: message,
      icon: Icons.error_outline,
      tone: WidgetsInfoBannerTone.warning,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  factory WidgetsAsyncStateCard.empty({
    required String title,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return WidgetsAsyncStateCard(
      title: title,
      message: message,
      icon: Icons.inbox_outlined,
      tone: WidgetsInfoBannerTone.info,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  final String title;
  final String message;
  final IconData icon;
  final WidgetsInfoBannerTone tone;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: CoreSpacing.lg(context)),
      child: WidgetsInfoBanner(
        title: title,
        message: message,
        icon: icon,
        tone: tone,
        action:
            actionLabel != null && onAction != null
                ? WidgetsAppButton(
                  label: actionLabel!,
                  onPressed: onAction,
                  variant: WidgetsAppButtonVariant.outline,
                )
                : null,
      ),
    );
  }
}

String orderPlacementErrorMessage(AppLocalizations l10n, Object error) {
  final key = error.toString();
  if (key.contains('cart_empty')) return l10n.cartEmptyMessage;
  if (key.contains('address_required')) return l10n.cartAddressRequired;
  return l10n.comingSoon;
}

String addressActionErrorMessage(AppLocalizations l10n, Object error) {
  final key = error.toString();
  if (key.contains('fields_required')) return l10n.mapRequiredFields;
  if (key.contains('cannot_remove')) return l10n.addressesDelete;
  if (key.contains('not_found')) return l10n.comingSoon;
  return l10n.comingSoon;
}
