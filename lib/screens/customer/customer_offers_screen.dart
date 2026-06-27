import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/customer_offers_providers.dart';
import 'package:ayletna_restaurant_app/data/models/model_list_entry.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
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
    final offers = ref.watch(visibleOfferEntriesProvider);

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
          ref.invalidate(visibleOfferEntriesProvider);
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            const _OffersHero(),
            SizedBox(height: CoreSpacing.lg(context)),
            if (offers.isNotEmpty) ...[
              _FeaturedOfferCard(offer: offers.first),
              SizedBox(height: CoreSpacing.lg(context)),
              for (final offer in offers) ...[
                _OfferCard(offer: offer),
                SizedBox(height: CoreSpacing.md(context)),
              ],
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
            l10n.comingSoon,
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
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsFoodMediaPanel(
            height: CoreContentSizes.heroImageHeight(context),
            badge: _FoodTag(
              label: l10n.guestLimitedOffer,
              color: CoreColors.brandGold,
            ),
            child: _OfferMedia(
              color: scheme.primary,
              icon: Icons.local_offer_outlined,
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.screenOffers,
            style: CoreTypography.headlineLarge(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.screenOffersDesc,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _FeaturedOfferCard extends ConsumerWidget {
  const _FeaturedOfferCard({required this.offer});

  final ModelListEntry offer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final title = isArabic ? offer.titleAr : offer.titleEn;
    final subtitle = isArabic ? offer.subtitleAr : offer.subtitleEn;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      subtitle ?? l10n.guestLimitedOffer,
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              WidgetsPriceBadge(priceLabel: '10%'),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.guestClaimOffer,
            onPressed: () {
              final ok = applyFeaturedOfferToCart(ref);
              if (!ok) {
                UtilityMockFeedback.showWarning(context, l10n.comingSoon);
                return;
              }
              UtilityMockFeedback.showSuccess(context, l10n.guestClaimOffer);
              context.go(AppRoutePaths.cart);
            },
            icon: Icons.shopping_basket_outlined,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _OfferCard extends ConsumerWidget {
  const _OfferCard({required this.offer});

  final ModelListEntry offer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final title = isArabic ? offer.titleAr : offer.titleEn;
    final subtitle = isArabic ? offer.subtitleAr : offer.subtitleEn;
    final isCombo = offer.id == 'o2';
    final color = isCombo ? CoreColors.brandOrange : scheme.primary;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Row(
        children: [
          SizedBox(
            width: CoreContentSizes.categoryMenuImageHeight(context),
            child: WidgetsFoodMediaPanel(
              height: CoreContentSizes.categoryMenuImageHeight(context),
              badge: _FoodTag(
                label: isCombo ? l10n.screenComboBuilder : l10n.screenOffers,
                color: color,
              ),
              child: _OfferMedia(
                color: color,
                icon:
                    isCombo
                        ? Icons.room_service_outlined
                        : Icons.local_offer_outlined,
              ),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  subtitle ?? l10n.guestLimitedOffer,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: isCombo ? l10n.screenComboBuilder : l10n.actionApply,
            onPressed: () {
              if (isComboOfferId(offer.id)) {
                context.push(AppRoutePaths.combo);
                return;
              }
              final ok = applyOfferToCart(ref, offer);
              if (!ok) {
                UtilityMockFeedback.showWarning(context, l10n.comingSoon);
                return;
              }
              UtilityMockFeedback.showSuccess(context, l10n.guestClaimOffer);
              context.go(AppRoutePaths.cart);
            },
            icon:
                isCombo
                    ? Icons.restaurant_menu_outlined
                    : Icons.check_circle_outline,
            variant:
                isCombo
                    ? WidgetsAppButtonVariant.secondary
                    : WidgetsAppButtonVariant.primary,
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
            onPressed: () => context.push(AppRoutePaths.combo),
            icon: Icons.arrow_forward,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
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

class _OfferMedia extends StatelessWidget {
  const _OfferMedia({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: _OfferPainter(color: color, accent: CoreColors.brandGold),
        ),
        Center(
          child: Icon(
            icon,
            color: color,
            size: CoreContentSizes.categoryMenuImageIcon(context),
          ),
        ),
      ],
    );
  }
}

class _OfferPainter extends CustomPainter {
  const _OfferPainter({required this.color, required this.accent});

  final Color color;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final plate = Paint()..color = color.withValues(alpha: 0.12);
    final rim =
        Paint()
          ..color = color.withValues(alpha: 0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2;
    final garnish = Paint()..color = accent.withValues(alpha: 0.34);
    final center = Offset(size.width * 0.5, size.height * 0.56);
    final radius = size.shortestSide * 0.30;
    canvas.drawCircle(center, radius, plate);
    canvas.drawCircle(center, radius, rim);
    canvas.drawCircle(
      Offset(size.width * 0.36, size.height * 0.42),
      radius * 0.15,
      garnish,
    );
    canvas.drawCircle(
      Offset(size.width * 0.62, size.height * 0.43),
      radius * 0.13,
      garnish,
    );
    canvas.drawCircle(
      Offset(size.width * 0.52, size.height * 0.68),
      radius * 0.15,
      garnish,
    );
  }

  @override
  bool shouldRepaint(covariant _OfferPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.accent != accent;
  }
}
