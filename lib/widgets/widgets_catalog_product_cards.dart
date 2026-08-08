import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_blog_post.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:flutter/material.dart';

/// Canonical product merchandising card (home, menu, marketing, related).
///
/// Thin typed wrappers keep call sites clear while sharing one visual system
/// ([WidgetsFoodCard] via [WidgetsFoodCatalogCard]).
class WidgetsProductCard extends StatelessWidget {
  const WidgetsProductCard({
    required this.title,
    required this.description,
    required this.priceLabel,
    required this.imageUrl,
    required this.badgeLabel,
    required this.actionLabel,
    required this.loyaltyLabel,
    required this.index,
    required this.onAction,
    required this.onTap,
    this.ratingLabel,
    this.actionIcon = Icons.add_shopping_cart_outlined,
    super.key,
  });

  factory WidgetsProductCard.fromMenuItem({
    required ModelMenuItem item,
    required bool isAr,
    required AppLocalizations l10n,
    required int index,
    required VoidCallback onAction,
    required VoidCallback onTap,
    String? badgeLabel,
    String? actionLabel,
    IconData actionIcon = Icons.add_shopping_cart_outlined,
    Key? key,
  }) {
    return WidgetsProductCard(
      key: key,
      title: isAr ? item.nameAr : item.nameEn,
      description: isAr ? item.descriptionAr : item.descriptionEn,
      priceLabel: UtilityFormatJod.format(
        item.priceJod,
        suffix: l10n.currencyJod,
      ),
      imageUrl: item.primaryImageUrl ?? item.imageUrl,
      badgeLabel: badgeLabel ?? l10n.productBestSeller,
      actionLabel: actionLabel ?? l10n.actionAddToCart,
      loyaltyLabel: l10n.loyaltyPointsShort(item.rewardPoints.toString()),
      index: index,
      onAction: onAction,
      onTap: onTap,
      actionIcon: actionIcon,
    );
  }

  final String title;
  final String description;
  final String priceLabel;
  final String? imageUrl;
  final String badgeLabel;
  final String actionLabel;
  final String loyaltyLabel;
  final String? ratingLabel;
  final int index;
  final VoidCallback onAction;
  final VoidCallback onTap;
  final IconData actionIcon;

  @override
  Widget build(BuildContext context) {
    return WidgetsFoodCatalogCard(
      title: title,
      description: description,
      priceLabel: priceLabel,
      imageUrl: imageUrl,
      badgeLabel: badgeLabel,
      actionLabel: actionLabel,
      loyaltyLabel: loyaltyLabel,
      ratingLabel: ratingLabel,
      index: index,
      onAction: onAction,
      onTap: onTap,
      actionIcon: actionIcon,
    );
  }
}

class WidgetsOfferProductCard extends StatelessWidget {
  const WidgetsOfferProductCard({
    required this.title,
    required this.description,
    required this.priceLabel,
    required this.imageUrl,
    required this.actionLabel,
    required this.loyaltyLabel,
    required this.index,
    required this.onAction,
    required this.onTap,
    this.badgeLabel,
    this.actionIcon = Icons.local_offer_outlined,
    super.key,
  });

  factory WidgetsOfferProductCard.fromOffer({
    required ModelCatalogOffer offer,
    required bool isAr,
    required AppLocalizations l10n,
    required int index,
    required VoidCallback onAction,
    required VoidCallback onTap,
    String? priceLabel,
    String? actionLabel,
    IconData actionIcon = Icons.local_offer_outlined,
    Key? key,
  }) {
    final badge =
        (isAr ? offer.badgeAr : offer.badgeEn) ??
        (offer.discountPercent != null
            ? l10n.comboDiscountOff(offer.discountPercent!.toStringAsFixed(0))
            : l10n.guestLimitedOffer);
    final discountLabel =
        offer.discountPercent != null
            ? l10n.comboDiscountOff(offer.discountPercent!.toStringAsFixed(0))
            : badge;
    return WidgetsOfferProductCard(
      key: key,
      title: isAr ? offer.titleAr : offer.titleEn,
      description:
          isAr
              ? (offer.subtitleAr ?? offer.titleAr)
              : (offer.subtitleEn ?? offer.titleEn),
      priceLabel: priceLabel ?? discountLabel,
      imageUrl: offer.primaryImageUrl,
      actionLabel: actionLabel ?? l10n.guestClaimOffer,
      loyaltyLabel: l10n.loyaltyPointsShort('${offer.rewardPoints}'),
      index: index,
      onAction: onAction,
      onTap: onTap,
      badgeLabel: badge,
      actionIcon: actionIcon,
    );
  }

  final String title;
  final String description;
  final String priceLabel;
  final String? imageUrl;
  final String actionLabel;
  final String loyaltyLabel;
  final int index;
  final VoidCallback onAction;
  final VoidCallback onTap;
  final String? badgeLabel;
  final IconData actionIcon;

  @override
  Widget build(BuildContext context) {
    return WidgetsFoodCatalogCard(
      title: title,
      description: description,
      priceLabel: priceLabel,
      imageUrl: imageUrl,
      badgeLabel: badgeLabel ?? title,
      actionLabel: actionLabel,
      loyaltyLabel: loyaltyLabel,
      index: index,
      onAction: onAction,
      onTap: onTap,
      actionIcon: actionIcon,
    );
  }
}

