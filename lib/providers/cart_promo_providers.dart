import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPromoState {
  const CartPromoState({
    this.code,
    this.applied = false,
    this.discountJod = 0,
  });

  final String? code;
  final bool applied;
  final double discountJod;

  CartPromoState copyWith({
    String? code,
    bool? applied,
    double? discountJod,
  }) {
    return CartPromoState(
      code: code ?? this.code,
      applied: applied ?? this.applied,
      discountJod: discountJod ?? this.discountJod,
    );
  }
}

class CartPromoNotifier extends StateNotifier<CartPromoState> {
  CartPromoNotifier(this.ref) : super(const CartPromoState());

  final Ref ref;

  bool applyCode(String rawCode, double orderSubtotal) {
    final code = rawCode.trim().toUpperCase();
    if (code.isEmpty || orderSubtotal <= 0) return false;

    double discount = 0;
    if (code == 'AYLETNA10' || code == 'SAVE10') {
      discount = orderSubtotal * 0.10;
    } else if (code == 'WELCOME') {
      discount = MockupCatalog.checkoutPromoSavingsJod;
    } else {
      final discounts = ref.read(visibleDiscountsProvider);
      if (discounts.isNotEmpty) {
        discount = orderSubtotal * (discounts.first.percentOff / 100);
      }
    }

    if (discount <= 0) return false;

    discount = discount.clamp(0, orderSubtotal);
    state = CartPromoState(
      code: rawCode.trim(),
      applied: true,
      discountJod: double.parse(discount.toStringAsFixed(2)),
    );
    return true;
  }

  void clear() => state = const CartPromoState();
}

final cartPromoProvider =
    StateNotifierProvider<CartPromoNotifier, CartPromoState>(
      (ref) => CartPromoNotifier(ref),
    );

final cartPromoDiscountProvider = Provider<double>((ref) {
  final promo = ref.watch(cartPromoProvider);
  return promo.applied ? promo.discountJod : 0;
});
