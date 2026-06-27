import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_mock.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

ModelOrderSummary _applyOrderOverride(
  ModelOrderSummary order,
  AdminOrdersState state,
) {
  if (state.removedOrderIds.contains(order.id)) {
    return order;
  }
  final status = state.statusOverrides[order.id] ?? order.statusKey;
  return ModelOrderSummary(
    id: order.id,
    orderType: order.orderType,
    customerLabel: order.customerLabel,
    totalJod: order.totalJod,
    depositJod: order.depositJod,
    statusKey: status,
    isPlated: order.isPlated,
  );
}

/// Admin order board mutations: status, pre-order accept, escalation.
class AdminOrdersState {
  const AdminOrdersState({
    this.statusOverrides = const {},
    this.removedOrderIds = const {},
    this.escalatedOrderIds = const {},
    this.acceptedPreOrderIds = const {},
    this.adjustedTimeLabels = const {},
  });

  final Map<String, String> statusOverrides;
  final Set<String> removedOrderIds;
  final Set<String> escalatedOrderIds;
  final Set<String> acceptedPreOrderIds;
  final Map<String, String> adjustedTimeLabels;

  AdminOrdersState copyWith({
    Map<String, String>? statusOverrides,
    Set<String>? removedOrderIds,
    Set<String>? escalatedOrderIds,
    Set<String>? acceptedPreOrderIds,
    Map<String, String>? adjustedTimeLabels,
  }) {
    return AdminOrdersState(
      statusOverrides: statusOverrides ?? this.statusOverrides,
      removedOrderIds: removedOrderIds ?? this.removedOrderIds,
      escalatedOrderIds: escalatedOrderIds ?? this.escalatedOrderIds,
      acceptedPreOrderIds: acceptedPreOrderIds ?? this.acceptedPreOrderIds,
      adjustedTimeLabels: adjustedTimeLabels ?? this.adjustedTimeLabels,
    );
  }
}

class AdminOrdersNotifier extends StateNotifier<AdminOrdersState> {
  AdminOrdersNotifier() : super(const AdminOrdersState());

  void updateOrderStatus(String orderId, String statusKey) {
    state = state.copyWith(
      statusOverrides: {...state.statusOverrides, orderId: statusKey},
    );
  }

  void acceptPreOrder(String orderId) {
    state = state.copyWith(
      acceptedPreOrderIds: {...state.acceptedPreOrderIds, orderId},
      statusOverrides: {...state.statusOverrides, orderId: 'preparing'},
      removedOrderIds: {...state.removedOrderIds, orderId},
    );
  }

  void adjustPreOrderTime(String orderId, String label) {
    state = state.copyWith(
      adjustedTimeLabels: {...state.adjustedTimeLabels, orderId: label},
    );
  }

  void escalateOrder(String orderId) {
    state = state.copyWith(
      escalatedOrderIds: {...state.escalatedOrderIds, orderId},
    );
  }
}

final adminOrdersProvider =
    StateNotifierProvider<AdminOrdersNotifier, AdminOrdersState>(
      (ref) => AdminOrdersNotifier(),
    );

final adminActiveOrdersProvider = Provider<List<ModelOrderSummary>>((ref) {
  final session = ref.watch(adminOrdersProvider);
  return MockupCatalog.activeOrders
      .where((order) => !session.removedOrderIds.contains(order.id))
      .map((order) => _applyOrderOverride(order, session))
      .toList();
});

final adminPreOrdersProvider = Provider<List<ModelOrderSummary>>((ref) {
  final session = ref.watch(adminOrdersProvider);
  return MockupCatalog.activeOrders
      .where(
        (order) =>
            !session.removedOrderIds.contains(order.id) &&
            !session.acceptedPreOrderIds.contains(order.id) &&
            (order.statusKey == 'pending' || order.isPlated),
      )
      .map((order) => _applyOrderOverride(order, session))
      .toList();
});

