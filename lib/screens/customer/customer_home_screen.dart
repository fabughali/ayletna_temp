import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_list_entry.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_category.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_customer_search_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_hero.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_home_loading_skeleton.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_responsive_card_grid.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD HomeScreen — warm food storefront and plated delivery highlights.
class CustomerHomeScreen extends ConsumerWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final categoriesAsync = ref.watch(menuCategoriesProvider);
    final itemsAsync = ref.watch(menuItemsProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenHome,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
        const WidgetsCartIconButton(),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(menuCategoriesProvider);
          ref.invalidate(menuItemsProvider);
        },
        child: categoriesAsync.when(
          loading: () => const WidgetsHomeLoadingSkeleton(),
          error: (e, _) => SelectableText.rich(TextSpan(text: e.toString())),
          data:
              (categories) => itemsAsync.when(
                loading: () => const WidgetsHomeLoadingSkeleton(),
                error:
                    (e, _) => SelectableText.rich(TextSpan(text: e.toString())),
                data:
                    (items) => ListView(
                      children: [
                        SizedBox(height: CoreSpacing.md(context)),
                        const WidgetsCustomerSearchBar(),
                        SizedBox(height: CoreSpacing.lg(context)),
                        _HomeFeatureSections(
                          offers: ref.watch(visibleOfferEntriesProvider),
                          combos: ref.watch(visibleComboEntriesProvider),
                          discountedItems: _itemsByIds(
                            items,
                            ref.watch(visibleDiscountItemIdsProvider),
                          ),
                          subscriptionItems: _itemsByIds(
                            items,
                            ref.watch(visibleSubscriptionItemIdsProvider),
                          ),
                          isAr: isAr,
                        ),
                        _SectionHeader(
                          title: l10n.screenCategory,
                          actionLabel: l10n.homeViewAll,
                          onAction: () => context.push(AppRoutePaths.category),
                        ),
                        SizedBox(height: CoreSpacing.md(context)),
                        _CategoryTiles(
                          categories: categories.take(6).toList(),
                          selectedId: ref.watch(selectedCategoryIdProvider),
                          isAr: isAr,
                          onSelected: (id) {
                            ref
                                .read(selectedCategoryIdProvider.notifier)
                                .state = id;
                            context.push(AppRoutePaths.category);
                          },
                        ),
                        SizedBox(height: CoreSpacing.xl(context)),
                        _SectionHeader(
                          title: l10n.homePopularThisWeek,
                          actionLabel: l10n.homeViewAll,
                          onAction: () => context.push(AppRoutePaths.category),
                        ),
                        SizedBox(height: CoreSpacing.md(context)),
                        _HomeFoodHero(item: _featuredItem(), isAr: isAr),
                        SizedBox(height: CoreSpacing.lg(context)),
                        _PopularGrid(items: _popularItems(), isAr: isAr),
                        SizedBox(height: CoreSpacing.xl(context)),
                        if (MockupCatalog.homePromoCards.isNotEmpty) ...[
                          _SectionHeader(
                            title: l10n.homeStories,
                            actionLabel: l10n.homeLearnHowItWorks,
                            onAction: () => context.push(AppRoutePaths.offers),
                          ),
                          SizedBox(height: CoreSpacing.md(context)),
                          _PlatedHero(l10n: l10n),
                          SizedBox(height: CoreSpacing.md(context)),
                          _PromoStoryCards(
                            entries: MockupCatalog.homePromoCards,
                            isAr: isAr,
                          ),
                          SizedBox(height: CoreSpacing.xl(context)),
                        ],
                        _SustainabilityCard(l10n: l10n),
                        SizedBox(height: CoreSpacing.xxl(context)),
                      ],
                    ),
              ),
        ),
      ),
    );
  }

  List<ModelMenuItem> _popularItems() {
    return [
      for (final id in MockupCatalog.popularMenuItemIds)
        if (MockupCatalog.itemById(id) case final item?) item,
    ];
  }

  ModelMenuItem _featuredItem() {
    return MockupCatalog.itemById(MockupCatalog.popularMenuItemIds.first) ??
        MockupCatalog.items.first;
  }

  List<ModelMenuItem> _itemsByIds(List<ModelMenuItem> items, List<String> ids) {
    return [
      for (final id in ids)
        if (_itemFrom(items, id) case final item?) item,
    ];
  }

  ModelMenuItem? _itemFrom(List<ModelMenuItem> items, String id) {
    for (final item in items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }
}

