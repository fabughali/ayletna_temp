import 'dart:async';

import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_category.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/data/models/model_cashier_postponed_order.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/providers/cashier_postponed_orders_provider.dart';
import 'package:ayletna_restaurant_app/providers/cashier_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_quantity_stepper.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cashier_virtual_keypad.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_order_invoice_block.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_order_ticket_sum.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:virtual_keypad/virtual_keypad.dart';

/// PRD CashierOrderScreen — restaurant POS, ticket, kitchen send, payment.
class CashierOrderScreen extends ConsumerStatefulWidget {
  const CashierOrderScreen({super.key});

  @override
  ConsumerState<CashierOrderScreen> createState() => _CashierOrderScreenState();
}

class _CashierOrderScreenState extends ConsumerState<CashierOrderScreen> {
  _CashierFulfillment _fulfillment = _CashierFulfillment.dineIn;
  String _selectedCategoryId = MockupCatalog.categories.first.id;
  final _searchController = VirtualKeypadController();
  final _tableNumberController = VirtualKeypadController();
  final _addressController = VirtualKeypadController();
  final _customerPhoneController = VirtualKeypadController();
  final _buildingController = VirtualKeypadController();
  final _floorController = VirtualKeypadController();
  final _accessCodeController = VirtualKeypadController();
  final _contactPersonController = VirtualKeypadController();
  final _deliveryTimeController = VirtualKeypadController();
  final _cashPaymentController = VirtualKeypadController();
  final _visaPaymentController = VirtualKeypadController();
  final _walletPaymentController = VirtualKeypadController();
  final _cashReceivedController = VirtualKeypadController();
  final _customTipController = VirtualKeypadController();
  _CashierTicketTab _ticketTab = _CashierTicketTab.order;
  _CashierPaymentTarget? _selectedPaymentTarget;
  bool _fulfillmentSelected = false;
  bool _tipConfigured = false;
  bool _paymentReceivedConfirmed = false;
  bool _kitchenSent = false;
  double _tipJod = 0;
  double _promoSavingsJod = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeResumeDraft());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tableNumberController.dispose();
    _addressController.dispose();
    _customerPhoneController.dispose();
    _buildingController.dispose();
    _floorController.dispose();
    _accessCodeController.dispose();
    _contactPersonController.dispose();
    _deliveryTimeController.dispose();
    _cashPaymentController.dispose();
    _visaPaymentController.dispose();
    _walletPaymentController.dispose();
    _cashReceivedController.dispose();
    _customTipController.dispose();
    super.dispose();
  }

  void _maybeResumeDraft() {
    final draft = ref.read(cashierResumeDraftProvider);
    if (draft == null) return;
    ref.read(cashierResumeDraftProvider.notifier).state = null;
    _loadPostponedDraft(draft);
  }

  void _loadPostponedDraft(ModelCashierPostponedOrder draft) {
    ref.read(cartProvider.notifier).replaceAll(draft.cartLines);
    setState(() {
      _fulfillment = _CashierFulfillment.values.firstWhere(
        (value) => value.name == draft.fulfillmentKey,
        orElse: () => _CashierFulfillment.dineIn,
      );
      _fulfillmentSelected = true;
      _tipConfigured = true;
      _tipJod = draft.tipJod;
      _promoSavingsJod = draft.promoSavingsJod;
      _tableNumberController.text = draft.tableNumber;
      _addressController.text = draft.address;
      _customerPhoneController.text = draft.customerPhone;
      _buildingController.text = draft.building;
      _floorController.text = draft.floor;
      _accessCodeController.text = draft.accessCode;
      _contactPersonController.text = draft.contactPerson;
      _deliveryTimeController.text = draft.deliveryTime;
      _cashReceivedController.text =
          draft.paidJod > 0 ? draft.paidJod.toStringAsFixed(2) : '';
      _customTipController.text =
          draft.tipJod > 0 ? draft.tipJod.toStringAsFixed(2) : '';
      _selectedPaymentTarget = null;
      _paymentReceivedConfirmed = false;
      _kitchenSent = false;
      _ticketTab = _CashierTicketTab.payment;
    });
    ref.read(cashierPostponedOrdersProvider.notifier).removeOrder(draft.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final cart = ref.watch(cartProvider);
    final subtotal = ref.watch(cartSubtotalProvider);
    final fulfillmentCharge = _fulfillmentCharge(_fulfillment, subtotal);
    final tax = 0.0;
    final total = (subtotal + fulfillmentCharge + _tipJod - _promoSavingsJod)
        .clamp(0, double.infinity);
    final priorBalanceJod = _customerPriorBalanceJod();
    final amountPayable = total + priorBalanceJod;
    final paidTotal = _paidTotal();
    final balanceDue = _computedBalanceDue(amountPayable.toDouble());
    final remainingDue = priorBalanceJod;
    final query = _searchController.text.trim().toLowerCase();
    final categoryItems = MockupCatalog.itemsForCategory(_selectedCategoryId);
    final items =
        query.isEmpty
            ? categoryItems
            : MockupCatalog.items.where((item) {
              return item.nameAr.toLowerCase().contains(query) ||
                  item.nameEn.toLowerCase().contains(query) ||
                  item.descriptionAr.toLowerCase().contains(query) ||
                  item.descriptionEn.toLowerCase().contains(query);
            }).toList();

    return WidgetsScaffoldPage(
      title: l10n.screenCashierOrder,
      fullWidth: true,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.cashierOrderHistory),
          icon: Icons.receipt_long_outlined,
          tooltip: l10n.screenCashierOrderHistory,
        ),
        WidgetsIconButton(
          onPressed:
              () => UtilityMockFeedback.showInfo(
                context,
                l10n.screenNotifications,
              ),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: CashierVirtualKeypadShell(
        isAr: isAr,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 760;
            final menu = _MenuWorkbench(
              categories: MockupCatalog.categories,
              selectedCategoryId: _selectedCategoryId,
              items: items,
              searchController: _searchController,
              isAr: isAr,
              onCategorySelected:
                  (id) => setState(() {
                    _selectedCategoryId = id;
                    _searchController.clear();
                  }),
              onSearchChanged: (_) => setState(() {}),
              onItemSelected: _addItem,
              onPromoSelected: _applyPromotion,
            );
            final ticket = _TicketPanel(
              fulfillment: _fulfillment,
              cart: cart,
              subtotal: subtotal,
              fulfillmentCharge: fulfillmentCharge,
              fulfillmentSelected: _fulfillmentSelected,
              tipJod: _tipJod,
              tipConfigured: _tipConfigured,
              promoSavingsJod: _promoSavingsJod,
              total: total.toDouble(),
              paidTotal: paidTotal,
              balanceDue: balanceDue,
              priorBalanceJod: priorBalanceJod,
              receivedValue: _receivedValue(),
              selectedPaymentLabel: _selectedPaymentLabel(l10n),
              paymentSelected: _selectedPaymentTarget != null,
              isAr: isAr,
              addressController: _addressController,
              customerPhoneController: _customerPhoneController,
              buildingController: _buildingController,
              floorController: _floorController,
              accessCodeController: _accessCodeController,
              contactPersonController: _contactPersonController,
              deliveryTimeController: _deliveryTimeController,
              cashPaymentController: _cashPaymentController,
              visaPaymentController: _visaPaymentController,
              walletPaymentController: _walletPaymentController,
              cashReceivedController: _cashReceivedController,
              onFulfillmentChanged:
                  (value) => setState(() => _fulfillment = value),
              customTipController: _customTipController,
              onTipChanged: _setTip,
              onPaymentChanged: () => setState(() {}),
              onQuantityChanged:
                  (line, quantity) => ref
                      .read(cartProvider.notifier)
                      .setQuantity(line.cartKey, quantity),
              onModifier: _showModifierSheet,
              onRemoveLine: _removeLine,
              onVoid: _voidOrder,
              onSendKitchen: cart.isEmpty ? null : _sendToKitchen,
              onPayment: cart.isEmpty ? null : () => _processPayment(total),
              onViewReceipt:
                  cart.isEmpty
                      ? null
                      : () => _showReceiptDialog(total.toDouble()),
              onPrintReceipt:
                  cart.isEmpty ? null : () => _printReceipt(total.toDouble()),
              onSendElectronicTicket:
                  cart.isEmpty ? null : _sendElectronicTicket,
            );

            final enabledTabs = _enabledTabs(cart);
            final selectedTab =
                enabledTabs.contains(_ticketTab)
                    ? _ticketTab
                    : _CashierTicketTab.order;
            final rightWorkbench = _CashierCheckoutStepLayout(
              selectedTab: selectedTab,
              enabledTabs: enabledTabs,
              onTabChanged: (tab) => _goToTicketTab(tab, total, cart),
              fitToHeight: selectedTab != _CashierTicketTab.order,
              summaries: _tabSummaries(
                context: context,
                cart: cart,
                subtotal: subtotal,
                fulfillmentCharge: fulfillmentCharge,
                total: total.toDouble(),
                priorBalanceJod: priorBalanceJod,
                amountPayable: amountPayable,
              ),
              child:
                  selectedTab == _CashierTicketTab.order
                      ? menu
                      : _buildCheckoutStep(
                        ticketTab: selectedTab,
                        cart: cart,
                        subtotal: subtotal,
                        fulfillmentCharge: fulfillmentCharge,
                        tax: tax,
                        total: total.toDouble(),
                        paidTotal: paidTotal,
                        remainingDue: remainingDue,
                        kitchenSent: _kitchenSent,
                      ),
            );

            return _CashierPosLayout(
              isWide: isWide,
              ticket: ticket,
              workbench: rightWorkbench,
              workbenchScrollable: selectedTab == _CashierTicketTab.order,
            );
          },
        ),
      ),
    );
  }

  void _addItem(ModelMenuItem item) {
    showWidgetsCartCustomizationSheet(
      context: context,
      item: item,
      useVirtualKeypad: true,
    );
  }

  void _setTip(double value) {
    final previousTotal = _currentTotal();
    setState(() {
      _tipJod = value;
      _tipConfigured = true;
    });
    if (_customTipController.text != value.toStringAsFixed(2)) {
      _customTipController.text = value == 0 ? '' : value.toStringAsFixed(2);
    }
    _refreshSelectedPaymentTotal(previousTotal, _currentTotal(tipJod: value));
  }

  Widget _buildCheckoutStep({
    required _CashierTicketTab ticketTab,
    required List<ModelCartLine> cart,
    required double subtotal,
    required double fulfillmentCharge,
    required double tax,
    required double total,
    required double paidTotal,
    required double remainingDue,
    required bool kitchenSent,
  }) {
    final cashChange =
        (_amount(_cashReceivedController) - _amount(_cashPaymentController))
            .clamp(0, double.infinity)
            .toDouble();
    final priorBalanceJod = _customerPriorBalanceJod();
    final amountPayable = total + priorBalanceJod;
    final balanceDue = _computedBalanceDue(amountPayable);
    final remainingDue = priorBalanceJod;

    return switch (ticketTab) {
      _CashierTicketTab.order => const SizedBox.shrink(),
      _CashierTicketTab.fulfillment => _FulfillmentTicketTab(
        fulfillment: _fulfillment,
        tableNumberController: _tableNumberController,
        addressController: _addressController,
        customerPhoneController: _customerPhoneController,
        buildingController: _buildingController,
        floorController: _floorController,
        accessCodeController: _accessCodeController,
        contactPersonController: _contactPersonController,
        deliveryTimeController: _deliveryTimeController,
        onFulfillmentChanged:
            (value) => setState(() {
              _fulfillment = value;
              _fulfillmentSelected = true;
              _selectedPaymentTarget = null;
              _paymentReceivedConfirmed = false;
              _cashPaymentController.clear();
              _visaPaymentController.clear();
              _walletPaymentController.clear();
              _cashReceivedController.clear();
            }),
      ),
      _CashierTicketTab.tip => _TipTicketTab(
        tipJod: _tipJod,
        customTipController: _customTipController,
        onTipChanged: _setTip,
        onCustomTipChanged:
            (value) => _setTip(double.tryParse(value.trim()) ?? 0),
      ),
      _CashierTicketTab.payment => _PaymentTicketTab(
        total: total,
        priorBalanceJod: priorBalanceJod,
        amountPayable: amountPayable,
        remaining: remainingDue,
        cashChange: cashChange,
        selectedPaymentTarget: _selectedPaymentTarget,
        cashPaymentController: _cashPaymentController,
        visaPaymentController: _visaPaymentController,
        walletPaymentController: _walletPaymentController,
        cashReceivedController: _cashReceivedController,
        balanceDue: balanceDue,
        onPaymentChanged:
            () => setState(() => _paymentReceivedConfirmed = false),
        onPaymentMethodSelected:
            (target) => _setPaymentMethod(target, amountPayable),
        paymentReceivedConfirmed: _paymentReceivedConfirmed,
        canConfirmPayment: _canConfirmPaymentReceived,
        splitTotalMismatch:
            _selectedPaymentTarget == _CashierPaymentTarget.split &&
            !_splitPaymentMatches(amountPayable),
        onPaymentReceived: () => _confirmPaymentReceived(total),
        onPostpone: () => _postponeOrder(total),
      ),
      _CashierTicketTab.confirmation => _ConfirmationTicketTab(
        cart: cart,
        sumData: _ticketSumData(
          cart: cart,
          subtotal: subtotal,
          fulfillmentCharge: fulfillmentCharge,
          total: total,
          paidTotal: paidTotal,
          balanceDue: balanceDue,
        ),
        kitchenSent: kitchenSent,
        onCancel: () => _goToTicketTab(_CashierTicketTab.payment, total, cart),
        onViewReceipt:
            cart.isEmpty ? null : () => _showReceiptDialog(total.toDouble()),
        onPrintReceipt:
            cart.isEmpty ? null : () => _printReceipt(total.toDouble()),
        onSendElectronicTicket: cart.isEmpty ? null : _sendElectronicTicket,
        onSendKitchen:
            cart.isEmpty
                ? null
                : () {
                  _sendToKitchen();
                },
        onNewOrder: kitchenSent ? _startNewOrder : null,
      ),
    };
  }

  Set<_CashierTicketTab> _enabledTabs(List<ModelCartLine> cart) {
    if (cart.isEmpty) return {_CashierTicketTab.order};
    final tabs = {_CashierTicketTab.order, _CashierTicketTab.fulfillment};
    if (_fulfillmentSelected) {
      tabs.addAll({_CashierTicketTab.tip, _CashierTicketTab.payment});
    }
    if (_paymentReadyForConfirmation) {
      tabs.add(_CashierTicketTab.confirmation);
    }
    return tabs;
  }

  bool get _canConfirmPaymentReceived {
    final target = _selectedPaymentTarget;
    if (target == null) return false;
    if (_cashReceivedController.text.trim().isEmpty) return false;
    switch (target) {
      case _CashierPaymentTarget.cash:
      case _CashierPaymentTarget.visa:
      case _CashierPaymentTarget.wallet:
        return true;
      case _CashierPaymentTarget.split:
        return _cashReceivedController.text.trim().isNotEmpty &&
            _cashPaymentController.text.trim().isNotEmpty &&
            _visaPaymentController.text.trim().isNotEmpty &&
            _walletPaymentController.text.trim().isNotEmpty &&
            _splitPaymentMatches(_amountPayableForValidation());
    }
  }

  double _amountPayableForValidation() {
    final total = _currentTotal();
    return total + _customerPriorBalanceJod();
  }

  bool _splitPaymentMatches(double amountPayable) {
    if (_selectedPaymentTarget != _CashierPaymentTarget.split) return true;
    return (_paidTotal() - amountPayable).abs() < 0.01;
  }

  bool get _paymentReadyForConfirmation =>
      _paymentReceivedConfirmed && _canConfirmPaymentReceived;

  double _receivedValue() => _amount(_cashReceivedController);

  double _computedBalanceDue(double amountPayable) {
    return (amountPayable - _receivedValue())
        .clamp(0, double.infinity)
        .toDouble();
  }

  double _customerPriorBalanceJod() {
    if (_customerPhoneController.text.trim().isEmpty) return 0;
    return MockupCatalog.cashierCustomerPriorBalanceJod;
  }

  double _paidTotal() {
    return _amount(_cashPaymentController) +
        _amount(_visaPaymentController) +
        _amount(_walletPaymentController);
  }

  void _goToTicketTab(
    _CashierTicketTab tab,
    num total,
    List<ModelCartLine> cart,
  ) {
    if (!_enabledTabs(cart).contains(tab)) return;
    setState(() => _ticketTab = tab);
  }

  void _setPaymentMethod(_CashierPaymentTarget target, double total) {
    final text = total.toStringAsFixed(2);
    setState(() {
      _selectedPaymentTarget = target;
      _paymentReceivedConfirmed = false;
      _cashReceivedController.clear();
      switch (target) {
        case _CashierPaymentTarget.cash:
          _cashPaymentController.text = text;
          _visaPaymentController.clear();
          _walletPaymentController.clear();
        case _CashierPaymentTarget.visa:
          _cashPaymentController.clear();
          _visaPaymentController.text = text;
          _walletPaymentController.clear();
        case _CashierPaymentTarget.wallet:
          _cashPaymentController.clear();
          _visaPaymentController.clear();
          _walletPaymentController.text = text;
        case _CashierPaymentTarget.split:
          _cashPaymentController.clear();
          _visaPaymentController.clear();
          _walletPaymentController.clear();
      }
    });
  }

  void _refreshSelectedPaymentTotal(double previousTotal, double nextTotal) {
    final target = _selectedPaymentTarget;
    if (target == null || target == _CashierPaymentTarget.split) return;
    final previousPayable = (previousTotal + _customerPriorBalanceJod())
        .toStringAsFixed(2);
    final nextPayable = (nextTotal + _customerPriorBalanceJod())
        .toStringAsFixed(2);
    switch (target) {
      case _CashierPaymentTarget.cash:
        if (_cashPaymentController.text == previousPayable) {
          _cashPaymentController.text = nextPayable;
        }
      case _CashierPaymentTarget.visa:
        if (_visaPaymentController.text == previousPayable) {
          _visaPaymentController.text = nextPayable;
        }
      case _CashierPaymentTarget.wallet:
        if (_walletPaymentController.text == previousPayable) {
          _walletPaymentController.text = nextPayable;
        }
      case _CashierPaymentTarget.split:
        break;
    }
  }

  double _currentTotal({double? tipJod}) {
    final subtotal = ref.read(cartSubtotalProvider);
    final fulfillmentCharge = _fulfillmentCharge(_fulfillment, subtotal);
    return (subtotal +
            fulfillmentCharge +
            (tipJod ?? _tipJod) -
            _promoSavingsJod)
        .clamp(0, double.infinity)
        .toDouble();
  }

  Map<_CashierTicketTab, String> _tabSummaries({
    required BuildContext context,
    required List<ModelCartLine> cart,
    required double subtotal,
    required double fulfillmentCharge,
    required double total,
    required double priorBalanceJod,
    required double amountPayable,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final itemCount = cart.fold<int>(0, (sum, line) => sum + line.quantity);
    final points = _loyaltyPoints(cart);
    final fulfillmentCost = UtilityFormatJod.format(
      fulfillmentCharge,
      suffix: l10n.currencyJod,
    );
    final selectedPayment = _selectedPaymentLabel(l10n);
    final priorText =
        priorBalanceJod > 0
            ? '${l10n.cashierPriorBalance} ${UtilityFormatJod.format(priorBalanceJod, suffix: l10n.currencyJod)} • '
            : '';
    final paymentTotal = UtilityFormatJod.format(
      priorBalanceJod > 0 ? amountPayable : total,
      suffix: l10n.currencyJod,
    );
    return {
      _CashierTicketTab.order:
          '$itemCount • ${UtilityFormatJod.format(subtotal, suffix: l10n.currencyJod)} • ${l10n.loyaltyPointsShort(points.toString())}',
      _CashierTicketTab.fulfillment:
          '${_fulfillment.label(l10n)} • $fulfillmentCost',
      _CashierTicketTab.tip:
          _tipJod == 0
              ? l10n.cartNoTip
              : UtilityFormatJod.format(_tipJod, suffix: l10n.currencyJod),
      _CashierTicketTab.payment: '$priorText$selectedPayment • $paymentTotal',
      _CashierTicketTab.confirmation:
          '${l10n.cashierReadyForConfirmation} • ${l10n.loyaltyPointsShort(points.toString())}',
    };
  }

  String _selectedPaymentLabel(AppLocalizations l10n) {
    return switch (_selectedPaymentTarget) {
      _CashierPaymentTarget.cash => l10n.paymentMethodCash,
      _CashierPaymentTarget.visa => l10n.paymentMethodCard,
      _CashierPaymentTarget.wallet => l10n.paymentMethodWallet,
      _CashierPaymentTarget.split => l10n.cashierSplitPayment,
      null => l10n.cashierPaymentPending,
    };
  }

  Future<void> _confirmPaymentReceived(double total) async {
    if (_selectedPaymentTarget == _CashierPaymentTarget.split &&
        !_splitPaymentMatches(_amountPayableForValidation())) {
      UtilityMockFeedback.showInfo(
        context,
        AppLocalizations.of(context)!.cashierSplitTotalMismatch,
      );
      return;
    }
    if (!_canConfirmPaymentReceived) {
      UtilityMockFeedback.showInfo(
        context,
        AppLocalizations.of(context)!.cashierPaymentPending,
      );
      return;
    }

    if (_selectedPaymentTarget == _CashierPaymentTarget.cash) {
      final received = _amount(_cashReceivedController);
      final deducted = _amount(_cashPaymentController);
      final change = (received - deducted).clamp(0, double.infinity).toDouble();
      final confirmed = await showDialog<bool>(
        context: context,
        builder:
            (dialogContext) => _CashReturnDialog(
              received: received,
              deducted: deducted,
              change: change,
            ),
      );
      if (confirmed != true || !mounted) return;
    }

    setState(() {
      _selectedPaymentTarget ??= _CashierPaymentTarget.cash;
      _paymentReceivedConfirmed = true;
    });
  }

  void _showModifierSheet(ModelCartLine line) {
    final item = MockupCatalog.itemById(line.itemId);
    if (item == null) return;
    showWidgetsCartCustomizationSheet(
      context: context,
      item: item,
      initialLine: line,
      replaceLineKey: line.cartKey,
      useVirtualKeypad: true,
    );
  }

  void _removeLine(ModelCartLine line) {
    final willBeEmpty = ref.read(cartProvider).length <= 1;
    ref.read(cartProvider.notifier).removeItem(line.cartKey);
    if (willBeEmpty) _resetCheckoutProgress();
    UtilityMockFeedback.showInfo(
      context,
      AppLocalizations.of(context)!.actionRemove,
    );
  }

  Future<void> _voidOrder() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await UtilityMockFeedback.confirm(
      context: context,
      title: l10n.cashierVoidOrder,
      message: l10n.cashierCurrentOrder,
      confirmLabel: l10n.cashierVoidOrder,
      cancelLabel: MaterialLocalizations.of(context).cancelButtonLabel,
      icon: Icons.delete_outline,
      confirmVariant: WidgetsAppButtonVariant.danger,
    );
    if (!confirmed || !mounted) return;
    ref.read(cartProvider.notifier).clear();
    _resetCheckoutProgress();
    UtilityMockFeedback.showSuccess(context, l10n.cashierVoidOrder);
  }

  void _resetCheckoutProgress() {
    setState(() {
      _ticketTab = _CashierTicketTab.order;
      _fulfillmentSelected = false;
      _tipConfigured = false;
      _selectedPaymentTarget = null;
      _paymentReceivedConfirmed = false;
      _kitchenSent = false;
      _tipJod = 0;
      _promoSavingsJod = 0;
      _cashPaymentController.clear();
      _visaPaymentController.clear();
      _walletPaymentController.clear();
      _cashReceivedController.clear();
      _customTipController.clear();
      _tableNumberController.clear();
      _addressController.clear();
      _customerPhoneController.clear();
      _buildingController.clear();
      _floorController.clear();
      _accessCodeController.clear();
      _contactPersonController.clear();
      _deliveryTimeController.clear();
    });
  }

  void _startNewOrder() {
    ref.read(cartProvider.notifier).clear();
    _resetCheckoutProgress();
    UtilityMockFeedback.showSuccess(
      context,
      AppLocalizations.of(context)!.cashierNewOrder,
    );
  }

  Future<void> _postponeOrder(double total) async {
    final l10n = AppLocalizations.of(context)!;
    final reason = await showDialog<_CashierPostponeReason>(
      context: context,
      builder: (context) => _PostponeOrderDialog(),
    );
    if (reason == null || !mounted) return;

    final cart = ref.read(cartProvider);
    if (cart.isEmpty) {
      UtilityMockFeedback.showWarning(context, l10n.cartEmptyMessage);
      return;
    }

    final id = 'P${DateTime.now().millisecondsSinceEpoch % 100000}';
    ref
        .read(cashierPostponedOrdersProvider.notifier)
        .addOrder(
          ModelCashierPostponedOrder(
            id: id,
            cartLines: [...cart],
            fulfillmentKey: _fulfillment.name,
            tipJod: _tipJod,
            promoSavingsJod: _promoSavingsJod,
            balanceJod: _computedBalanceDue(total + _customerPriorBalanceJod()),
            paidJod: _receivedValue(),
            totalJod: total,
            reasonKey: reason.key,
            reasonNote: reason.note,
            tableNumber: _tableNumberController.text.trim(),
            address: _addressController.text.trim(),
            customerPhone: _customerPhoneController.text.trim(),
            building: _buildingController.text.trim(),
            floor: _floorController.text.trim(),
            accessCode: _accessCodeController.text.trim(),
            contactPerson: _contactPersonController.text.trim(),
            deliveryTime: _deliveryTimeController.text.trim(),
            createdAt: DateTime.now(),
          ),
        );
    ref.read(cartProvider.notifier).clear();
    _resetCheckoutProgress();
    UtilityMockFeedback.showSuccess(context, l10n.cashierPostponeSaved);
  }

  void _sendToKitchen() {
    final l10n = AppLocalizations.of(context)!;
    if (ref.read(cartProvider).isEmpty) {
      UtilityMockFeedback.showWarning(context, l10n.cartEmptyMessage);
      return;
    }
    setState(() => _kitchenSent = true);
    UtilityMockFeedback.showSuccess(context, l10n.screenOrderPrep);
  }

  void _processPayment(num total) {
    final l10n = AppLocalizations.of(context)!;
    final cart = ref.read(cartProvider);
    if (cart.isEmpty) {
      UtilityMockFeedback.showError(context, l10n.cartEmptyMessage);
      return;
    }
    if (!_paymentReceivedConfirmed) {
      UtilityMockFeedback.showError(context, l10n.cashierPaymentPending);
      return;
    }

    final orderId = 'C${DateTime.now().millisecondsSinceEpoch % 100000}';
    final customerLabel =
        _customerPhoneController.text.trim().isEmpty
            ? l10n.cashierWalkIn
            : _customerPhoneController.text.trim();
    ref
        .read(cashierSessionOrdersProvider.notifier)
        .recordOrder(
          ModelOrderSummary(
            id: orderId,
            orderType: _orderTypeForFulfillment(_fulfillment),
            customerLabel: customerLabel,
            totalJod: total.toDouble(),
            depositJod:
                _fulfillment == _CashierFulfillment.plated
                    ? MockupCatalog.checkoutPlatedDepositJod
                    : 0,
            statusKey: 'completed',
            isPlated: _fulfillment == _CashierFulfillment.plated,
          ),
        );

    ref.read(cartProvider.notifier).clear();
    _resetCheckoutProgress();
    UtilityMockFeedback.showSuccess(
      context,
      '${l10n.cashierPaid} • ${UtilityFormatJod.format(total.toDouble(), suffix: l10n.currencyJod)}',
    );
  }

  OrderType _orderTypeForFulfillment(_CashierFulfillment fulfillment) {
    return switch (fulfillment) {
      _CashierFulfillment.takeaway => OrderType.takeaway,
      _CashierFulfillment.delivery => OrderType.delivery,
      _CashierFulfillment.groupDelivery => OrderType.delivery,
      _CashierFulfillment.plated => OrderType.platedDelivery,
      _ => OrderType.dineIn,
    };
  }

  void _showReceiptDialog(double total) {
    final cart = ref.read(cartProvider);
    final subtotal = cart.fold<double>(
      0,
      (sum, line) => sum + line.lineTotalJod,
    );
    final amountPayable = total + _customerPriorBalanceJod();
    showDialog<void>(
      context: context,
      builder:
          (dialogContext) => _ReceiptDialog(
            cart: cart,
            sumData: _ticketSumData(
              cart: cart,
              subtotal: subtotal,
              fulfillmentCharge: _fulfillmentCharge(_fulfillment, subtotal),
              total: total,
              paidTotal: _paidTotal(),
              balanceDue: _computedBalanceDue(amountPayable),
            ),
            onPrint: () {
              Navigator.of(dialogContext).pop();
              _printReceipt(total);
            },
          ),
    );
  }

  OrderTicketSumData _ticketSumData({
    required List<ModelCartLine> cart,
    required double subtotal,
    required double fulfillmentCharge,
    required double total,
    required double paidTotal,
    required double balanceDue,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return OrderTicketSumData(
      itemCount: cart.fold<int>(0, (sum, line) => sum + line.quantity),
      points: _loyaltyPoints(cart),
      subtotal: subtotal,
      fulfillmentLabel: _fulfillmentSelected ? _fulfillment.label(l10n) : null,
      fulfillmentCharge: fulfillmentCharge,
      fulfillmentSelected: _fulfillmentSelected,
      tipJod: _tipJod,
      tipConfigured: _tipConfigured,
      promoSavingsJod: _promoSavingsJod,
      paymentSelected: _selectedPaymentTarget != null,
      selectedPaymentLabel: _selectedPaymentLabel(l10n),
      paidTotal: paidTotal,
      receivedValue: _receivedValue(),
      priorBalanceJod: _customerPriorBalanceJod(),
      balanceDue: balanceDue,
      total: total,
    );
  }

  void _printReceipt(double total) {
    final l10n = AppLocalizations.of(context)!;
    UtilityMockFeedback.showSuccess(
      context,
      '${l10n.cashierPrintRollReceipt} • ${UtilityFormatJod.format(total, suffix: l10n.currencyJod)}',
    );
  }

  void _sendElectronicTicket() {
    final l10n = AppLocalizations.of(context)!;
    UtilityMockFeedback.showSuccess(context, l10n.cashierElectronicTicketSent);
  }

  void _applyPromotion(_CashierPromotion promotion) {
    setState(() => _promoSavingsJod = promotion.savingsJod);
    UtilityMockFeedback.showSuccess(context, promotion.label);
  }

  double _fulfillmentCharge(_CashierFulfillment fulfillment, double subtotal) {
    return switch (fulfillment) {
      _CashierFulfillment.dineIn =>
        subtotal * MockupCatalog.checkoutDineInServiceRate,
      _CashierFulfillment.takeaway =>
        MockupCatalog.checkoutTakeawayPackagingFeeJod,
      _CashierFulfillment.delivery => MockupCatalog.checkoutDeliveryFeeJod,
      _CashierFulfillment.groupDelivery =>
        MockupCatalog.checkoutGroupDeliveryFeeJod,
      _CashierFulfillment.plated => MockupCatalog.checkoutPlatedDepositJod,
    };
  }

  int _loyaltyPoints(List<ModelCartLine> cart) {
    return cart.fold<int>(
      0,
      (total, line) => total + _lineRewardPoints(line) * line.quantity,
    );
  }

  int _lineRewardPoints(ModelCartLine line) {
    return cashierLineRewardPoints(line);
  }

  double _amount(TextEditingController controller) {
    return double.tryParse(controller.text.trim()) ?? 0;
  }
}

