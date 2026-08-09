import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_checkout_fees_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_promo_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';
import 'package:ayletna_restaurant_app/providers/rewards_admin_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_action_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_switch.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_checkout_sections.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_checkout_step_strip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_choice_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_filter_chip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Stepped checkout — payment, order summary, COD change, points (step 3).
class CustomerCheckoutPaymentScreen extends ConsumerStatefulWidget {
  const CustomerCheckoutPaymentScreen({super.key});

  @override
  ConsumerState<CustomerCheckoutPaymentScreen> createState() =>
      _CustomerCheckoutPaymentScreenState();
}

class _CustomerCheckoutPaymentScreenState
    extends ConsumerState<CustomerCheckoutPaymentScreen> {
  static const _presetTips = [0.0, 0.5, 1.0, 2.0];

  final _promoController = TextEditingController();
  final _cashTenderedController = TextEditingController();
  final _customTipController = TextEditingController();
  bool _customTipSelected = false;

  @override
  void initState() {
    super.initState();
    final tip = ref.read(checkoutDraftProvider).tipJod;
    final isPreset = _presetTips.any((p) => (p - tip).abs() < 0.001);
    if (!isPreset && tip > 0) {
      _customTipSelected = true;
      _customTipController.text = tip.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _promoController.dispose();
    _cashTenderedController.dispose();
    _customTipController.dispose();
    super.dispose();
  }

  void _selectPresetTip(double tip) {
    setState(() => _customTipSelected = false);
    ref.read(checkoutDraftProvider.notifier).setTipJod(tip);
  }

  void _selectCustomTip() {
    setState(() => _customTipSelected = true);
    final parsed = double.tryParse(_customTipController.text.trim());
    ref.read(checkoutDraftProvider.notifier).setTipJod(
      parsed == null || parsed < 0 ? 0 : parsed,
    );
  }

  void _onCustomTipChanged(String raw) {
    final parsed = double.tryParse(raw.trim());
    ref.read(checkoutDraftProvider.notifier).setTipJod(
      parsed == null || parsed < 0 ? 0 : double.parse(parsed.toStringAsFixed(2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final draft = ref.watch(checkoutDraftProvider);
    final isGuest = ref.watch(appRoleProvider) == AppRole.guest;
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
    if (promo.applied &&
        _promoController.text.trim().isEmpty &&
        promo.code != null) {
      _promoController.text = promo.code!;
    }

    final pointsBalance = ref.watch(loyaltyPointsProvider).balance;
    final pointsValue = checkoutPointsValueJod(pointsBalance);
    // Tax is not shown on the summary; payable excludes estimated tax.
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

    final tendered = draft.cashTenderedJod;
    final changeDue =
        draft.paymentType == CheckoutPaymentType.cash &&
                tendered != null &&
                tendered >= summaryTotal
            ? double.parse((tendered - summaryTotal).toStringAsFixed(2))
            : null;

    if (draft.cashTenderedJod != null &&
        _cashTenderedController.text.trim().isEmpty) {
      _cashTenderedController.text = draft.cashTenderedJod!.toStringAsFixed(2);
    }

    final jod = l10n.currencyJod;

    return WidgetsScaffoldPage(
      title: l10n.cartCheckoutStepPayment,
      showLeading: false,
      actions: const [],
      bottomSheet: WidgetsActionBar(
        primary: WidgetsAppButton(
          label: isGuest ? l10n.guestSignInToOrder : l10n.actionContinue,
          icon: Icons.arrow_forward,
          fullWidth: true,
          onPressed:
              isGuest
                  ? () => context.push(AppRoutePaths.login)
                  : () => _continueToReview(context, summaryTotal),
        ),
        secondary: WidgetsAppButton(
          label: l10n.prepBack,
          icon: Icons.arrow_back,
          variant: WidgetsAppButtonVariant.outline,
          fullWidth: true,
          onPressed: () => context.pop(),
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
                  () => ref
                      .read(checkoutDraftProvider.notifier)
                      .setPaymentType(type),
            ),
            if (type != CheckoutPaymentType.values.last)
              SizedBox(height: CoreSpacing.sm(context)),
          ],
          if (draft.paymentType == CheckoutPaymentType.cash) ...[
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAppCard(
              variant: WidgetsAppCardVariant.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.checkoutCashTenderedLabel,
                    style: CoreTypography.titleMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: CoreSpacing.md(context)),
                  WidgetsAppTextField(
                    controller: _cashTenderedController,
                    label: l10n.checkoutCashTenderedLabel,
                    hintText: l10n.checkoutCashTenderedHint,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (raw) {
                      final parsed = double.tryParse(raw.trim());
                      ref
                          .read(checkoutDraftProvider.notifier)
                          .setCashTenderedJod(parsed);
                    },
                  ),
                  if (changeDue != null) ...[
                    SizedBox(height: CoreSpacing.md(context)),
                    Text(
                      l10n.checkoutCashChangeDue(
                        UtilityFormatJod.format(changeDue, suffix: jod),
                      ),
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.primary,
                      ).copyWith(fontWeight: FontWeight.w800),
                    ),
                  ] else if (tendered != null && tendered < summaryTotal) ...[
                    SizedBox(height: CoreSpacing.md(context)),
                    Text(
                      l10n.checkoutCashChangeNeedMore,
                      style: CoreTypography.caption(
                        context,
                        CoreColors.semanticError,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppCard(
            variant: WidgetsAppCardVariant.form,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.checkoutUseLoyaltyPoints,
                        style: CoreTypography.titleMedium(
                          context,
                          scheme.onSurface,
                        ).copyWith(fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: CoreSpacing.xs(context)),
                      Text(
                        l10n.checkoutLoyaltyPointsAvailable(
                          '$pointsBalance',
                          UtilityFormatJod.format(pointsValue, suffix: jod),
                        ),
                        style: CoreTypography.caption(
                          context,
                          scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                WidgetsAppSwitch(
                  value: draft.useLoyaltyPoints,
                  onChanged:
                      pointsBalance > 0
                          ? (value) => ref
                              .read(checkoutDraftProvider.notifier)
                              .setUseLoyaltyPoints(value)
                          : null,
                ),
              ],
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.cartTipTitle,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.cartTipSubtitle,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              for (final tip in _presetTips)
                WidgetsFilterChip(
                  label:
                      tip == 0
                          ? l10n.cartNoTip
                          : '${tip.toStringAsFixed(2)} ${l10n.currencyJod}',
                  selected: !_customTipSelected && draft.tipJod == tip,
                  onSelected: (_) => _selectPresetTip(tip),
                ),
              WidgetsFilterChip(
                label: l10n.tipCustom,
                selected: _customTipSelected,
                onSelected: (_) => _selectCustomTip(),
              ),
            ],
          ),
          if (_customTipSelected) ...[
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppCard(
              variant: WidgetsAppCardVariant.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.tipCustomAmountBody,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: CoreSpacing.md(context)),
                  WidgetsAppTextField(
                    controller: _customTipController,
                    label: l10n.tipCustomAmountJod,
                    hintText: l10n.tipCustomAmountValue,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: _onCustomTipChanged,
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsCheckoutPromoCodeCard(
            controller: _promoController,
            promoApplied: promo.applied,
            savingsJod: discount,
            onApply: () {
              final ok = ref.read(cartPromoProvider.notifier).applyCode(
                _promoController.text,
                costs.totalBeforeSavings,
              );
              if (!ok) {
                UtilityMockFeedback.showWarning(
                  context,
                  l10n.cartInvalidPromoCode,
                );
                return;
              }
              ref.read(checkoutDraftProvider.notifier).setPromoApplied(true);
              UtilityMockFeedback.showSuccess(context, l10n.cartPromoCode);
            },
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
        ],
      ),
    );
  }

  void _continueToReview(BuildContext context, double summaryTotal) {
    final l10n = AppLocalizations.of(context)!;
    final draft = ref.read(checkoutDraftProvider);
    if (draft.paymentType == CheckoutPaymentType.cash) {
      final tendered = draft.cashTenderedJod;
      if (tendered == null || tendered < summaryTotal) {
        UtilityMockFeedback.showWarning(
          context,
          l10n.checkoutCashChangeNeedMore,
        );
        return;
      }
    }
    context.push(AppRoutePaths.checkoutReview);
  }

  static String _paymentLabel(AppLocalizations l10n, CheckoutPaymentType type) {
    return switch (type) {
      CheckoutPaymentType.cliq => l10n.paymentMethodCliq,
      CheckoutPaymentType.card => l10n.paymentMethodVisaMaster,
      CheckoutPaymentType.cash => l10n.paymentMethodCashOnDelivery,
    };
  }

  static IconData _paymentIcon(CheckoutPaymentType type) {
    return switch (type) {
      CheckoutPaymentType.cliq => Icons.phone_iphone_outlined,
      CheckoutPaymentType.card => Icons.credit_card_outlined,
      CheckoutPaymentType.cash => Icons.payments_outlined,
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
        context.push(AppRoutePaths.checkoutReview);
    }
  }
}