class _HomeFeatureSections extends StatelessWidget {
  const _HomeFeatureSections({
    required this.offers,
    required this.combos,
    required this.discountedItems,
    required this.subscriptionItems,
    required this.isAr,
  });

  final List<ModelListEntry> offers;
  final List<ModelListEntry> combos;
  final List<ModelMenuItem> discountedItems;
  final List<ModelMenuItem> subscriptionItems;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (offers.isNotEmpty) ...[
          _SectionHeader(
            title: l10n.homeOffers,
            actionLabel: l10n.homeViewAll,
            onAction: () => context.push(AppRoutePaths.offers),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _EntryRail(
            entries: offers,
            isAr: isAr,
            icon: Icons.local_offer_outlined,
            color: CoreColors.brandGold,
            actionLabel: l10n.guestClaimOffer,
            onTap: (_) => context.push(AppRoutePaths.offers),
          ),
          SizedBox(height: CoreSpacing.xl(context)),
        ],
        if (combos.isNotEmpty) ...[
          _SectionHeader(
            title: l10n.homeCombos,
            actionLabel: l10n.homeViewAll,
            onAction: () => context.push(AppRoutePaths.combo),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _EntryRail(
            entries: combos,
            isAr: isAr,
            icon: Icons.room_service_outlined,
            color: CoreColors.brandOrange,
            actionLabel: l10n.screenComboBuilder,
            onTap: (_) => context.push(AppRoutePaths.combo),
          ),
          SizedBox(height: CoreSpacing.xl(context)),
        ],
        if (discountedItems.isNotEmpty) ...[
          _SectionHeader(
            title: l10n.homeDiscounts,
            actionLabel: l10n.homeViewAll,
            onAction: () => context.push(AppRoutePaths.discounts),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _MenuItemRail(
            items: discountedItems,
            isAr: isAr,
            badgeLabel: l10n.homeDiscountBadge,
            actionLabel: l10n.actionAddToCart,
          ),
          SizedBox(height: CoreSpacing.xl(context)),
        ],
        if (subscriptionItems.isNotEmpty) ...[
          _SectionHeader(
            title: l10n.homeSubscriptions,
            actionLabel: l10n.homeViewAll,
            onAction: () => context.push(AppRoutePaths.loyalty),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _SubscriptionItemRail(items: subscriptionItems, isAr: isAr),
          SizedBox(height: CoreSpacing.xl(context)),
        ],
      ],
    );
  }
}

class _EntryRail extends StatelessWidget {
  const _EntryRail({
    required this.entries,
    required this.isAr,
    required this.icon,
    required this.color,
    required this.actionLabel,
    required this.onTap,
  });

  final List<ModelListEntry> entries;
  final bool isAr;
  final IconData icon;
  final Color color;
  final String actionLabel;
  final ValueChanged<ModelListEntry> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < entries.take(2).length; index++) ...[
          _FeatureEntryCard(
            entry: entries[index],
            isAr: isAr,
            icon: icon,
            color: color,
            actionLabel: actionLabel,
            onTap: () => onTap(entries[index]),
          ),
          if (index != entries.take(2).length - 1)
            SizedBox(height: CoreSpacing.sm(context)),
        ],
      ],
    );
  }
}

class _FeatureEntryCard extends StatelessWidget {
  const _FeatureEntryCard({
    required this.entry,
    required this.isAr,
    required this.icon,
    required this.color,
    required this.actionLabel,
    required this.onTap,
  });

  final ModelListEntry entry;
  final bool isAr;
  final IconData icon;
  final Color color;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final title = isAr ? entry.titleAr : entry.titleEn;
    final subtitle = isAr ? entry.subtitleAr : entry.subtitleEn;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      onTap: onTap,
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Icon(icon, color: color),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  subtitle ?? actionLabel,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          WidgetsIconButton(
            onPressed: onTap,
            icon: Icons.arrow_forward,
            tooltip: actionLabel,
            variant: WidgetsIconButtonVariant.tonal,
            color: color,
          ),
        ],
      ),
    );
  }
}

class _MenuItemRail extends ConsumerWidget {
  const _MenuItemRail({
    required this.items,
    required this.isAr,
    required this.badgeLabel,
    required this.actionLabel,
  });