/// Branch settings toggles for orders, delivery, tax, and kitchen alerts.
class AdminSettingsState {
  const AdminSettingsState({
    this.ordersOpen = true,
    this.deliveryEnabled = true,
    this.taxIncluded = true,
    this.kitchenAlerts = true,
  });

  final bool ordersOpen;
  final bool deliveryEnabled;
  final bool taxIncluded;
  final bool kitchenAlerts;

  AdminSettingsState copyWith({
    bool? ordersOpen,
    bool? deliveryEnabled,
    bool? taxIncluded,
    bool? kitchenAlerts,
  }) {
    return AdminSettingsState(
      ordersOpen: ordersOpen ?? this.ordersOpen,
      deliveryEnabled: deliveryEnabled ?? this.deliveryEnabled,
      taxIncluded: taxIncluded ?? this.taxIncluded,
      kitchenAlerts: kitchenAlerts ?? this.kitchenAlerts,
    );
  }
}

class AdminSettingsNotifier extends StateNotifier<AdminSettingsState> {
  AdminSettingsNotifier() : super(const AdminSettingsState());

  void setOrdersOpen(bool value) =>
      state = state.copyWith(ordersOpen: value);

  void setDeliveryEnabled(bool value) =>
      state = state.copyWith(deliveryEnabled: value);

  void setTaxIncluded(bool value) => state = state.copyWith(taxIncluded: value);

  void setKitchenAlerts(bool value) =>
      state = state.copyWith(kitchenAlerts: value);
}

final adminSettingsProvider =
    StateNotifierProvider<AdminSettingsNotifier, AdminSettingsState>(
      (ref) => AdminSettingsNotifier(),
    );

/// Plated deposit return window and reminder policy.
class AdminDepositConfigState {
  const AdminDepositConfigState({
    this.returnWindowHours = 48,
    this.automatedReminders = true,
    this.globalDepositJod = MockupCatalog.checkoutPlatedDepositJod,
    this.saved = false,
  });

  final double returnWindowHours;
  final bool automatedReminders;
  final double globalDepositJod;
  final bool saved;

  AdminDepositConfigState copyWith({
    double? returnWindowHours,
    bool? automatedReminders,
    double? globalDepositJod,
    bool? saved,
  }) {
    return AdminDepositConfigState(
      returnWindowHours: returnWindowHours ?? this.returnWindowHours,
      automatedReminders: automatedReminders ?? this.automatedReminders,
      globalDepositJod: globalDepositJod ?? this.globalDepositJod,
      saved: saved ?? this.saved,
    );
  }
}

class AdminDepositConfigNotifier extends StateNotifier<AdminDepositConfigState> {
  AdminDepositConfigNotifier() : super(const AdminDepositConfigState());

  void setReturnWindowHours(double hours) {
    state = state.copyWith(returnWindowHours: hours, saved: false);
  }

  void setAutomatedReminders(bool value) {
    state = state.copyWith(automatedReminders: value, saved: false);
  }

  void setGlobalDepositJod(double jod) {
    if (jod <= 0) return;
    state = state.copyWith(globalDepositJod: jod, saved: false);
  }

  void save() {
    state = state.copyWith(saved: true);
  }
}

final adminDepositConfigProvider =
    StateNotifierProvider<AdminDepositConfigNotifier, AdminDepositConfigState>(
      (ref) => AdminDepositConfigNotifier(),
    );

/// Daily tip pool approval for operator review.
class AdminTipDistributionState {
  const AdminTipDistributionState({
    this.approved = false,
    this.recalculated = false,
    this.poolJod = MockupCatalog.dailyTipPoolJod,
    this.showAllStaff = false,
  });

  final bool approved;
  final bool recalculated;
  final double poolJod;
  final bool showAllStaff;

  AdminTipDistributionState copyWith({
    bool? approved,
    bool? recalculated,
    double? poolJod,
    bool? showAllStaff,
  }) {
    return AdminTipDistributionState(
      approved: approved ?? this.approved,
      recalculated: recalculated ?? this.recalculated,
      poolJod: poolJod ?? this.poolJod,
      showAllStaff: showAllStaff ?? this.showAllStaff,
    );
  }
}

