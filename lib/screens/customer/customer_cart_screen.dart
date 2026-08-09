import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_checkout_step_strip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_customization_sheet.dart';
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

/// PRD CartScreen — basket items + related products (step 1).
class CustomerCartScreen extends ConsumerStatefulWidget {
  const CustomerCartScreen({super.key});

  @override
  ConsumerState<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends ConsumerState<CustomerCartScreen> {
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
    final hasItems = visibleItems.isNotEmpty;

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
          activeStep: 0,
          completedThrough: -1,
          onStepTapped: (step) => _jumpToCheckoutStep(context, step),
        ),
        SizedBox(height: CoreSpacing.lg(context)),
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
      ],
      SizedBox(height: CoreSpacing.xxl(context)),
    ];

    return WidgetsScaffoldPage(
      title: l10n.screenCart,
      actions: [
        WidgetsIconButton(
          icon: Icons.support_agent_outlined,
          tooltip: l10n.screenSupport,
          onPressed: () => context.push(AppRoutePaths.support),
        ),
      ],
      bottomSheet:
          hasItems
              ? _StickyCartBar(
                totalLabel: UtilityFormatJod.format(
                  subtotal,
                  suffix: l10n.currencyJod,
                ),
                proceedLabel:
                    isGuest
                        ? l10n.guestSignInToOrder
                        : l10n.cartProceedCheckout,
                onProceed:
                    isGuest
                        ? () => context.push(AppRoutePaths.login)
                        : () => context.push(AppRoutePaths.checkout),
              )
              : null,
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(cartProvider);
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

  void _jumpToCheckoutStep(BuildContext context, int step) {
    switch (step) {
      case 0:
        break;
      case 1:
        context.push(AppRoutePaths.checkout);
      case 2:
        context.push(AppRoutePaths.payment);
      case 3:
        context.push(AppRoutePaths.checkoutReview);
    }
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
