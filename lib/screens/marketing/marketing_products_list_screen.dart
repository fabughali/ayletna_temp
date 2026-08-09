import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_product_cards.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Marketing → Products list — same product cards as customer surfaces.
class MarketingProductsListScreen extends ConsumerWidget {
  const MarketingProductsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final itemsAsync = ref.watch(menuAllItemsProvider);

    return WidgetsScaffoldPage(
      title: l10n.menuCatalogTabProducts,
      child: itemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(child: Text(l10n.catalogBrowseEmpty)),
        data: (items) {
          final list = items.isEmpty ? MockupCatalog.items : items;
          return ListView(
            padding: EdgeInsets.all(CoreSpacing.md(context)),
            children: [
              WidgetsAppCard(
                variant: WidgetsAppCardVariant.food,
                padding: EdgeInsets.all(CoreSpacing.lg(context)),
                onTap: () => context.push(AppRoutePaths.marketingProductCreate),
                child: Row(
                  children: [
                    Icon(Icons.add_circle, color: CoreColors.brandGold),
                    SizedBox(width: CoreSpacing.sm(context)),
                    Expanded(
                      child: Text(
                        l10n.marketingProductCreate,
                        style: CoreTypography.titleMedium(
                          context,
                          Theme.of(context).colorScheme.onSurface,
                        ).copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
              SizedBox(height: CoreSpacing.lg(context)),
              WidgetsFoodCatalogGrid(
                children: [
                  for (var i = 0; i < list.length; i++)
                    WidgetsProductCard.fromMenuItem(
                      item: list[i],
                      isAr: isAr,
                      l10n: l10n,
                      index: i,
                      actionLabel: l10n.actionEdit,
                      actionIcon: Icons.edit_outlined,
                      onAction:
                          () => context.push(
                            AppRoutePaths.marketingProductDetail(list[i].id),
                          ),
                      onTap:
                          () => context.push(
                            AppRoutePaths.marketingProductDetail(list[i].id),
                          ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
