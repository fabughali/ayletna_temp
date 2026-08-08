import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_product_cards.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Browse all subscription meal plans.
class CustomerSubscriptionsScreen extends ConsumerWidget {
  const CustomerSubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final meals = ref.watch(visibleSubscriptionsProvider);

    return WidgetsScaffoldPage(
      title: l10n.homeSubscriptions,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(visibleSubscriptionsProvider);
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsPageHeader(
              title: l10n.homeSubscriptions,
              subtitle:
                  meals.isEmpty
                      ? l10n.catalogBrowseEmpty
                      : l10n.searchResultsCount(meals.length),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsInfoBanner(
              message: l10n.marketingSubscriptionContentOnly,
              icon: Icons.info_outline,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            if (meals.isEmpty)
              _EmptySubscriptionsCard(l10n: l10n)
            else
              WidgetsFoodCatalogGrid(
                children: [
                  for (var index = 0; index < meals.length; index++)
                    _SubscriptionGridCard(
                      meal: meals[index],
                      index: index,
                      isAr: isAr,
                      linkedItem: ref.watch(
                        menuItemByIdProvider(meals[index].menuItemId),
                      ),
                    ),
                ],
              ),
            SizedBox(height: CoreSpacing.lg(context)),
            const _LoyaltyInvite(),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionGridCard extends ConsumerWidget {
  const _SubscriptionGridCard({
    required this.meal,
    required this.index,
    required this.isAr,
    required this.linkedItem,
  });

  final ModelSubscriptionMeal meal;
  final int index;
  final bool isAr;
  final ModelMenuItem? linkedItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsSubscriptionCard(
      meal: meal,
      isAr: isAr,
      l10n: l10n,
      index: index,
      imageUrl: meal.primaryImageUrl ?? linkedItem?.primaryImageUrl,
      actionLabel: l10n.homeSubscriptionCta,
      onTap: () => context.push(AppRoutePaths.subscriptionDetail(meal.id)),
      onAction: () {
        if (linkedItem != null) {
          showWidgetsCartCustomizationSheet(
            context: context,
            item: linkedItem!,
          );
          return;
        }
        context.push(AppRoutePaths.subscriptionDetail(meal.id));
      },
    );
  }
}

class _EmptySubscriptionsCard extends StatelessWidget {
  const _EmptySubscriptionsCard({required this.l10n});

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
            Icons.calendar_month_outlined,
            color: scheme.primary,
            size: CoreContentSizes.productHeroIcon(context) * 0.36,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.homeSubscriptions,
            textAlign: TextAlign.center,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.catalogBrowseEmpty,
            textAlign: TextAlign.center,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _LoyaltyInvite extends StatelessWidget {
  const _LoyaltyInvite();

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
              color: CoreColors.brandGold.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Icon(Icons.loyalty_outlined, color: CoreColors.brandGold),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.screenLoyalty,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  l10n.screenLoyaltyDesc,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          WidgetsAppButton(
            label: l10n.homeViewAll,
            onPressed: () => context.push(AppRoutePaths.loyalty),
            icon: Icons.arrow_forward,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}
