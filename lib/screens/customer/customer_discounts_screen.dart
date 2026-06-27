import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Customer discounted items screen.
class CustomerDiscountsScreen extends ConsumerWidget {
  const CustomerDiscountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final discountIds = ref.watch(visibleDiscountItemIdsProvider);
    final items = [
      for (final id in discountIds)
        if (MockupCatalog.itemById(id) case final item?) item,
    ];

    return WidgetsScaffoldPage(
      title: l10n.homeDiscounts,
      child: ListView(
        children: [
          SizedBox(height: CoreSpacing.md(context)),
          _DiscountHero(count: items.length),
          SizedBox(height: CoreSpacing.lg(context)),
          if (items.isEmpty)
            _EmptyDiscountsCard(l10n: l10n)
          else
            for (var index = 0; index < items.length; index++) ...[
              _DiscountItemCard(
                item: items[index],
                index: index,
                isAr: isAr,
                onAdd: () {
                  showWidgetsCartCustomizationSheet(
                    context: context,
                    item: items[index],
                  );
                },
                onOpen: () {
                  ref.read(selectedMenuItemIdProvider.notifier).state =
                      items[index].id;
                  context.push(AppRoutePaths.productDetail);
                },
              ),
              if (index != items.length - 1)
                SizedBox(height: CoreSpacing.md(context)),
            ],
          SizedBox(height: CoreSpacing.xxl(context)),
        ],
      ),
    );
  }
}

class _DiscountHero extends StatelessWidget {
  const _DiscountHero({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: CoreColors.brandGold.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Icon(Icons.percent_outlined, color: CoreColors.brandGold),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.homeDiscounts,
                  style: CoreTypography.headlineSmall(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  count == 0 ? l10n.comingSoon : l10n.searchResultsCount(count),
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DiscountItemCard extends StatelessWidget {
  const _DiscountItemCard({
    required this.item,
    required this.index,
    required this.isAr,
    required this.onAdd,
    required this.onOpen,
  });

  final ModelMenuItem item;
  final int index;
  final bool isAr;
  final VoidCallback onAdd;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsFoodCard(
      title: isAr ? item.nameAr : item.nameEn,
      description: isAr ? item.descriptionAr : item.descriptionEn,
      priceLabel: UtilityFormatJod.format(
        item.priceJod,
        suffix: l10n.currencyJod,
      ),
      media: WidgetsMockFoodImage(
        imageUrl: item.imageUrl,
        fallback: _DiscountFallback(index: index),
      ),
      actionLabel: l10n.actionAddToCart,
      onAction: onAdd,
      onTap: onOpen,
      loyaltyLabel: l10n.loyaltyPointsShort(item.rewardPoints.toString()),
      badges: [_DiscountBadge(label: l10n.homeDiscountBadge)],
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  const _DiscountBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: CoreColors.brandGold.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        border: Border.all(color: CoreColors.brandGold.withValues(alpha: 0.28)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: CoreSpacing.sm(context),
          vertical: CoreSpacing.xs(context),
        ),
        child: Text(
          label,
          style: CoreTypography.caption(
            context,
            Theme.of(context).colorScheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

class _DiscountFallback extends StatelessWidget {
  const _DiscountFallback({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final color =
        index.isEven
            ? CoreColors.brandGold
            : Theme.of(context).colorScheme.primary;
    return ColoredBox(
      color: color.withValues(alpha: 0.10),
      child: Center(
        child: Icon(
          Icons.local_offer_outlined,
          color: color,
          size: CoreContentSizes.categoryMenuImageIcon(context),
        ),
      ),
    );
  }
}

class _EmptyDiscountsCard extends StatelessWidget {
  const _EmptyDiscountsCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.xl(context)),
      child: Column(
        children: [
          Icon(Icons.local_offer_outlined, color: scheme.primary),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.comingSoon,
            textAlign: TextAlign.center,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppButton(
            label: l10n.searchBrowseMenu,
            onPressed: () => context.push(AppRoutePaths.category),
            icon: Icons.restaurant_menu_outlined,
            variant: WidgetsAppButtonVariant.secondary,
          ),
        ],
      ),
    );
  }
}