  final List<ModelMenuItem> items;
  final bool isAr;
  final String badgeLabel;
  final String actionLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibleItems = items.take(3).toList();

    return WidgetsResponsiveCardGrid(
      minCardWidth: 260,
      maxCardWidth: 360,
      heightRatio: 0.54,
      minCardHeight: 168,
      maxCardHeight: 196,
      children: [
        for (var index = 0; index < visibleItems.length; index++)
          _CompactMenuFeatureCard(
            item: visibleItems[index],
            index: index,
            isAr: isAr,
            badgeLabel: badgeLabel,
            actionLabel: actionLabel,
            onAction: () {
              showWidgetsCartCustomizationSheet(
                context: context,
                item: visibleItems[index],
              );
            },
            onOpen: () {
              ref.read(selectedMenuItemIdProvider.notifier).state =
                  visibleItems[index].id;
              context.push(AppRoutePaths.productDetail);
            },
          ),
      ],
    );
  }
}

class _SubscriptionItemRail extends ConsumerWidget {
  const _SubscriptionItemRail({required this.items, required this.isAr});

  final List<ModelMenuItem> items;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibleItems = items.take(3).toList();

    return WidgetsResponsiveCardGrid(
      minCardWidth: 270,
      maxCardWidth: 380,
      heightRatio: 0.62,
      minCardHeight: 210,
      maxCardHeight: 252,
      children: [
        for (var index = 0; index < visibleItems.length; index++)
          _SubscriptionFeatureCard(
            item: visibleItems[index],
            index: index,
            isAr: isAr,
            onOpen: () {
              ref.read(selectedMenuItemIdProvider.notifier).state =
                  visibleItems[index].id;
              context.push(AppRoutePaths.productDetail);
            },
            onSubscribe: () {
              showWidgetsCartCustomizationSheet(
                context: context,
                item: visibleItems[index],
              );
            },
          ),
      ],
    );
  }
}

class _SubscriptionFeatureCard extends StatelessWidget {
  const _SubscriptionFeatureCard({
    required this.item,
    required this.index,
    required this.isAr,
    required this.onOpen,
    required this.onSubscribe,
  });