class _MenuWorkbench extends StatelessWidget {
  const _MenuWorkbench({
    required this.categories,
    required this.selectedCategoryId,
    required this.items,
    required this.searchController,
    required this.isAr,
    required this.onCategorySelected,
    required this.onSearchChanged,
    required this.onItemSelected,
    required this.onPromoSelected,
  });

  final List<ModelMenuCategory> categories;
  final String selectedCategoryId;
  final List<ModelMenuItem> items;
  final TextEditingController searchController;
  final bool isAr;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<ModelMenuItem> onItemSelected;
  final ValueChanged<_CashierPromotion> onPromoSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Text(
          l10n.cashierFind,
          style: CoreTypography.titleMedium(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.md(context)),
        CashierTouchTextField(
          label: l10n.cashierFind,
          controller: searchController,
          hintText: l10n.cashierMenuSearchHint,
          prefixIcon: Icons.search,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          onChanged: onSearchChanged,
        ),
        SizedBox(height: CoreSpacing.md(context)),
        _CashierPromotionsPanel(onSelected: onPromoSelected, isAr: isAr),
        SizedBox(height: CoreSpacing.lg(context)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final category in categories) ...[
                _CategoryChip(
                  category: category,
                  selected: category.id == selectedCategoryId,
                  isAr: isAr,
                  onTap: () => onCategorySelected(category.id),
                ),
                SizedBox(width: CoreSpacing.sm(context)),
              ],
            ],
          ),
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 260,
            mainAxisExtent: 340,
            crossAxisSpacing: CoreSpacing.md(context),
            mainAxisSpacing: CoreSpacing.md(context),
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return _DishButton(
              item: item,
              isAr: isAr,
              onTap: () => onItemSelected(item),
            );
          },
        ),
      ],
    );
  }
}

