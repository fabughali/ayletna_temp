import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_order_history.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_detail.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/data/models/model_place_order_request.dart';
import 'package:ayletna_restaurant_app/data/models/model_place_order_result.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_order.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';

class RepositoryOrderMock implements RepositoryOrder {
  RepositoryOrderMock._();

  static final RepositoryOrderMock instance = RepositoryOrderMock._();

  final Map<String, ModelOrderDetail> _placedOrders = {};
  final List<ModelCustomerOrderHistory> _placedHistory = [];
  String? _lastPlacedOrderId;

  String? get lastPlacedOrderId => _lastPlacedOrderId;

  @override
  Future<List<ModelOrderSummary>> fetchActiveOrders() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return MockupCatalog.activeOrders;
  }

  @override
  Future<List<ModelOrderSummary>> fetchOrderHistory() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return MockupCatalog.orderHistory;
  }

  @override
  Future<List<ModelCustomerOrderHistory>> fetchCustomerOrderHistory() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return [..._placedHistory, ...MockupCatalog.customerOrderHistory];
  }

  @override
  Future<ModelOrderDetail> fetchCheckoutOrderDetail() async {
    return fetchOrderDetailById(_lastPlacedOrderId ?? MockupCatalog.checkoutOrderDetail.id);
  }

  @override
  Future<ModelOrderDetail> fetchOrderDetailById(String orderId) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final normalized = orderId.replaceAll('#', '');
    final stored = _placedOrders[normalized] ?? _placedOrders[orderId];
    if (stored != null) return stored;
    if (orderId == MockupCatalog.checkoutOrderDetail.id ||
        orderId == MockupCatalog.checkoutOrderRef) {
      return MockupCatalog.checkoutOrderDetail;
    }
    return MockupCatalog.checkoutOrderDetail.copyWith(
      id: normalized,
      reference: orderId.startsWith('#') ? orderId : '#$orderId',
    );
  }

  @override
  Future<ModelOrderSummary> fetchActiveOrderById(String id) async {
    return MockupCatalog.activeOrders.firstWhere(
      (order) => order.id == id,
      orElse: () => MockupCatalog.activeOrders.first,
    );
  }

  @override
  Future<ModelPlaceOrderResult> placeOrder(ModelPlaceOrderRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));

    if (request.lines.isEmpty) {
      throw const OrderPlacementException('cart_empty');
    }

    final requiresAddress = _requiresAddress(request.draft.fulfillment);
    if (requiresAddress && request.draft.selectedAddressId == null) {
      throw const OrderPlacementException('address_required');
    }

    final orderId = 'SV-${DateTime.now().millisecondsSinceEpoch % 100000}';
    final subtotal = request.lines.fold<double>(
      0,
      (sum, line) => sum + line.lineTotalJod,
    );
    final fulfillmentCharge = _fulfillmentChargeFor(
      request.draft.fulfillment,
      subtotal,
    );
    final isPlated = request.draft.fulfillment == CheckoutFulfillment.plated;

    final detail = ModelOrderDetail(
      id: orderId,
      reference: '#$orderId',
      customerNameAr: MockupCatalog.customerDisplayNameAr,
      customerNameEn: MockupCatalog.customerDisplayNameEn,
      statusKey: 'pending',
      lines: [...request.lines],
      deliveryFeeJod: isPlated ? 0 : fulfillmentCharge,
      depositJod: isPlated ? fulfillmentCharge : 0,
      tipJod: request.draft.tipJod,
      fulfillment: request.draft.fulfillment,
      promoSavingsJod: request.promoSavingsJod,
      pointsDiscountJod: request.pointsDiscountJod,
      paymentType: request.draft.paymentType,
      cashTenderedJod: request.draft.cashTenderedJod,
    );

    _placedOrders[orderId] = detail;
    _lastPlacedOrderId = orderId;
    _placedHistory.insert(0, _historyRowFromDetail(detail, request));

    return ModelPlaceOrderResult(orderId: orderId, detail: detail);
  }

  ModelCustomerOrderHistory _historyRowFromDetail(
    ModelOrderDetail detail,
    ModelPlaceOrderRequest request,
  ) {
    final now = DateTime.now();
    final dateEn =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final dateAr = dateEn;
    final fulfillmentKey = request.draft.fulfillment.name;
    return ModelCustomerOrderHistory(
      id: detail.id,
      labelAr: 'طلب $fulfillmentKey',
      labelEn: 'Order · $fulfillmentKey',
      dateAr: dateAr,
      dateEn: dateEn,
      totalJod: detail.totalJod,
      itemsAr: detail.lines.map((l) => l.nameAr).toList(),
      itemsEn: detail.lines.map((l) => l.nameEn).toList(),
      isActive: true,
      currentStepIndex: 0,
    );
  }

  @override
  Future<List<ModelCartLine>> buildReorderLines(String orderId) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return [...MockupCatalog.cartPreviewLines];
  }

  /// Matches [WidgetsCheckoutSummaryCosts.calculate] fee rules (mock catalog).
  double _fulfillmentChargeFor(
    CheckoutFulfillment fulfillment,
    double subtotal,
  ) {
    return switch (fulfillment) {
      CheckoutFulfillment.dineIn =>
        subtotal * MockupCatalog.checkoutDineInServiceRate,
      CheckoutFulfillment.takeaway =>
        MockupCatalog.checkoutTakeawayPackagingFeeJod,
      CheckoutFulfillment.delivery => MockupCatalog.checkoutDeliveryFeeJod,
      CheckoutFulfillment.groupDelivery =>
        MockupCatalog.checkoutGroupDeliveryFeeJod,
      CheckoutFulfillment.plated => MockupCatalog.checkoutPlatedDepositJod,
    };
  }

  bool _requiresAddress(CheckoutFulfillment fulfillment) {
    return fulfillment == CheckoutFulfillment.delivery ||
        fulfillment == CheckoutFulfillment.groupDelivery ||
        fulfillment == CheckoutFulfillment.plated;
  }
}
