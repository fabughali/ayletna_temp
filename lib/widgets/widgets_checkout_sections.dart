import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/cart_checkout_fees_providers.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_financial_summary.dart';
import 'package:flutter/material.dart';

/// Shared cart/checkout monetary breakdown (food + fulfillment fees + tax).
class WidgetsCheckoutSummaryCosts {
  const WidgetsCheckoutSummaryCosts({
    required this.subtotal,
    required this.fulfillmentCharge,
    required this.tax,
  });

  final double subtotal;
  final double fulfillmentCharge;
  final double tax;

  double get totalBeforeSavings => subtotal + fulfillmentCharge + tax;

  static WidgetsCheckoutSummaryCosts calculate({
    required double subtotal,
    required CheckoutFulfillment fulfillment,
    required CartCheckoutFees fees,
  }) {
    final fulfillmentCharge = switch (fulfillment) {
      CheckoutFulfillment.dineIn => subtotal * fees.dineInServiceRate,
      CheckoutFulfillment.takeaway => fees.takeawayPackagingFeeJod,
      CheckoutFulfillment.delivery => fees.deliveryFeeJod,
      CheckoutFulfillment.groupDelivery => fees.groupDeliveryFeeJod,
      CheckoutFulfillment.plated => fees.platedDepositJod,
    };
    final taxableFulfillmentCharge =
        fulfillment == CheckoutFulfillment.plated ? 0.0 : fulfillmentCharge;
    return WidgetsCheckoutSummaryCosts(
      subtotal: subtotal,
      fulfillmentCharge: fulfillmentCharge,
      tax: fees.taxIncludedInPrices
          ? 0
          : (subtotal + taxableFulfillmentCharge) * fees.taxRate,
    );
  }
}

/// Fulfillment picker card — same design as the former cart step-1 card.
class WidgetsCheckoutFulfillmentSection extends StatelessWidget {
  const WidgetsCheckoutFulfillmentSection({
    required this.selected,
    required this.showMore,
    required this.onToggleMore,
    required this.onSelected,
    required this.onTerms,
    super.key,
  });

  final CheckoutFulfillment selected;
  final bool showMore;
  final VoidCallback onToggleMore;
  final ValueChanged<CheckoutFulfillment> onSelected;
  final VoidCallback onTerms;

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
          Text(
            l10n.cartFulfillmentTitle,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.cartFulfillmentSubtitle,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _FulfillmentOption(
            selected: selected == CheckoutFulfillment.dineIn,
            title: l10n.orderTypeDineIn,
            body: l10n.orderTypeDineInBody,
            icon: Icons.table_restaurant_outlined,
            color: CoreColors.orderTypeDineIn,
            onTap: () => onSelected(CheckoutFulfillment.dineIn),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _FulfillmentOption(
            selected: selected == CheckoutFulfillment.takeaway,
            title: l10n.orderTypeTakeaway,
            body: l10n.orderTypeTakeawayBody,
            icon: Icons.takeout_dining_outlined,
            color: CoreColors.orderTypeTakeaway,
            onTap: () => onSelected(CheckoutFulfillment.takeaway),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _FulfillmentOption(
            selected: selected == CheckoutFulfillment.delivery,
            title: l10n.orderTypeDeliveryTitle,
            body: l10n.orderTypeDeliveryBody,
            icon: Icons.delivery_dining_outlined,
            color: CoreColors.orderTypeDelivery,
            onTap: () => onSelected(CheckoutFulfillment.delivery),
          ),
          if (showMore) ...[
            SizedBox(height: CoreSpacing.sm(context)),
            _FulfillmentOption(
              selected: selected == CheckoutFulfillment.groupDelivery,
              title: l10n.cartGroupDeliveryTitle,
              body: l10n.cartGroupDeliveryBody,
              icon: Icons.groups_2_outlined,
              color: CoreColors.brandOlive,
              onTap: () => onSelected(CheckoutFulfillment.groupDelivery),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            _FulfillmentOption(
              selected: selected == CheckoutFulfillment.plated,
              title: l10n.orderTypePlatedTitle,
              body: l10n.orderTypePlatedBody,
              icon: Icons.flatware_outlined,
              color: CoreColors.orderTypePlated,
              onTap: () => onSelected(CheckoutFulfillment.plated),
            ),
          ],
          SizedBox(height: CoreSpacing.sm(context)),
          TextButton(
            onPressed: onToggleMore,
            child: Text(
              showMore
                  ? l10n.cartHideFulfillmentOptions
                  : l10n.cartMoreFulfillmentOptions,
            ),
          ),
          Center(
            child: TextButton(
              onPressed: onTerms,
              child: Text(l10n.cartTermsAndConditions),
            ),
          ),
        ],
      ),
    );
  }
}