class _CashierPosLayout extends StatelessWidget {
  const _CashierPosLayout({
    required this.isWide,
    required this.ticket,
    required this.workbench,
    required this.workbenchScrollable,
  });

  final bool isWide;
  final Widget ticket;
  final Widget workbench;
  final bool workbenchScrollable;

  @override
  Widget build(BuildContext context) {
    final spacing = CoreSpacing.lg(context);

    if (!isWide) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 680, child: ticket),
          SizedBox(height: spacing),
          workbench,
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final fixedTicketWidth = _ticketPaneWidth(constraints.maxWidth);
        final height =
            constraints.hasBoundedHeight
                ? constraints.maxHeight
                : MediaQuery.sizeOf(context).height;
        final workbenchBottomInset =
            workbenchScrollable
                ? CoreSpacing.xxl(context)
                : CoreSpacing.lg(context);
        return SizedBox(
          height: height,
          child: Row(
            textDirection: TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: fixedTicketWidth,
                child: _FixedPane(
                  padding: EdgeInsetsDirectional.only(
                    top: CoreSpacing.md(context),
                    bottom: CoreSpacing.lg(context),
                  ),
                  child: ticket,
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: _ScrollablePane(
                  scrollable: workbenchScrollable,
                  padding: EdgeInsetsDirectional.only(
                    top: CoreSpacing.md(context),
                    bottom: workbenchBottomInset,
                  ),
                  child: workbench,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double _ticketPaneWidth(double width) {
    if (width >= 1200) return 350;
    if (width >= 1000) return 330;
    if (width >= 840) return 310;
    return 290;
  }
}

class _CashierCheckoutStepLayout extends StatelessWidget {
  const _CashierCheckoutStepLayout({
    required this.selectedTab,
    required this.enabledTabs,
    required this.onTabChanged,
    required this.fitToHeight,
    required this.summaries,
    required this.child,
  });

  final _CashierTicketTab selectedTab;
  final Set<_CashierTicketTab> enabledTabs;
  final ValueChanged<_CashierTicketTab> onTabChanged;
  final bool fitToHeight;
  final Map<_CashierTicketTab, String> summaries;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (fitToHeight) {
      return LayoutBuilder(
        builder: (context, constraints) {
          if (!constraints.hasBoundedHeight) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WidgetsAppCard(
                  variant: WidgetsAppCardVariant.dashboard,
                  padding: EdgeInsets.all(CoreSpacing.lg(context)),
                  child: _TicketTabBar(
                    selected: selectedTab,
                    enabledTabs: enabledTabs,
                    summaries: summaries,
                    onChanged: onTabChanged,
                  ),
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                child,
              ],
            );
          }
          return SizedBox(
            height: constraints.maxHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WidgetsAppCard(
                  variant: WidgetsAppCardVariant.dashboard,
                  padding: EdgeInsets.all(CoreSpacing.lg(context)),
                  child: _TicketTabBar(
                    selected: selectedTab,
                    enabledTabs: enabledTabs,
                    summaries: summaries,
                    onChanged: onTabChanged,
                  ),
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                Expanded(child: child),
              ],
            ),
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        WidgetsAppCard(
          variant: WidgetsAppCardVariant.dashboard,
          padding: EdgeInsets.all(CoreSpacing.lg(context)),
          child: _TicketTabBar(
            selected: selectedTab,
            enabledTabs: enabledTabs,
            summaries: summaries,
            onChanged: onTabChanged,
          ),
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        child,
      ],
    );
  }
}

class _FixedPane extends StatelessWidget {
  const _FixedPane({required this.child, required this.padding});

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: padding, child: child);
  }
}

class _ScrollablePane extends StatelessWidget {
  const _ScrollablePane({
    required this.child,
    required this.padding,
    required this.scrollable,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    if (!scrollable) {
      return Padding(padding: padding, child: child);
    }
    return ListView(padding: padding, children: [child]);
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.category,
    required this.selected,
    required this.isAr,
    required this.onTap,
  });

