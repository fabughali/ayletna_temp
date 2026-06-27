import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CheckoutFulfillment { dineIn, takeaway, delivery, groupDelivery, plated }

enum CheckoutPaymentType { cash, card, wallet }

class CheckoutDraft {
  const CheckoutDraft({
    this.fulfillment = CheckoutFulfillment.delivery,
    this.selectedAddressId,
    this.paymentType = CheckoutPaymentType.card,
    this.tipJod = 0,
    this.promoApplied = false,
  });

  final CheckoutFulfillment fulfillment;
  final String? selectedAddressId;
  final CheckoutPaymentType paymentType;
  final double tipJod;
  final bool promoApplied;

  CheckoutDraft copyWith({
    CheckoutFulfillment? fulfillment,
    String? selectedAddressId,
    CheckoutPaymentType? paymentType,
    double? tipJod,
    bool? promoApplied,
  }) {
    return CheckoutDraft(
      fulfillment: fulfillment ?? this.fulfillment,
      selectedAddressId: selectedAddressId ?? this.selectedAddressId,
      paymentType: paymentType ?? this.paymentType,
      tipJod: tipJod ?? this.tipJod,
      promoApplied: promoApplied ?? this.promoApplied,
    );
  }
}

class CheckoutDraftNotifier extends StateNotifier<CheckoutDraft> {
  CheckoutDraftNotifier() : super(const CheckoutDraft());

  void setFulfillment(CheckoutFulfillment value) {
    state = state.copyWith(fulfillment: value);
  }

  void setAddressId(String? value) {
    state = state.copyWith(selectedAddressId: value);
  }

  void setPaymentType(CheckoutPaymentType value) {
    state = state.copyWith(paymentType: value);
  }

  void setTipJod(double value) {
    state = state.copyWith(tipJod: value);
  }

  void setPromoApplied(bool value) {
    state = state.copyWith(promoApplied: value);
  }

  void reset() {
    state = const CheckoutDraft();
  }
}

final checkoutDraftProvider =
    StateNotifierProvider<CheckoutDraftNotifier, CheckoutDraft>(
      (ref) => CheckoutDraftNotifier(),
    );
