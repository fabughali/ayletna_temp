import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
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
import 'package:ayletna_restaurant_app/widgets/widgets_financial_summary.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_tag.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_quantity_stepper.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
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
  bool _showMoreFulfillment = false;

  final _itemsSectionKey = GlobalKey();
  final _fulfillmentSectionKey = GlobalKey();
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
    final summaryTotal = totalBeforeSavings - discount;
    final hasItems = visibleItems.isNotEmpty;
    final checkoutActiveStep = !hasItems ? 0 : 1;
    final checkoutCompletedThrough = !hasItems ? -1 : 0;

    final listChildren = <Widget>[
      SizedBox(height: CoreSpacing.md(context)),
      WidgetsPageHeader(
        title: l10n.cartYourCartTitle,
        subtitle: l10n.cartReviewSubtitle,
      ),
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
            showMore: _showMoreFulfillment,
            onToggleMore:
                () => setState(
                  () => _showMoreFulfillment = !_showMoreFulfillment,
                ),
            onSelected: _selectFulfillment,
            onTerms: () => context.push(AppRoutePaths.terms),
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
                l10n.cartInvalidPromoCode,
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
            tipJod: 0,
            discount: discount,
            total: summaryTotal,
          ),
        ),
        SizedBox(height: CoreSpacing.lg(context)),
      ],
      const _HelpCard(),
      SizedBox(height: CoreSpacing.xxl(context)),
    ];

    return WidgetsScaffoldPage(
      title: l10n.screenCart,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      bottomSheet:
          hasItems
              ? _StickyCartBar(
                totalLabel: UtilityFormatJod.format(
                  summaryTotal,
                  suffix: l10n.currencyJod,
                ),
                proceedLabel:
                    isGuest
                        ? l10n.guestSignInToOrder
                        : l10n.cartProceedCheckout,
                onProceed:
                    isGuest
                        ? () => context.push(AppRoutePaths.login)
                        : () => _onProceedCheckout(),
              )
              : null,
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(cartProvider);
          ref.invalidate(cartPromoProvider);
          if (context.mounted) {
            UtilityMockFeedback.showInfo(context, l10n.screenCart);
          }
        },
        child: ListView.builder(
          itemCount: listChildren.length,
          itemBuilder: (context, index) => listChildren[index],
        ),
      ),
    );
  }

  void _syncCheckoutDraft() {
    final draft = ref.read(checkoutDraftProvider.notifier);
    draft.setFulfillment(_toCheckoutFulfillment(_fulfillment));
    draft.setPromoApplied(ref.read(cartPromoProvider).applied);
  }

  Future<void> _onProceedCheckout() async {
    _syncCheckoutDraft();
    if (!mounted) return;
    context.push(AppRoutePaths.checkout);
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

  void _selectFulfillment(_CartFulfillment value) {
    setState(() {
      _fulfillment = value;
      if (value == _CartFulfillment.groupDelivery ||
          value == _CartFulfillment.plated) {
        _showMoreFulfillment = true;
      }
    });
  }

  void _scrollToCheckoutStep(int step) {
    final key = switch (step) {
      0 => _itemsSectionKey,
      1 => _fulfillmentSectionKey,
      _ => _summarySectionKey,
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
            badge: WidgetsFoodTag(label: orderMeta.label, color: orderMeta.color),
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
    required this.showMore,
    required this.onToggleMore,
    required this.onSelected,
    required this.onTerms,
  });

  final _CartFulfillment selected;
  final bool showMore;
  final VoidCallback onToggleMore;
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
          if (showMore) ...[
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
          ],
          SizedBox(height: CoreSpacing.sm(context)),
          TextButton(
            onPressed: onToggleMore,
            child: Text(
              showMore
                  ? l10n.cartHideFulfillmentOptions
                  : l10n.cartMoreFulfillmentOptions,
            ),
          ),
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

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({
    required this.subtotal,
    required this.fulfillment,
    required this.fulfillmentCharge,
    required this.tax,
    required this.tipJod,
    required this.discount,
    required this.total,
  });

  final double subtotal;
  final _CartFulfillment fulfillment;
  final double fulfillmentCharge;
  final double tax;
  final double tipJod;
  final double discount;
  final double total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isPlated = fulfillment == _CartFulfillment.plated;
    final jod = l10n.currencyJod;

    final lines = <WidgetsFinancialSummaryLine>[
      WidgetsFinancialSummaryLine(
        label: l10n.checkoutFood,
        value: UtilityFormatJod.format(subtotal, suffix: jod),
        accentColor: CoreColors.semanticRevenue,
      ),
      WidgetsFinancialSummaryLine(
        label: isPlated
            ? l10n.checkoutDeposit
            : _fulfillmentChargeLabel(l10n, fulfillment),
        value:
            fulfillmentCharge == 0
                ? l10n.cartFree
                : UtilityFormatJod.format(fulfillmentCharge, suffix: jod),
        accentColor: isPlated ? CoreColors.semanticDeposit : null,
      ),
      WidgetsFinancialSummaryLine(
        label: l10n.cartEstimatedTax,
        value: UtilityFormatJod.format(tax, suffix: jod),
      ),
      WidgetsFinancialSummaryLine(
        label: l10n.checkoutTip,
        value:
            tipJod == 0
                ? l10n.cartNoTip
                : UtilityFormatJod.format(tipJod, suffix: jod),
        accentColor: CoreColors.semanticTip,
      ),
      if (discount > 0)
        WidgetsFinancialSummaryLine(
          label: l10n.cartPromoCode,
          value: '-${UtilityFormatJod.format(discount, suffix: jod)}',
        ),
    ];

    return WidgetsFinancialSummary(
      title: l10n.cartOrderSummary,
      subtitle: '${l10n.cartFulfillment}: ${_fulfillmentTitle(l10n, fulfillment)}',
      lines: lines,
      totalLabel: l10n.cartTotal,
      totalValue: UtilityFormatJod.format(total, suffix: jod),
      totalColor: CoreColors.brandGold,
      accentColor: CoreColors.semanticRevenue,
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
            l10n.cartCompleteOrderTitle,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.cartPopularAddonsSubtitle,
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

class _StickyCartBar extends StatelessWidget {
  const _StickyCartBar({
    required this.totalLabel,
    required this.proceedLabel,
    required this.onProceed,
  });

  final String totalLabel;
  final String proceedLabel;
  final VoidCallback onProceed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Material(
      elevation: 8,
      color: scheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            CoreSpacing.lg(context),
            CoreSpacing.md(context),
            CoreSpacing.lg(context),
            CoreSpacing.md(context),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.cartTotal,
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      totalLabel,
                      style: CoreTypography.titleMedium(
                        context,
                        CoreColors.brandGold,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                flex: 2,
                child: WidgetsAppButton(
                  label: proceedLabel,
                  onPressed: onProceed,
                  icon: Icons.arrow_forward,
                  fullWidth: true,
                ),
              ),
            ],
          ),
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
