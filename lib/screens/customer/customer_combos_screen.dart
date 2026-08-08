import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/customer_offers_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_product_cards.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Browse all catalog combo bundles.
class CustomerCombosScreen extends ConsumerWidget {
  const CustomerCombosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final combos = ref.watch(visibleCombosProvider);

    return WidgetsScaffoldPage(
      title: l10n.homeCombos,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(visibleCombosProvider);
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsPageHeader(
              title: l10n.homeCombos,
              subtitle:
                  combos.isEmpty
                      ? l10n.catalogBrowseEmpty
                      : l10n.searchResultsCount(combos.length),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            if (combos.isEmpty)
              _EmptyCombosCard(l10n: l10n)
            else
              WidgetsFoodCatalogGrid(
                children: [
                  for (var index = 0; index < combos.length; index++)
                    WidgetsComboProductCard(
                      combo: combos[index],
                      index: index,
                      isAr: isAr,
                      l10n: l10n,
                      onTap:
                          () => context.push(
                            AppRoutePaths.comboDetail(combos[index].id),
                          ),
                      onAction: () {
                        addComboToCart(ref, combos[index]);
                        if (!context.mounted) return;
                        UtilityMockFeedback.showSuccess(
                          context,
                          l10n.actionAddToCart,
                        );
                      },
                    ),
                ],
              ),
            SizedBox(height: CoreSpacing.lg(context)),
            const _ComboBuilderInvite(),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _EmptyCombosCard extends StatelessWidget {
  const _EmptyCombosCard({required this.l10n});

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
            Icons.room_service_outlined,
            color: scheme.primary,
            size: CoreContentSizes.productHeroIcon(context) * 0.36,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.homeCombos,
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

class _ComboBuilderInvite extends StatelessWidget {
  const _ComboBuilderInvite();

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
              color: scheme.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Icon(Icons.tune_outlined, color: scheme.primary),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.screenComboBuilder,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  l10n.screenComboBuilderDesc,
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
            onPressed: () => context.push(AppRoutePaths.combo),
            icon: Icons.arrow_forward,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}