class AdminTipDistributionNotifier
    extends StateNotifier<AdminTipDistributionState> {
  AdminTipDistributionNotifier() : super(const AdminTipDistributionState());

  void recalculatePool() {
    state = state.copyWith(
      recalculated: true,
      poolJod: MockupCatalog.dailyTipPoolJod * 1.02,
      approved: false,
    );
  }

  void approveAll() {
    state = state.copyWith(approved: true);
  }

  void toggleShowAllStaff() {
    state = state.copyWith(showAllStaff: !state.showAllStaff);
  }
}

final adminTipDistributionProvider =
    StateNotifierProvider<AdminTipDistributionNotifier, AdminTipDistributionState>(
      (ref) => AdminTipDistributionNotifier(),
    );

/// Team invites and permission toggles for user management.
class AdminUsersState {
  const AdminUsersState({
    this.sessionMembers = const [],
    this.activeOverrides = const {},
    this.searchQuery = '',
  });

  final List<ModelAdminTeamMember> sessionMembers;
  final Map<String, bool> activeOverrides;
  final String searchQuery;

  List<ModelAdminTeamMember> get allMembers {
    final merged = [...sessionMembers, ...MockupCatalog.adminTeamMembers];
    final seen = <String>{};
    return [
      for (final member in merged)
        if (seen.add(member.email))
          ModelAdminTeamMember(
            nameAr: member.nameAr,
            nameEn: member.nameEn,
            roleAr: member.roleAr,
            roleEn: member.roleEn,
            email: member.email,
            shiftAr: member.shiftAr,
            shiftEn: member.shiftEn,
            colorKey: member.colorKey,
            iconKey: member.iconKey,
            active: activeOverrides[member.email] ?? member.active,
          ),
    ];
  }

  List<ModelAdminTeamMember> get filteredMembers {
    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return allMembers;
    return allMembers
        .where(
          (member) =>
              member.nameEn.toLowerCase().contains(query) ||
              member.nameAr.contains(query) ||
              member.email.toLowerCase().contains(query),
        )
        .toList();
  }

