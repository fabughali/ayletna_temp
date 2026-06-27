import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_order_history.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_detail.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/data/models/model_place_order_request.dart';
import 'package:ayletna_restaurant_app/data/models/model_place_order_result.dart';

abstract class RepositoryOrder {
  Future<List<ModelOrderSummary>> fetchActiveOrders();
  Future<List<ModelOrderSummary>> fetchOrderHistory();
  Future<List<ModelCustomerOrderHistory>> fetchCustomerOrderHistory();
  Future<ModelOrderDetail> fetchCheckoutOrderDetail();
  Future<ModelOrderDetail> fetchOrderDetailById(String orderId);
  Future<ModelOrderSummary> fetchActiveOrderById(String id);
  Future<ModelPlaceOrderResult> placeOrder(ModelPlaceOrderRequest request);
  Future<List<ModelCartLine>> buildReorderLines(String orderId);
}