  final ModelMenuItem item;
  final int index;
  final bool isAr;
  final VoidCallback onOpen;
  final VoidCallback onSubscribe;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final color = index.isEven ? CoreColors.brandOlive : CoreColors.brandGold;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.zero,
      onTap: onOpen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        child: Stack(
          fit: StackFit.expand,
          children: [
            WidgetsMockFoodImage(
              imageUrl: item.imageUrl,
              fit: BoxFit.cover,
              fallback: ColoredBox(
                color: color.withValues(alpha: 0.14),
                child: Icon(Icons.calendar_month_outlined, color: color),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.08),
                    Colors.black.withValues(alpha: 0.70),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: _FoodTag(
                      label: l10n.homeSubscriptions,
                      color: color,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    isAr ? item.nameAr : item.nameEn,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CoreTypography.titleMedium(
                      context,
                      Colors.white,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: CoreSpacing.xs(context)),
                  Text(
                    isAr ? item.descriptionAr : item.descriptionEn,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CoreTypography.caption(
                      context,
                      Colors.white.withValues(alpha: 0.84),
                    ),
                  ),
                  SizedBox(height: CoreSpacing.md(context)),
                  Row(
                    children: [
                      Expanded(
                        child: WidgetsPriceBadge(
                          priceLabel: UtilityFormatJod.format(
                            item.priceJod,
                            suffix: l10n.currencyJod,
                          ),
                        ),
                      ),
                      SizedBox(width: CoreSpacing.sm(context)),
                      WidgetsIconButton(
                        onPressed: onSubscribe,
                        icon: Icons.calendar_month_outlined,
                        tooltip: l10n.homeSubscriptionCta,
                        variant: WidgetsIconButtonVariant.filled,
                        color: scheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompactMenuFeatureCard extends StatelessWidget {
  const _CompactMenuFeatureCard({
    required this.item,
    required this.index,
    required this.isAr,
    required this.badgeLabel,
    required this.actionLabel,
    required this.onAction,
    required this.onOpen,
  });

  final ModelMenuItem item;
  final int index;
  final bool isAr;
  final String badgeLabel;
  final String actionLabel;
  final VoidCallback onAction;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final color = switch (index % 4) {
      0 => scheme.primary,
      1 => CoreColors.brandGold,
      2 => CoreColors.orderTypePlated,
      _ => scheme.secondary,
    };

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      onTap: onOpen,
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Icon(Icons.restaurant_menu_outlined, color: color),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _FoodTag(label: badgeLabel, color: color),
                SizedBox(height: CoreSpacing.sm(context)),
                Text(
                  isAr ? item.nameAr : item.nameEn,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  UtilityFormatJod.format(
                    item.priceJod,
                    suffix: l10n.currencyJod,
                  ),
                  style: CoreTypography.caption(
                    context,
                    scheme.primary,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          WidgetsIconButton(
            onPressed: onAction,
            icon:
                actionLabel == l10n.homeSubscriptionCta
                    ? Icons.calendar_month_outlined
                    : Icons.add_shopping_cart_outlined,
            tooltip: actionLabel,
            variant: WidgetsIconButtonVariant.tonal,
            color: color,
          ),
        ],
      ),
    );
  }
}

class _HomeFoodHero extends ConsumerWidget {
  const _HomeFoodHero({required this.item, required this.isAr});

  final ModelMenuItem item;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final name = isAr ? item.nameAr : item.nameEn;
    final description = isAr ? item.descriptionAr : item.descriptionEn;

    return WidgetsFoodHero(
      title: name,
      subtitle: description,
      media: WidgetsMockFoodImage(
        imageUrl: item.imageUrl,
        fallback: const _HeroFeastMedia(),
      ),
      primaryLabel: l10n.homeOrderNow,
      onPrimary: () {
        ref.read(selectedMenuItemIdProvider.notifier).state = item.id;
        context.push(AppRoutePaths.productDetail);
      },
      secondaryLabel: l10n.screenCategory,
      onSecondary: () => context.push(AppRoutePaths.category),
    );
  }
}

class _CategoryTiles extends StatelessWidget {
  const _CategoryTiles({
    required this.categories,
    required this.selectedId,
    required this.isAr,
    required this.onSelected,
  });

  final List<ModelMenuCategory> categories;
  final String selectedId;
  final bool isAr;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var index = 0; index < categories.length; index++) ...[
            _CategoryTile(
              category: categories[index],
              selected: categories[index].id == selectedId,
              label: isAr ? categories[index].nameAr : categories[index].nameEn,
              index: index,
              onTap: () => onSelected(categories[index].id),
            ),
            SizedBox(width: CoreSpacing.md(context)),
          ],
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.category,
    required this.selected,
    required this.label,
    required this.index,
    required this.onTap,
  });

  final ModelMenuCategory category;
  final bool selected;
  final String label;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = _colorFor(context, index);

    return SizedBox(
      width: CoreContentSizes.logoWelcome(context) * 1.22,
      child: WidgetsAppCard(
        variant: WidgetsAppCardVariant.food,
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: color.withValues(alpha: selected ? 0.20 : 0.12),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(CoreSpacing.sm(context)),
                child: Icon(_iconFor(category.iconKey), color: color, size: 28),
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CoreTypography.bodyMedium(
                context,
                selected ? scheme.primary : scheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(String key) {
    return switch (key) {
      'shawarma' => Icons.fastfood_outlined,
      'skillet' => Icons.egg_alt_outlined,
      'hummus' => Icons.rice_bowl_outlined,
      'drink' => Icons.local_bar_outlined,
      'sandwich' => Icons.lunch_dining_outlined,
      'falafel' => Icons.circle_outlined,
      'pizza' => Icons.local_pizza_outlined,
      'snack' => Icons.fastfood_outlined,
      'manaqeesh' => Icons.bakery_dining_outlined,
      'pastry' => Icons.breakfast_dining_outlined,
      'burger' => Icons.lunch_dining,
      _ => Icons.restaurant_outlined,
    };
  }

  Color _colorFor(BuildContext context, int index) {
    final scheme = Theme.of(context).colorScheme;
    return switch (index % 4) {
      0 => scheme.primary,
      1 => CoreColors.brandGold,
      2 => CoreColors.orderTypePlated,
      _ => scheme.secondary,
    };
  }
}

class _PlatedHero extends StatelessWidget {
  const _PlatedHero({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsFoodMediaPanel(
            height: CoreContentSizes.categoryHeroHeight(context) * 0.38,
            badge: _FoodTag(
              label: l10n.homePlatedDelivery,
              color: CoreColors.orderTypePlated,
            ),
            child: CustomPaint(
              painter: _TableFeastPainter(
                color: scheme.primary.withValues(alpha: 0.20),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.homeZeroWasteTitle,
            style: CoreTypography.headlineSmall(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.homeZeroWasteSubtitle,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppButton(
            label: l10n.homeOrderNow,
            onPressed: () => context.push(AppRoutePaths.cart),
            variant: WidgetsAppButtonVariant.secondary,
            icon: Icons.arrow_forward,
          ),
        ],
      ),
    );
  }
}

class _PromoStoryCards extends StatelessWidget {
  const _PromoStoryCards({required this.entries, required this.isAr});

  final List<ModelListEntry> entries;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < entries.length; index++) ...[
          _PromoStoryCard(entry: entries[index], isAr: isAr, index: index),
          if (index != entries.length - 1)
            SizedBox(height: CoreSpacing.md(context)),
        ],
      ],
    );
  }
}

class _PromoStoryCard extends StatelessWidget {
  const _PromoStoryCard({
    required this.entry,
    required this.isAr,
    required this.index,
  });

  final ModelListEntry entry;
  final bool isAr;
  final int index;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (index % 3) {
      0 => CoreColors.semanticSuccess,
      1 => CoreColors.brandGold,
      _ => CoreColors.orderTypePlated,
    };
    final icon = switch (entry.id) {
      'healthy_selection' => Icons.eco_outlined,
      'client_feedback' => Icons.rate_review_outlined,
      'festival_table' => Icons.celebration_outlined,
      _ => Icons.article_outlined,
    };

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Icon(icon, color: color),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAr ? entry.titleAr : entry.titleEn,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  (isAr ? entry.subtitleAr : entry.subtitleEn) ?? '',
                  style: CoreTypography.caption(
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: CoreTypography.headlineSmall(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        WidgetsAppButton(
          label: actionLabel,
          onPressed: onAction,
          variant: WidgetsAppButtonVariant.ghost,
        ),
      ],
    );
  }
}

class _PopularGrid extends ConsumerWidget {
  const _PopularGrid({required this.items, required this.isAr});

  final List<ModelMenuItem> items;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WidgetsResponsiveCardGrid(
      minCardWidth: 280,
      maxCardWidth: 360,
      children: [
        for (var index = 0; index < items.length; index++)
          _PopularFoodCard(
            item: items[index],
            index: index,
            isAr: isAr,
            onAdd: () => _addItem(context, ref, items[index]),
            onOpen: () => _openItem(context, ref, items[index]),
          ),
      ],
    );
  }

  void _addItem(BuildContext context, WidgetRef ref, ModelMenuItem item) {
    showWidgetsCartCustomizationSheet(context: context, item: item);
  }

  void _openItem(BuildContext context, WidgetRef ref, ModelMenuItem item) {
    ref.read(selectedMenuItemIdProvider.notifier).state = item.id;
    context.push(AppRoutePaths.productDetail);
  }
}

class _PopularFoodCard extends StatelessWidget {
  const _PopularFoodCard({
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
    final name = isAr ? item.nameAr : item.nameEn;
    final description = isAr ? item.descriptionAr : item.descriptionEn;
    final badgeLabel = _BadgeCopy.forIndex(l10n, index);

    return WidgetsFoodCard(
      title: name,
      description: description,
      priceLabel: UtilityFormatJod.format(
        item.priceJod,
        suffix: l10n.currencyJod,
      ),
      media: WidgetsMockFoodImage(
        imageUrl: item.imageUrl,
        fallback: _DishMediaIcon(index: index),
      ),
      actionLabel: l10n.actionAddToCart,
      onAction: onAdd,
      onTap: onOpen,
      fillHeight: true,
      badgeLabel: badgeLabel,
      loyaltyLabel: l10n.loyaltyPointsShort(item.rewardPoints.toString()),
      badges: [_FoodTag(label: badgeLabel, color: _badgeColor(context, index))],
    );
  }

  Color _badgeColor(BuildContext context, int index) {
    final scheme = Theme.of(context).colorScheme;
    return switch (index) {
      0 => scheme.primary,
      1 => CoreColors.brandGold,
      2 => CoreColors.orderTypePlated,
      _ => scheme.secondary,
    };
  }
}

class _BadgeCopy {
  static String forIndex(AppLocalizations l10n, int index) {
    return switch (index) {
      0 => l10n.orderTypeDineIn,
      1 => l10n.orderTypeTakeaway,
      2 => l10n.badgePlated,
      _ => l10n.orderTypeDelivery,
    };
  }
}

class _HeroFeastMedia extends StatelessWidget {
  const _HeroFeastMedia();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: _SignatureDishPainter(
            color: scheme.primary,
            accent: CoreColors.brandGold,
          ),
        ),
        Center(
          child: Icon(
            Icons.dinner_dining_outlined,
            size: CoreContentSizes.categoryMenuImageIcon(context) * 1.2,
            color: scheme.primary,
          ),
        ),
      ],
    );
  }
}