class _FulfillmentOption extends StatelessWidget {
  const _FulfillmentOption({
    required this.selected,
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final String body;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant:
          selected ? WidgetsAppCardVariant.food : WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      onTap: onTap,
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: color.withValues(alpha: selected ? 0.18 : 0.11),
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? color : scheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

/// Promo code card — same design as the former cart promo block.
class WidgetsCheckoutPromoCodeCard extends StatelessWidget {
  const WidgetsCheckoutPromoCodeCard({
    required this.controller,
    required this.promoApplied,
    required this.savingsJod,
    required this.onApply,
    super.key,
  });

  final TextEditingController controller;
  final bool promoApplied;
  final double savingsJod;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.cartPromoCode,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            promoApplied
                ? UtilityFormatJod.format(savingsJod, suffix: l10n.currencyJod)
                : l10n.cartPromoHint,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsAppTextField(
                  controller: controller,
                  label: l10n.cartPromoCode,
                  hintText: l10n.cartPromoHint,
                  readOnly: promoApplied,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              WidgetsAppButton(
                label: promoApplied ? l10n.actionConfirm : l10n.actionApply,
                onPressed: promoApplied ? null : onApply,
                icon:
                    promoApplied
                        ? Icons.check_circle_outline
                        : Icons.local_offer_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Order summary card — same financial summary design as the former cart card.
class WidgetsCheckoutOrderSummaryCard extends StatelessWidget {
  const WidgetsCheckoutOrderSummaryCard({
    required this.subtotal,
    required this.fulfillment,
    required this.fulfillmentCharge,
    required this.tipJod,
    required this.discount,
    required this.pointsDiscount,
    required this.total,
    super.key,
  });

  final double subtotal;
  final CheckoutFulfillment fulfillment;
  final double fulfillmentCharge;
  final double tipJod;
  final double discount;
  final double pointsDiscount;
  final double total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isPlated = fulfillment == CheckoutFulfillment.plated;
    final jod = l10n.currencyJod;

    final lines = <WidgetsFinancialSummaryLine>[
      WidgetsFinancialSummaryLine(
        label: l10n.checkoutFood,
        value: UtilityFormatJod.format(subtotal, suffix: jod),
        accentColor: CoreColors.semanticRevenue,
      ),
      WidgetsFinancialSummaryLine(
        label: isPlated
            ? l10n.checkoutDeposit
            : _fulfillmentChargeLabel(l10n, fulfillment),
        value:
            fulfillmentCharge == 0
                ? l10n.cartFree
                : UtilityFormatJod.format(fulfillmentCharge, suffix: jod),
        accentColor: isPlated ? CoreColors.semanticDeposit : null,
      ),
      WidgetsFinancialSummaryLine(
        label: l10n.checkoutTip,
        value:
            tipJod == 0
                ? l10n.cartNoTip
                : UtilityFormatJod.format(tipJod, suffix: jod),
        accentColor: CoreColors.semanticTip,
      ),
      if (discount > 0)
        WidgetsFinancialSummaryLine(
          label: l10n.cartPromoCode,
          value: '-${UtilityFormatJod.format(discount, suffix: jod)}',
        ),
      if (pointsDiscount > 0)
        WidgetsFinancialSummaryLine(
          label: l10n.checkoutLoyaltyPointsDiscount,
          value: '-${UtilityFormatJod.format(pointsDiscount, suffix: jod)}',
        ),
    ];

    return WidgetsFinancialSummary(
      title: l10n.cartOrderSummary,
      subtitle:
          '${l10n.cartFulfillment}: ${_fulfillmentTitle(l10n, fulfillment)}',
      lines: lines,
      totalLabel: l10n.cartTotal,
      totalValue: UtilityFormatJod.format(total, suffix: jod),
      totalColor: CoreColors.brandGold,
      accentColor: CoreColors.semanticRevenue,
    );
  }

  String _fulfillmentTitle(
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

  String _fulfillmentChargeLabel(
    AppLocalizations l10n,
    CheckoutFulfillment fulfillment,
  ) {
    return switch (fulfillment) {
      CheckoutFulfillment.dineIn => l10n.cartDineInServiceFee,
      CheckoutFulfillment.takeaway => l10n.cartTakeawayPackagingFee,
      CheckoutFulfillment.delivery => l10n.cartDeliveryFee,
      CheckoutFulfillment.groupDelivery => l10n.cartGroupDeliveryFee,
      CheckoutFulfillment.plated => l10n.cartPlatedDeposit,
    };
  }
}
