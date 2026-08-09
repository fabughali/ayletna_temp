import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/customer_offers_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_product_cards.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_tag.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [OffersScreen] redesigned as a food deals flow.
class CustomerOffersScreen extends ConsumerWidget {
  const CustomerOffersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final offers = ref.watch(visibleOffersProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenOffers,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(visibleOffersProvider);
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsPageHeader(
              title: l10n.screenOffers,
              subtitle: l10n.screenOffersDesc,
            ),
            const _OffersHero(),
            SizedBox(height: CoreSpacing.lg(context)),
            if (offers.isNotEmpty) ...[
              WidgetsFoodCatalogGrid(
                children: [
                  for (var i = 0; i < offers.length; i++)
                    _OfferCard(offer: offers[i], index: i),
                ],
              ),
            ] else ...[
              _EmptyOffersCard(l10n: l10n),
              SizedBox(height: CoreSpacing.lg(context)),
            ],
            const _ComboBuilderInvite(),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _EmptyOffersCard extends StatelessWidget {
  const _EmptyOffersCard({required this.l10n});

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
            Icons.local_offer_outlined,
            color: scheme.primary,
            size: CoreContentSizes.productHeroIcon(context) * 0.36,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.screenOffers,
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

class _OffersHero extends StatelessWidget {
  const _OffersHero();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsFoodMediaPanel(
            height: CoreContentSizes.heroImageHeight(context),
            badge: WidgetsFoodTag(
              label: l10n.guestLimitedOffer,
              color: CoreColors.brandGold,
            ),
            child: _OfferFallbackMedia(
              color: CoreColors.brandGold,
              icon: Icons.local_offer_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class _OfferCard extends ConsumerWidget {
  const _OfferCard({required this.offer, required this.index});

  final ModelCatalogOffer offer;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final isCombo = isComboOfferId(offer.id);

    return WidgetsOfferProductCard.fromOffer(
      offer: offer,
      isAr: isArabic,
      l10n: l10n,
      index: index,
      actionLabel: isCombo ? l10n.screenComboBuilder : l10n.guestClaimOffer,
      actionIcon:
          isCombo
              ? Icons.restaurant_menu_outlined
              : Icons.local_offer_outlined,
      onAction: () {
        if (isCombo) {
          context.push(AppRoutePaths.offerDetail(offer.id));
          return;
        }
        final ok = applyOfferToCart(ref, offer);
        if (!ok) {
          context.push(AppRoutePaths.offerDetail(offer.id));
          return;
        }
        UtilityMockFeedback.showSuccess(context, l10n.guestClaimOffer);
        context.go(AppRoutePaths.cart);
      },
      onTap: () => context.push(AppRoutePaths.offerDetail(offer.id)),
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
              child: Icon(Icons.room_service_outlined, color: scheme.primary),
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
            onPressed: () => context.push(AppRoutePaths.combos),
            icon: Icons.arrow_forward,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}

class _OfferFallbackMedia extends StatelessWidget {
  const _OfferFallbackMedia({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color.withValues(alpha: 0.10),
      child: Center(
        child: Icon(
          icon,
          color: color,
          size: CoreContentSizes.categoryMenuImageIcon(context),
        ),
      ),
    );
  }
}