class _DishMediaIcon extends StatelessWidget {
  const _DishMediaIcon({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final icons = [
      Icons.dinner_dining_outlined,
      Icons.fastfood_outlined,
      Icons.tapas_outlined,
      Icons.outdoor_grill_outlined,
    ];

    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: _SignatureDishPainter(
            color: _colorFor(context, index),
            accent: CoreColors.brandGold,
          ),
        ),
        Center(
          child: Icon(
            icons[index % icons.length],
            size: CoreContentSizes.categoryMenuImageIcon(context),
            color: scheme.primary,
          ),
        ),
      ],
    );
  }

  Color _colorFor(BuildContext context, int index) {
    final scheme = Theme.of(context).colorScheme;
    return switch (index % 4) {
      0 => scheme.primary,
      1 => CoreColors.brandGold,
      2 => CoreColors.orderTypePlated,
      _ => scheme.secondary,
    };
  }
}

class _FoodTag extends StatelessWidget {
  const _FoodTag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        border: Border.all(color: color.withValues(alpha: 0.24)),
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
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _SustainabilityCard extends StatelessWidget {
  const _SustainabilityCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return WidgetsInfoBanner(
      title: l10n.homeSustainabilityDeposit,
      message: l10n.homeSustainabilityBody,
      icon: Icons.eco_outlined,
      tone: WidgetsInfoBannerTone.success,
      action: WidgetsAppButton(
        label: l10n.homeLearnHowItWorks,
        onPressed: () => context.push(AppRoutePaths.terms),
        variant: WidgetsAppButtonVariant.ghost,
      ),
    );
  }
}

