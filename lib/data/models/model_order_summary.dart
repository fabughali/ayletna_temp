import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';

/// Kitchen / delivery / admin order row (UI phase).
class ModelOrderSummary {
  const ModelOrderSummary({
    required this.id,
    required this.orderType,
    required this.customerLabel,
    required this.totalJod,
    required this.depositJod,
    required this.statusKey,
    required this.isPlated,
  });

  final String id;
  final OrderType orderType;
  final String customerLabel;
  final double totalJod;
  final double depositJod;
  final String statusKey;
  final bool isPlated;
}