  final ModelMenuCategory category;
  final bool selected;
  final bool isAr;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = selected ? scheme.primary : scheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: selected ? 0.14 : 0.08),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
          border: Border.all(color: color.withValues(alpha: 0.22)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CoreSpacing.md(context),
            vertical: CoreSpacing.sm(context),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _categoryIcon(category.iconKey),
                color: color,
                size: CoreContentSizes.orderTypeIcon(context),
              ),
              SizedBox(width: CoreSpacing.xs(context)),
              Text(
                isAr ? category.nameAr : category.nameEn,
                style: CoreTypography.caption(
                  context,
                  color,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CashierPromotionsPanel extends StatelessWidget {
  const _CashierPromotionsPanel({required this.onSelected, required this.isAr});

  final ValueChanged<_CashierPromotion> onSelected;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final promotions = _CashierPromotion.available(context);
    if (promotions.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.cashierPromotionsTitle,
          style: CoreTypography.titleMedium(
            context,
            Theme.of(context).colorScheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.md(context)),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: promotions.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 260,
            mainAxisExtent: 340,
            crossAxisSpacing: CoreSpacing.md(context),
            mainAxisSpacing: CoreSpacing.md(context),
          ),
          itemBuilder: (context, index) {
            final promotion = promotions[index];
            return _PromotionCard(
              promotion: promotion,
              isAr: isAr,
              onTap: () => onSelected(promotion),
            );
          },
        ),
      ],
    );
  }
}

class _PromotionCard extends StatelessWidget {
  const _PromotionCard({
    required this.promotion,
    required this.isAr,
    required this.onTap,
  });

  final _CashierPromotion promotion;
  final bool isAr;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsFoodMediaPanel(
            height:
                CoreContentSizes.categoryMenuImageHeight(
                  context,
                ).clamp(104, 132).toDouble(),
            badge: _FoodTag(
              label: promotion.sectionLabel,
              color: promotion.color,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    promotion.color.withValues(alpha: 0.28),
                    promotion.color.withValues(alpha: 0.08),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  promotion.icon,
                  color: promotion.color,
                  size: CoreContentSizes.buttonIcon(context) * 1.6,
                ),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            promotion.label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CoreTypography.bodyMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            promotion.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          const Spacer(),
          SizedBox(height: CoreSpacing.sm(context)),
          Row(
            children: [
              Flexible(
                child: WidgetsPriceBadge(
                  priceLabel: UtilityFormatJod.format(
                    promotion.savingsJod,
                    suffix: l10n.currencyJod,
                  ),
                  compact: true,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Icon(Icons.local_offer_outlined, color: promotion.color),
            ],
          ),
        ],
      ),
    );
  }
}

class _DishButton extends StatelessWidget {
  const _DishButton({
    required this.item,
    required this.isAr,
    required this.onTap,
  });

  final ModelMenuItem item;
  final bool isAr;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final color = _categoryColor(context, item.categoryId);

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsFoodMediaPanel(
            height:
                CoreContentSizes.categoryMenuImageHeight(
                  context,
                ).clamp(104, 132).toDouble(),
            badge: _FoodTag(label: item.categoryId, color: color),
            child: WidgetsMockFoodImage(
              imageUrl: item.imageUrl,
              fallback: _DishMedia(
                color: color,
                icon: _categoryIcon(item.categoryId),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            isAr ? item.nameAr : item.nameEn,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CoreTypography.bodyMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            isAr ? item.descriptionAr : item.descriptionEn,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          const Spacer(),
          SizedBox(height: CoreSpacing.sm(context)),
          Row(
            children: [
              Flexible(
                child: WidgetsPriceBadge(
                  priceLabel: UtilityFormatJod.format(
                    item.priceJod,
                    suffix: l10n.currencyJod,
                  ),
                  compact: true,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Icon(Icons.add_circle_outline, color: scheme.primary),
            ],
          ),
        ],
      ),
    );
  }
}

class _TicketPanel extends StatelessWidget {
  const _TicketPanel({
    required this.fulfillment,
    required this.cart,
    required this.subtotal,
    required this.fulfillmentCharge,
    required this.fulfillmentSelected,
    required this.tipJod,
    required this.tipConfigured,
    required this.promoSavingsJod,
    required this.total,
    required this.paidTotal,
    required this.balanceDue,
    required this.priorBalanceJod,
    required this.receivedValue,
    required this.selectedPaymentLabel,
    required this.paymentSelected,
    required this.isAr,
    required this.addressController,
    required this.customerPhoneController,
    required this.buildingController,
    required this.floorController,
    required this.accessCodeController,
    required this.contactPersonController,
    required this.deliveryTimeController,
    required this.cashPaymentController,
    required this.visaPaymentController,
    required this.walletPaymentController,
    required this.cashReceivedController,
    required this.customTipController,
    required this.onFulfillmentChanged,
    required this.onTipChanged,
    required this.onPaymentChanged,
    required this.onQuantityChanged,
    required this.onModifier,
    required this.onRemoveLine,
    required this.onVoid,
    required this.onSendKitchen,
    required this.onPayment,
    required this.onViewReceipt,
    required this.onPrintReceipt,
    required this.onSendElectronicTicket,
  });

