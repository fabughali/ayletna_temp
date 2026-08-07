import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_category.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_product_cards.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_category_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_search_bar.dart';
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
      actions: const [
        WidgetsCartIconButton(),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(menuCategoriesProvider);
          ref.invalidate(menuAllItemsProvider);
        },
        child: categoriesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (error, _) => WidgetsAsyncStateCard.error(
                title: l10n.screenMenu,
                message: error.toString(),
                actionLabel: l10n.homeViewAll,
                onAction: () {
                  ref.invalidate(menuCategoriesProvider);
                  ref.invalidate(menuAllItemsProvider);
                },
              ),
          data:
              (categories) => itemsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error:
                    (innerError, _) => WidgetsAsyncStateCard.error(
                      title: l10n.screenMenu,
                      message: innerError.toString(),
                      actionLabel: l10n.homeViewAll,
                      onAction: () {
                        ref.invalidate(menuCategoriesProvider);
                        ref.invalidate(menuAllItemsProvider);
                      },
                    ),
                data: (items) {
                  final selectedItems =
                      items
                          .where(
                            (item) =>
                                item.categoryId == selectedId &&
                                item.isAvailable,
                          )
                          .toList();

                  return ListView(
                    children: [
                      SizedBox(height: CoreSpacing.md(context)),
                      const WidgetsSearchBar(),
                      SizedBox(height: CoreSpacing.lg(context)),
                      _CategoryHeader(
                        title: _titleFor(l10n, categories, selectedId, isAr),
                        description: _descriptionFor(
                          l10n,
                          categories,
                          selectedId,
                          isAr,
                        ),
                      ),
                      SizedBox(height: CoreSpacing.md(context)),
                      _CategoryCards(
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
    return categories
        .firstWhere(
          (category) => category.id == selectedId,
          orElse: () => categories.first,
        )
        .localizedName(isAr);
  }

  static String _descriptionFor(
    AppLocalizations l10n,
    List<ModelMenuCategory> categories,
    String selectedId,
    bool isAr,
  ) {
    final category = categories.firstWhere(
      (c) => c.id == selectedId,
      orElse: () => categories.first,
    );
    return (isAr ? category.descriptionAr : category.descriptionEn) ??
        l10n.screenCategoryDesc;
  }
}

extension on ModelMenuCategory {
  String localizedName(bool isAr) => isAr ? nameAr : nameEn;
}

class _MenuGrid extends ConsumerWidget {
  const _MenuGrid({
    required this.items,
    required this.isAr,
    required this.l10n,
  });

  final List<ModelMenuItem> items;
  final bool isAr;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (items.isEmpty) {
      return WidgetsAsyncStateCard.empty(
        title: l10n.screenMenu,
        message: l10n.categoryEmptyMessage,
      );
    }

    return WidgetsFoodCatalogGrid(
      children: [
        for (var index = 0; index < items.length; index++)
          WidgetsProductCard.fromMenuItem(
            item: items[index],
            isAr: isAr,
            l10n: l10n,
            index: index,
            onAction:
                () => showWidgetsCartCustomizationSheet(
                  context: context,
                  item: items[index],
                ),
            onTap: () {
              ref.read(selectedMenuItemIdProvider.notifier).state =
                  items[index].id;
              context.push(AppRoutePaths.productDetail);
            },
          ),
      ],
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: CoreTypography.headlineSmall(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Text(
          description,
          style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _CategoryCards extends StatelessWidget {
  const _CategoryCards({
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
              selected: selectedId == categories[index].id,
              label: categories[index].localizedName(isAr),
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
