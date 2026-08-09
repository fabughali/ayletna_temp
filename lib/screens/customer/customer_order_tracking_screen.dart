import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_url_actions.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_tag.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_error_message.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD OrderTrackingScreen · supports `ayletna://order/{id}`.
class CustomerOrderTrackingScreen extends ConsumerWidget {
  const CustomerOrderTrackingScreen({super.key, this.orderId});

  final String? orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final effectiveId =
        orderId ??
        ref.watch(activeTrackingOrderIdProvider) ??
        ref.watch(placedOrderIdProvider) ??
        MockupCatalog.checkoutOrderDetail.id;
    final orderAsync = ref.watch(orderDetailByIdProvider(effectiveId));

    return WidgetsScaffoldPage(
      title: l10n.screenOrderTracking,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_none,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: orderAsync.when(
        loading:
            () => const Center(child: CircularProgressIndicator()),
        error:
            (_, __) => Center(
              child: WidgetsErrorMessage(message: l10n.orderTrackingLoadError),
            ),
        data:
            (order) => ListView(
              children: [
                SizedBox(height: CoreSpacing.md(context)),
                WidgetsPageHeader(
                  title: l10n.trackingEstimatedArrival,
                  subtitle: l10n.trackingFromRestaurant,
                ),
                _TrackingHeroCard(
                  orderReference: order.reference,
                  statusKey: order.statusKey,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _KitchenProgressCard(
                  orderReference: order.reference,
                  statusKey: order.statusKey,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _OrderSummaryCard(lines: order.lines, totalJod: order.totalJod),
                SizedBox(height: CoreSpacing.lg(context)),
                const _FreshnessPromiseGrid(),
                SizedBox(height: CoreSpacing.lg(context)),
                const _SupportCard(),
                SizedBox(height: CoreSpacing.lg(context)),
                _RatingPromptCard(orderId: order.id),
                SizedBox(height: CoreSpacing.xxl(context)),
              ],
            ),
      ),
    );
  }
}

class _TrackingHeroCard extends StatelessWidget {
  const _TrackingHeroCard({
    required this.orderReference,
    required this.statusKey,
  });