  final _CashierFulfillment fulfillment;
  final List<ModelCartLine> cart;
  final double subtotal;
  final double fulfillmentCharge;
  final bool fulfillmentSelected;
  final double tipJod;
  final bool tipConfigured;
  final double promoSavingsJod;
  final double total;
  final double paidTotal;
  final double balanceDue;
  final double priorBalanceJod;
  final double receivedValue;
  final String selectedPaymentLabel;
  final bool paymentSelected;
  final bool isAr;
  final TextEditingController addressController;
  final TextEditingController customerPhoneController;
  final TextEditingController buildingController;
  final TextEditingController floorController;
  final TextEditingController accessCodeController;
  final TextEditingController contactPersonController;
  final TextEditingController deliveryTimeController;
  final TextEditingController cashPaymentController;
  final TextEditingController visaPaymentController;
  final TextEditingController walletPaymentController;
  final TextEditingController cashReceivedController;
  final TextEditingController customTipController;
  final ValueChanged<_CashierFulfillment> onFulfillmentChanged;
  final ValueChanged<double> onTipChanged;
  final VoidCallback onPaymentChanged;
  final void Function(ModelCartLine line, int quantity) onQuantityChanged;
  final ValueChanged<ModelCartLine> onModifier;
  final ValueChanged<ModelCartLine> onRemoveLine;
  final VoidCallback onVoid;
  final VoidCallback? onSendKitchen;
  final VoidCallback? onPayment;
  final VoidCallback? onViewReceipt;
  final VoidCallback? onPrintReceipt;
  final VoidCallback? onSendElectronicTicket;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: WidgetsAppCard(
        variant: WidgetsAppCardVariant.form,
        padding: EdgeInsets.all(CoreSpacing.lg(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _OrderTicketTab(
                cart: cart,
                isAr: isAr,
                fulfillment: fulfillment,
                fulfillmentCharge: fulfillmentCharge,
                fulfillmentSelected: fulfillmentSelected,
                tipJod: tipJod,
                tipConfigured: tipConfigured,
                promoSavingsJod: promoSavingsJod,
                total: total,
                paidTotal: paidTotal,
                balanceDue: balanceDue,
                priorBalanceJod: priorBalanceJod,
                receivedValue: receivedValue,
                selectedPaymentLabel: selectedPaymentLabel,
                paymentSelected: paymentSelected,
                onQuantityChanged: onQuantityChanged,
                onModifier: onModifier,
                onRemoveLine: onRemoveLine,
                onVoid: onVoid,
                onSendKitchen: onSendKitchen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketTabBar extends StatelessWidget {
  const _TicketTabBar({
    required this.selected,
    required this.enabledTabs,
    required this.summaries,
    required this.onChanged,
  });

  final _CashierTicketTab selected;
  final Set<_CashierTicketTab> enabledTabs;
  final Map<_CashierTicketTab, String> summaries;
  final ValueChanged<_CashierTicketTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final tabs = _CashierTicketTab.values;
    return Row(
      children: [
        for (final tab in tabs) ...[
          Expanded(
            child: _CheckoutTabCard(
              label: tab.label(AppLocalizations.of(context)!),
              summary: summaries[tab] ?? '',
              icon: tab.icon,
              selected: selected == tab,
              enabled: enabledTabs.contains(tab),
              onTap: () => onChanged(tab),
            ),
          ),
          if (tab != tabs.last) SizedBox(width: CoreSpacing.sm(context)),
        ],
      ],
    );
  }
}

class _CheckoutTabCard extends StatelessWidget {
  const _CheckoutTabCard({
    required this.label,
    required this.summary,
    required this.icon,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final String summary;
  final IconData icon;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color =
        !enabled
            ? scheme.outline
            : selected
            ? scheme.primary
            : scheme.onSurfaceVariant;
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: selected ? 0.16 : 0.06),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
          border: Border.all(
            color: color.withValues(alpha: selected ? 0.42 : 0.18),
          ),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 112),
          child: Padding(
            padding: EdgeInsets.all(CoreSpacing.md(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 32),
                SizedBox(height: CoreSpacing.sm(context)),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.bodyMedium(
                    context,
                    color,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  summary,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    color,
                  ).copyWith(fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderTicketTab extends StatelessWidget {
  const _OrderTicketTab({
    required this.cart,
    required this.isAr,
    required this.fulfillment,
    required this.fulfillmentCharge,
    required this.fulfillmentSelected,
    required this.tipJod,
    required this.tipConfigured,
    required this.promoSavingsJod,
    required this.total,
    required this.paidTotal,
    required this.balanceDue,
    required this.priorBalanceJod,
    required this.receivedValue,
    required this.selectedPaymentLabel,
    required this.paymentSelected,
    required this.onQuantityChanged,
    required this.onModifier,
    required this.onRemoveLine,
    required this.onVoid,
    required this.onSendKitchen,
  });

  final List<ModelCartLine> cart;
  final bool isAr;
  final _CashierFulfillment fulfillment;
  final double fulfillmentCharge;
  final bool fulfillmentSelected;
  final double tipJod;
  final bool tipConfigured;
  final double promoSavingsJod;
  final double total;
  final double paidTotal;
  final double balanceDue;
  final double priorBalanceJod;
  final double receivedValue;
  final String selectedPaymentLabel;
  final bool paymentSelected;
  final void Function(ModelCartLine line, int quantity) onQuantityChanged;
  final ValueChanged<ModelCartLine> onModifier;
  final ValueChanged<ModelCartLine> onRemoveLine;
  final VoidCallback onVoid;
  final VoidCallback? onSendKitchen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final itemCount = cart.fold<int>(0, (sum, line) => sum + line.quantity);
    final subtotal = cart.fold<double>(
      0,
      (sum, line) => sum + line.lineTotalJod,
    );
    final points = cart.fold<int>(
      0,
      (sum, line) => sum + cashierLineRewardPoints(line) * line.quantity,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child:
              cart.isEmpty
                  ? SingleChildScrollView(
                    child: _EmptyTicket(message: l10n.cashierOrderEmpty),
                  )
                  : ListView(
                    children: [
                      for (final line in cart) ...[
                        _TicketLine(
                          line: line,
                          isAr: isAr,
                          onQuantityChanged:
                              (quantity) => onQuantityChanged(line, quantity),
                          onModifier: () => onModifier(line),
                          onRemove: () => onRemoveLine(line),
                        ),
                        SizedBox(height: CoreSpacing.sm(context)),
                      ],
                    ],
                  ),
        ),
        SizedBox(height: CoreSpacing.md(context)),
        _TicketTotalsFooter(
          itemCount: itemCount,
          subtotal: subtotal,
          points: points,
          fulfillment: fulfillment,
          fulfillmentCharge: fulfillmentCharge,
          fulfillmentSelected: fulfillmentSelected,
          tipJod: tipJod,
          tipConfigured: tipConfigured,
          promoSavingsJod: promoSavingsJod,
          total: total,
          paidTotal: paidTotal,
          balanceDue: balanceDue,
          priorBalanceJod: priorBalanceJod,
          receivedValue: receivedValue,
          selectedPaymentLabel: selectedPaymentLabel,
          paymentSelected: paymentSelected,
          onVoid: cart.isEmpty ? null : onVoid,
        ),
      ],
    );
  }
}

class _TicketTotalsFooter extends StatelessWidget {
  const _TicketTotalsFooter({
    required this.itemCount,
    required this.subtotal,
    required this.points,
    required this.fulfillment,
    required this.fulfillmentCharge,
    required this.fulfillmentSelected,
    required this.tipJod,
    required this.tipConfigured,
    required this.promoSavingsJod,
    required this.total,
    required this.paidTotal,
    required this.balanceDue,
    required this.priorBalanceJod,
    required this.receivedValue,
    required this.selectedPaymentLabel,
    required this.paymentSelected,
    required this.onVoid,
  });

  final int itemCount;
  final double subtotal;
  final int points;
  final _CashierFulfillment fulfillment;
  final double fulfillmentCharge;
  final bool fulfillmentSelected;
  final double tipJod;
  final bool tipConfigured;
  final double promoSavingsJod;
  final double total;
  final double paidTotal;
  final double balanceDue;
  final double priorBalanceJod;
  final double receivedValue;
  final String selectedPaymentLabel;
  final bool paymentSelected;
  final VoidCallback? onVoid;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final amountRows = OrderTicketSumBuilders.leftTicketSumRows(
      l10n,
      OrderTicketSumData(
        itemCount: itemCount,
        points: points,
        subtotal: subtotal,
        fulfillmentLabel: fulfillmentSelected ? fulfillment.label(l10n) : null,
        fulfillmentCharge: fulfillmentCharge,
        fulfillmentSelected: fulfillmentSelected,
        tipJod: tipJod,
        tipConfigured: tipConfigured,
        promoSavingsJod: promoSavingsJod,
        paymentSelected: paymentSelected,
        selectedPaymentLabel: selectedPaymentLabel,
        paidTotal: paidTotal,
        receivedValue: receivedValue,
        priorBalanceJod: priorBalanceJod,
        balanceDue: balanceDue,
        total: total,
      ),
    );

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsOrderTicketSumTable(rows: amountRows),
          SizedBox(height: CoreSpacing.md(context)),
          _CashierActionCard(
            label: l10n.cashierVoidOrder,
            icon: Icons.delete_outline,
            onTap: onVoid,
            tone: CoreColors.semanticError,
            expandWidth: true,
          ),
        ],
      ),
    );
  }
}

class _CashierActionCard extends StatelessWidget {
  const _CashierActionCard({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.tone,
    this.minHeight = 116,
    this.expandWidth = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final Color tone;
  final double minHeight;
  final bool expandWidth;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final color = enabled ? tone : Theme.of(context).colorScheme.outline;
    final card = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: enabled ? 0.12 : 0.06),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
          border: Border.all(color: color.withValues(alpha: 0.28)),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Padding(
            padding: EdgeInsets.all(CoreSpacing.md(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: CoreContentSizes.buttonIcon(context),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    color,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (!expandWidth) return card;
    return SizedBox(width: double.infinity, child: card);
  }
}

class _CashierStepWorkbench extends StatelessWidget {
  const _CashierStepWorkbench({required this.details, required this.actions});

  final Widget details;
  final Widget actions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fallbackHeight = (MediaQuery.sizeOf(context).height - 220).clamp(
          520.0,
          980.0,
        );
        final height =
            constraints.hasBoundedHeight
                ? constraints.maxHeight
                : fallbackHeight;
        if (constraints.maxWidth < 900) {
          return SizedBox(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _WorkbenchDetailsPane(child: details)),
                SizedBox(height: CoreSpacing.md(context)),
                Expanded(child: actions),
              ],
            ),
          );
        }
        return SizedBox(
          height: height,
          child: Row(
            textDirection: TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 5, child: _WorkbenchDetailsPane(child: details)),
              SizedBox(width: CoreSpacing.lg(context)),
              Expanded(flex: 4, child: actions),
            ],
          ),
        );
      },
    );
  }
}

class _WorkbenchDetailsPane extends StatelessWidget {
  const _WorkbenchDetailsPane({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      child: child,
    );
  }
}

class _FittedActionColumn extends StatelessWidget {
  const _FittedActionColumn({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < children.length; index++) ...[
          Expanded(child: children[index]),
          if (index < children.length - 1)
            SizedBox(height: CoreSpacing.sm(context)),
        ],
      ],
    );
  }
}

class _FulfillmentDetailsCard extends StatelessWidget {
  const _FulfillmentDetailsCard({
    required this.fulfillment,
    required this.tableNumberController,
  });

  final _CashierFulfillment fulfillment;
  final TextEditingController tableNumberController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(fulfillment.icon, color: scheme.primary),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  fulfillment.label(l10n),
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          if (fulfillment == _CashierFulfillment.dineIn)
            CashierTouchTextField(
              label: l10n.cashierTableNumber,
              controller: tableNumberController,
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
              prefixIcon: Icons.table_restaurant_outlined,
            )
          else
            Text(
              l10n.cashierNoTableNeeded,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurfaceVariant,
              ).copyWith(fontWeight: FontWeight.w800),
            ),
        ],
      ),
    );
  }
}

class _FulfillmentTicketTab extends StatelessWidget {
  const _FulfillmentTicketTab({
    required this.fulfillment,
    required this.tableNumberController,
    required this.addressController,
    required this.customerPhoneController,
    required this.buildingController,
    required this.floorController,
    required this.accessCodeController,
    required this.contactPersonController,
    required this.deliveryTimeController,
    required this.onFulfillmentChanged,
  });

  final _CashierFulfillment fulfillment;
  final TextEditingController tableNumberController;
  final TextEditingController addressController;
  final TextEditingController customerPhoneController;
  final TextEditingController buildingController;
  final TextEditingController floorController;
  final TextEditingController accessCodeController;
  final TextEditingController contactPersonController;
  final TextEditingController deliveryTimeController;
  final ValueChanged<_CashierFulfillment> onFulfillmentChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final details =
        fulfillment.requiresLocation
            ? _DeliveryDetailsSection(
              addressController: addressController,
              customerPhoneController: customerPhoneController,
              buildingController: buildingController,
              floorController: floorController,
              accessCodeController: accessCodeController,
              contactPersonController: contactPersonController,
              deliveryTimeController: deliveryTimeController,
            )
            : _FulfillmentDetailsCard(
              fulfillment: fulfillment,
              tableNumberController: tableNumberController,
            );
    return _CashierStepWorkbench(
      details: details,
      actions: _FittedActionColumn(
        children: [
          for (final option in _CashierFulfillment.values)
            _FulfillmentOptionCard(
              label: option.label(l10n),
              icon: option.icon,
              selected: fulfillment == option,
              color: option.color,
              onTap: () => onFulfillmentChanged(option),
              minHeight: 0,
            ),
        ],
      ),
    );
  }
}

class _TipTicketTab extends StatelessWidget {
  const _TipTicketTab({
    required this.tipJod,
    required this.customTipController,
    required this.onTipChanged,
    required this.onCustomTipChanged,
  });

  final double tipJod;
  final TextEditingController customTipController;
  final ValueChanged<double> onTipChanged;
  final ValueChanged<String> onCustomTipChanged;

  @override
  Widget build(BuildContext context) {
    return _CashierStepWorkbench(
      details: _TipDetailsCard(
        tipJod: tipJod,
        customTipController: customTipController,
        onCustomTipChanged: onCustomTipChanged,
      ),
      actions: _TipOptionCards(selectedTipJod: tipJod, onChanged: onTipChanged),
    );
  }
}

class _TipDetailsCard extends StatelessWidget {
  const _TipDetailsCard({
    required this.tipJod,
    required this.customTipController,
    required this.onCustomTipChanged,
  });

  final double tipJod;
  final TextEditingController customTipController;
  final ValueChanged<String> onCustomTipChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.cartTipTitle,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsPriceBadge(
            priceLabel: UtilityFormatJod.format(
              tipJod,
              suffix: l10n.currencyJod,
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          CashierTouchTextField(
            label: l10n.tipCustomAmountJod,
            controller: customTipController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textDirection: TextDirection.ltr,
            prefixIcon: Icons.edit_outlined,
            onChanged: onCustomTipChanged,
          ),
        ],
      ),
    );
  }
}

class _TipOptionCards extends StatelessWidget {
  const _TipOptionCards({
    required this.selectedTipJod,
    required this.onChanged,
  });

