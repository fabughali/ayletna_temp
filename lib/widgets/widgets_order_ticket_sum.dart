import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Shared ticket / invoice sum row data.
class OrderTicketSumData {
  const OrderTicketSumData({
    required this.itemCount,
    required this.points,
    required this.subtotal,
    required this.fulfillmentLabel,
    required this.fulfillmentCharge,
    required this.fulfillmentSelected,
    required this.tipJod,
    required this.tipConfigured,
    required this.promoSavingsJod,
    required this.paymentSelected,
    required this.selectedPaymentLabel,
    required this.paidTotal,
    required this.receivedValue,
    required this.priorBalanceJod,
    required this.balanceDue,
    required this.total,
  });

  final int itemCount;
  final int points;
  final double subtotal;
  final String? fulfillmentLabel;
  final double fulfillmentCharge;
  final bool fulfillmentSelected;
  final double tipJod;
  final bool tipConfigured;
  final double promoSavingsJod;
  final bool paymentSelected;
  final String selectedPaymentLabel;
  final double paidTotal;
  final double receivedValue;
  final double priorBalanceJod;
  final double balanceDue;
  final double total;
}

class OrderTicketSumRow {
  const OrderTicketSumRow({
    required this.label,
    required this.amount,
    this.emphasized = false,
    this.dividerBefore = false,
  });

  final String label;
  final String amount;
  final bool emphasized;
  final bool dividerBefore;
}

String orderTicketAmount(double amount) => amount.toStringAsFixed(2);

String orderTicketSumLabel(String label, String currency) =>
    '$label ($currency)';

/// Builders for cashier-style ticket and invoice tables.
abstract final class OrderTicketSumBuilders {
  static List<OrderTicketSumRow> invoiceHeaderRows(
    AppLocalizations l10n,
    OrderTicketSumData data,
  ) {
    return [
      OrderTicketSumRow(
        label: l10n.cashierInvoicePoints,
        amount: data.points.toString(),
      ),
      OrderTicketSumRow(
        label: l10n.cashierItemsCount,
        amount: data.itemCount.toString(),
      ),
    ];
  }

  static List<OrderTicketSumRow> invoiceLineRows(
    List<ModelCartLine> cart, {
    required bool isAr,
  }) {
    return [
      for (final line in cart)
        OrderTicketSumRow(
          label: '${line.quantity}x ${isAr ? line.nameAr : line.nameEn}',
          amount: orderTicketAmount(line.lineTotalJod),
        ),
    ];
  }

  static List<OrderTicketSumRow> invoiceSumRows(
    AppLocalizations l10n,
    OrderTicketSumData data,
  ) {
    final currency = l10n.currencyJod;
    return [
      OrderTicketSumRow(
        label: orderTicketSumLabel(l10n.cashierSubtotal, currency),
        amount: orderTicketAmount(data.subtotal),
      ),
      if (data.fulfillmentSelected && data.fulfillmentLabel != null)
        OrderTicketSumRow(
          label: orderTicketSumLabel(data.fulfillmentLabel!, currency),
          amount: orderTicketAmount(data.fulfillmentCharge),
        ),
      OrderTicketSumRow(
        label: orderTicketSumLabel(l10n.cashierTotal, currency),
        amount: orderTicketAmount(data.total),
        emphasized: true,
      ),
    ];
  }

  static List<OrderTicketSumRow> invoicePaymentRows(
    AppLocalizations l10n,
    OrderTicketSumData data,
  ) {
    if (!data.paymentSelected) return const [];
    final currency = l10n.currencyJod;
    return [
      OrderTicketSumRow(
        label: l10n.cashierPaymentMethod,
        amount: data.selectedPaymentLabel,
      ),
      OrderTicketSumRow(
        label: orderTicketSumLabel(l10n.cashierPaidAmount, currency),
        amount: orderTicketAmount(data.paidTotal),
      ),
    ];
  }

  static List<OrderTicketSumRow> leftTicketSumRows(
    AppLocalizations l10n,
    OrderTicketSumData data,
  ) {
    final currency = l10n.currencyJod;
    final paidValue =
        data.receivedValue > 0 ? data.receivedValue : data.paidTotal;

    return [
      OrderTicketSumRow(
        label: l10n.cashierInvoicePoints,
        amount: data.points.toString(),
      ),
      OrderTicketSumRow(
        label: l10n.cashierItemsCount,
        amount: data.itemCount.toString(),
      ),
      OrderTicketSumRow(
        dividerBefore: true,
        label: orderTicketSumLabel(l10n.cashierSubtotal, currency),
        amount: orderTicketAmount(data.subtotal),
      ),
      if (data.fulfillmentSelected && data.fulfillmentLabel != null)
        OrderTicketSumRow(
          label: orderTicketSumLabel(data.fulfillmentLabel!, currency),
          amount: orderTicketAmount(data.fulfillmentCharge),
        ),
      if (data.priorBalanceJod > 0)
        OrderTicketSumRow(
          label: orderTicketSumLabel(l10n.cashierPriorBalance, currency),
          amount: orderTicketAmount(data.priorBalanceJod),
        ),
      if (data.balanceDue > 0)
        OrderTicketSumRow(
          label: orderTicketSumLabel(l10n.cashierBalanceDue, currency),
          amount: orderTicketAmount(data.balanceDue),
        ),
      OrderTicketSumRow(
        dividerBefore: true,
        label: orderTicketSumLabel(l10n.cashierTotal, currency),
        amount: orderTicketAmount(data.total),
        emphasized: true,
      ),
      if (data.paymentSelected) ...[
        OrderTicketSumRow(
          label: l10n.cashierPaymentMethod,
          amount: data.selectedPaymentLabel,
        ),
        OrderTicketSumRow(
          label: orderTicketSumLabel(l10n.cashierPaidAmount, currency),
          amount: orderTicketAmount(paidValue),
        ),
      ],
    ];
  }
}

/// Two-column amount / label table used on cashier tickets and invoices.
class WidgetsOrderTicketSumTable extends StatelessWidget {
  const WidgetsOrderTicketSumTable({required this.rows, super.key});

  final List<OrderTicketSumRow> rows;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const amountColumnWidth = 76.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < rows.length; index++) ...[
          if (rows[index].dividerBefore) ...[
            Divider(
              color: scheme.outlineVariant,
              height: CoreSpacing.md(context),
            ),
          ],
          Padding(
            padding: EdgeInsets.only(
              bottom: index == rows.length - 1 ? 0 : CoreSpacing.sm(context),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: amountColumnWidth,
                  child: Text(
                    rows[index].amount,
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.ltr,
                    style: (rows[index].emphasized
                            ? CoreTypography.titleMedium(
                              context,
                              scheme.primary,
                            )
                            : CoreTypography.bodyMedium(
                              context,
                              scheme.onSurface,
                            ))
                        .copyWith(
                          fontWeight: FontWeight.w900,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                  ),
                ),
                SizedBox(width: CoreSpacing.sm(context)),
                Expanded(
                  child: Text(
                    rows[index].label,
                    style: CoreTypography.bodyMedium(
                      context,
                      rows[index].emphasized
                          ? scheme.onSurface
                          : scheme.onSurfaceVariant,
                    ).copyWith(
                      fontWeight:
                          rows[index].emphasized
                              ? FontWeight.w900
                              : FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
