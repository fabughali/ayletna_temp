import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CheckoutFulfillment { dineIn, takeaway, delivery, groupDelivery, plated }

/// Customer stepped-checkout payment options.
enum CheckoutPaymentType { cliq, card, cash }

/// Mock redeem rate: 800 loyalty points = 1.00 JOD (matches 200 pts → 0.25 JOD).
const double kCheckoutRedeemPointsPerJod = 800;

/// COD bill denominations offered as an optional “bring change” note.
const List<double> kCheckoutCashChangeDenominations = [
  1,
  5,
  10,
  20,
  50,
];

/// Denominations the customer may select for cash-on-delivery change.
///
/// Normally only values **strictly greater** than [orderTotalJod] are offered.
/// When the total is **more than 50 JOD**, every denomination is offered.
List<double> checkoutCashChangeDenominationsForTotal(double orderTotalJod) {
  if (orderTotalJod > 50) {
    return List<double>.unmodifiable(kCheckoutCashChangeDenominations);
  }
  return kCheckoutCashChangeDenominations
      .where((amount) => amount > orderTotalJod)
      .toList(growable: false);
}

class CheckoutDraft {
  const CheckoutDraft({
    this.fulfillment = CheckoutFulfillment.delivery,
    this.selectedAddressId,
    this.paymentType = CheckoutPaymentType.card,
    this.tipJod = 0,
    this.promoApplied = false,
    this.useLoyaltyPoints = false,
    this.cashTenderedJod,
  });

  final CheckoutFulfillment fulfillment;
  final String? selectedAddressId;
  final CheckoutPaymentType paymentType;
  final double tipJod;
  final bool promoApplied;
  final bool useLoyaltyPoints;
  /// Amount the customer will hand the courier (COD). Null when not set.
  final double? cashTenderedJod;

  CheckoutDraft copyWith({
    CheckoutFulfillment? fulfillment,
    String? selectedAddressId,
    CheckoutPaymentType? paymentType,
    double? tipJod,
    bool? promoApplied,
    bool? useLoyaltyPoints,
    double? cashTenderedJod,
    bool clearCashTendered = false,
  }) {
    return CheckoutDraft(
      fulfillment: fulfillment ?? this.fulfillment,
      selectedAddressId: selectedAddressId ?? this.selectedAddressId,
      paymentType: paymentType ?? this.paymentType,
      tipJod: tipJod ?? this.tipJod,
      promoApplied: promoApplied ?? this.promoApplied,
      useLoyaltyPoints: useLoyaltyPoints ?? this.useLoyaltyPoints,
      cashTenderedJod:
          clearCashTendered
              ? null
              : (cashTenderedJod ?? this.cashTenderedJod),
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
    state = state.copyWith(
      paymentType: value,
      clearCashTendered: value != CheckoutPaymentType.cash,
    );
  }

  void setTipJod(double value) {
    state = state.copyWith(tipJod: value);
  }

  void setPromoApplied(bool value) {
    state = state.copyWith(promoApplied: value);
  }

  void setUseLoyaltyPoints(bool value) {
    state = state.copyWith(useLoyaltyPoints: value);
  }

  void setCashTenderedJod(double? value) {
    state = state.copyWith(
      cashTenderedJod: value,
      clearCashTendered: value == null,
    );
  }

  void reset() {
    state = const CheckoutDraft();
  }
}

final checkoutDraftProvider =
    StateNotifierProvider<CheckoutDraftNotifier, CheckoutDraft>(
      (ref) => CheckoutDraftNotifier(),
    );

/// JOD value of [points] at the checkout redeem rate.
double checkoutPointsValueJod(int points) {
  if (points <= 0) return 0;
  return double.parse(
    (points / kCheckoutRedeemPointsPerJod).toStringAsFixed(2),
  );
}