class WidgetsDiscountProductCard extends StatelessWidget {
  const WidgetsDiscountProductCard({
    required this.item,
    required this.isAr,
    required this.l10n,
    required this.index,
    required this.onAction,
    required this.onTap,
    this.badgeLabel,
    this.actionLabel,
    this.actionIcon = Icons.add_shopping_cart_outlined,
    super.key,
  });

  final ModelMenuItem item;
  final bool isAr;
  final AppLocalizations l10n;
  final int index;
  final VoidCallback onAction;
  final VoidCallback onTap;
  final String? badgeLabel;
  final String? actionLabel;
  final IconData actionIcon;

  @override
  Widget build(BuildContext context) {
    return WidgetsProductCard.fromMenuItem(
      item: item,
      isAr: isAr,
      l10n: l10n,
      index: index,
      onAction: onAction,
      onTap: onTap,
      badgeLabel: badgeLabel ?? l10n.homeDiscountBadge,
      actionLabel: actionLabel,
      actionIcon: actionIcon,
    );
  }
}

class WidgetsComboProductCard extends StatelessWidget {
  const WidgetsComboProductCard({
    required this.combo,
    required this.isAr,
    required this.l10n,
    required this.index,
    required this.onAction,
    required this.onTap,
    this.actionLabel,
    this.actionIcon = Icons.restaurant_menu_outlined,
    super.key,
  });

  final ModelCatalogCombo combo;
  final bool isAr;
  final AppLocalizations l10n;
  final int index;
  final VoidCallback onAction;
  final VoidCallback onTap;
  final String? actionLabel;
  final IconData actionIcon;

  @override
  Widget build(BuildContext context) {
    final title = isAr ? combo.titleAr : combo.titleEn;
    final subtitle =
        isAr
            ? (combo.subtitleAr ?? combo.titleAr)
            : (combo.subtitleEn ?? combo.titleEn);
    final badge = l10n.comboDiscountOff(
      combo.discountPercent.toStringAsFixed(0),
    );

    return WidgetsFoodCatalogCard(
      title: title,
      description: subtitle,
      priceLabel: UtilityFormatJod.format(
        combo.priceJod,
        suffix: l10n.currencyJod,
      ),
      imageUrl: combo.primaryImageUrl,
      badgeLabel: badge,
      actionLabel: actionLabel ?? l10n.actionAddToCart,
      loyaltyLabel: l10n.loyaltyPointsShort('${combo.rewardPoints}'),
      index: index,
      onAction: onAction,
      onTap: onTap,
      actionIcon: actionIcon,
    );
  }
}

class WidgetsSubscriptionCard extends StatelessWidget {
  const WidgetsSubscriptionCard({
    required this.meal,
    required this.isAr,
    required this.l10n,
    required this.index,
    required this.onAction,
    required this.onTap,
    this.imageUrl,
    this.actionLabel,
    super.key,
  });

  final ModelSubscriptionMeal meal;
  final bool isAr;
  final AppLocalizations l10n;
  final int index;
  final VoidCallback onAction;
  final VoidCallback onTap;
  final String? imageUrl;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    final periodLabel =
        meal.billingPeriod == 'weekly'
            ? l10n.billingPeriodWeekly
            : l10n.billingPeriodMonthly;
    final title =
        isAr
            ? (meal.titleAr.isNotEmpty ? meal.titleAr : meal.menuItemId)
            : (meal.titleEn.isNotEmpty ? meal.titleEn : meal.menuItemId);
    final description = meal.freeDelivery
        ? '$periodLabel · ${l10n.marketingSubscriptionFreeDelivery}'
        : periodLabel;

    return WidgetsFoodCatalogCard(
      title: title,
      description: description,
      priceLabel: UtilityFormatJod.format(
        meal.priceJod,
        suffix: l10n.currencyJod,
      ),
      imageUrl: imageUrl ?? meal.primaryImageUrl,
      badgeLabel: periodLabel,
      actionLabel: actionLabel ?? l10n.actionAddToCart,
      loyaltyLabel: l10n.loyaltyPointsShort(
        ((meal.priceJod * 10).round()).toString(),
      ),
      index: index,
      onAction: onAction,
      onTap: onTap,
      actionIcon: Icons.event_repeat_outlined,
    );
  }
}

/// Blog merchandising card — same [WidgetsFoodCatalogCard] shell as offers/menu.
class WidgetsBlogProductCard extends StatelessWidget {
  const WidgetsBlogProductCard({
    required this.post,
    required this.isAr,
    required this.l10n,
    required this.index,
    required this.onAction,
    required this.onTap,
    super.key,
  });

  final BlogPost post;
  final bool isAr;
  final AppLocalizations l10n;
  final int index;
  final VoidCallback onAction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WidgetsFoodCatalogCard(
      title: post.title(isAr),
      description: post.excerpt(isAr),
      priceLabel: post.author,
      imageUrl: post.coverImageUrl,
      badgeLabel: l10n.homeBlogBadge,
      actionLabel: l10n.homeBlogRead,
      loyaltyLabel: post.author,
      index: index,
      onAction: onAction,
      onTap: onTap,
      actionIcon: Icons.menu_book_outlined,
    );
  }
}
