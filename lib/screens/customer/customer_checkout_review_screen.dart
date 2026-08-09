import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_checkout_fees_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_promo_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';
import 'package:ayletna_restaurant_app/providers/order_placement_providers.dart';
import 'package:ayletna_restaurant_app/providers/rewards_admin_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_action_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_checkout_sections.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_checkout_step_strip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Stepped checkout — final review before place order (step 4).
class CustomerCheckoutReviewScreen extends ConsumerWidget {
  const CustomerCheckoutReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final draft = ref.watch(checkoutDraftProvider);
    final isGuest = ref.watch(appRoleProvider) == AppRole.guest;
    final placeOrderState = ref.watch(placeOrderProvider);
    final isSubmitting = placeOrderState is AsyncLoading;
    final scheme = Theme.of(context).colorScheme;
    final cartLines = ref.watch(cartProvider);
    final subtotal = cartLines.fold<double>(
      0,
      (sum, line) => sum + line.unitPriceJod * line.quantity,
    );
    final fees = ref.watch(cartCheckoutFeesProvider);
    final costs = WidgetsCheckoutSummaryCosts.calculate(
      subtotal: subtotal,
      fulfillment: draft.fulfillment,
      fees: fees,
    );
    final promo = ref.watch(cartPromoProvider);
    final discount = promo.applied ? promo.discountJod : 0.0;
    final pointsBalance = ref.watch(loyaltyPointsProvider).balance;
    final pointsValue = checkoutPointsValueJod(pointsBalance);
    final afterPromo =
        (costs.subtotal + costs.fulfillmentCharge - discount + draft.tipJod)
            .clamp(0.0, double.infinity);
    final pointsDiscount =
        draft.useLoyaltyPoints
            ? double.parse(
              pointsValue.clamp(0.0, afterPromo).toStringAsFixed(2),
            )
            : 0.0;
    final summaryTotal = double.parse(
      (afterPromo - pointsDiscount).toStringAsFixed(2),
    );
    final jod = l10n.currencyJod;
    final changeDue =
        draft.paymentType == CheckoutPaymentType.cash &&
                draft.cashTenderedJod != null
            ? double.parse(
              (draft.cashTenderedJod! - summaryTotal).clamp(0, 9999)
                  .toStringAsFixed(2),
            )
            : null;

