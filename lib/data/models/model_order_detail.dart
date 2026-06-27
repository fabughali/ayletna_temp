import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';

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

  double get foodSubtotalJod {
    return lines.fold<double>(0, (sum, line) => sum + line.lineTotalJod);
  }

  double get totalJod => foodSubtotalJod + deliveryFeeJod + depositJod + tipJod;
}
