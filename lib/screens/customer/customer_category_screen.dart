import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_category.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_customer_search_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_responsive_card_grid.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD CategoryScreen.
class CustomerCategoryScreen extends ConsumerWidget {
  const CustomerCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final selectedId = ref.watch(selectedCategoryIdProvider);
    final categoriesAsync = ref.watch(menuCategoriesProvider);
    final itemsAsync = ref.watch(menuAllItemsProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenMenu,
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
          ref.invalidate(menuAllItemsProvider);
        },
        child: categoriesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => SelectableText.rich(TextSpan(text: e.toString())),
          data:
              (categories) => itemsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error:
                    (e, _) => SelectableText.rich(TextSpan(text: e.toString())),
                data: (items) {
                  final selectedItems =
                      items
                          .where((item) => item.categoryId == selectedId)
                          .toList();

                  return ListView(
                    children: [
                      SizedBox(height: CoreSpacing.md(context)),
                      const WidgetsCustomerSearchBar(),
                      SizedBox(height: CoreSpacing.lg(context)),
                      _CategoryHero(
                        title: _titleFor(l10n, categories, selectedId, isAr),
                        description: _descriptionFor(l10n, selectedId),
                        selectedId: selectedId,
                      ),
                      SizedBox(height: CoreSpacing.lg(context)),
                      _CategoryChips(
                        categories: categories,
                        selectedId: selectedId,
                        isAr: isAr,
                        onSelected: (id) {
                          ref.read(selectedCategoryIdProvider.notifier).state =
                              id;
                        },
                      ),
                      SizedBox(height: CoreSpacing.lg(context)),
                      _MenuGrid(
                        items: selectedItems,
                        selectedId: selectedId,
                        isAr: isAr,
                        l10n: l10n,
                      ),
                      SizedBox(height: CoreSpacing.xxl(context)),
                    ],
                  );
                },
              ),
        ),
      ),
    );
  }

  static String _titleFor(
    AppLocalizations l10n,
    List<ModelMenuCategory> categories,
    String selectedId,
    bool isAr,
  ) {
    if (selectedId == 'hummus_ful') {
      return l10n.categoryMezzeTitle;
    }
    return categories
        .firstWhere(
          (category) => category.id == selectedId,
          orElse: () => categories.first,
        )
        .localizedName(isAr);
  }

  static String _descriptionFor(AppLocalizations l10n, String selectedId) {
    if (selectedId == 'hummus_ful') {
      return l10n.categoryMezzeDescription;
    }
    if (selectedId == 'shawarma') {
      return l10n.categoryShawarmaHeroDescription;
    }
    return l10n.screenCategoryDesc;
  }
}

extension on ModelMenuCategory {
  String localizedName(bool isAr) => isAr ? nameAr : nameEn;
}

class _MenuGrid extends ConsumerWidget {
  const _MenuGrid({
    required this.items,
    required this.selectedId,
    required this.isAr,
    required this.l10n,
  });

