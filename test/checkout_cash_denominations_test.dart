import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('checkoutCashChangeDenominationsForTotal', () {
    test('excludes denominations at or below the order total', () {
      expect(
        checkoutCashChangeDenominationsForTotal(1.5),
        [5, 10, 20, 50],
      );
      expect(
        checkoutCashChangeDenominationsForTotal(13),
        [20, 50],
      );
      expect(
        checkoutCashChangeDenominationsForTotal(0.5),
        [1, 5, 10, 20, 50],
      );
    });

    test('offers every denomination when total is more than 50', () {
      expect(
        checkoutCashChangeDenominationsForTotal(50.01),
        [1, 5, 10, 20, 50],
      );
      expect(
        checkoutCashChangeDenominationsForTotal(60),
        [1, 5, 10, 20, 50],
      );
    });

    test('keeps filtering at exactly 50', () {
      expect(checkoutCashChangeDenominationsForTotal(50), isEmpty);
    });
  });
}