  AdminUsersState copyWith({
    List<ModelAdminTeamMember>? sessionMembers,
    Map<String, bool>? activeOverrides,
    String? searchQuery,
  }) {
    return AdminUsersState(
      sessionMembers: sessionMembers ?? this.sessionMembers,
      activeOverrides: activeOverrides ?? this.activeOverrides,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class AdminUsersNotifier extends StateNotifier<AdminUsersState> {
  AdminUsersNotifier() : super(const AdminUsersState());

  void inviteMember({
    required String nameEn,
    required String nameAr,
    required String roleEn,
    required String roleAr,
    required String email,
  }) {
    final normalized = email.trim().toLowerCase();
    if (normalized.isEmpty) return;
    if (state.allMembers.any((m) => m.email.toLowerCase() == normalized)) {
      return;
    }
    state = state.copyWith(
      sessionMembers: [
        ModelAdminTeamMember(
          nameAr: nameAr.trim(),
          nameEn: nameEn.trim(),
          roleAr: roleAr.trim(),
          roleEn: roleEn.trim(),
          email: normalized,
          shiftAr: 'وردية جديدة',
          shiftEn: 'New shift',
          colorKey: 'primary',
          iconKey: 'person',
          active: true,
        ),
        ...state.sessionMembers,
      ],
    );
  }

  bool hasMemberEmail(String email) {
    final normalized = email.trim().toLowerCase();
    return state.allMembers.any((m) => m.email.toLowerCase() == normalized);
  }

  void toggleActive(String email, bool active) {
    state = state.copyWith(
      activeOverrides: {...state.activeOverrides, email: active},
    );
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }
}

final adminUsersProvider =
    StateNotifierProvider<AdminUsersNotifier, AdminUsersState>(
      (ref) => AdminUsersNotifier(),
    );

/// Menu item active flags, bulk import, and session-added items.
class AdminMenuState {
  const AdminMenuState({
    this.activeOverrides = const {},
    this.bulkImportedCount = 0,
    this.selectedCategoryIndex = 0,
    this.publishedProductIds = const {},
    this.addedMenuItems = const [],
    this.catalogItemOverrides = const {},
    this.searchQuery = '',
    this.unpublishedProductIds = const {},
  });

  final Map<String, bool> activeOverrides;
  final int bulkImportedCount;
  final int selectedCategoryIndex;
  final Set<String> publishedProductIds;
  final List<ModelMenuItem> addedMenuItems;
  final Map<String, ModelMenuItem> catalogItemOverrides;
  final String searchQuery;
  final Set<String> unpublishedProductIds;

  AdminMenuState copyWith({
    Map<String, bool>? activeOverrides,
    int? bulkImportedCount,
    int? selectedCategoryIndex,
    Set<String>? publishedProductIds,
    List<ModelMenuItem>? addedMenuItems,
    Map<String, ModelMenuItem>? catalogItemOverrides,
    String? searchQuery,
    Set<String>? unpublishedProductIds,
  }) {
    return AdminMenuState(
      activeOverrides: activeOverrides ?? this.activeOverrides,
      bulkImportedCount: bulkImportedCount ?? this.bulkImportedCount,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      publishedProductIds: publishedProductIds ?? this.publishedProductIds,
      addedMenuItems: addedMenuItems ?? this.addedMenuItems,
      catalogItemOverrides: catalogItemOverrides ?? this.catalogItemOverrides,
      searchQuery: searchQuery ?? this.searchQuery,
      unpublishedProductIds:
          unpublishedProductIds ?? this.unpublishedProductIds,
    );
  }

  bool isSeedProductPublished(String productId) {
    return !unpublishedProductIds.contains(productId);
  }
}

int _menuItemSeq = 900;

class AdminMenuNotifier extends StateNotifier<AdminMenuState> {
  AdminMenuNotifier() : super(const AdminMenuState());

  void setItemActive(String key, bool active) {
    state = state.copyWith(
      activeOverrides: {...state.activeOverrides, key: active},
    );
  }

  void setCategoryIndex(int index) {
    state = state.copyWith(selectedCategoryIndex: index);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query.trim());
  }

  bool upsertCatalogItemOverride(ModelMenuItem item) {
    if (item.id.isEmpty || item.nameEn.trim().isEmpty || item.priceJod <= 0) {
      return false;
    }
    state = state.copyWith(
      catalogItemOverrides: {...state.catalogItemOverrides, item.id: item},
    );
    return true;
  }

  void bulkImport() {
    state = state.copyWith(bulkImportedCount: state.bulkImportedCount + 3);
  }

  void publishProduct(String productId) {
    final unpublished = {...state.unpublishedProductIds}..remove(productId);
    state = state.copyWith(
      publishedProductIds: {...state.publishedProductIds, productId},
      unpublishedProductIds: unpublished,
    );
  }

  ModelMenuItem? addMenuItem({
    required String nameAr,
    required String nameEn,
    required String descriptionAr,
    required String descriptionEn,
    required double priceJod,
    String categoryId = 'custom',
  }) {
    if (nameEn.trim().isEmpty || priceJod <= 0) return null;
    final id = 'menu_custom_${_menuItemSeq++}';
    final item = ModelMenuItem(
      id: id,
      categoryId: categoryId,
      nameAr: nameAr.trim(),
      nameEn: nameEn.trim(),
      priceJod: priceJod,
      descriptionAr: descriptionAr.trim(),
      descriptionEn: descriptionEn.trim(),
    );
    state = state.copyWith(
      addedMenuItems: [...state.addedMenuItems, item],
      publishedProductIds: {...state.publishedProductIds, id},
    );
    return item;
  }

  bool updateAddedMenuItem(ModelMenuItem item) {
    final index = state.addedMenuItems.indexWhere((i) => i.id == item.id);
    if (index == -1) return false;
    final next = [...state.addedMenuItems]..[index] = item;
    state = state.copyWith(addedMenuItems: next);
    return true;
  }

  bool removeAddedMenuItem(String id) {
    state = state.copyWith(
      addedMenuItems: state.addedMenuItems.where((i) => i.id != id).toList(),
      publishedProductIds: {...state.publishedProductIds}..remove(id),
      unpublishedProductIds: {...state.unpublishedProductIds}..remove(id),
    );
    return true;
  }

  void unpublishProduct(String productId) {
    state = state.copyWith(
      publishedProductIds: {...state.publishedProductIds}..remove(productId),
      unpublishedProductIds: {...state.unpublishedProductIds, productId},
    );
  }
}

final adminMenuProvider =
    StateNotifierProvider<AdminMenuNotifier, AdminMenuState>(
      (ref) => AdminMenuNotifier(),
    );

/// Plate asset editor flags persisted for the mock session.
class AdminPlateConfigState {
  const AdminPlateConfigState({
    this.requiresDeposit = true,
    this.allowDelivery = true,
    this.autoRestock = true,
    this.saved = false,
  });

  final bool requiresDeposit;
  final bool allowDelivery;
  final bool autoRestock;
  final bool saved;

  AdminPlateConfigState copyWith({
    bool? requiresDeposit,
    bool? allowDelivery,
    bool? autoRestock,
    bool? saved,
  }) {
    return AdminPlateConfigState(
      requiresDeposit: requiresDeposit ?? this.requiresDeposit,
      allowDelivery: allowDelivery ?? this.allowDelivery,
      autoRestock: autoRestock ?? this.autoRestock,
      saved: saved ?? this.saved,
    );
  }
}

class AdminPlateConfigNotifier extends StateNotifier<AdminPlateConfigState> {
  AdminPlateConfigNotifier() : super(const AdminPlateConfigState());

  void setRequiresDeposit(bool value) =>
      state = state.copyWith(requiresDeposit: value, saved: false);

  void setAllowDelivery(bool value) =>
      state = state.copyWith(allowDelivery: value, saved: false);

  void setAutoRestock(bool value) =>
      state = state.copyWith(autoRestock: value, saved: false);

  void save() => state = state.copyWith(saved: true);
}

final adminPlateConfigProvider =
    StateNotifierProvider<AdminPlateConfigNotifier, AdminPlateConfigState>(
      (ref) => AdminPlateConfigNotifier(),
    );

/// Owner privacy, loyalty, and offers configuration from the growth hub.
class AdminGrowthConfigState {
  const AdminGrowthConfigState({
    this.hideRawCosts = true,
    this.hideStaffSalaries = true,
    this.netProfitOnly = false,
    this.doublePoints = true,
    this.birthdayDessert = true,
    this.lunchOffer = true,
    this.familyTrayOffer = false,
    this.saved = false,
  });

  final bool hideRawCosts;
  final bool hideStaffSalaries;
  final bool netProfitOnly;
  final bool doublePoints;
  final bool birthdayDessert;
  final bool lunchOffer;
  final bool familyTrayOffer;
  final bool saved;

  AdminGrowthConfigState copyWith({
    bool? hideRawCosts,
    bool? hideStaffSalaries,
    bool? netProfitOnly,
    bool? doublePoints,
    bool? birthdayDessert,
    bool? lunchOffer,
    bool? familyTrayOffer,
    bool? saved,
  }) {
    return AdminGrowthConfigState(
      hideRawCosts: hideRawCosts ?? this.hideRawCosts,
      hideStaffSalaries: hideStaffSalaries ?? this.hideStaffSalaries,
      netProfitOnly: netProfitOnly ?? this.netProfitOnly,
      doublePoints: doublePoints ?? this.doublePoints,
      birthdayDessert: birthdayDessert ?? this.birthdayDessert,
      lunchOffer: lunchOffer ?? this.lunchOffer,
      familyTrayOffer: familyTrayOffer ?? this.familyTrayOffer,
      saved: saved ?? this.saved,
    );
  }
}

class AdminGrowthConfigNotifier extends StateNotifier<AdminGrowthConfigState> {
  AdminGrowthConfigNotifier() : super(const AdminGrowthConfigState());

  void update(AdminGrowthConfigState next) => state = next.copyWith(saved: false);

  void save() => state = state.copyWith(saved: true);
}

final adminGrowthConfigProvider =
    StateNotifierProvider<AdminGrowthConfigNotifier, AdminGrowthConfigState>(
      (ref) => AdminGrowthConfigNotifier(),
    );

/// Shared report filter applied from sheet and reports hub.
class AdminReportFilterState {
  const AdminReportFilterState({
    this.period = 'today',
    this.channel = 'all',
    this.modules = const {'sales', 'tips', 'inventory'},
    this.appliedAt,
  });

  final String period;
  final String channel;
  final Set<String> modules;
  final DateTime? appliedAt;

  AdminReportFilterState copyWith({
    String? period,
    String? channel,
    Set<String>? modules,
    DateTime? appliedAt,
  }) {
    return AdminReportFilterState(
      period: period ?? this.period,
      channel: channel ?? this.channel,
      modules: modules ?? this.modules,
      appliedAt: appliedAt ?? this.appliedAt,
    );
  }
}

class AdminReportFilterNotifier extends StateNotifier<AdminReportFilterState> {
  AdminReportFilterNotifier() : super(const AdminReportFilterState());

  void apply({
    required String period,
    required String channel,
    required Set<String> modules,
  }) {
    state = AdminReportFilterState(
      period: period,
      channel: channel,
      modules: modules,
      appliedAt: DateTime.now(),
    );
  }

  void reset() {
    state = const AdminReportFilterState(appliedAt: null);
  }
}

final adminReportFilterProvider =
    StateNotifierProvider<AdminReportFilterNotifier, AdminReportFilterState>(
      (ref) => AdminReportFilterNotifier(),
    );

/// Financial shift-close approval and audit export markers.
class AdminFinancialState {
  const AdminFinancialState({
    this.shiftCloseApproved = false,
    this.lastAuditExportAt,
    this.auditRequestedAt,
  });

  final bool shiftCloseApproved;
  final DateTime? lastAuditExportAt;
  final DateTime? auditRequestedAt;

  AdminFinancialState copyWith({
    bool? shiftCloseApproved,
    DateTime? lastAuditExportAt,
    DateTime? auditRequestedAt,
  }) {
    return AdminFinancialState(
      shiftCloseApproved: shiftCloseApproved ?? this.shiftCloseApproved,
      lastAuditExportAt: lastAuditExportAt ?? this.lastAuditExportAt,
      auditRequestedAt: auditRequestedAt ?? this.auditRequestedAt,
    );
  }
}

class AdminFinancialNotifier extends StateNotifier<AdminFinancialState> {
  AdminFinancialNotifier() : super(const AdminFinancialState());

  void approveShiftClose() {
    state = state.copyWith(shiftCloseApproved: true);
  }

  void recordAuditExport() {
    state = state.copyWith(lastAuditExportAt: DateTime.now());
  }

  void requestDetailedAudit() {
    state = state.copyWith(auditRequestedAt: DateTime.now());
  }
}

final adminFinancialProvider =
    StateNotifierProvider<AdminFinancialNotifier, AdminFinancialState>(
      (ref) => AdminFinancialNotifier(),
    );

/// Audit log category filter for the admin audit screen.
class AdminAuditFilterState {
  const AdminAuditFilterState({this.category = 'all'});

  final String category;

  AdminAuditFilterState copyWith({String? category}) {
    return AdminAuditFilterState(category: category ?? this.category);
  }
}

class AdminAuditFilterNotifier extends StateNotifier<AdminAuditFilterState> {
  AdminAuditFilterNotifier() : super(const AdminAuditFilterState());

  void setCategory(String category) {
    state = state.copyWith(category: category);
  }
}

final adminAuditFilterProvider =
    StateNotifierProvider<AdminAuditFilterNotifier, AdminAuditFilterState>(
      (ref) => AdminAuditFilterNotifier(),
    );
