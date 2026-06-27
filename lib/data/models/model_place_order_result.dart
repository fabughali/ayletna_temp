import 'package:ayletna_restaurant_app/data/models/model_order_detail.dart';

/// Result of a successful order placement.
class ModelPlaceOrderResult {
  const ModelPlaceOrderResult({
    required this.orderId,
    required this.detail,
  });

  final String orderId;
  final ModelOrderDetail detail;
}

/// Thrown when order placement fails validation or server-side checks.
class OrderPlacementException implements Exception {
  const OrderPlacementException(this.messageKey);

  final String messageKey;

  @override
  String toString() => 'OrderPlacementException($messageKey)';
}
