import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_action_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_illustration_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [PlatedReturnReminderScreen].
class CustomerPlatedReturnReminderScreen extends ConsumerWidget {
  const CustomerPlatedReturnReminderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final plan = ref.watch(platedReturnPlanProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenPlatedReturnReminder,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      bottomSheet: WidgetsActionBar(
        primary: WidgetsAppButton(
          label: l10n.platedReturnSchedulePickup,
          onPressed:
              () => UtilityMockFeedback.showActionSheet(
                context: context,
                title: l10n.platedReturnSchedulePickup,
                message: l10n.platedReturnReadyBody,
                actions: [
                  MockSheetAction(
                    label: l10n.actionConfirm,
                    icon: Icons.delivery_dining_outlined,
                    onSelected: () {
                      ref.read(platedReturnPlanProvider.notifier).state =
                          PlatedReturnPlan.pickupScheduled;
                      UtilityMockFeedback.showSuccess(
                        context,
                        l10n.platedReturnPickupScheduled,
                      );
                    },
                  ),
                ],
              ),
          icon: Icons.delivery_dining_outlined,
          variant: WidgetsAppButtonVariant.secondary,
          fullWidth: true,
        ),
        secondary: WidgetsAppButton(
          label: l10n.platedReturnSelfReturn,
          onPressed: () {
            ref.read(platedReturnPlanProvider.notifier).state =
                PlatedReturnPlan.selfReturnLogged;
            UtilityMockFeedback.showSuccess(
              context,
              l10n.platedReturnSelfReturnLogged,
            );
          },
          icon: Icons.directions_walk_outlined,
          variant: WidgetsAppButtonVariant.outline,
          fullWidth: true,
        ),
      ),
      child: ListView(
        padding: EdgeInsetsDirectional.only(
          top: CoreSpacing.md(context),
          bottom: CoreSpacing.xxl(context) * 3,
        ),
        children: [
          WidgetsPageHeader(
            title: l10n.platedReturnReadyTitle,
            subtitle: l10n.platedReturnReadyBody,
            eyebrow: l10n.screenPlatedReturnReminder,
          ),
          if (plan != PlatedReturnPlan.none) ...[
            WidgetsInfoBanner(
              title:
                  plan == PlatedReturnPlan.pickupScheduled
                      ? l10n.platedReturnPickupScheduled
                      : l10n.platedReturnSelfReturnLogged,
              message: l10n.platedReturnReadyBody,
              icon:
                  plan == PlatedReturnPlan.pickupScheduled
                      ? Icons.delivery_dining_outlined
                      : Icons.directions_walk_outlined,
              tone: WidgetsInfoBannerTone.info,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
          ],
          SizedBox(height: CoreSpacing.lg(context)),
          const _PlatedHeroCard(),
          SizedBox(height: CoreSpacing.xxl(context)),
          const _RefundableDepositCard(),
        ],
      ),
    );
  }
}

class _PlatedHeroCard extends StatelessWidget {
  const _PlatedHeroCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsIllustrationPanel(
      height: CoreContentSizes.heroImageHeight(context) * 1.32,
      badge: WidgetsStatusPill(
        label: l10n.platedReturnBadge,
        icon: Icons.flatware,
        color: CoreColors.brandOrange,
        variant: WidgetsStatusPillVariant.filled,
      ),
      child: CustomPaint(painter: _PlatedDishPainter()),
    );
  }
}

class _RefundableDepositCard extends StatelessWidget {
  const _RefundableDepositCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsInfoBanner(
      title: l10n.platedReturnDepositTitle,
      message: l10n.platedReturnDepositBody,
      icon: Icons.payments_outlined,
      tone: WidgetsInfoBannerTone.success,
    );
  }
}

class _PlatedDishPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final background =
        Paint()
          ..shader = LinearGradient(
            colors: [
              CoreColors.brandBrown.withValues(alpha: 0.95),
              CoreColors.splashGradientBottomLight,
            ],
            begin: AlignmentDirectional.topCenter,
            end: AlignmentDirectional.bottomCenter,
          ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, background);

    final table =
        Paint()
          ..color = CoreColors.surfaceLight.withValues(alpha: 0.58)
          ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.06,
          size.height * 0.18,
          size.width * 0.88,
          size.height * 0.66,
        ),
        Radius.circular(CoreSpacing.radiusCard),
      ),
      table,
    );

    final platePaint =
        Paint()
          ..color = CoreColors.brandOrange
          ..style = PaintingStyle.fill;
    final shadow =
        Paint()
          ..color = CoreColors.brandBrown.withValues(alpha: 0.18)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    final center = Offset(size.width * 0.52, size.height * 0.56);
    canvas.drawOval(
      Rect.fromCenter(
        center: center.translate(0, size.height * 0.05),
        width: size.width * 0.56,
        height: size.height * 0.18,
      ),
      shadow,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: size.width * 0.62,
        height: size.height * 0.24,
      ),
      platePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: size.width * 0.42,
        height: size.height * 0.15,
      ),
      Paint()
        ..color = CoreColors.brandBrown.withValues(alpha: 0.28)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );
    canvas.drawCircle(
      Offset(size.width * 0.50, size.height * 0.42),
      size.shortestSide * 0.14,
      platePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.50, size.height * 0.42),
      size.shortestSide * 0.10,
      Paint()
        ..color = CoreColors.brandBrown.withValues(alpha: 0.20)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5,
    );

    final cutlery =
        Paint()
          ..color = CoreColors.brandBrown.withValues(alpha: 0.75)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;
    canvas.drawLine(
      Offset(size.width * 0.18, size.height * 0.27),
      Offset(size.width * 0.38, size.height * 0.19),
      cutlery,
    );
    canvas.drawLine(
      Offset(size.width * 0.24, size.height * 0.31),
      Offset(size.width * 0.44, size.height * 0.22),
      cutlery,
    );
  }

  @override
  bool shouldRepaint(covariant _PlatedDishPainter oldDelegate) => false;
}
