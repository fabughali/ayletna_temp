import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';

/// Shared mock order detail used across review and detail screens.
class ModelOrderDetail {
  const ModelOrderDetail({
    required this.id,
    required this.reference,
    required this.customerNameAr,
    required this.customerNameEn,
    required this.statusKey,
    required this.lines,
    required this.deliveryFeeJod,
    required this.depositJod,
    required this.tipJod,
    this.fulfillment = CheckoutFulfillment.delivery,
    this.promoSavingsJod = 0,
    this.pointsDiscountJod = 0,
    this.paymentType = CheckoutPaymentType.card,
    this.cashTenderedJod,
  });

  final String id;
  final String reference;
  final String customerNameAr;
  final String customerNameEn;
  final String statusKey;
  final List<ModelCartLine> lines;
  final double deliveryFeeJod;
  final double depositJod;
  final double tipJod;
  final CheckoutFulfillment fulfillment;
  final double promoSavingsJod;
  final double pointsDiscountJod;
  final CheckoutPaymentType paymentType;
  final double? cashTenderedJod;

  double get foodSubtotalJod {
    return lines.fold<double>(0, (sum, line) => sum + line.lineTotalJod);
  }

  /// Charge shown on checkout summary / invoice (service, packaging, delivery, or deposit).
  double get fulfillmentChargeJod =>
      fulfillment == CheckoutFulfillment.plated ? depositJod : deliveryFeeJod;

  double get totalJod =>
      (foodSubtotalJod +
              fulfillmentChargeJod +
              tipJod -
              promoSavingsJod -
              pointsDiscountJod)
          .clamp(0.0, double.infinity);

  ModelOrderDetail copyWith({
    String? id,
    String? reference,
    String? customerNameAr,
    String? customerNameEn,
    String? statusKey,
    List<ModelCartLine>? lines,
    double? deliveryFeeJod,
    double? depositJod,
    double? tipJod,
    CheckoutFulfillment? fulfillment,
    double? promoSavingsJod,
    double? pointsDiscountJod,
    CheckoutPaymentType? paymentType,
    double? cashTenderedJod,
    bool clearCashTendered = false,
  }) {
    return ModelOrderDetail(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      customerNameAr: customerNameAr ?? this.customerNameAr,
      customerNameEn: customerNameEn ?? this.customerNameEn,
      statusKey: statusKey ?? this.statusKey,
      lines: lines ?? this.lines,
      deliveryFeeJod: deliveryFeeJod ?? this.deliveryFeeJod,
      depositJod: depositJod ?? this.depositJod,
      tipJod: tipJod ?? this.tipJod,
      fulfillment: fulfillment ?? this.fulfillment,
      promoSavingsJod: promoSavingsJod ?? this.promoSavingsJod,
      pointsDiscountJod: pointsDiscountJod ?? this.pointsDiscountJod,
      paymentType: paymentType ?? this.paymentType,
      cashTenderedJod:
          clearCashTendered
              ? null
              : (cashTenderedJod ?? this.cashTenderedJod),
    );
  }
}
