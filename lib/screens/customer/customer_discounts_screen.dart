import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_product_cards.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
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
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(visibleDiscountItemIdsProvider);
          if (context.mounted) {
            UtilityMockFeedback.showInfo(context, l10n.homeDiscounts);
          }
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsPageHeader(
              title: l10n.homeDiscounts,
              subtitle:
                  items.isEmpty
                      ? l10n.customerDiscountsEmptyTitle
                      : l10n.searchResultsCount(items.length),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            if (items.isEmpty)
              _EmptyDiscountsCard(l10n: l10n)
            else
              WidgetsFoodCatalogGrid(
                children: [
                  for (var index = 0; index < items.length; index++)
                    WidgetsDiscountProductCard(
                      item: items[index],
                      isAr: isAr,
                      l10n: l10n,
                      index: index,
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
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
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
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        children: [
          Icon(
            Icons.discount_outlined,
            color: scheme.primary,
            size: CoreContentSizes.productHeroIcon(context) * 0.36,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.customerDiscountsEmptyTitle,
            textAlign: TextAlign.center,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
