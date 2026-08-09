import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_detail.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_order_invoice_block.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_order_ticket_sum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('confirmation invoice sum rows match step-4 order summary lines', (
    tester,
  ) async {
    late AppLocalizations l10n;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            l10n = AppLocalizations.of(context)!;
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    const order = ModelOrderDetail(
      id: 'SV-1',
      reference: '#SV-1',
      customerNameAr: 'عميل',
      customerNameEn: 'Guest',
      statusKey: 'pending',
      lines: [
        ModelCartLine(
          itemId: 'hummus',
          nameAr: 'حمص',
          nameEn: 'Hummus',
          unitPriceJod: 2,
          quantity: 2,
        ),
      ],
      deliveryFeeJod: 1.5,
      depositJod: 0,
      tipJod: 0.5,
      fulfillment: CheckoutFulfillment.delivery,
      promoSavingsJod: 0.25,
      pointsDiscountJod: 1,
      paymentType: CheckoutPaymentType.cliq,
    );

    // Food 4 + delivery 1.5 + tip 0.5 - promo 0.25 - points 1 = 4.75
    expect(order.totalJod, 4.75);

    final data = orderTicketSumDataFromOrderDetail(order, l10n);
    final rows = OrderTicketSumBuilders.invoiceSumRows(l10n, data);

    expect(rows.map((r) => r.label).toList(), [
      '${l10n.checkoutFood} (${l10n.currencyJod})',
      '${l10n.cartDeliveryFee} (${l10n.currencyJod})',
      '${l10n.checkoutTip} (${l10n.currencyJod})',
      '${l10n.cartPromoCode} (${l10n.currencyJod})',
      '${l10n.checkoutLoyaltyPointsDiscount} (${l10n.currencyJod})',
      '${l10n.cartTotal} (${l10n.currencyJod})',
    ]);
    expect(rows.map((r) => r.amount).toList(), [
      '4.00',
      '1.50',
      '0.50',
      '-0.25',
      '-1.00',
      '4.75',
    ]);
    expect(data.selectedPaymentLabel, l10n.paymentMethodCliq);
  });
}
