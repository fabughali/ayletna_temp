import 'package:ayletna_restaurant_app/data/models/model_customer_order_history.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_detail.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/data/models/model_saved_address.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repository_address.dart';
import 'repository_address_mock.dart';
import 'repository_menu.dart';
import 'repository_menu_mock.dart';
import 'repository_order.dart';
import 'repository_order_mock.dart';

export 'user_profile_repository.dart';
export '../../providers/order_placement_providers.dart'
    show checkoutOrderDetailProvider, placeOrderProvider, ratingOrderDetailProvider, reorderLinesProvider;

final repositoryMenuProvider = Provider<RepositoryMenu>(
  (ref) => const RepositoryMenuMock(),
);

final repositoryOrderProvider = Provider<RepositoryOrder>(
  (ref) => RepositoryOrderMock.instance,
);

final repositoryAddressProvider = Provider<RepositoryAddress>(
  (ref) => RepositoryAddressMock.instance,
);

final activeOrdersProvider = FutureProvider<List<ModelOrderSummary>>((
  ref,
) async {
  return ref.read(repositoryOrderProvider).fetchActiveOrders();
});

final orderHistoryProvider = FutureProvider<List<ModelOrderSummary>>((
  ref,
) async {
  return ref.read(repositoryOrderProvider).fetchOrderHistory();
});

final customerOrderHistoryProvider =
    FutureProvider<List<ModelCustomerOrderHistory>>((ref) async {
      return ref.read(repositoryOrderProvider).fetchCustomerOrderHistory();
    });

final savedAddressesProvider = FutureProvider<List<ModelSavedAddress>>((
  ref,
) async {
  return ref.read(repositoryAddressProvider).fetchSavedAddresses();
});

final adminOrderDetailProvider =
    FutureProvider.family<ModelOrderSummary, String>((ref, id) async {
      return ref.read(repositoryOrderProvider).fetchActiveOrderById(id);
    });

final orderDetailByIdProvider = FutureProvider.family<ModelOrderDetail, String>(
  (ref, id) async {
    return ref.read(repositoryOrderProvider).fetchOrderDetailById(id);
  },
);
