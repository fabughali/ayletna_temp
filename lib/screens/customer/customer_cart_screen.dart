import 'package:ayletna_restaurant_app/core/app_config.dart';
import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/data/models/model_saved_address.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_checkout_fees_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_promo_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_checkout_step_strip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_quantity_stepper.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD CartScreen redesigned as a warm basket review.
class CustomerCartScreen extends ConsumerStatefulWidget {
  const CustomerCartScreen({super.key});

  @override
  ConsumerState<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends ConsumerState<CustomerCartScreen> {
  final _promoController = TextEditingController();
  _CartFulfillment _fulfillment = _CartFulfillment.delivery;
  String? _selectedAddressId;
  _CartPaymentType _paymentType = _CartPaymentType.card;
  double _tipJod = 0;

  final _itemsSectionKey = GlobalKey();
  final _fulfillmentSectionKey = GlobalKey();
  final _paymentSectionKey = GlobalKey();
  final _summarySectionKey = GlobalKey();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final isGuest = ref.watch(appRoleProvider) == AppRole.guest;
    final addresses =
        ref.watch(savedAddressesProvider).valueOrNull ??
        const <ModelSavedAddress>[];
    final menuCatalog =
        ref.watch(menuAllItemsProvider).maybeWhen(
          data: (items) => items,
          orElse: () => MockupCatalog.items,
        );
    final items = _CartLineState.fromLines(
      ref.watch(cartProvider),
      catalog: menuCatalog,
    );
    final visibleItems = items.where((item) => item.quantity > 0).toList();
    final subtotal = visibleItems.fold<double>(
      0,
      (sum, item) => sum + item.unitPriceJod * item.quantity,
    );
    final fees = ref.watch(cartCheckoutFeesProvider);
    final summaryCosts = _CartSummaryCosts.calculate(
      subtotal: subtotal,
      fulfillment: _fulfillment,
      fees: fees,
    );
    final totalBeforeSavings = summaryCosts.totalBeforeSavings;
    final promo = ref.watch(cartPromoProvider);
    final discount = promo.applied ? promo.discountJod : 0.0;
    final summaryTotal = totalBeforeSavings - discount + _tipJod;
    final selectedAddress = _resolveSelectedAddress(addresses);
    final addressRequired = _requiresAddress(_fulfillment);
    final canProceed = !addressRequired || selectedAddress != null;
    final hasItems = visibleItems.isNotEmpty;
    final checkoutActiveStep = !hasItems ? 0 : (canProceed ? 3 : 1);
    final checkoutCompletedThrough = !hasItems ? -1 : (canProceed ? 2 : 0);

    return WidgetsScaffoldPage(
      title: l10n.screenCart,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: ListView(
        children: [
          SizedBox(height: CoreSpacing.md(context)),
          _BasketHero(count: visibleItems.length),
          SizedBox(height: CoreSpacing.lg(context)),
          _ItemsHeader(
            count: visibleItems.length,
            onClear: () => _clearCart(context),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          if (visibleItems.isEmpty) ...[
            _EmptyCartPanel(onBrowse: () => context.go(AppRoutePaths.category)),
            SizedBox(height: CoreSpacing.lg(context)),
          ] else ...[
            WidgetsCheckoutStepStrip(
              activeStep: checkoutActiveStep,
              completedThrough: checkoutCompletedThrough,
              onStepTapped: _scrollToCheckoutStep,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            KeyedSubtree(key: _itemsSectionKey, child: const SizedBox.shrink()),
            for (var index = 0; index < visibleItems.length; index++) ...[
              _CartItemCard(
                item: visibleItems[index],
                index: index,
                onIncrement:
                    () => ref
                        .read(cartProvider.notifier)
                        .setQuantity(
                          visibleItems[index].line.cartKey,
                          visibleItems[index].quantity + 1,
                        ),
                onDecrement:
                    () => ref
                        .read(cartProvider.notifier)
                        .setQuantity(
                          visibleItems[index].line.cartKey,
                          visibleItems[index].quantity - 1,
                        ),
                onRemove: () => _removeItem(context, visibleItems[index]),
              ),
              SizedBox(height: CoreSpacing.md(context)),
            ],
            _CartSuggestionsSection(
              cartItemIds: visibleItems.map((e) => e.line.itemId).toSet(),
              menuItems: menuCatalog,
              isAr: isAr,
              l10n: l10n,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            KeyedSubtree(
              key: _fulfillmentSectionKey,
              child: _FulfillmentSection(
                selected: _fulfillment,
                onSelected: _selectFulfillment,
                onTerms: () => context.push(AppRoutePaths.terms),
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            if (addressRequired) ...[
              _DeliveryAddressCard(
                address: selectedAddress,
                onChoose: _showAddressPicker,
              ),
              SizedBox(height: CoreSpacing.lg(context)),
            ],
            KeyedSubtree(
              key: _paymentSectionKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PaymentTypeCard(
                    selected: _paymentType,
                    onSelected: (value) => setState(() => _paymentType = value),
                  ),
                  SizedBox(height: CoreSpacing.lg(context)),
                  _TipSection(
                    selectedTipJod: _tipJod,
                    onSelected: (value) => setState(() => _tipJod = value),
                  ),
                ],
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _PromoCodeCard(
              controller: _promoController,
              promoApplied: promo.applied,
              savingsJod: discount,
              onApply: () {
                final ok = ref.read(cartPromoProvider.notifier).applyCode(
                  _promoController.text,
                  totalBeforeSavings,
                );
                if (!ok) {
                  UtilityMockFeedback.showWarning(
                    context,
                    isAr
                        ? 'رمز غير صالح — جرّب AYLETNA10 أو WELCOME'
                        : 'Invalid code — try AYLETNA10 or WELCOME',
                  );
                  return;
                }
                UtilityMockFeedback.showSuccess(context, l10n.cartPromoCode);
              },
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            if (isGuest) ...[
              WidgetsInfoBanner(
                title: l10n.guestSignInToOrder,
                message: l10n.cartGuestSignInPrompt,
                tone: WidgetsInfoBannerTone.warning,
                icon: Icons.login_outlined,
                action: WidgetsAppButton(
                  label: l10n.actionSignIn,
                  onPressed: () => context.push(AppRoutePaths.login),
                  icon: Icons.arrow_forward,
                  variant: WidgetsAppButtonVariant.outline,
                ),
              ),
              SizedBox(height: CoreSpacing.lg(context)),
            ],
            KeyedSubtree(
              key: _summarySectionKey,
              child: _OrderSummaryCard(
                subtotal: subtotal,
                fulfillment: _fulfillment,
                fulfillmentCharge: summaryCosts.fulfillmentCharge,
                tax: summaryCosts.tax,
                tipJod: _tipJod,
                discount: discount,
                total: summaryTotal,
                proceedLabel:
                    isGuest
                        ? l10n.guestSignInToOrder
                        : l10n.cartProceedCheckout,
                onProceed:
                    isGuest
                        ? () => context.push(AppRoutePaths.login)
                        : canProceed
                        ? () {
                          if (AppConfig.useSteppedCheckoutRoutes) {
                            _syncCheckoutDraft(addresses);
                            context.push(AppRoutePaths.checkout);
                          } else {
                            context.push(AppRoutePaths.orderConfirmation);
                          }
                        }
                        : null,
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
          ],
          const _HelpCard(),
          SizedBox(height: CoreSpacing.xxl(context)),
        ],
      ),
    );
  }

  ModelSavedAddress? _resolveSelectedAddress(
    List<ModelSavedAddress> addresses,
  ) {
    if (_selectedAddressId != null) {
      for (final address in addresses) {
        if (address.id == _selectedAddressId) return address;
      }
    }
    for (final address in addresses) {
      if (address.isSelected) return address;
    }
    return addresses.isEmpty ? null : addresses.first;
  }

  void _syncCheckoutDraft(List<ModelSavedAddress> addresses) {
    final draft = ref.read(checkoutDraftProvider.notifier);
    draft.setFulfillment(_toCheckoutFulfillment(_fulfillment));
    draft.setAddressId(_resolveSelectedAddress(addresses)?.id);
    draft.setPaymentType(_toCheckoutPayment(_paymentType));
    draft.setTipJod(_tipJod);
    draft.setPromoApplied(ref.read(cartPromoProvider).applied);
  }

  CheckoutFulfillment _toCheckoutFulfillment(_CartFulfillment value) {
    return switch (value) {
      _CartFulfillment.dineIn => CheckoutFulfillment.dineIn,
      _CartFulfillment.takeaway => CheckoutFulfillment.takeaway,
      _CartFulfillment.delivery => CheckoutFulfillment.delivery,
      _CartFulfillment.groupDelivery => CheckoutFulfillment.groupDelivery,
      _CartFulfillment.plated => CheckoutFulfillment.plated,
    };
  }

  CheckoutPaymentType _toCheckoutPayment(_CartPaymentType value) {
    return switch (value) {
      _CartPaymentType.card => CheckoutPaymentType.card,
      _CartPaymentType.cash => CheckoutPaymentType.cash,
    };
  }

  bool _requiresAddress(_CartFulfillment fulfillment) {
    return fulfillment == _CartFulfillment.delivery ||
        fulfillment == _CartFulfillment.groupDelivery ||
        fulfillment == _CartFulfillment.plated;
  }

  void _selectFulfillment(_CartFulfillment value) {
    setState(() => _fulfillment = value);
    final addresses =
        ref.read(savedAddressesProvider).valueOrNull ??
        const <ModelSavedAddress>[];
    if (_requiresAddress(value) && _resolveSelectedAddress(addresses) == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _showAddressPicker();
      });
    }
  }

  void _scrollToCheckoutStep(int step) {
    final key = switch (step) {
      0 => _itemsSectionKey,
      1 => _fulfillmentSectionKey,
      2 => _paymentSectionKey,
      3 => _summarySectionKey,
      _ => _itemsSectionKey,
    };
    final target = key.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      alignment: 0.08,
    );
  }

  Future<void> _showAddressPicker() async {
    final addresses =
        ref.read(savedAddressesProvider).valueOrNull ??
        const <ModelSavedAddress>[];
    final address = await showDialog<ModelSavedAddress>(
      context: context,
      builder:
          (dialogContext) => _AddressPickerDialog(
            addresses: addresses,
            onAddAddress: () {
              Navigator.of(dialogContext).pop();
              context.push('${AppRoutePaths.mapPicker}?return=profile');
            },
          ),
    );
    if (address == null || !mounted) return;
    setState(() => _selectedAddressId = address.id);
  }

  Future<void> _clearCart(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await UtilityMockFeedback.confirm(
      context: context,
      title: l10n.cartClearAll,
      message: l10n.cartEmptyMessage,
      confirmLabel: l10n.actionConfirm,
      cancelLabel: l10n.actionCancel,
      confirmVariant: WidgetsAppButtonVariant.danger,
      icon: Icons.delete_outline,
    );

    if (!confirmed || !context.mounted) return;

    ref.read(cartProvider.notifier).clear();
    UtilityMockFeedback.showInfo(context, l10n.cartClearAll);
  }

  Future<void> _removeItem(BuildContext context, _CartLineState item) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await UtilityMockFeedback.confirm(
      context: context,
      title: l10n.actionRemove,
      message: item.title(context),
      confirmLabel: l10n.actionConfirm,
      cancelLabel: l10n.actionCancel,
      confirmVariant: WidgetsAppButtonVariant.danger,
      icon: Icons.delete_outline,
    );

    if (!confirmed || !context.mounted) return;

    ref.read(cartProvider.notifier).removeItem(item.line.cartKey);
    UtilityMockFeedback.showInfo(context, l10n.actionRemove);
  }
}

enum _CartFulfillment { dineIn, takeaway, delivery, groupDelivery, plated }

enum _CartPaymentType { card, cash }

class _CartSummaryCosts {
  const _CartSummaryCosts({
    required this.subtotal,
    required this.fulfillmentCharge,
    required this.tax,
  });

  final double subtotal;
  final double fulfillmentCharge;
  final double tax;

  double get totalBeforeSavings => subtotal + fulfillmentCharge + tax;

  static _CartSummaryCosts calculate({
    required double subtotal,
    required _CartFulfillment fulfillment,
    required CartCheckoutFees fees,
  }) {
    final fulfillmentCharge = switch (fulfillment) {
      _CartFulfillment.dineIn => subtotal * fees.dineInServiceRate,
      _CartFulfillment.takeaway => fees.takeawayPackagingFeeJod,
      _CartFulfillment.delivery => fees.deliveryFeeJod,
      _CartFulfillment.groupDelivery => fees.groupDeliveryFeeJod,
      _CartFulfillment.plated => fees.platedDepositJod,
    };
    final taxableFulfillmentCharge =
        fulfillment == _CartFulfillment.plated ? 0.0 : fulfillmentCharge;
    return _CartSummaryCosts(
      subtotal: subtotal,
      fulfillmentCharge: fulfillmentCharge,
      tax: fees.taxIncludedInPrices
          ? 0
          : (subtotal + taxableFulfillmentCharge) * fees.taxRate,
    );
  }
}

class _BasketHero extends StatelessWidget {
  const _BasketHero({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsFoodMediaPanel(
            height: CoreContentSizes.heroImageHeight(context),
            badge: _FoodTag(
              label: l10n.cartOrderItemsCount(count),
              color: scheme.primary,
            ),
            child: CustomPaint(
              painter: _BasketPainter(
                color: scheme.primary,
                accent: CoreColors.brandGold,
              ),
              child: Center(
                child: Icon(
                  Icons.shopping_basket_outlined,
                  size: CoreContentSizes.categoryMenuImageIcon(context),
                  color: scheme.primary,
                ),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.screenCart,
            style: CoreTypography.headlineLarge(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.cartTermsNotice,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _ItemsHeader extends StatelessWidget {
  const _ItemsHeader({required this.count, required this.onClear});

  final int count;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.cartOrderItemsCount(count),
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        WidgetsAppButton(
          label: l10n.cartClearAll,
          onPressed: count > 0 ? onClear : null,
          variant: WidgetsAppButtonVariant.ghost,
        ),
      ],
    );
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({
    required this.item,
    required this.index,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  final _CartLineState item;
  final int index;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final orderMeta = item.orderMeta(l10n);

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsFoodMediaPanel(
            height: CoreContentSizes.categoryMenuImageHeight(context),
            badge: _FoodTag(label: orderMeta.label, color: orderMeta.color),
            child: WidgetsMockFoodImage(
              imageUrl: item.menuItem?.imageUrl,
              fallback: _CartDishMedia(
                color: orderMeta.color,
                icon: orderMeta.icon,
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title(context),
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      item.subtitle(context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              WidgetsPriceBadge(
                priceLabel: UtilityFormatJod.format(
                  item.unitPriceJod,
                  suffix: l10n.currencyJod,
                ),
                compact: true,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              WidgetsQuantityStepper(
                value: item.quantity,
                onIncrement: onIncrement,
                onDecrement: onDecrement,
              ),
              const Spacer(),
              WidgetsIconButton(
                onPressed:
                    () => WidgetsCustomizationSheet.show(
                      context,
                      line: item.line,
                      menuItem: item.menuItem,
                    ),
                icon: Icons.tune_outlined,
                tooltip: l10n.actionEdit,
              ),
              SizedBox(width: CoreSpacing.xs(context)),
              WidgetsIconButton(
                onPressed: onRemove,
                icon: Icons.delete_outline,
                tooltip: l10n.actionRemove,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PromoCodeCard extends StatelessWidget {
  const _PromoCodeCard({
    required this.controller,
    required this.promoApplied,
    required this.savingsJod,
    required this.onApply,
  });

  final TextEditingController controller;
  final bool promoApplied;
  final double savingsJod;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.cartPromoCode,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            promoApplied
                ? UtilityFormatJod.format(savingsJod, suffix: l10n.currencyJod)
                : l10n.cartPromoHint,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsAppTextField(
                  controller: controller,
                  label: l10n.cartPromoCode,
                  hintText: l10n.cartPromoHint,
                  readOnly: promoApplied,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              WidgetsAppButton(
                label: promoApplied ? l10n.actionConfirm : l10n.actionApply,
                onPressed: promoApplied ? null : onApply,
                icon:
                    promoApplied
                        ? Icons.check_circle_outline
                        : Icons.local_offer_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FulfillmentSection extends StatelessWidget {
  const _FulfillmentSection({
    required this.selected,
    required this.onSelected,
    required this.onTerms,
  });

  final _CartFulfillment selected;
  final ValueChanged<_CartFulfillment> onSelected;
  final VoidCallback onTerms;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.cartFulfillmentTitle,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.cartFulfillmentSubtitle,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _FulfillmentOption(
            selected: selected == _CartFulfillment.dineIn,
            title: l10n.orderTypeDineIn,
            body: l10n.orderTypeDineInBody,
            icon: Icons.table_restaurant_outlined,
            color: CoreColors.orderTypeDineIn,
            onTap: () => onSelected(_CartFulfillment.dineIn),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _FulfillmentOption(
            selected: selected == _CartFulfillment.takeaway,
            title: l10n.orderTypeTakeaway,
            body: l10n.orderTypeTakeawayBody,
            icon: Icons.takeout_dining_outlined,
            color: CoreColors.orderTypeTakeaway,
            onTap: () => onSelected(_CartFulfillment.takeaway),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _FulfillmentOption(
            selected: selected == _CartFulfillment.delivery,
            title: l10n.orderTypeDeliveryTitle,
            body: l10n.orderTypeDeliveryBody,
            icon: Icons.delivery_dining_outlined,
            color: CoreColors.orderTypeDelivery,
            onTap: () => onSelected(_CartFulfillment.delivery),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _FulfillmentOption(
            selected: selected == _CartFulfillment.groupDelivery,
            title: l10n.cartGroupDeliveryTitle,
            body: l10n.cartGroupDeliveryBody,
            icon: Icons.groups_2_outlined,
            color: CoreColors.brandOlive,
            onTap: () => onSelected(_CartFulfillment.groupDelivery),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _FulfillmentOption(
            selected: selected == _CartFulfillment.plated,
            title: l10n.orderTypePlatedTitle,
            body: l10n.orderTypePlatedBody,
            icon: Icons.flatware_outlined,
            color: CoreColors.orderTypePlated,
            onTap: () => onSelected(_CartFulfillment.plated),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Center(
            child: TextButton(
              onPressed: onTerms,
              child: Text(l10n.cartTermsAndConditions),
            ),
          ),
        ],
      ),
    );
  }
}

class _FulfillmentOption extends StatelessWidget {
  const _FulfillmentOption({
    required this.selected,
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final String body;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant:
          selected ? WidgetsAppCardVariant.food : WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      onTap: onTap,
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: color.withValues(alpha: selected ? 0.18 : 0.11),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.sm(context)),
              child: Icon(icon, color: color),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? color : scheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

class _DeliveryAddressCard extends StatelessWidget {
  const _DeliveryAddressCard({required this.address, required this.onChoose});

  final ModelSavedAddress? address;
  final VoidCallback onChoose;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final selected = address;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_outlined, color: scheme.primary),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.cartSelectedAddress,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsAppButton(
                label: l10n.cartChooseAddress,
                onPressed: onChoose,
                icon: Icons.edit_location_alt_outlined,
                variant: WidgetsAppButtonVariant.outline,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          if (selected == null)
            Text(
              l10n.cartAddressRequired,
              style: CoreTypography.bodyMedium(context, scheme.error),
            )
          else ...[
            Text(
              isAr ? selected.labelAr : selected.labelEn,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: CoreSpacing.xs(context)),
            Text(
              isAr ? selected.addressAr : selected.addressEn,
              style: CoreTypography.caption(context, scheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}

class _PaymentTypeCard extends StatelessWidget {
  const _PaymentTypeCard({required this.selected, required this.onSelected});

  final _CartPaymentType selected;
  final ValueChanged<_CartPaymentType> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.cartPaymentType,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _PaymentTypeOption(
            selected: selected == _CartPaymentType.card,
            title: l10n.paymentMethodCard,
            icon: Icons.credit_card_outlined,
            onTap: () => onSelected(_CartPaymentType.card),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _PaymentTypeOption(
            selected: selected == _CartPaymentType.cash,
            title: l10n.paymentMethodCash,
            icon: Icons.payments_outlined,
            onTap: () => onSelected(_CartPaymentType.cash),
          ),
        ],
      ),
    );
  }
}

class _PaymentTypeOption extends StatelessWidget {
  const _PaymentTypeOption({
    required this.selected,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = selected ? scheme.primary : scheme.onSurfaceVariant;

    return WidgetsAppCard(
      variant:
          selected ? WidgetsAppCardVariant.food : WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Text(
              title,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: color,
          ),
        ],
      ),
    );
  }
}

class _TipSection extends StatefulWidget {
  const _TipSection({required this.selectedTipJod, required this.onSelected});

  final double selectedTipJod;
  final ValueChanged<double> onSelected;

  @override
  State<_TipSection> createState() => _TipSectionState();
}

class _TipSectionState extends State<_TipSection> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: _formatTip(widget.selectedTipJod),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatTip(double amount) {
    return amount == 0 ? '' : amount.toStringAsFixed(2);
  }

  void _selectTip(double amount) {
    _controller.text = _formatTip(amount);
    widget.onSelected(amount);
  }

  void _updateManualTip(String value) {
    final parsed = double.tryParse(value.trim().replaceAll(',', '.'));
    widget.onSelected(parsed == null || parsed < 0 ? 0 : parsed);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final options = <({String label, double amount})>[
      (label: l10n.cartNoTip, amount: 0),
      (label: l10n.tipPreset1, amount: 1),
      (label: l10n.tipPreset2, amount: 2),
      (label: l10n.tipPreset5, amount: 5),
    ];

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.volunteer_activism_outlined, color: scheme.primary),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.cartTipTitle,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.cartTipSubtitle,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              for (final option in options)
                _TipChip(
                  label: option.label,
                  selected: widget.selectedTipJod == option.amount,
                  onTap: () => _selectTip(option.amount),
                ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            controller: _controller,
            label: l10n.tipCustomAmountJod,
            hintText: l10n.tipCustomAmountValue,
            prefixIcon: Icons.edit_outlined,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: _updateManualTip,
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.tipCustomAmountBody,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _TipChip extends StatelessWidget {
  const _TipChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ChoiceChip(
      selected: selected,
      label: Text(label),
      avatar:
          selected
              ? Icon(Icons.check, size: 18, color: scheme.onPrimary)
              : null,
      onSelected: (_) => onTap(),
      selectedColor: scheme.primary,
      labelStyle: CoreTypography.caption(
        context,
        selected ? scheme.onPrimary : scheme.onSurface,
      ).copyWith(fontWeight: FontWeight.w900),
      side: BorderSide(
        color:
            selected
                ? scheme.primary
                : scheme.outlineVariant.withValues(alpha: 0.9),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
      ),
    );
  }
}

class _AddressPickerDialog extends StatelessWidget {
  const _AddressPickerDialog({
    required this.addresses,
    required this.onAddAddress,
  });

  final List<ModelSavedAddress> addresses;
  final VoidCallback onAddAddress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: CoreSpacing.lg(context),
        vertical: CoreSpacing.xl(context),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Padding(
          padding: EdgeInsets.all(CoreSpacing.lg(context)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.deliveryChooseAddress,
                style: CoreTypography.titleMedium(
                  context,
                  scheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
              SizedBox(height: CoreSpacing.md(context)),
              for (final address in addresses) ...[
                WidgetsAppCard(
                  variant: WidgetsAppCardVariant.form,
                  padding: EdgeInsets.all(CoreSpacing.md(context)),
                  onTap: () => Navigator.of(context).pop(address),
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: scheme.primary,
                  ),
                  title: isAr ? address.labelAr : address.labelEn,
                  child: Text(
                    isAr ? address.addressAr : address.addressEn,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
              ],
              WidgetsAppButton(
                label: l10n.deliveryAddNewAddress,
                onPressed: onAddAddress,
                icon: Icons.add_location_alt_outlined,
                variant: WidgetsAppButtonVariant.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({
    required this.subtotal,
    required this.fulfillment,
    required this.fulfillmentCharge,
    required this.tax,
    required this.tipJod,
    required this.discount,
    required this.total,
    required this.proceedLabel,
    this.onProceed,
  });

  final double subtotal;
  final _CartFulfillment fulfillment;
  final double fulfillmentCharge;
  final double tax;
  final double tipJod;
  final double discount;
  final double total;
  final String proceedLabel;
  final VoidCallback? onProceed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.cartOrderSummary,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _SummaryLine(
            label: l10n.cartSubtotal,
            value: UtilityFormatJod.format(subtotal, suffix: l10n.currencyJod),
          ),
          _SummaryLine(
            label: l10n.cartFulfillment,
            value: _fulfillmentTitle(l10n, fulfillment),
          ),
          _SummaryLine(
            label: _fulfillmentChargeLabel(l10n, fulfillment),
            value:
                fulfillmentCharge == 0
                    ? l10n.cartFree
                    : UtilityFormatJod.format(
                      fulfillmentCharge,
                      suffix: l10n.currencyJod,
                    ),
          ),
          _SummaryLine(
            label: l10n.cartEstimatedTax,
            value: UtilityFormatJod.format(tax, suffix: l10n.currencyJod),
          ),
          _SummaryLine(
            label: l10n.checkoutTip,
            value:
                tipJod == 0
                    ? l10n.cartNoTip
                    : UtilityFormatJod.format(tipJod, suffix: l10n.currencyJod),
          ),
          if (discount > 0)
            _SummaryLine(
              label: l10n.cartPromoCode,
              value:
                  '-${UtilityFormatJod.format(discount, suffix: l10n.currencyJod)}',
            ),
          Divider(
            height: CoreSpacing.xl(context),
            color: scheme.outlineVariant,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: CoreColors.brandGold.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
              border: Border.all(
                color: CoreColors.brandGold.withValues(alpha: 0.22),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.cartTotal,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                  WidgetsPriceBadge(
                    priceLabel: UtilityFormatJod.format(
                      total,
                      suffix: l10n.currencyJod,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppButton(
            label: proceedLabel,
            onPressed: onProceed,
            icon: Icons.arrow_forward,
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  String _fulfillmentTitle(
    AppLocalizations l10n,
    _CartFulfillment fulfillment,
  ) {
    return switch (fulfillment) {
      _CartFulfillment.dineIn => l10n.orderTypeDineIn,
      _CartFulfillment.takeaway => l10n.orderTypeTakeaway,
      _CartFulfillment.delivery => l10n.orderTypeDeliveryTitle,
      _CartFulfillment.groupDelivery => l10n.cartGroupDeliveryTitle,
      _CartFulfillment.plated => l10n.orderTypePlatedTitle,
    };
  }

  String _fulfillmentChargeLabel(
    AppLocalizations l10n,
    _CartFulfillment fulfillment,
  ) {
    return switch (fulfillment) {
      _CartFulfillment.dineIn => l10n.cartDineInServiceFee,
      _CartFulfillment.takeaway => l10n.cartTakeawayPackagingFee,
      _CartFulfillment.delivery => l10n.cartDeliveryFee,
      _CartFulfillment.groupDelivery => l10n.cartGroupDeliveryFee,
      _CartFulfillment.plated => l10n.cartPlatedDeposit,
    };
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

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
          Text(
            value,
            style: CoreTypography.bodyMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _CartSuggestionsSection extends StatelessWidget {
  const _CartSuggestionsSection({
    required this.cartItemIds,
    required this.menuItems,
    required this.isAr,
    required this.l10n,
  });

  final Set<String> cartItemIds;
  final List<ModelMenuItem> menuItems;
  final bool isAr;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final suggestions =
        menuItems
            .where((item) => !cartItemIds.contains(item.id))
            .where(
              (item) => {
                'drinks',
                'pastries',
                'falafel',
                'hummus_ful',
              }.contains(item.categoryId),
            )
            .take(3)
            .toList();
    if (suggestions.isEmpty) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            isAr ? 'أكمل طلبك' : 'Complete your order',
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            isAr
                ? 'إضافات شائعة مع طلبك'
                : 'Popular add-ons for your basket',
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (var index = 0; index < suggestions.length; index++) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    isAr ? suggestions[index].nameAr : suggestions[index].nameEn,
                    style: CoreTypography.bodyMedium(context, scheme.onSurface),
                  ),
                ),
                WidgetsPriceBadge(
                  priceLabel: UtilityFormatJod.format(
                    suggestions[index].priceJod,
                    suffix: l10n.currencyJod,
                  ),
                  compact: true,
                ),
                SizedBox(width: CoreSpacing.sm(context)),
                WidgetsIconButton(
                  onPressed:
                      () => showWidgetsCartCustomizationSheet(
                        context: context,
                        item: suggestions[index],
                      ),
                  icon: Icons.add_shopping_cart_outlined,
                  tooltip: l10n.actionAddToCart,
                ),
              ],
            ),
            if (index != suggestions.length - 1)
              SizedBox(height: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }
}

class _HelpCard extends StatelessWidget {
  const _HelpCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsInfoBanner(
      title: l10n.cartHelpTitle,
      message: l10n.cartChatWithUs,
      tone: WidgetsInfoBannerTone.info,
      icon: Icons.support_agent,
      action: WidgetsAppButton(
        label: l10n.screenSupport,
        onPressed: () => context.push(AppRoutePaths.support),
        icon: Icons.support_agent_outlined,
        variant: WidgetsAppButtonVariant.secondary,
        fullWidth: true,
      ),
    );
  }
}

class _EmptyCartPanel extends StatelessWidget {
  const _EmptyCartPanel({required this.onBrowse});

  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      child: Column(
        children: [
          Icon(
            Icons.shopping_basket_outlined,
            size: CoreContentSizes.emptyStateIcon(context),
            color: scheme.primary,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.cartEmptyMessage,
            textAlign: TextAlign.center,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.cartViewItems,
            onPressed: onBrowse,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}

class _CartLineState {
  _CartLineState({required this.line, required this.menuItem})
    : quantity = line.quantity;

  final ModelCartLine line;
  final ModelMenuItem? menuItem;
  int quantity;

  double get unitPriceJod => line.unitPriceJod;

  String title(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return isArabic ? line.nameAr : line.nameEn;
  }

  String subtitle(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final configuration =
        isArabic ? line.configurationAr : line.configurationEn;
    final details = [
      if (configuration != null && configuration.isNotEmpty) configuration,
      if (line.remarks != null && line.remarks!.isNotEmpty) line.remarks!,
    ];
    if (details.isNotEmpty) return details.join(' • ');

    final item = menuItem;
    if (item == null) return line.itemId;
    return isArabic ? item.descriptionAr : item.descriptionEn;
  }

  _CartOrderMeta orderMeta(AppLocalizations l10n) {
    return _CartOrderMeta(
      label: l10n.menuTakeaway,
      color: CoreColors.orderTypeTakeaway,
      icon: Icons.takeout_dining_outlined,
    );
  }

  static List<_CartLineState> fromLines(
    List<ModelCartLine> lines, {
    List<ModelMenuItem>? catalog,
  }) {
    final pool = catalog ?? MockupCatalog.items;
    return lines.map((line) {
      ModelMenuItem? menuItem;
      for (final item in pool) {
        if (item.id == line.itemId) {
          menuItem = item;
          break;
        }
      }
      menuItem ??= MockupCatalog.itemById(line.itemId);
      return _CartLineState(line: line, menuItem: menuItem);
    }).toList();
  }
}

class _CartOrderMeta {
  const _CartOrderMeta({
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;
}

class _CartDishMedia extends StatelessWidget {
  const _CartDishMedia({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: _BasketPainter(color: color, accent: CoreColors.brandGold),
        ),
        Center(
          child: Icon(
            icon,
            size: CoreContentSizes.categoryMenuImageIcon(context),
            color: color,
          ),
        ),
      ],
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

class _BasketPainter extends CustomPainter {
  const _BasketPainter({required this.color, required this.accent});

  final Color color;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final plate =
        Paint()
          ..color = color.withValues(alpha: 0.12)
          ..style = PaintingStyle.fill;
    final rim =
        Paint()
          ..color = color.withValues(alpha: 0.24)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4;
    final garnish =
        Paint()
          ..color = accent.withValues(alpha: 0.28)
          ..style = PaintingStyle.fill;

    final center = Offset(size.width * 0.50, size.height * 0.56);
    final radius = size.shortestSide * 0.32;
    canvas.drawCircle(center, radius, plate);
    canvas.drawCircle(center, radius, rim);
    canvas.drawCircle(
      Offset(size.width * 0.35, size.height * 0.35),
      radius * 0.17,
      garnish,
    );
    canvas.drawCircle(
      Offset(size.width * 0.66, size.height * 0.33),
      radius * 0.14,
      garnish,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width * 0.52, size.height * 0.68),
        width: radius * 1.15,
        height: radius * 0.54,
      ),
      0.2,
      2.7,
      false,
      rim,
    );
  }

  @override
  bool shouldRepaint(covariant _BasketPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.accent != accent;
  }
}
