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
    this.receiptPrinted = false,
    this.electronicTicketSent = false,
  });

  final String id;
  final OrderType orderType;
  final String customerLabel;
  final double totalJod;
  final double depositJod;
  final String statusKey;
  final bool isPlated;
  final bool receiptPrinted;
  final bool electronicTicketSent;

  ModelOrderSummary copyWith({
    String? id,
    OrderType? orderType,
    String? customerLabel,
    double? totalJod,
    double? depositJod,
    String? statusKey,
    bool? isPlated,
    bool? receiptPrinted,
    bool? electronicTicketSent,
  }) {
    return ModelOrderSummary(
      id: id ?? this.id,
      orderType: orderType ?? this.orderType,
      customerLabel: customerLabel ?? this.customerLabel,
      totalJod: totalJod ?? this.totalJod,
      depositJod: depositJod ?? this.depositJod,
      statusKey: statusKey ?? this.statusKey,
      isPlated: isPlated ?? this.isPlated,
      receiptPrinted: receiptPrinted ?? this.receiptPrinted,
      electronicTicketSent:
          electronicTicketSent ?? this.electronicTicketSent,
    );
  }
}
