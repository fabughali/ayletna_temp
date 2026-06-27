import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartCheckoutFees {
  const CartCheckoutFees({
    required this.dineInServiceRate,
    required this.takeawayPackagingFeeJod,
    required this.deliveryFeeJod,
    required this.groupDeliveryFeeJod,
    required this.platedDepositJod,
    required this.taxRate,
    required this.taxIncludedInPrices,
  });

  final double dineInServiceRate;
  final double takeawayPackagingFeeJod;
  final double deliveryFeeJod;
  final double groupDeliveryFeeJod;
  final double platedDepositJod;
  final double taxRate;
  final bool taxIncludedInPrices;
}

final cartCheckoutFeesProvider = Provider<CartCheckoutFees>((ref) {
  final settings = ref.watch(adminSettingsProvider);
  final deposit = ref.watch(adminDepositConfigProvider);
  return CartCheckoutFees(
    dineInServiceRate: MockupCatalog.checkoutDineInServiceRate,
    takeawayPackagingFeeJod: MockupCatalog.checkoutTakeawayPackagingFeeJod,
    deliveryFeeJod: MockupCatalog.checkoutDeliveryFeeJod,
    groupDeliveryFeeJod: MockupCatalog.checkoutGroupDeliveryFeeJod,
    platedDepositJod: deposit.globalDepositJod,
    taxRate: settings.taxIncluded ? 0 : MockupCatalog.checkoutTaxRate,
    taxIncludedInPrices: settings.taxIncluded,
  );
});