  final String orderReference;
  final String statusKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final etaMinutes = switch (statusKey) {
      'delivered' || 'completed' => 0,
      'on_the_way' || 'out_for_delivery' => 18,
      'ready' || 'quality' => 28,
      _ => 35,
    };
    final etaLabel =
        etaMinutes == 0
            ? l10n.trackingDelivered
            : TimeOfDay.fromDateTime(
              DateTime.now().add(Duration(minutes: etaMinutes)),
            ).format(context);
    final statusBadge = switch (statusKey) {
      'delivered' || 'completed' => l10n.trackingDelivered,
      'on_the_way' || 'out_for_delivery' => l10n.trackingOnTheWay,
      _ => l10n.trackingPreparingKitchen,
    };

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsFoodMediaPanel(
            height: CoreContentSizes.heroImageHeight(context),
            badge: WidgetsFoodTag(
              label: statusBadge,
              color: CoreColors.semanticSuccess,
            ),
            child: CustomPaint(
              painter: _KitchenPassPainter(
                color: scheme.primary,
                accent: CoreColors.brandGold,
              ),
              child: Center(
                child: Icon(
                  Icons.room_service_outlined,
                  color: scheme.primary,
                  size: CoreContentSizes.categoryMenuImageIcon(context),
                ),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.trackingEstimatedArrival,
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      etaLabel,
                      style: CoreTypography.headlineLarge(
                        context,
                        scheme.primary,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              WidgetsPriceBadge(priceLabel: orderReference, compact: true),
            ],
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.trackingFromRestaurant,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _KitchenProgressCard extends StatelessWidget {
  const _KitchenProgressCard({
    required this.orderReference,
    required this.statusKey,
  });

  final String orderReference;
  final String statusKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final stepIndex = switch (statusKey) {
      'delivered' || 'completed' => 4,
      'on_the_way' || 'out_for_delivery' => 3,
      'ready' || 'quality' => 2,
      'preparing' || 'kitchen' => 1,
      _ => 0,
    };

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.adminOrderLabel(orderReference),
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.trackingFromRestaurant,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          _TimelineStep(
            completed: stepIndex > 0,
            active: stepIndex == 0,
            icon: Icons.receipt_long_outlined,
            title: l10n.trackingOrderReceived,
            body: l10n.trackingOrderReceivedBody,
          ),
          _TimelineStep(
            completed: stepIndex > 1,
            active: stepIndex == 1,
            icon: Icons.soup_kitchen_outlined,
            title: l10n.trackingPreparingKitchen,
            body: l10n.trackingPreparingBody,
          ),
          _TimelineStep(
            completed: stepIndex > 2,
            active: stepIndex == 2,
            icon: Icons.verified_outlined,
            title: l10n.trackingQualityAssured,
            body: l10n.trackingQualityBody,
          ),
          _TimelineStep(
            completed: stepIndex > 3,
            active: stepIndex == 3,
            icon: Icons.delivery_dining_outlined,
            title: l10n.trackingOnWayTitle,
            body: l10n.trackingOnWayBody,
            actionLabel: l10n.trackingCallMarcus,
          ),
          _TimelineStep(
            completed: stepIndex >= 4,
            active: stepIndex == 4,
            icon: Icons.home_outlined,
            title: l10n.trackingDelivered,
            body: l10n.trackingDeliveredBody,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.icon,
    required this.title,
    required this.body,
    this.completed = false,
    this.active = false,
    this.isLast = false,
    this.actionLabel,
  });

  final IconData icon;
  final String title;
  final String body;
  final bool completed;
  final bool active;
  final bool isLast;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = active || completed ? scheme.primary : scheme.outline;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: color.withValues(alpha: active ? 0.18 : 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(color: color.withValues(alpha: 0.35)),
                ),
                child: SizedBox.square(
                  dimension: CoreContentSizes.timelineIcon(context),
                  child: Icon(
                    completed ? Icons.check : icon,
                    color: color,
                    size: CoreContentSizes.orderTypeIcon(context),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: CoreContentSizes.timelineLineWidth(context),
                    color: scheme.outlineVariant,
                  ),
                ),
            ],
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.lg(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CoreTypography.bodyMedium(
                      context,
                      active ? scheme.primary : scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: CoreSpacing.xs(context)),
                  Text(
                    body,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                  if (actionLabel != null) ...[
                    SizedBox(height: CoreSpacing.sm(context)),
                    WidgetsAppButton(
                      label: actionLabel!,
                      onPressed: () async {
                        final launched = await UtilityUrlActions.launchExternalUri(
                          Uri.parse('tel:+962790000123'),
                        );
                        if (!launched && context.mounted) {
                          UtilityMockFeedback.showInfo(
                            context,
                            AppLocalizations.of(
                              context,
                            )!.orderHistoryDriverContactBody,
                          );
                        }
                      },
                      icon: Icons.phone_outlined,
                      variant: WidgetsAppButtonVariant.secondary,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({required this.lines, required this.totalJod});

  final List<ModelCartLine> lines;
  final double totalJod;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final totalText = UtilityFormatJod.format(
      totalJod,
      suffix: l10n.currencyJod,
    );

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.plain,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.trackingOrderSummary,
            style: CoreTypography.titleMedium(
              context,
              Theme.of(context).colorScheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (final line in lines) ...[
            _OrderLine(line: line, isArabic: isArabic),
            SizedBox(height: CoreSpacing.sm(context)),
          ],
          Divider(height: CoreSpacing.xl(context)),
          Row(
            children: [
              Expanded(child: Text(l10n.trackingTotal)),
              WidgetsPriceBadge(priceLabel: totalText, compact: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderLine extends StatelessWidget {
  const _OrderLine({required this.line, required this.isArabic});

  final ModelCartLine line;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final name = isArabic ? line.nameAr : line.nameEn;
    final price = UtilityFormatJod.format(
      line.lineTotalJod,
      suffix: l10n.currencyJod,
    );

    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: CoreSpacing.sm(context),
              vertical: CoreSpacing.xs(context),
            ),
            child: Text(
              '${line.quantity}x',
              style: CoreTypography.caption(
                context,
                scheme.primary,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ),
        ),
        SizedBox(width: CoreSpacing.md(context)),
        Expanded(
          child: Text(
            name,
            style: CoreTypography.bodyMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        Text(
          price,
          style: CoreTypography.caption(context, scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _FreshnessPromiseGrid extends StatelessWidget {
  const _FreshnessPromiseGrid();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        _AssuranceCard(
          icon: Icons.verified_outlined,
          title: l10n.trackingQualityAssured,
          body: l10n.trackingQualityBody,
          color: CoreColors.semanticSuccess,
        ),
        SizedBox(height: CoreSpacing.md(context)),
        _AssuranceCard(
          icon: Icons.sensors_outlined,
          title: l10n.trackingNoContactDelivery,
          body: l10n.trackingNoContactBody,
          color: Theme.of(context).colorScheme.primary,
        ),
        SizedBox(height: CoreSpacing.md(context)),
        _AssuranceCard(
          icon: Icons.eco_outlined,
          title: l10n.trackingEcoPackaging,
          body: l10n.trackingEcoBody,
          color: CoreColors.brandGold,
        ),
      ],
    );
  }
}

class _SupportCard extends StatelessWidget {
  const _SupportCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsInfoBanner(
      title: l10n.trackingNeedHelp,
      message: l10n.trackingHelpBody,
      icon: Icons.support_agent_outlined,
      tone: WidgetsInfoBannerTone.warning,
      action: WidgetsAppButton(
        label: l10n.trackingContactSupport,
        onPressed: () => context.push(AppRoutePaths.support),
        icon: Icons.support_agent_outlined,
        variant: WidgetsAppButtonVariant.secondary,
        fullWidth: true,
      ),
    );
  }
}

class _RatingPromptCard extends ConsumerWidget {
  const _RatingPromptCard({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: CoreColors.brandGold.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Icon(Icons.star_rounded, color: CoreColors.brandGold),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.screenRatingReview,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  l10n.ratingRewardLoop,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          WidgetsAppButton(
            label: l10n.ratingSubmit,
            onPressed: () {
              ref.read(ratingOrderIdProvider.notifier).state = orderId;
              context.push(AppRoutePaths.ratingReview);
            },
            icon: Icons.rate_review_outlined,
            variant: WidgetsAppButtonVariant.secondary,
          ),
        ],
      ),
    );
  }
}

class _AssuranceCard extends StatelessWidget {
  const _AssuranceCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.sm(context)),
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
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  body,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KitchenPassPainter extends CustomPainter {
  const _KitchenPassPainter({required this.color, required this.accent});

  final Color color;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final ticketPaint = Paint()..color = color.withValues(alpha: 0.10);
    final borderPaint =
        Paint()
          ..color = color.withValues(alpha: 0.28)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
    final accentPaint =
        Paint()
          ..color = accent.withValues(alpha: 0.34)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round;

    final ticket = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.22,
        size.height * 0.18,
        size.width * 0.56,
        size.height * 0.62,
      ),
      Radius.circular(size.width * 0.04),
    );
    canvas.drawRRect(ticket, ticketPaint);
    canvas.drawRRect(ticket, borderPaint);

    for (var i = 0; i < 4; i++) {
      final y = size.height * (0.34 + i * 0.10);
      canvas.drawLine(
        Offset(size.width * 0.32, y),
        Offset(size.width * 0.68, y),
        accentPaint,
      );
    }

    final domeRect = Rect.fromCenter(
      center: Offset(size.width * 0.5, size.height * 0.68),
      width: size.width * 0.32,
      height: size.height * 0.18,
    );
    canvas.drawArc(domeRect, 3.14, 3.14, false, borderPaint);
    canvas.drawLine(
      Offset(size.width * 0.32, size.height * 0.77),
      Offset(size.width * 0.68, size.height * 0.77),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _KitchenPassPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.accent != accent;
  }
}
