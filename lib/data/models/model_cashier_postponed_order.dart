import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';

/// Saved cashier order awaiting payment (mock phase).
class ModelCashierPostponedOrder {
  const ModelCashierPostponedOrder({
    required this.id,
    required this.cartLines,
    required this.fulfillmentKey,
    required this.tipJod,
    required this.promoSavingsJod,
    required this.balanceJod,
    required this.paidJod,
    required this.totalJod,
    required this.reasonKey,
    required this.reasonNote,
    required this.tableNumber,
    required this.address,
    required this.customerPhone,
    required this.building,
    required this.floor,
    required this.accessCode,
    required this.contactPerson,
    required this.deliveryTime,
    required this.createdAt,
  });

  final String id;
  final List<ModelCartLine> cartLines;
  final String fulfillmentKey;
  final double tipJod;
  final double promoSavingsJod;
  final double balanceJod;
  final double paidJod;
  final double totalJod;
  final String reasonKey;
  final String reasonNote;
  final String tableNumber;
  final String address;
  final String customerPhone;
  final String building;
  final String floor;
  final String accessCode;
  final String contactPerson;
  final String deliveryTime;
  final DateTime createdAt;
}
