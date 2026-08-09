import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_detail.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_order_ticket_sum.dart';
import 'package:flutter/material.dart';

String checkoutPaymentTypeLabel(
  AppLocalizations l10n,
  CheckoutPaymentType type,
) {
  return switch (type) {
    CheckoutPaymentType.cliq => l10n.paymentMethodCliq,
    CheckoutPaymentType.card => l10n.paymentMethodVisaMaster,
    CheckoutPaymentType.cash => l10n.paymentMethodCashOnDelivery,
  };
}

String checkoutFulfillmentChargeLabel(
  AppLocalizations l10n,
  CheckoutFulfillment fulfillment,
) {
  return switch (fulfillment) {
    CheckoutFulfillment.dineIn => l10n.cartDineInServiceFee,
    CheckoutFulfillment.takeaway => l10n.cartTakeawayPackagingFee,
    CheckoutFulfillment.delivery => l10n.cartDeliveryFee,
    CheckoutFulfillment.groupDelivery => l10n.cartGroupDeliveryFee,
    CheckoutFulfillment.plated => l10n.checkoutDeposit,
  };
}

/// Maps [ModelOrderDetail] to shared ticket sum data for receipts.
OrderTicketSumData orderTicketSumDataFromOrderDetail(
  ModelOrderDetail order,
  AppLocalizations l10n, {
  String? paymentLabel,
  double? paidTotal,
}) {
  return OrderTicketSumData(
    itemCount: order.lines.fold<int>(0, (sum, line) => sum + line.quantity),
    points: 0,
    subtotal: order.foodSubtotalJod,
    fulfillmentLabel: checkoutFulfillmentChargeLabel(l10n, order.fulfillment),
    fulfillmentCharge: order.fulfillmentChargeJod,
    fulfillmentSelected: true,
    tipJod: order.tipJod,
    tipConfigured: true,
    promoSavingsJod: order.promoSavingsJod,
    pointsDiscountJod: order.pointsDiscountJod,
    paymentSelected: true,
    selectedPaymentLabel:
        paymentLabel ?? checkoutPaymentTypeLabel(l10n, order.paymentType),
    paidTotal: paidTotal ?? order.totalJod,
    receivedValue: order.cashTenderedJod ?? 0,
    priorBalanceJod: 0,
    balanceDue: 0,
    total: order.totalJod,
  );
}

/// Cashier-style invoice block reusable across POS, customer, and admin flows.
class WidgetsOrderInvoiceBlock extends StatelessWidget {
  const WidgetsOrderInvoiceBlock({
    required this.cart,
    required this.sumData,
    this.onCancel,
    this.showTitle = false,
    this.bare = false,
    super.key,
  });

  final List<ModelCartLine> cart;
  final OrderTicketSumData sumData;
  final VoidCallback? onCancel;
  final bool showTitle;
  final bool bare;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final headerRows = OrderTicketSumBuilders.invoiceHeaderRows(l10n, sumData);
    final lineRows = OrderTicketSumBuilders.invoiceLineRows(cart, isAr: isAr);
    final sumRows = OrderTicketSumBuilders.invoiceSumRows(l10n, sumData);
    final paymentRows = OrderTicketSumBuilders.invoicePaymentRows(
      l10n,
      sumData,
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (onCancel != null)
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: IconButton(
              onPressed: onCancel,
              icon: const Icon(Icons.close_rounded),
              tooltip: l10n.actionCancel,
            ),
          ),
        if (showTitle) ...[
          Center(
            child: Text(
              l10n.cashierClientInvoice,
              style: CoreTypography.titleMedium(
                context,
                scheme.primary,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
        ],
        WidgetsOrderTicketSumTable(rows: headerRows),
        Divider(color: scheme.outlineVariant, height: CoreSpacing.lg(context)),
        if (lineRows.isNotEmpty) ...[
          WidgetsOrderTicketSumTable(rows: lineRows),
          Divider(
            color: scheme.outlineVariant,
            height: CoreSpacing.lg(context),
          ),
        ],
        WidgetsOrderTicketSumTable(rows: sumRows),
        if (paymentRows.isNotEmpty) ...[
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsOrderTicketSumTable(rows: paymentRows),
        ],
      ],
    );

    if (bare) {
      return SingleChildScrollView(child: content);
    }

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: SingleChildScrollView(child: content),
    );
  }
}
