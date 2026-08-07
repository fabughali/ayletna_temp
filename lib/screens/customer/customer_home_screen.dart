import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_list_entry.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_category.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_product_cards.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_category_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_search_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_hero.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_home_loading_skeleton.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
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
      actions: const [
        WidgetsCartIconButton(),
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
                        const WidgetsSearchBar(),
                        SizedBox(height: CoreSpacing.lg(context)),
                        _HomeFoodHero(item: _featuredItem(), isAr: isAr),
                        SizedBox(height: CoreSpacing.xl(context)),
                        _SectionHeader(
                          title: l10n.homePopularThisWeek,
                          actionLabel: l10n.homeViewAll,
                          onAction: () => context.push(AppRoutePaths.category),
                        ),
                        SizedBox(height: CoreSpacing.md(context)),
                        _PopularGrid(items: _popularItems(), isAr: isAr),
                        SizedBox(height: CoreSpacing.xl(context)),
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
                        _HomeFeatureSections(
                          offers: ref.watch(visibleOfferEntriesProvider),
                          combos: ref.watch(visibleComboEntriesProvider),
                          isAr: isAr,
                        ),
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

}

class _HomeFeatureSections extends StatelessWidget {
  const _HomeFeatureSections({
    required this.offers,
    required this.combos,
    required this.isAr,
  });

  final List<ModelListEntry> offers;
  final List<ModelListEntry> combos;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Single secondary promo rail — prefer offers, else combos.
    if (offers.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
        ],
      );
    }
    if (combos.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
            actionLabel: l10n.homeViewAll,
            onTap: (_) => context.push(AppRoutePaths.combo),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
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
        imageUrl: item.primaryImageUrl ?? item.imageUrl,
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
            WidgetsCategoryCard.fromCategory(
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
    final l10n = AppLocalizations.of(context)!;
    return WidgetsFoodCatalogGrid(
      children: [
        for (var index = 0; index < items.length; index++)
          WidgetsProductCard.fromMenuItem(
            item: items[index],
            isAr: isAr,
            l10n: l10n,
            index: index,
            badgeLabel: _popularBadge(l10n, index),
            onAction: () => _addItem(context, ref, items[index]),
            onTap: () => _openItem(context, ref, items[index]),
          ),
      ],
    );
  }

  String _popularBadge(AppLocalizations l10n, int index) {
    return switch (index) {
      0 => l10n.orderTypeDineIn,
      1 => l10n.orderTypeTakeaway,
      2 => l10n.badgePlated,
      _ => l10n.orderTypeDelivery,
    };
  }

  void _addItem(BuildContext context, WidgetRef ref, ModelMenuItem item) {
    showWidgetsCartCustomizationSheet(context: context, item: item);
  }

  void _openItem(BuildContext context, WidgetRef ref, ModelMenuItem item) {
    ref.read(selectedMenuItemIdProvider.notifier).state = item.id;
    context.push(AppRoutePaths.productDetail);
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
