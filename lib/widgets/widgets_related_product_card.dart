import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:flutter/material.dart';

/// Related-product rail card — same visual language as [WidgetsFoodCatalogCard].
class WidgetsRelatedProductCard extends StatelessWidget {
  const WidgetsRelatedProductCard({
    required this.title,
    required this.priceLabel,
    required this.imageUrl,
    required this.index,
    required this.actionLabel,
    required this.loyaltyLabel,
    required this.badgeLabel,
    required this.onAction,
    required this.onTap,
    this.width,
    super.key,
  });

  factory WidgetsRelatedProductCard.fromItem({
    required ModelMenuItem item,
    required bool isAr,
    required AppLocalizations l10n,
    required int index,
    required VoidCallback onAction,
    required VoidCallback onTap,
    double? width,
    Key? key,
  }) {
    return WidgetsRelatedProductCard(
      key: key,
      title: isAr ? item.nameAr : item.nameEn,
      priceLabel: UtilityFormatJod.format(
        item.priceJod,
        suffix: l10n.currencyJod,
      ),
      imageUrl: item.primaryImageUrl ?? item.imageUrl,
      index: index,
      actionLabel: l10n.actionAddToCart,
      loyaltyLabel: l10n.loyaltyPointsShort(item.rewardPoints.toString()),
      badgeLabel: l10n.productBestSeller,
      onAction: onAction,
      onTap: onTap,
      width: width,
    );
  }

  final String title;
  final String priceLabel;
  final String? imageUrl;
  final int index;
  final String actionLabel;
  final String loyaltyLabel;
  final String badgeLabel;
  final VoidCallback onAction;
  final VoidCallback onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? UtilitySizer.of(context, 220),
      child: WidgetsFoodCatalogCard(
        title: title,
        description: priceLabel,
        priceLabel: priceLabel,
        imageUrl: imageUrl,
        badgeLabel: badgeLabel,
        actionLabel: actionLabel,
        loyaltyLabel: loyaltyLabel,
        index: index,
        onAction: onAction,
        onTap: onTap,
      ),
    );
  }
}
