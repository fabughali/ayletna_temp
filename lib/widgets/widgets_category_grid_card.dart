import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_product_cards.dart';
import 'package:flutter/material.dart';

/// Legacy alias — prefer [WidgetsProductCard] directly.
///
/// Kept so older call sites still render the canonical product card.
class WidgetsCategoryGridCard extends StatelessWidget {
  const WidgetsCategoryGridCard({
    required this.title,
    required this.description,
    required this.priceLabel,
    required this.imageUrl,
    required this.index,
    required this.onAdd,
    this.onTap,
    this.onFavorite,
    this.actionLabel,
    this.loyaltyLabel,
    this.badgeLabel,
    super.key,
  });

  final String title;
  final String description;
  final String priceLabel;
  final String? imageUrl;
  final int index;
  final VoidCallback onAdd;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final String? actionLabel;
  final String? loyaltyLabel;
  final String? badgeLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsProductCard(
      title: title,
      description: description,
      priceLabel: priceLabel,
      imageUrl: imageUrl,
      badgeLabel: badgeLabel ?? l10n.productBestSeller,
      actionLabel: actionLabel ?? l10n.actionAddToCart,
      loyaltyLabel: loyaltyLabel ?? l10n.loyaltyPointsShort('0'),
      index: index,
      onAction: onAdd,
      onTap: onTap ?? onAdd,
    );
  }
}
