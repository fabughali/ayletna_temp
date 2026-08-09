import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_checkout_fees_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';
import 'package:ayletna_restaurant_app/providers/order_placement_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_action_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_checkout_step_strip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_choice_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_filter_chip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_financial_summary.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Stepped checkout — payment method and tip (step 3).
class CustomerCheckoutPaymentScreen extends ConsumerStatefulWidget {
  const CustomerCheckoutPaymentScreen({super.key});

  @override
  ConsumerState<CustomerCheckoutPaymentScreen> createState() =>
      _CustomerCheckoutPaymentScreenState();
}

class _CustomerCheckoutPaymentScreenState
    extends ConsumerState<CustomerCheckoutPaymentScreen> {
  @override
  Widget build(BuildContext context) {
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
    final depositJod =
        draft.fulfillment == CheckoutFulfillment.plated
            ? ref.watch(cartCheckoutFeesProvider).platedDepositJod
            : 0.0;
    final summaryTotal = subtotal + depositJod + draft.tipJod;
    final jod = l10n.currencyJod;

    return WidgetsScaffoldPage(
      title: l10n.cartCheckoutStepPayment,
      bottomSheet: WidgetsActionBar(
        primary: WidgetsAppButton(
          label: isGuest ? l10n.guestSignInToOrder : l10n.cartProceedCheckout,
          icon: Icons.check_circle_outline,
          fullWidth: true,
          onPressed:
              isSubmitting
                  ? null
                  : isGuest
                  ? () => context.push(AppRoutePaths.login)
                  : () => _submitOrder(context),
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
            activeStep: 2,
            completedThrough: 1,
            onStepTapped: (step) => _jumpToStep(context, step),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsPageHeader(
            title: l10n.cartCheckoutStepPayment,
            subtitle: l10n.checkoutPaymentSummaryTitle,
            eyebrow: l10n.checkoutPaymentMethod,
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.cartPaymentType,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (final type in CheckoutPaymentType.values) ...[
            WidgetsChoiceCard(
              title: _paymentLabel(l10n, type),
              icon: _paymentIcon(type),
              selected: draft.paymentType == type,
              onTap:
                  isSubmitting
                      ? () {}
                      : () => ref
                          .read(checkoutDraftProvider.notifier)
                          .setPaymentType(type),
            ),
            if (type != CheckoutPaymentType.values.last)
              SizedBox(height: CoreSpacing.sm(context)),
          ],
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.cartTipTitle,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              for (final tip in const [0.0, 0.5, 1.0, 2.0])
                WidgetsFilterChip(
                  label:
                      tip == 0
                          ? l10n.cartNoTip
                          : '${tip.toStringAsFixed(2)} ${l10n.currencyJod}',
                  selected: draft.tipJod == tip,
                  onSelected:
                      isSubmitting
                          ? (_) {}
                          : (_) => ref
                              .read(checkoutDraftProvider.notifier)
                              .setTipJod(tip),
                ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsFinancialSummary(
            title: l10n.checkoutPaymentSummaryTitle,
            lines: [
              WidgetsFinancialSummaryLine(
                label: l10n.checkoutFood,
                value: UtilityFormatJod.format(subtotal, suffix: jod),
                accentColor: CoreColors.semanticRevenue,
              ),
              if (depositJod > 0)
                WidgetsFinancialSummaryLine(
                  label: l10n.checkoutDeposit,
                  value: UtilityFormatJod.format(depositJod, suffix: jod),
                  accentColor: CoreColors.semanticDeposit,
                ),
              WidgetsFinancialSummaryLine(
                label: l10n.checkoutTip,
                value:
                    draft.tipJod == 0
                        ? l10n.cartNoTip
                        : UtilityFormatJod.format(draft.tipJod, suffix: jod),
                accentColor: CoreColors.semanticTip,
              ),
            ],
            totalLabel: l10n.cartTotal,
            totalValue: UtilityFormatJod.format(summaryTotal, suffix: jod),
            totalColor: CoreColors.brandGold,
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

  Future<void> _submitOrder(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final result = await ref.read(placeOrderProvider.notifier).submit();
    if (!context.mounted) return;

    if (result != null) {
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

  static String _paymentLabel(AppLocalizations l10n, CheckoutPaymentType type) {
    return switch (type) {
      CheckoutPaymentType.cash => l10n.paymentMethodCash,
      CheckoutPaymentType.card => l10n.paymentMethodCard,
      CheckoutPaymentType.wallet => l10n.paymentMethodWallet,
    };
  }

  static IconData _paymentIcon(CheckoutPaymentType type) {
    return switch (type) {
      CheckoutPaymentType.cash => Icons.payments_outlined,
      CheckoutPaymentType.card => Icons.credit_card_outlined,
      CheckoutPaymentType.wallet => Icons.account_balance_wallet_outlined,
    };
  }

  static void _jumpToStep(BuildContext context, int step) {
    switch (step) {
      case 0:
        context.go(AppRoutePaths.cart);
      case 1:
        context.go(AppRoutePaths.checkout);
      case 2:
        break;
      case 3:
        context.push(AppRoutePaths.orderConfirmation);
    }
  }
}
