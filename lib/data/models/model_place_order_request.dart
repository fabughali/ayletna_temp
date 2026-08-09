import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';

/// Payload for placing an order — mirrors future POST /orders body.
class ModelPlaceOrderRequest {
  const ModelPlaceOrderRequest({
    required this.lines,
    required this.draft,
    this.promoSavingsJod = 0,
    this.pointsDiscountJod = 0,
  });

  final List<ModelCartLine> lines;
  final CheckoutDraft draft;
  final double promoSavingsJod;
  final double pointsDiscountJod;
}