    return WidgetsScaffoldPage(
      title: l10n.cartCheckoutStepReview,
      showLeading: false,
      actions: const [],
      bottomSheet: WidgetsActionBar(
        primary: WidgetsAppButton(
          label:
              isGuest
                  ? l10n.guestSignInToOrder
                  : l10n.checkoutPlaceOrderAmount(
                    UtilityFormatJod.format(summaryTotal, suffix: jod),
                  ),
          icon: Icons.check_circle_outline,
          fullWidth: true,
          onPressed:
              isSubmitting
                  ? null
                  : isGuest
                  ? () => context.push(AppRoutePaths.login)
                  : () => _submitOrder(context, ref),
        ),
        secondary: WidgetsAppButton(
          label: l10n.prepBack,
          icon: Icons.arrow_back,
          variant: WidgetsAppButtonVariant.outline,
          fullWidth: true,
          onPressed: isSubmitting ? null : () => context.pop(),
        ),
      ),
      child: ListView(
        padding: EdgeInsetsDirectional.only(
          top: CoreSpacing.md(context),
          bottom: CoreSpacing.xxl(context) * 3,
        ),
        children: [
          WidgetsCheckoutStepStrip(
            activeStep: 3,
            completedThrough: 2,
            onStepTapped: (step) => _jumpToStep(context, step),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsPageHeader(
            title: l10n.cartCheckoutStepReview,
            subtitle: l10n.checkoutReviewSubtitle,
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppCard(
            variant: WidgetsAppCardVariant.form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ReviewRow(
                  label: l10n.cartFulfillment,
                  value: _fulfillmentLabel(l10n, draft.fulfillment),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                _ReviewRow(
                  label: l10n.checkoutPaymentMethod,
                  value: _paymentLabel(l10n, draft.paymentType),
                ),
                if (draft.paymentType == CheckoutPaymentType.cash &&
                    draft.cashTenderedJod != null) ...[
                  SizedBox(height: CoreSpacing.sm(context)),
                  _ReviewRow(
                    label: l10n.checkoutCashTenderedLabel,
                    value: UtilityFormatJod.format(
                      draft.cashTenderedJod!,
                      suffix: jod,
                    ),
                  ),
                  if (changeDue != null) ...[
                    SizedBox(height: CoreSpacing.sm(context)),
                    _ReviewRow(
                      label: l10n.checkoutCashChangeDue(
                        UtilityFormatJod.format(changeDue, suffix: jod),
                      ),
                      value: '',
                      emphasize: true,
                    ),
                  ],
                ],
                if (draft.useLoyaltyPoints && pointsDiscount > 0) ...[
                  SizedBox(height: CoreSpacing.sm(context)),
                  _ReviewRow(
                    label: l10n.checkoutLoyaltyPointsDiscount,
                    value:
                        '-${UtilityFormatJod.format(pointsDiscount, suffix: jod)}',
                  ),
                ],
                if (promo.applied && promo.code != null) ...[
                  SizedBox(height: CoreSpacing.sm(context)),
                  _ReviewRow(
                    label: l10n.cartPromoCode,
                    value: promo.code!,
                  ),
                ],
                SizedBox(height: CoreSpacing.sm(context)),
                Text(
                  l10n.cartOrderItemsCount(cartLines.length),
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsCheckoutOrderSummaryCard(
            subtotal: subtotal,
            fulfillment: draft.fulfillment,
            fulfillmentCharge: costs.fulfillmentCharge,
            tipJod: draft.tipJod,
            discount: discount,
            pointsDiscount: pointsDiscount,
            total: summaryTotal,
          ),
          if (placeOrderState case AsyncError(:final error)) ...[
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAsyncStateCard.error(
              title: l10n.screenOrderConfirmation,
              message: orderPlacementErrorMessage(l10n, error),
            ),
          ],
          if (isSubmitting) ...[
            SizedBox(height: CoreSpacing.lg(context)),
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }

  Future<void> _submitOrder(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final draft = ref.read(checkoutDraftProvider);
    final balance = ref.read(loyaltyPointsProvider).balance;
    var pointsToRedeem = 0;
    if (draft.useLoyaltyPoints && balance > 0) {
      final cartLines = ref.read(cartProvider);
      final subtotal = cartLines.fold<double>(
        0,
        (sum, line) => sum + line.unitPriceJod * line.quantity,
      );
      final fees = ref.read(cartCheckoutFeesProvider);
      final costs = WidgetsCheckoutSummaryCosts.calculate(
        subtotal: subtotal,
        fulfillment: draft.fulfillment,
        fees: fees,
      );
      final discount =
          ref.read(cartPromoProvider).applied
              ? ref.read(cartPromoProvider).discountJod
              : 0.0;
      final afterPromo =
          (costs.subtotal + costs.fulfillmentCharge - discount + draft.tipJod)
              .clamp(0.0, double.infinity);
      final pointsDiscount = checkoutPointsValueJod(
        balance,
      ).clamp(0.0, afterPromo);
      pointsToRedeem =
          (pointsDiscount * kCheckoutRedeemPointsPerJod).round().clamp(
            0,
            balance,
          );
    }

    final result = await ref.read(placeOrderProvider.notifier).submit();
    if (!context.mounted) return;

    if (result != null) {
      if (pointsToRedeem > 0) {
        ref.read(loyaltyPointsProvider.notifier).redeem(
          pointsToRedeem,
          rewardTitleEn: 'Checkout points redemption',
          rewardTitleAr: 'استبدال نقاط عند الدفع',
        );
      }
      ref.read(cartPromoProvider.notifier).clear();
      UtilityMockFeedback.showSuccess(context, l10n.screenOrderConfirmation);
      context.go(AppRoutePaths.orderConfirmation);
      return;
    }

    final state = ref.read(placeOrderProvider);
    if (state case AsyncError(:final error)) {
      UtilityMockFeedback.showError(
        context,
        orderPlacementErrorMessage(l10n, error),
      );
    }
  }

  static String _fulfillmentLabel(
    AppLocalizations l10n,
    CheckoutFulfillment fulfillment,
  ) {
    return switch (fulfillment) {
      CheckoutFulfillment.dineIn => l10n.orderTypeDineIn,
      CheckoutFulfillment.takeaway => l10n.orderTypeTakeaway,
      CheckoutFulfillment.delivery => l10n.orderTypeDeliveryTitle,
      CheckoutFulfillment.groupDelivery => l10n.cartGroupDeliveryTitle,
      CheckoutFulfillment.plated => l10n.orderTypePlatedTitle,
    };
  }

  static String _paymentLabel(AppLocalizations l10n, CheckoutPaymentType type) {
    return switch (type) {
      CheckoutPaymentType.cliq => l10n.paymentMethodCliq,
      CheckoutPaymentType.card => l10n.paymentMethodVisaMaster,
      CheckoutPaymentType.cash => l10n.paymentMethodCashOnDelivery,
    };
  }

  static void _jumpToStep(BuildContext context, int step) {
    switch (step) {
      case 0:
        context.go(AppRoutePaths.cart);
      case 1:
        context.go(AppRoutePaths.checkout);
      case 2:
        context.go(AppRoutePaths.payment);
      case 3:
        break;
    }
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (value.isEmpty) {
      return Text(
        label,
        style: CoreTypography.bodyMedium(
          context,
          emphasize ? scheme.primary : scheme.onSurface,
        ).copyWith(fontWeight: FontWeight.w800),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: CoreTypography.bodyMedium(
              context,
              scheme.onSurfaceVariant,
            ),
          ),
        ),
        SizedBox(width: CoreSpacing.sm(context)),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: CoreTypography.bodyMedium(
              context,
              emphasize ? scheme.primary : scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
