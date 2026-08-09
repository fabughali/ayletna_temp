import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_product_cards.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Customer saved favorites — same catalog card design as menu/offers.
class CustomerFavoritesScreen extends ConsumerWidget {
  const CustomerFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final items = ref.watch(favoriteMenuItemsProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenFavorites,
      actions: const [WidgetsCartIconButton()],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(favoriteMenuItemsProvider);
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsPageHeader(
              title: l10n.screenFavorites,
              subtitle:
                  items.isEmpty
                      ? l10n.favoritesEmptySubtitle
                      : l10n.searchResultsCount(items.length),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            if (items.isEmpty)
              _EmptyFavoritesCard(l10n: l10n)
            else
              WidgetsFoodCatalogGrid(
                children: [
                  for (var index = 0; index < items.length; index++)
                    WidgetsProductCard.fromMenuItem(
                      item: items[index],
                      isAr: isAr,
                      l10n: l10n,
                      index: index,
                      badgeLabel: l10n.screenFavorites,
                      actionLabel: l10n.actionAddToCart,
                      onAction: () {
                        showWidgetsCartCustomizationSheet(
                          context: context,
                          item: items[index],
                        );
                      },
                      onTap: () {
                        ref.read(selectedMenuItemIdProvider.notifier).state =
                            items[index].id;
                        context.push(AppRoutePaths.productDetail);
                      },
                    ),
                ],
              ),
            if (items.isNotEmpty) ...[
              SizedBox(height: CoreSpacing.lg(context)),
              WidgetsAppButton(
                label: l10n.favoritesClearAll,
                icon: Icons.heart_broken_outlined,
                variant: WidgetsAppButtonVariant.secondary,
                onPressed: () {
                  ref.read(favoriteMenuIdsProvider.notifier).clearAll();
                  UtilityMockFeedback.showInfo(context, l10n.favoritesRemoved);
                },
                fullWidth: true,
              ),
            ],
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _EmptyFavoritesCard extends StatelessWidget {
  const _EmptyFavoritesCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        children: [
          Icon(
            Icons.favorite_border,
            color: scheme.primary,
            size: CoreContentSizes.emptyStateIcon(context),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.favoritesEmptyTitle,
            textAlign: TextAlign.center,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.favoritesEmptySubtitle,
            textAlign: TextAlign.center,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppButton(
            label: l10n.screenMenu,
            icon: Icons.restaurant_menu_outlined,
            onPressed: () => context.go(AppRoutePaths.category),
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}