class _TableFeastPainter extends CustomPainter {
  const _TableFeastPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2;
    final fill =
        Paint()
          ..color = color.withValues(alpha: 0.18)
          ..style = PaintingStyle.fill;
    final baseY = size.height * 0.62;

    for (var i = 0; i < 5; i++) {
      final x = size.width * (0.48 + i * 0.11);
      final radius = size.shortestSide * (0.08 + i * 0.01);
      canvas.drawCircle(Offset(x, baseY + (i.isEven ? -8 : 10)), radius, fill);
      canvas.drawCircle(Offset(x, baseY + (i.isEven ? -8 : 10)), radius, paint);
    }
    canvas.drawLine(
      Offset(size.width * 0.45, size.height * 0.82),
      Offset(size.width * 0.96, size.height * 0.82),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _TableFeastPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _SignatureDishPainter extends CustomPainter {
  const _SignatureDishPainter({required this.color, required this.accent});

  final Color color;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final plate =
        Paint()
          ..color = color.withValues(alpha: 0.12)
          ..style = PaintingStyle.fill;
    final rim =
        Paint()
          ..color = color.withValues(alpha: 0.24)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4;
    final garnish =
        Paint()
          ..color = accent.withValues(alpha: 0.26)
          ..style = PaintingStyle.fill;

    final center = Offset(size.width * 0.50, size.height * 0.54);
    final radius = size.shortestSide * 0.34;
    canvas.drawCircle(center, radius, plate);
    canvas.drawCircle(center, radius, rim);
    canvas.drawCircle(
      Offset(size.width * 0.34, size.height * 0.36),
      radius * 0.18,
      garnish,
    );
    canvas.drawCircle(
      Offset(size.width * 0.64, size.height * 0.30),
      radius * 0.14,
      garnish,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width * 0.55, size.height * 0.66),
        width: radius * 1.15,
        height: radius * 0.55,
      ),
      0.1,
      2.8,
      false,
      rim,
    );
  }

  @override
  bool shouldRepaint(covariant _SignatureDishPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.accent != accent;
  }
}
