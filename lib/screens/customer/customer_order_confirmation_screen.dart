import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_detail.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_order_invoice_block.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [OrderConfirmationScreen] redesigned as a warm kitchen handoff.
class CustomerOrderConfirmationScreen extends ConsumerWidget {
  const CustomerOrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final orderAsync = ref.watch(checkoutOrderDetailProvider);

    return orderAsync.when(
      loading:
          () => WidgetsScaffoldPage(
            title: l10n.screenOrderConfirmation,
            child: const Center(child: CircularProgressIndicator()),
          ),
      error:
          (error, _) => WidgetsScaffoldPage(
            title: l10n.screenOrderConfirmation,
            child: Center(child: Text(error.toString())),
          ),
      data:
          (order) =>
              _ConfirmationBody(orderReference: order.reference, order: order),
    );
  }
}

class _ConfirmationBody extends StatelessWidget {
  const _ConfirmationBody({required this.orderReference, required this.order});

  final String orderReference;
  final ModelOrderDetail order;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final totalText = UtilityFormatJod.format(
      order.totalJod,
      suffix: l10n.currencyJod,
    );
    final receiptData = orderTicketSumDataFromOrderDetail(
      order,
      l10n,
      paymentLabel: l10n.paymentMethodCard,
    );

    return WidgetsScaffoldPage(
      title: l10n.screenOrderConfirmation,
      child: ListView(
        children: [
          SizedBox(height: CoreSpacing.md(context)),
          _ConfirmationHero(totalText: totalText),
          SizedBox(height: CoreSpacing.lg(context)),
          _KitchenHandoffCard(orderReference: orderReference),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsOrderInvoiceBlock(
            cart: order.lines,
            sumData: receiptData,
            showTitle: true,
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          const _FreshnessTimelineCard(),
          SizedBox(height: CoreSpacing.lg(context)),
          _DeliveryDetailsCard(totalText: totalText),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppButton(
            label: l10n.orderConfirmedTrack,
            onPressed: () => context.go(AppRoutePaths.orderTracking),
            icon: Icons.soup_kitchen_outlined,
            fullWidth: true,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.orderConfirmedHome,
            onPressed: () => context.go(AppRoutePaths.home),
            icon: Icons.restaurant_menu_outlined,
            variant: WidgetsAppButtonVariant.outline,
            fullWidth: true,
          ),
          SizedBox(height: CoreSpacing.xxl(context)),
        ],
      ),
    );
  }
}

class _ConfirmationHero extends StatelessWidget {
  const _ConfirmationHero({required this.totalText});

  final String totalText;

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
              label: l10n.orderConfirmedArrival,
              color: CoreColors.semanticSuccess,
            ),
            child: CustomPaint(
              painter: _KitchenHandoffPainter(
                color: scheme.primary,
                accent: CoreColors.brandGold,
              ),
              child: Center(
                child: Icon(
                  Icons.check_circle_outline,
                  size: CoreContentSizes.successIcon(context),
                  color: scheme.primary,
                ),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.orderConfirmedThanks,
            style: CoreTypography.headlineLarge(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.orderConfirmedSuccess,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: WidgetsPriceBadge(priceLabel: totalText),
          ),
        ],
      ),
    );
  }
}

class _KitchenHandoffCard extends StatelessWidget {
  const _KitchenHandoffCard({required this.orderReference});

  final String orderReference;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(CoreSpacing.sm(context)),
                  child: Icon(
                    Icons.soup_kitchen_outlined,
                    color: scheme.primary,
                  ),
                ),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.orderConfirmedNumberLabel,
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      orderReference,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              _FoodTag(
                label: l10n.orderConfirmedType,
                color: CoreColors.orderTypePlated,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsInfoBanner(
            title: l10n.orderConfirmedAddressLabel,
            message: l10n.orderConfirmedAddress,
            icon: Icons.location_on_outlined,
            tone: WidgetsInfoBannerTone.info,
          ),
        ],
      ),
    );
  }
}

class _FreshnessTimelineCard extends StatelessWidget {
  const _FreshnessTimelineCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.trackingPreparingKitchen,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _MiniKitchenStep(
            icon: Icons.receipt_long_outlined,
            title: l10n.trackingOrderReceived,
            body: l10n.trackingOrderReceivedBody,
            color: CoreColors.semanticSuccess,
          ),
          _MiniKitchenStep(
            icon: Icons.restaurant_outlined,
            title: l10n.trackingPreparingKitchen,
            body: l10n.trackingPreparingBody,
            color: scheme.primary,
          ),
          _MiniKitchenStep(
            icon: Icons.verified_outlined,
            title: l10n.trackingQualityAssured,
            body: l10n.trackingQualityBody,
            color: CoreColors.brandGold,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _MiniKitchenStep extends StatelessWidget {
  const _MiniKitchenStep({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color color;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : CoreSpacing.md(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
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

class _DeliveryDetailsCard extends StatelessWidget {
  const _DeliveryDetailsCard({required this.totalText});

  final String totalText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.plain,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        children: [
          _DetailRow(
            label: l10n.orderConfirmedArrivalLabel,
            value: l10n.orderConfirmedArrival,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _DetailRow(label: l10n.trackingTotal, value: totalText),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.orderConfirmedEmailSent,
            textAlign: TextAlign.center,
            style: CoreTypography.caption(
              context,
              scheme.onSurfaceVariant,
            ).copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
        ),
        SizedBox(width: CoreSpacing.md(context)),
        Text(
          value,
          textAlign: TextAlign.end,
          style: CoreTypography.bodyMedium(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w800),
        ),
      ],
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

class _KitchenHandoffPainter extends CustomPainter {
  const _KitchenHandoffPainter({required this.color, required this.accent});

  final Color color;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final platePaint = Paint()..color = color.withValues(alpha: 0.12);
    final rimPaint =
        Paint()
          ..color = color.withValues(alpha: 0.28)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5;
    final steamPaint =
        Paint()
          ..color = accent.withValues(alpha: 0.42)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round;

    final center = Offset(size.width * 0.5, size.height * 0.62);
    final radius = size.shortestSide * 0.28;
    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: radius * 2.5,
        height: radius * 0.78,
      ),
      platePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: radius * 2.5,
        height: radius * 0.78,
      ),
      rimPaint,
    );

    for (final x in [0.38, 0.5, 0.62]) {
      final path =
          Path()
            ..moveTo(size.width * x, size.height * 0.40)
            ..cubicTo(
              size.width * (x - 0.04),
              size.height * 0.31,
              size.width * (x + 0.05),
              size.height * 0.27,
              size.width * x,
              size.height * 0.18,
            );
      canvas.drawPath(path, steamPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _KitchenHandoffPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.accent != accent;
  }
}
