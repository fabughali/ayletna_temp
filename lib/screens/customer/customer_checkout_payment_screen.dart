import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';
import 'package:ayletna_restaurant_app/providers/order_placement_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_checkout_step_strip.dart';
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

    return WidgetsScaffoldPage(
      title: l10n.cartCheckoutStepPayment,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: CoreSpacing.md(context)),
        children: [
          WidgetsCheckoutStepStrip(
            activeStep: 2,
            completedThrough: 1,
            onStepTapped: (step) => _jumpToStep(context, step),
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
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              for (final type in CheckoutPaymentType.values)
                ChoiceChip(
                  label: Text(_paymentLabel(l10n, type)),
                  selected: draft.paymentType == type,
                  onSelected:
                      isSubmitting
                          ? null
                          : (_) => ref
                              .read(checkoutDraftProvider.notifier)
                              .setPaymentType(type),
                ),
            ],
          ),
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
            children: [
              for (final tip in const [0.0, 0.5, 1.0, 2.0])
                ChoiceChip(
                  label: Text(
                    tip == 0
                        ? l10n.cartNoTip
                        : '${tip.toStringAsFixed(2)} ${l10n.currencyJod}',
                  ),
                  selected: draft.tipJod == tip,
                  onSelected:
                      isSubmitting
                          ? null
                          : (_) => ref
                              .read(checkoutDraftProvider.notifier)
                              .setTipJod(tip),
                ),
            ],
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
          SizedBox(height: CoreSpacing.xxl(context)),
          WidgetsAppButton(
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
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.prepBack,
            icon: Icons.arrow_back,
            variant: WidgetsAppButtonVariant.outline,
            fullWidth: true,
            onPressed: isSubmitting ? null : () => context.pop(),
          ),
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