  final double selectedTipJod;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tips = <double>[0, 1, 2, 5];
    return _FittedActionColumn(
      children: [
        for (final tip in tips)
          _FulfillmentOptionCard(
            label:
                tip == 0
                    ? l10n.cartNoTip
                    : UtilityFormatJod.format(tip, suffix: l10n.currencyJod),
            icon: Icons.volunteer_activism_outlined,
            selected: selectedTipJod == tip,
            color: CoreColors.semanticTip,
            onTap: () => onChanged(tip),
            minHeight: 0,
          ),
      ],
    );
  }
}

class _PaymentTicketTab extends StatelessWidget {
  const _PaymentTicketTab({
    required this.total,
    required this.priorBalanceJod,
    required this.amountPayable,
    required this.remaining,
    required this.cashChange,
    required this.selectedPaymentTarget,
    required this.cashPaymentController,
    required this.visaPaymentController,
    required this.walletPaymentController,
    required this.cashReceivedController,
    required this.balanceDue,
    required this.onPaymentChanged,
    required this.onPaymentMethodSelected,
    required this.paymentReceivedConfirmed,
    required this.canConfirmPayment,
    required this.splitTotalMismatch,
    required this.onPaymentReceived,
    required this.onPostpone,
  });

  final double total;
  final double priorBalanceJod;
  final double amountPayable;
  final double remaining;
  final double cashChange;
  final _CashierPaymentTarget? selectedPaymentTarget;
  final TextEditingController cashPaymentController;
  final TextEditingController visaPaymentController;
  final TextEditingController walletPaymentController;
  final TextEditingController cashReceivedController;
  final double balanceDue;
  final VoidCallback onPaymentChanged;
  final ValueChanged<_CashierPaymentTarget> onPaymentMethodSelected;
  final bool paymentReceivedConfirmed;
  final bool canConfirmPayment;
  final bool splitTotalMismatch;
  final VoidCallback onPaymentReceived;
  final VoidCallback onPostpone;

  @override
  Widget build(BuildContext context) {
    return _CashierStepWorkbench(
      details: _PaymentSplitSection(
        selectedPaymentTarget: selectedPaymentTarget,
        priorBalanceJod: priorBalanceJod,
        amountPayable: amountPayable,
        cashPaymentController: cashPaymentController,
        visaPaymentController: visaPaymentController,
        walletPaymentController: walletPaymentController,
        cashReceivedController: cashReceivedController,
        balanceDue: balanceDue,
        remaining: remaining,
        cashChange: cashChange,
        paymentReceivedConfirmed: paymentReceivedConfirmed,
        canConfirmPayment: canConfirmPayment,
        splitTotalMismatch: splitTotalMismatch,
        onChanged: onPaymentChanged,
        onPaymentReceived: onPaymentReceived,
        onPostpone: onPostpone,
      ),
      actions: _PaymentMethodCards(
        amountPayable: amountPayable,
        selectedTarget: selectedPaymentTarget,
        onSelected: onPaymentMethodSelected,
      ),
    );
  }
}

class _ConfirmationTicketTab extends StatelessWidget {
  const _ConfirmationTicketTab({
    required this.cart,
    required this.sumData,
    required this.kitchenSent,
    required this.onCancel,
    required this.onViewReceipt,
    required this.onPrintReceipt,
    required this.onSendElectronicTicket,
    required this.onSendKitchen,
    required this.onNewOrder,
  });