  final List<ModelMenuItem> items;
  final String selectedId;
  final bool isAr;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (items.isEmpty) {
      return WidgetsAppCard(
        padding: EdgeInsets.all(CoreSpacing.lg(context)),
        child: Text(
          isAr
              ? 'لا توجد أصناف في هذه الفئة حالياً.'
              : 'No items in this category yet.',
          style: CoreTypography.bodyMedium(
            context,
            Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return WidgetsResponsiveCardGrid(
      minCardWidth: 280,
      maxCardWidth: 360,
      children: [
        for (var index = 0; index < items.length; index++)
          _MenuCard(
            index: index,
            item: items[index],
            isAr: isAr,
            priceLabel: UtilityFormatJod.format(
              items[index].priceJod,
              suffix: l10n.currencyJod,
            ),
            badge: _BadgeCopy.forCategory(l10n, selectedId, index),
            onOpen: () {
              ref.read(selectedMenuItemIdProvider.notifier).state =
                  items[index].id;
              context.push(AppRoutePaths.productDetail);
            },
            onAdd: () {
              showWidgetsCartCustomizationSheet(
                context: context,
                item: items[index],
              );
            },
          ),
      ],
    );
  }
}

class _CategoryHero extends StatelessWidget {
  const _CategoryHero({
    required this.title,
    required this.description,
    required this.selectedId,
  });

  final String title;
  final String description;
  final String selectedId;

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
            height: CoreContentSizes.categoryHeroHeight(context) * 0.48,
            badge: _FoodTag(
              label: AppLocalizations.of(context)!.categoryEyebrow,
              color: _categoryTone(context, selectedId),
            ),
            child: CustomPaint(
              painter: _CategoryDishPainter(
                color: _categoryTone(context, selectedId),
                accent: CoreColors.brandGold,
              ),
              child: Center(
                child: Icon(
                  _CategoryIcon.forId(selectedId),
                  size: CoreContentSizes.categoryMenuImageIcon(context) * 1.25,
                  color: scheme.primary,
                ),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            title,
            style: CoreTypography.headlineLarge(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            description,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Color _categoryTone(BuildContext context, String id) {
    final scheme = Theme.of(context).colorScheme;
    return switch (id) {
      'shawarma' => CoreColors.brandGold,
      'hummus_ful' ||
      'falafel' ||
      'manaqeesh' ||
      'pastries' => CoreColors.orderTypePlated,
      'qalayat' || 'sandwiches' || 'snacks' => scheme.secondary,
      'drinks' => scheme.tertiary,
      'pizza' => CoreColors.brandOrange,
      'burgers' => CoreColors.semanticRevenue,
      _ => scheme.primary,
    };
  }
}

class _CategoryChips extends StatelessWidget {
  const _CategoryChips({
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
            _CategoryPickerCard(
              label: categories[index].localizedName(isAr),
              icon: _CategoryIcon.forId(categories[index].id),
              selected: selectedId == categories[index].id,
              color: _CategoryTone.forIndex(context, index),
              onTap: () => onSelected(categories[index].id),
            ),
            SizedBox(width: CoreSpacing.md(context)),
          ],
        ],
      ),
    );
  }
}

class _CategoryPickerCard extends StatelessWidget {
  const _CategoryPickerCard({
    required this.label,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

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
                child: Icon(icon, color: color, size: 28),
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
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.index,
    required this.item,
    required this.isAr,
    required this.priceLabel,
    required this.badge,
    required this.onOpen,
    required this.onAdd,
  });

  final int index;
  final ModelMenuItem item;
  final bool isAr;
  final String priceLabel;
  final String badge;
  final VoidCallback onOpen;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsFoodCard(
      title: isAr ? item.nameAr : item.nameEn,
      description: isAr ? item.descriptionAr : item.descriptionEn,
      priceLabel: priceLabel,
      media: WidgetsMockFoodImage(
        imageUrl: item.imageUrl,
        fallback: _DishMediaIcon(index: index, categoryId: item.categoryId),
      ),
      actionLabel: l10n.actionAddToCart,
      onAction: onAdd,
      onTap: onOpen,
      fillHeight: true,
      badgeLabel: badge,
      loyaltyLabel: l10n.loyaltyPointsShort(item.rewardPoints.toString()),
      badges: [
        _FoodTag(label: badge, color: _CategoryTone.forIndex(context, index)),
      ],
    );
  }
}

class _DishMediaIcon extends StatelessWidget {
  const _DishMediaIcon({required this.index, required this.categoryId});

  final int index;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    final color = _CategoryTone.forIndex(context, index);

    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: _CategoryDishPainter(
            color: color,
            accent: CoreColors.brandGold,
          ),
        ),
        Center(
          child: Icon(
            _itemIcon(categoryId, index),
            size: CoreContentSizes.categoryMenuImageIcon(context),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  IconData _itemIcon(String categoryId, int index) {
    if (categoryId == 'shawarma') {
      return switch (index) {
        0 => Icons.lunch_dining_outlined,
        1 => Icons.dinner_dining_outlined,
        2 => Icons.ramen_dining_outlined,
        _ => Icons.local_fire_department_outlined,
      };
    }

    return switch (categoryId) {
      'qalayat' => Icons.egg_alt_outlined,
      'hummus_ful' => Icons.rice_bowl_outlined,
      'drinks' => Icons.local_bar_outlined,
      'sandwiches' => Icons.lunch_dining_outlined,
      'falafel' => Icons.circle_outlined,
      'pizza' => Icons.local_pizza_outlined,
      'snacks' => Icons.fastfood_outlined,
      'manaqeesh' => Icons.bakery_dining_outlined,
      'pastries' => Icons.breakfast_dining_outlined,
      'burgers' => Icons.lunch_dining,
      _ => Icons.restaurant_outlined,
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

abstract final class _BadgeCopy {
  static String forCategory(
    AppLocalizations l10n,
    String categoryId,
    int index,
  ) {
    if (categoryId == 'shawarma') {
      return switch (index) {
        0 => l10n.badgeHighProtein,
        1 => l10n.badgePlateMeal,
        2 => l10n.badgeKetoChoice,
        _ => l10n.badgeSpicy,
      };
    }

    return switch (index) {
      0 => l10n.badgeSignature,
      1 => l10n.badgeVegetarian,
      2 => l10n.badgeHealthy,
      5 => l10n.badgeFamily,
      _ => l10n.badgeChefFavorite,
    };
  }
}

abstract final class _CategoryIcon {
  static IconData forId(String id) => switch (id) {
    'shawarma' => Icons.kebab_dining_outlined,
    'qalayat' => Icons.egg_alt_outlined,
    'hummus_ful' => Icons.rice_bowl_outlined,
    'drinks' => Icons.local_bar_outlined,
    'sandwiches' => Icons.lunch_dining_outlined,
    'falafel' => Icons.circle_outlined,
    'pizza' => Icons.local_pizza_outlined,
    'snacks' => Icons.fastfood_outlined,
    'manaqeesh' => Icons.bakery_dining_outlined,
    'pastries' => Icons.breakfast_dining_outlined,
    'burgers' => Icons.lunch_dining,
    _ => Icons.restaurant_menu_outlined,
  };
}

abstract final class _CategoryTone {
  static Color forIndex(BuildContext context, int index) {
    final scheme = Theme.of(context).colorScheme;
    return switch (index % 5) {
      0 => scheme.primary,
      1 => CoreColors.brandGold,
      2 => CoreColors.orderTypePlated,
      3 => scheme.secondary,
      _ => scheme.tertiary,
    };
  }
}

class _CategoryDishPainter extends CustomPainter {
  const _CategoryDishPainter({required this.color, required this.accent});

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
          ..color = accent.withValues(alpha: 0.24)
          ..style = PaintingStyle.fill;

    final center = Offset(size.width * 0.50, size.height * 0.54);
    final radius = size.shortestSide * 0.34;
    canvas.drawCircle(center, radius, plate);
    canvas.drawCircle(center, radius, rim);
    canvas.drawCircle(
      Offset(size.width * 0.32, size.height * 0.34),
      radius * 0.16,
      garnish,
    );
    canvas.drawCircle(
      Offset(size.width * 0.68, size.height * 0.33),
      radius * 0.13,
      garnish,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width * 0.53, size.height * 0.65),
        width: radius * 1.12,
        height: radius * 0.55,
      ),
      0.2,
      2.7,
      false,
      rim,
    );
  }

  @override
  bool shouldRepaint(covariant _CategoryDishPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.accent != accent;
  }
}