  final List<ModelCartLine> cart;
  final OrderTicketSumData sumData;
  final bool kitchenSent;
  final VoidCallback onCancel;
  final VoidCallback? onViewReceipt;
  final VoidCallback? onPrintReceipt;
  final VoidCallback? onSendElectronicTicket;
  final VoidCallback? onSendKitchen;
  final VoidCallback? onNewOrder;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _CashierStepWorkbench(
      details: WidgetsOrderInvoiceBlock(
        cart: cart,
        sumData: sumData,
        onCancel: onCancel,
      ),
      actions: Column(
        children: [
          Expanded(
            child: _FittedActionColumn(
              children: [
                _PreparationCountdownButton(onSendKitchen: onSendKitchen),
                _CashierActionCard(
                  label: l10n.cashierViewReceipt,
                  icon: Icons.receipt_long_outlined,
                  onTap: onViewReceipt,
                  tone: Theme.of(context).colorScheme.primary,
                  minHeight: 0,
                ),
                _CashierActionCard(
                  label: l10n.cashierPrintRollReceipt,
                  icon: Icons.print_outlined,
                  onTap: onPrintReceipt,
                  tone: CoreColors.brandGold,
                  minHeight: 0,
                ),
                _CashierActionCard(
                  label: l10n.cashierSendElectronicTicket,
                  icon: Icons.qr_code_2_outlined,
                  onTap: onSendElectronicTicket,
                  tone: CoreColors.brandOlive,
                  minHeight: 0,
                ),
                _CashierActionCard(
                  label:
                      kitchenSent
                          ? l10n.cashierNewOrder
                          : l10n.cashierKitchenSent,
                  icon: Icons.add_shopping_cart_outlined,
                  onTap: onNewOrder,
                  tone: CoreColors.semanticSuccess,
                  minHeight: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PreparationCountdownButton extends StatefulWidget {
  const _PreparationCountdownButton({required this.onSendKitchen});

  final VoidCallback? onSendKitchen;

  @override
  State<_PreparationCountdownButton> createState() =>
      _PreparationCountdownButtonState();
}

class _PreparationCountdownButtonState
    extends State<_PreparationCountdownButton> {
  static const _initialSeconds = 5;
  Timer? _timer;
  int _secondsLeft = _initialSeconds;
  bool _sent = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void didUpdateWidget(covariant _PreparationCountdownButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.onSendKitchen != widget.onSendKitchen) {
      _timer?.cancel();
      _secondsLeft = _initialSeconds;
      _sent = false;
      _startCountdown();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    if (widget.onSendKitchen == null) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsLeft <= 1) {
        _send();
        return;
      }
      setState(() => _secondsLeft--);
    });
  }

  void _send() {
    if (_sent) return;
    _timer?.cancel();
    setState(() {
      _sent = true;
      _secondsLeft = 0;
    });
    widget.onSendKitchen?.call();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final enabled = widget.onSendKitchen != null && !_sent;
    final label =
        _sent
            ? l10n.screenOrderPrep
            : '${l10n.cashierSendOrderPreparation} ($_secondsLeft)';
    return _CashierActionCard(
      label: label,
      icon: Icons.soup_kitchen_outlined,
      onTap: enabled ? _send : null,
      tone: scheme.primary,
      minHeight: 0,
    );
  }
}

class _DeliveryDetailsSection extends StatelessWidget {
  const _DeliveryDetailsSection({
    required this.addressController,
    required this.customerPhoneController,
    required this.buildingController,
    required this.floorController,
    required this.accessCodeController,
    required this.contactPersonController,
    required this.deliveryTimeController,
  });

  final TextEditingController addressController;
  final TextEditingController customerPhoneController;
  final TextEditingController buildingController;
  final TextEditingController floorController;
  final TextEditingController accessCodeController;
  final TextEditingController contactPersonController;
  final TextEditingController deliveryTimeController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
                ),
                child: Padding(
                  padding: EdgeInsets.all(CoreSpacing.sm(context)),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: scheme.primary,
                    size: CoreContentSizes.buttonIcon(context),
                  ),
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.cashierLocationDetails,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.primaryContainer.withValues(alpha: 0.32),
              borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
              border: Border.all(color: scheme.primary.withValues(alpha: 0.22)),
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.sm(context)),
              child: CashierTouchTextField(
                label: l10n.cashierAddress,
                controller: addressController,
                prefixIcon: Icons.map_outlined,
                keyboardType: TextInputType.streetAddress,
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          LayoutBuilder(
            builder: (context, constraints) {
              final spacing = CoreSpacing.sm(context);
              final useTwoColumns = constraints.maxWidth >= 420;
              final slotWidth =
                  useTwoColumns
                      ? (constraints.maxWidth - spacing) / 2
                      : constraints.maxWidth;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  _DeliveryFieldSlot(
                    width: slotWidth,
                    child: CashierTouchTextField(
                      label: l10n.fieldPhone,
                      controller: customerPhoneController,
                      keyboardType: TextInputType.phone,
                      textDirection: TextDirection.ltr,
                      prefixIcon: Icons.phone_outlined,
                    ),
                  ),
                  _DeliveryFieldSlot(
                    width: slotWidth,
                    child: CashierTouchTextField(
                      label: l10n.cashierContactPerson,
                      controller: contactPersonController,
                      prefixIcon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  _DeliveryFieldSlot(
                    width: slotWidth,
                    child: CashierTouchTextField(
                      label: l10n.cashierBuildingNumber,
                      controller: buildingController,
                      prefixIcon: Icons.apartment_outlined,
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  _DeliveryFieldSlot(
                    width: slotWidth,
                    child: CashierTouchTextField(
                      label: l10n.cashierFloorNumber,
                      controller: floorController,
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.ltr,
                      prefixIcon: Icons.stairs_outlined,
                    ),
                  ),
                  _DeliveryFieldSlot(
                    width: slotWidth,
                    child: CashierTouchTextField(
                      label: l10n.cashierDoorAccessCode,
                      controller: accessCodeController,
                      prefixIcon: Icons.lock_outline,
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  _DeliveryFieldSlot(
                    width: slotWidth,
                    child: CashierTouchTextField(
                      label: l10n.cashierDeliveryTimeSchedule,
                      controller: deliveryTimeController,
                      prefixIcon: Icons.schedule_outlined,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DeliveryFieldSlot extends StatelessWidget {
  const _DeliveryFieldSlot({required this.child, required this.width});

  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: child);
  }
}

class _PaymentSplitSection extends StatelessWidget {
  const _PaymentSplitSection({
    required this.selectedPaymentTarget,
    required this.priorBalanceJod,
    required this.amountPayable,
    required this.cashPaymentController,
    required this.visaPaymentController,
    required this.walletPaymentController,
    required this.cashReceivedController,
    required this.balanceDue,
    required this.remaining,
    required this.cashChange,
    required this.paymentReceivedConfirmed,
    required this.canConfirmPayment,
    required this.splitTotalMismatch,
    required this.onChanged,
    required this.onPaymentReceived,
    required this.onPostpone,
  });

  final _CashierPaymentTarget? selectedPaymentTarget;
  final double priorBalanceJod;
  final double amountPayable;
  final TextEditingController cashPaymentController;
  final TextEditingController visaPaymentController;
  final TextEditingController walletPaymentController;
  final TextEditingController cashReceivedController;
  final double balanceDue;
  final double remaining;
  final double cashChange;
  final bool paymentReceivedConfirmed;
  final bool canConfirmPayment;
  final bool splitTotalMismatch;
  final VoidCallback onChanged;
  final VoidCallback onPaymentReceived;
  final VoidCallback onPostpone;

  double _amount(TextEditingController controller) {
    return double.tryParse(controller.text.trim()) ?? 0;
  }

  String _sectionTitle(AppLocalizations l10n) {
    return switch (selectedPaymentTarget) {
      _CashierPaymentTarget.split => l10n.cashierSplitPayment,
      _CashierPaymentTarget.cash ||
      _CashierPaymentTarget.visa ||
      _CashierPaymentTarget.wallet => l10n.cashierPaymentDetails,
      null => l10n.cashierSelectPaymentMethod,
    };
  }

  List<Widget> _paymentMethodFields(
    BuildContext context,
    AppLocalizations l10n,
    double spacing,
  ) {
    final target = selectedPaymentTarget;
    if (target == null) return const [];

    switch (target) {
      case _CashierPaymentTarget.cash:
        return [
          _PaymentAmountDisplay(
            label: l10n.paymentMethodCash,
            amount: _amount(cashPaymentController),
            color: CoreColors.semanticSuccess,
          ),
        ];
      case _CashierPaymentTarget.visa:
        return [
          _PaymentAmountDisplay(
            label: l10n.paymentMethodCard,
            amount: _amount(visaPaymentController),
            color: CoreColors.brandOlive,
          ),
        ];
      case _CashierPaymentTarget.wallet:
        return [
          _PaymentAmountDisplay(
            label: l10n.paymentMethodWallet,
            amount: _amount(walletPaymentController),
            color: CoreColors.semanticTip,
          ),
        ];
      case _CashierPaymentTarget.split:
        return [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _MoneyField(
                  label: l10n.paymentMethodCash,
                  controller: cashPaymentController,
                  onChanged: onChanged,
                  compact: true,
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: _MoneyField(
                  label: l10n.paymentMethodCard,
                  controller: visaPaymentController,
                  onChanged: onChanged,
                  compact: true,
                ),
              ),
            ],
          ),
          SizedBox(height: spacing),
          _MoneyField(
            label: l10n.paymentMethodWallet,
            controller: walletPaymentController,
            onChanged: onChanged,
            compact: true,
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final spacing = CoreSpacing.sm(context);
    final scheme = Theme.of(context).colorScheme;
    final paymentFields = _paymentMethodFields(context, l10n, spacing);

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.zero,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(CoreSpacing.md(context)),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _sectionTitle(l10n),
                    style: CoreTypography.titleMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  if (priorBalanceJod > 0) ...[
                    SizedBox(height: spacing),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: CoreColors.semanticWarning.withValues(
                          alpha: 0.12,
                        ),
                        borderRadius: BorderRadius.circular(
                          CoreSpacing.radiusCard,
                        ),
                        border: Border.all(
                          color: CoreColors.semanticWarning.withValues(
                            alpha: 0.35,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: CoreSpacing.md(context),
                          vertical: CoreSpacing.sm(context),
                        ),
                        child: _SummaryLine(
                          label: l10n.cashierPriorBalance,
                          value: UtilityFormatJod.format(
                            priorBalanceJod,
                            suffix: l10n.currencyJod,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: spacing),
                    _SummaryLine(
                      label: l10n.cashierTotal,
                      value: UtilityFormatJod.format(
                        amountPayable,
                        suffix: l10n.currencyJod,
                      ),
                    ),
                  ],
                  if (paymentFields.isNotEmpty) ...[
                    SizedBox(height: spacing),
                    ...paymentFields,
                    if (splitTotalMismatch) ...[
                      SizedBox(height: spacing),
                      Text(
                        l10n.cashierSplitTotalMismatch,
                        style: CoreTypography.caption(
                          context,
                          CoreColors.semanticError,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ],
                  if (selectedPaymentTarget != null) ...[
                    SizedBox(height: spacing),
                    _MoneyField(
                      label: l10n.cashierReceivedValue,
                      controller: cashReceivedController,
                      onChanged: onChanged,
                      prominent: true,
                      compact: true,
                    ),
                    SizedBox(height: spacing),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer.withValues(alpha: 0.42),
                        borderRadius: BorderRadius.circular(
                          CoreSpacing.radiusCard,
                        ),
                        border: Border.all(
                          color: scheme.primary.withValues(alpha: 0.32),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: CoreSpacing.md(context),
                          vertical: CoreSpacing.sm(context),
                        ),
                        child: _SummaryLine(
                          label: l10n.cashierBalanceDue,
                          value: UtilityFormatJod.format(
                            balanceDue,
                            suffix: l10n.currencyJod,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: spacing),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest.withValues(
                          alpha: 0.45,
                        ),
                        borderRadius: BorderRadius.circular(
                          CoreSpacing.radiusCard,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: CoreSpacing.md(context),
                          vertical: CoreSpacing.sm(context),
                        ),
                        child: Column(
                          children: [
                            if (remaining > 0)
                              _SummaryLine(
                                label: l10n.cashierRemainingDue,
                                value: UtilityFormatJod.format(
                                  remaining,
                                  suffix: l10n.currencyJod,
                                ),
                              ),
                            if (selectedPaymentTarget ==
                                _CashierPaymentTarget.cash)
                              _SummaryLine(
                                label: l10n.cashierCashChange,
                                value: UtilityFormatJod.format(
                                  cashChange,
                                  suffix: l10n.currencyJod,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  if (selectedPaymentTarget != null) ...[
                    SizedBox(height: spacing),
                    _CashierActionCard(
                      label:
                          paymentReceivedConfirmed
                              ? l10n.cashierPaymentReceivedConfirmed
                              : l10n.cashierPaymentReceived,
                      icon:
                          paymentReceivedConfirmed
                              ? Icons.check_circle_outline
                              : Icons.payments_outlined,
                      onTap:
                          paymentReceivedConfirmed || !canConfirmPayment
                              ? null
                              : onPaymentReceived,
                      tone: CoreColors.semanticSuccess,
                      expandWidth: true,
                      minHeight: 80,
                    ),
                  ],
                  SizedBox(height: spacing),
                  _CashierActionCard(
                    label: l10n.cashierPostponeOrder,
                    icon: Icons.pause_circle_outline,
                    onTap: onPostpone,
                    tone: CoreColors.semanticWarning,
                    expandWidth: true,
                    minHeight: 72,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PaymentAmountDisplay extends StatelessWidget {
  const _PaymentAmountDisplay({
    required this.label,
    required this.amount,
    required this.color,
  });

  final String label;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        border: Border.all(color: color.withValues(alpha: 0.32)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: CoreSpacing.lg(context),
          vertical: CoreSpacing.xl(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: CoreTypography.titleMedium(
                context,
                color,
              ).copyWith(fontWeight: FontWeight.w800),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            Text(
              UtilityFormatJod.format(amount, suffix: l10n.currencyJod),
              textAlign: TextAlign.center,
              style: CoreTypography.headlineLarge(context, color).copyWith(
                fontSize: 52,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoneyField extends StatelessWidget {
  const _MoneyField({
    required this.label,
    required this.controller,
    required this.onChanged,
    this.prominent = false,
    this.compact = false,
  });

  final String label;
  final TextEditingController controller;
  final VoidCallback onChanged;
  final bool prominent;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final field = CashierTouchTextField(
      label: label,
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textDirection: TextDirection.ltr,
      prefixIcon: Icons.payments_outlined,
      textInputAction: TextInputAction.next,
      onChanged: (_) => onChanged(),
    );
    if (!prominent) return field;

    final scheme = Theme.of(context).colorScheme;
    if (compact) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.primaryContainer.withValues(alpha: 0.42),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
          border: Border.all(color: scheme.primary.withValues(alpha: 0.32)),
        ),
        child: Padding(
          padding: EdgeInsets.all(CoreSpacing.xs(context)),
          child: field,
        ),
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.32)),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.priority_high_rounded, color: scheme.primary),
                SizedBox(width: CoreSpacing.xs(context)),
                Expanded(
                  child: Text(
                    label,
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.primary,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
            SizedBox(height: CoreSpacing.xs(context)),
            field,
          ],
        ),
      ),
    );
  }
}

class _CashierPostponeReason {
  const _CashierPostponeReason({required this.key, required this.note});

  final String key;
  final String note;
}

class _PostponeOrderDialog extends StatefulWidget {
  @override
  State<_PostponeOrderDialog> createState() => _PostponeOrderDialogState();
}

class _PostponeOrderDialogState extends State<_PostponeOrderDialog> {
  String? _selectedKey;
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final reasons = [
      ('visa_declined', l10n.cashierPostponeReasonVisaDeclined),
      ('fetching_cash', l10n.cashierPostponeReasonFetchingCash),
      ('no_change', l10n.cashierPostponeReasonNoChange),
      ('other', l10n.cashierPostponeReasonOther),
    ];
    return AlertDialog(
      title: Text(l10n.cashierPostponeTitle),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.cashierPostponeReason,
              style: CoreTypography.bodyMedium(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ).copyWith(fontWeight: FontWeight.w800),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            for (final reason in reasons)
              Padding(
                padding: EdgeInsets.only(bottom: CoreSpacing.xs(context)),
                child: RadioListTile<String>(
                  value: reason.$1,
                  groupValue: _selectedKey,
                  onChanged: (value) => setState(() => _selectedKey = value),
                  title: Text(reason.$2),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              label: l10n.cashierPostponeNote,
              controller: _noteController,
              prefixIcon: Icons.notes_outlined,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        FilledButton(
          onPressed:
              _selectedKey == null
                  ? null
                  : () => Navigator.of(context).pop(
                    _CashierPostponeReason(
                      key: _selectedKey!,
                      note: _noteController.text.trim(),
                    ),
                  ),
          child: Text(l10n.cashierPostponeOrder),
        ),
      ],
    );
  }
}

class _CashReturnDialog extends StatelessWidget {
  const _CashReturnDialog({
    required this.received,
    required this.deducted,
    required this.change,
  });

  final double received;
  final double deducted;
  final double change;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return AlertDialog(
      title: Text(l10n.cashierCashReturnDialogTitle),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SummaryLine(
              label: l10n.cashierReceivedValue,
              value: UtilityFormatJod.format(
                received,
                suffix: l10n.currencyJod,
              ),
            ),
            _SummaryLine(
              label: l10n.cashierDeductedValue,
              value: UtilityFormatJod.format(
                deducted,
                suffix: l10n.currencyJod,
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
                border: Border.all(
                  color: scheme.primary.withValues(alpha: 0.28),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(CoreSpacing.md(context)),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.cashierReturnHighlighted,
                        style: CoreTypography.titleMedium(
                          context,
                          scheme.primary,
                        ).copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                    WidgetsPriceBadge(
                      priceLabel: UtilityFormatJod.format(
                        change,
                        suffix: l10n.currencyJod,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        WidgetsAppButton(
          label: MaterialLocalizations.of(context).okButtonLabel,
          onPressed: () => Navigator.of(context).pop(true),
          icon: Icons.check_circle_outline,
        ),
      ],
    );
  }
}

class _PaymentMethodCards extends StatelessWidget {
  const _PaymentMethodCards({
    required this.amountPayable,
    required this.selectedTarget,
    required this.onSelected,
  });

  final double amountPayable;
  final _CashierPaymentTarget? selectedTarget;
  final ValueChanged<_CashierPaymentTarget> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final totalText = UtilityFormatJod.format(
      amountPayable,
      suffix: l10n.currencyJod,
    );
    return _FittedActionColumn(
      children: [
        _FulfillmentOptionCard(
          label: '${l10n.paymentMethodCash}\n$totalText',
          icon: Icons.payments_outlined,
          selected: selectedTarget == _CashierPaymentTarget.cash,
          color: CoreColors.semanticSuccess,
          onTap: () => onSelected(_CashierPaymentTarget.cash),
          minHeight: 0,
        ),
        _FulfillmentOptionCard(
          label: '${l10n.paymentMethodCard}\n$totalText',
          icon: Icons.credit_card_outlined,
          selected: selectedTarget == _CashierPaymentTarget.visa,
          color: CoreColors.brandOlive,
          onTap: () => onSelected(_CashierPaymentTarget.visa),
          minHeight: 0,
        ),
        _FulfillmentOptionCard(
          label: '${l10n.paymentMethodWallet}\n$totalText',
          icon: Icons.account_balance_wallet_outlined,
          selected: selectedTarget == _CashierPaymentTarget.wallet,
          color: CoreColors.semanticTip,
          onTap: () => onSelected(_CashierPaymentTarget.wallet),
          minHeight: 0,
        ),
        _FulfillmentOptionCard(
          label: l10n.cashierSplitPayment,
          icon: Icons.call_split_outlined,
          selected: selectedTarget == _CashierPaymentTarget.split,
          color: CoreColors.brandGold,
          onTap: () => onSelected(_CashierPaymentTarget.split),
          minHeight: 0,
        ),
      ],
    );
  }
}

class _FulfillmentOptionCard extends StatelessWidget {
  const _FulfillmentOptionCard({
    required this.label,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
    this.minHeight = 132,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final effectiveColor = selected ? color : scheme.onSurfaceVariant;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: effectiveColor.withValues(alpha: selected ? 0.16 : 0.08),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
          border: Border.all(
            color: effectiveColor.withValues(alpha: selected ? 0.42 : 0.20),
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Padding(
            padding: EdgeInsets.all(
              minHeight <= 96
                  ? CoreSpacing.sm(context)
                  : CoreSpacing.lg(context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: effectiveColor,
                  size: minHeight <= 96 ? 26 : 34,
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.bodyMedium(
                    context,
                    effectiveColor,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TicketLine extends StatelessWidget {
  const _TicketLine({
    required this.line,
    required this.isAr,
    required this.onQuantityChanged,
    required this.onModifier,
    required this.onRemove,
  });

  final ModelCartLine line;
  final bool isAr;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onModifier;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    isAr ? line.nameAr : line.nameEn,
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                ),
                WidgetsPriceBadge(
                  priceLabel: UtilityFormatJod.format(
                    line.lineTotalJod,
                    suffix: l10n.currencyJod,
                  ),
                  compact: true,
                ),
              ],
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            Row(
              children: [
                WidgetsQuantityStepper(
                  value: line.quantity,
                  onIncrement: () => onQuantityChanged(line.quantity + 1),
                  onDecrement: () => onQuantityChanged(line.quantity - 1),
                ),
                const Spacer(),
                WidgetsIconButton(
                  onPressed: onModifier,
                  icon: Icons.tune_outlined,
                  tooltip: l10n.actionEdit,
                ),
                SizedBox(width: CoreSpacing.xs(context)),
                WidgetsIconButton(
                  onPressed: onRemove,
                  icon: Icons.delete_outline,
                  tooltip: l10n.actionRemove,
                  variant: WidgetsIconButtonVariant.tonal,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyTicket extends StatelessWidget {
  const _EmptyTicket({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: CoreSpacing.xl(context)),
      child: Column(
        children: [
          Icon(
            Icons.shopping_basket_outlined,
            size: CoreContentSizes.emptyStateIcon(context),
            color: scheme.onSurfaceVariant,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            message,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final valueStyle = CoreTypography.bodyMedium(
      context,
      scheme.onSurface,
    ).copyWith(fontWeight: FontWeight.w800);
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurfaceVariant,
              ),
            ),
          ),
          Flexible(
            child: Text(value, textAlign: TextAlign.end, style: valueStyle),
          ),
        ],
      ),
    );
  }
}

class _FoodTag extends StatelessWidget {
  const _FoodTag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: CoreSpacing.sm(context),
          vertical: CoreSpacing.xs(context),
        ),
        child: Text(
          label,
          style: CoreTypography.caption(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _DishMedia extends StatelessWidget {
  const _DishMedia({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: _DishPainter(color: color, accent: CoreColors.brandGold),
        ),
        Center(
          child: Icon(
            icon,
            color: color,
            size: CoreContentSizes.categoryMenuImageIcon(context),
          ),
        ),
      ],
    );
  }
}

class _DishPainter extends CustomPainter {
  const _DishPainter({required this.color, required this.accent});

  final Color color;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final plate = Paint()..color = color.withValues(alpha: 0.12);
    final rim =
        Paint()
          ..color = color.withValues(alpha: 0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2;
    final garnish = Paint()..color = accent.withValues(alpha: 0.34);
    final center = Offset(size.width * 0.5, size.height * 0.56);
    final radius = size.shortestSide * 0.30;
    canvas.drawCircle(center, radius, plate);
    canvas.drawCircle(center, radius, rim);
    canvas.drawCircle(
      Offset(size.width * 0.36, size.height * 0.42),
      radius * 0.15,
      garnish,
    );
    canvas.drawCircle(
      Offset(size.width * 0.62, size.height * 0.43),
      radius * 0.13,
      garnish,
    );
    canvas.drawCircle(
      Offset(size.width * 0.52, size.height * 0.68),
      radius * 0.15,
      garnish,
    );
  }

  @override
  bool shouldRepaint(covariant _DishPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.accent != accent;
  }
}

class _ReceiptDialog extends StatelessWidget {
  const _ReceiptDialog({
    required this.cart,
    required this.sumData,
    required this.onPrint,
  });

  final List<ModelCartLine> cart;
  final OrderTicketSumData sumData;
  final VoidCallback onPrint;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.fromLTRB(
        CoreSpacing.lg(context),
        0,
        CoreSpacing.lg(context),
        CoreSpacing.md(context),
      ),
      title: Align(
        alignment: AlignmentDirectional.topEnd,
        child: TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close_rounded),
          label: Text(l10n.actionCancel),
        ),
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                l10n.appTitle,
                style: CoreTypography.titleMedium(
                  context,
                  Theme.of(context).colorScheme.primary,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsOrderInvoiceBlock(
              cart: cart,
              sumData: sumData,
              showTitle: true,
              bare: true,
            ),
          ],
        ),
      ),
      actions: [
        FilledButton.icon(
          onPressed: onPrint,
          icon: const Icon(Icons.print_outlined),
          label: Text(l10n.cashierPrintRollReceipt),
        ),
      ],
    );
  }
}

enum _CashierTicketTab {
  order,
  fulfillment,
  tip,
  payment,
  confirmation;

  IconData get icon {
    return switch (this) {
      order => Icons.receipt_long_outlined,
      fulfillment => Icons.delivery_dining_outlined,
      tip => Icons.volunteer_activism_outlined,
      payment => Icons.payments_outlined,
      confirmation => Icons.verified_outlined,
    };
  }

  String label(AppLocalizations l10n) {
    return switch (this) {
      order => l10n.cashierTabOrder,
      fulfillment => l10n.cashierTabFulfillment,
      tip => l10n.cashierTabTip,
      payment => l10n.cashierTabPayment,
      confirmation => l10n.cashierTabConfirm,
    };
  }
}

enum _CashierPaymentTarget { cash, visa, wallet, split }

enum _CashierFulfillment {
  dineIn,
  takeaway,
  delivery,
  groupDelivery,
  plated;

  bool get requiresLocation {
    return this == delivery || this == groupDelivery || this == plated;
  }

  Color get color {
    return switch (this) {
      dineIn => CoreColors.orderTypeDineIn,
      takeaway => CoreColors.orderTypeTakeaway,
      delivery => CoreColors.orderTypeDelivery,
      groupDelivery => CoreColors.brandOlive,
      plated => CoreColors.orderTypePlated,
    };
  }

  IconData get icon {
    return switch (this) {
      dineIn => Icons.table_restaurant_outlined,
      takeaway => Icons.shopping_bag_outlined,
      delivery => Icons.delivery_dining_outlined,
      groupDelivery => Icons.route_outlined,
      plated => Icons.room_service_outlined,
    };
  }

  String label(AppLocalizations l10n) {
    return switch (this) {
      dineIn => l10n.orderTypeDineIn,
      takeaway => l10n.orderTypeTakeaway,
      delivery => l10n.orderTypeDelivery,
      groupDelivery => l10n.cartGroupDeliveryTitle,
      plated => l10n.orderTypePlated,
    };
  }
}

class _CashierPromotion {
  const _CashierPromotion({
    required this.label,
    required this.description,
    required this.sectionLabel,
    required this.icon,
    required this.color,
    required this.savingsJod,
  });

  final String label;
  final String description;
  final String sectionLabel;
  final IconData icon;
  final Color color;
  final double savingsJod;

  static List<_CashierPromotion> available(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = AppLocalizations.of(context)!;
    return [
      if (MockupCatalog.offers.isNotEmpty)
        _CashierPromotion(
          label:
              isAr
                  ? MockupCatalog.offers.first.titleAr
                  : MockupCatalog.offers.first.titleEn,
          description:
              isAr
                  ? (MockupCatalog.offers.first.subtitleAr ?? '')
                  : (MockupCatalog.offers.first.subtitleEn ?? ''),
          sectionLabel: l10n.cashierPromotionOffers,
          icon: Icons.local_offer_outlined,
          color: CoreColors.semanticRevenue,
          savingsJod: MockupCatalog.cashierOfferSavingsJod,
        ),
      if (MockupCatalog.comboHighlights.isNotEmpty)
        _CashierPromotion(
          label:
              isAr
                  ? MockupCatalog.comboHighlights.first.titleAr
                  : MockupCatalog.comboHighlights.first.titleEn,
          description:
              isAr
                  ? (MockupCatalog.comboHighlights.first.subtitleAr ?? '')
                  : (MockupCatalog.comboHighlights.first.subtitleEn ?? ''),
          sectionLabel: l10n.cashierPromotionCombos,
          icon: Icons.fastfood_outlined,
          color: CoreColors.brandOrange,
          savingsJod: MockupCatalog.cashierComboSavingsJod,
        ),
      if (MockupCatalog.discountedMenuItemIds.isNotEmpty)
        _CashierPromotion(
          label: l10n.cashierPromotionDiscounts,
          description: l10n.cashierPromotionSavings,
          sectionLabel: l10n.cashierPromotionDiscounts,
          icon: Icons.percent_outlined,
          color: CoreColors.brandGold,
          savingsJod: MockupCatalog.checkoutPromoSavingsJod,
        ),
      if (MockupCatalog.subscriptionMenuItemIds.isNotEmpty)
        _CashierPromotion(
          label: l10n.cashierPromotionSubscriptions,
          description: l10n.cashierPromotionSubscriptions,
          sectionLabel: l10n.cashierPromotionSubscriptions,
          icon: Icons.calendar_month_outlined,
          color: CoreColors.brandOlive,
          savingsJod: MockupCatalog.cashierSubscriptionSavingsJod,
        ),
    ];
  }
}

IconData _categoryIcon(String key) {
  return switch (key) {
    'qalayat' => Icons.egg_alt_outlined,
    'hummus_ful' => Icons.rice_bowl_outlined,
    'drink' || 'drinks' => Icons.local_drink_outlined,
    'sandwiches' => Icons.lunch_dining_outlined,
    'falafel' => Icons.circle_outlined,
    'pizza' => Icons.local_pizza_outlined,
    'snacks' => Icons.fastfood_outlined,
    'manaqeesh' => Icons.bakery_dining_outlined,
    'pastries' => Icons.breakfast_dining_outlined,
    'burgers' => Icons.lunch_dining,
    'shawarma' => Icons.kebab_dining_outlined,
    _ => Icons.restaurant_menu_outlined,
  };
}

Color _categoryColor(BuildContext context, String categoryId) {
  final scheme = Theme.of(context).colorScheme;
  return switch (categoryId) {
    'drinks' => CoreColors.orderTypeDelivery,
    'hummus_ful' || 'falafel' || 'manaqeesh' || 'pastries' => scheme.secondary,
    'pizza' => CoreColors.brandGold,
    'shawarma' => CoreColors.brandOrange,
    'burgers' => CoreColors.semanticRevenue,
    _ => scheme.primary,
  };
}

int cashierLineRewardPoints(ModelCartLine line) {
  for (final item in MockupCatalog.items) {
    if (item.id == line.itemId) return item.rewardPoints;
  }
  return (line.unitPriceJod * 10).round();
}
