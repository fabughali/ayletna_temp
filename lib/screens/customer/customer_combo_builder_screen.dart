import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [ComboBuilderScreen] redesigned as a real meal builder mock flow.
class CustomerComboBuilderScreen extends ConsumerStatefulWidget {
  const CustomerComboBuilderScreen({super.key});

  @override
  ConsumerState<CustomerComboBuilderScreen> createState() =>
      _CustomerComboBuilderScreenState();
}

class _CustomerComboBuilderScreenState
    extends ConsumerState<CustomerComboBuilderScreen> {
  String? _mainId;
  String? _sideId;
  String? _drinkId;
  String? _dessertId;

  List<ModelMenuItem> _menuItems(WidgetRef ref) {
    return ref.watch(menuAllItemsProvider).maybeWhen(
      data: (items) => items.isNotEmpty ? items : MockupCatalog.items,
      orElse: () => MockupCatalog.items,
    );
  }

  String _stepId(_ComboStep step, String? current, List<ModelMenuItem> items) {
    final stepItems = _itemsForStep(step, items);
    if (stepItems.isEmpty) return current ?? '';
    if (current != null && stepItems.any((item) => item.id == current)) {
      return current;
    }
    return stepItems.first.id;
  }

  ModelMenuItem? _itemById(String id, List<ModelMenuItem> items) {
    for (final item in items) {
      if (item.id == id) return item;
    }
    return MockupCatalog.itemById(id);
  }

  double _comboDiscountRate(WidgetRef ref) {
    final combos = ref.watch(visibleCombosProvider);
    if (combos.isEmpty) return 0.12;
    return combos.first.discountPercent / 100;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final menuItems = _menuItems(ref);
    final mainId = _stepId(_ComboStep.main, _mainId, menuItems);
    final sideId = _stepId(_ComboStep.side, _sideId, menuItems);
    final drinkId = _stepId(_ComboStep.drink, _drinkId, menuItems);
    final dessertId = _stepId(_ComboStep.dessert, _dessertId, menuItems);
    final selectedItems =
        [
          _itemById(mainId, menuItems),
          _itemById(sideId, menuItems),
          _itemById(drinkId, menuItems),
          _itemById(dessertId, menuItems),
        ].whereType<ModelMenuItem>().toList();
    if (selectedItems.length < 4) {
      return WidgetsScaffoldPage(
        title: l10n.screenComboBuilder,
        child: Center(
          child: Text(l10n.searchEmptyBody),
        ),
      );
    }
    final subtotal = selectedItems.fold<double>(
      0,
      (sum, item) => sum + item.priceJod,
    );
    final discountRate = _comboDiscountRate(ref);
    final savings = subtotal * discountRate;
    final total = subtotal - savings;

    return WidgetsScaffoldPage(
      title: l10n.screenComboBuilder,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(menuAllItemsProvider);
          ref.invalidate(visibleCombosProvider);
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            _ComboHero(total: total),
            SizedBox(height: CoreSpacing.lg(context)),
            _ComboStepSection(
              step: _ComboStep.main,
              selectedId: mainId,
              menuItems: menuItems,
              onSelected: (id) => setState(() => _mainId = id),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _ComboStepSection(
              step: _ComboStep.side,
              selectedId: sideId,
              menuItems: menuItems,
              onSelected: (id) => setState(() => _sideId = id),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _ComboStepSection(
              step: _ComboStep.drink,
              selectedId: drinkId,
              menuItems: menuItems,
              onSelected: (id) => setState(() => _drinkId = id),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _ComboStepSection(
              step: _ComboStep.dessert,
              selectedId: dessertId,
              menuItems: menuItems,
              onSelected: (id) => setState(() => _dessertId = id),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _ComboSummaryCard(
              subtotal: subtotal,
              savings: savings,
              total: total,
              onProceed: () => _addComboToCart(context, selectedItems, discountRate),
            ),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }

  void _addComboToCart(
    BuildContext context,
    List<ModelMenuItem> items,
    double discountRate,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final cart = ref.read(cartProvider.notifier);
    final multiplier = 1 - discountRate;
    for (final item in items) {
      cart.addConfiguredItem(
        item: item,
        quantity: 1,
        unitPriceJod: item.priceJod * multiplier,
        configurationKey: 'combo:${items.map((i) => i.id).join('+')}',
        configurationAr: l10n.screenComboBuilder,
        configurationEn: l10n.screenComboBuilder,
      );
    }
    UtilityMockFeedback.showSuccess(context, l10n.actionAddToCart);
    context.go(AppRoutePaths.cart);
  }
}

enum _ComboStep { main, side, drink, dessert }

class _ComboHero extends StatelessWidget {
  const _ComboHero({required this.total});

  final double total;

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
              label: l10n.guestLimitedOffer,
              color: CoreColors.brandGold,
            ),
            child: _ComboMedia(
              color: scheme.primary,
              icon: Icons.room_service_outlined,
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.screenComboBuilder,
            style: CoreTypography.headlineLarge(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.screenComboBuilderDesc,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: WidgetsPriceBadge(
              priceLabel: UtilityFormatJod.format(
                total,
                suffix: l10n.currencyJod,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComboStepSection extends StatelessWidget {
  const _ComboStepSection({
    required this.step,
    required this.selectedId,
    required this.menuItems,
    required this.onSelected,
  });

  final _ComboStep step;
  final String selectedId;
  final List<ModelMenuItem> menuItems;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _stepTitle(context, step),
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (final item in _itemsForStep(step, menuItems)) ...[
            _ComboChoiceCard(
              item: item,
              selected: item.id == selectedId,
              onTap: () => onSelected(item.id),
            ),
            if (item != _itemsForStep(step, menuItems).last)
              SizedBox(height: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }
}

class _ComboChoiceCard extends StatelessWidget {
  const _ComboChoiceCard({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final ModelMenuItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final color = _categoryColor(context, item.categoryId);

    return WidgetsAppCard(
      variant:
          selected ? WidgetsAppCardVariant.food : WidgetsAppCardVariant.plain,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? color : scheme.onSurfaceVariant,
          ),
          SizedBox(width: CoreSpacing.md(context)),
          ClipRRect(
            borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
            child: SizedBox.square(
              dimension: CoreContentSizes.logoCard(context),
              child: WidgetsMockFoodImage(
                imageUrl: item.imageUrl,
                fallback: ColoredBox(
                  color: color.withValues(alpha: 0.12),
                  child: Icon(_categoryIcon(item.categoryId), color: color),
                ),
              ),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? item.nameAr : item.nameEn,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  isArabic ? item.descriptionAr : item.descriptionEn,
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
              item.priceJod,
              suffix: l10n.currencyJod,
            ),
            compact: true,
          ),
        ],
      ),
    );
  }
}

class _ComboSummaryCard extends StatelessWidget {
  const _ComboSummaryCard({
    required this.subtotal,
    required this.savings,
    required this.total,
    required this.onProceed,
  });

  final double subtotal;
  final double savings;
  final double total;
  final VoidCallback onProceed;

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
            label: l10n.screenOffers,
            value:
                '-${UtilityFormatJod.format(savings, suffix: l10n.currencyJod)}',
          ),
          Divider(
            height: CoreSpacing.xl(context),
            color: scheme.outlineVariant,
          ),
          Row(
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
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppButton(
            label: l10n.cartProceedCheckout,
            onPressed: onProceed,
            icon: Icons.shopping_basket_outlined,
            fullWidth: true,
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

class _ComboMedia extends StatelessWidget {
  const _ComboMedia({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: _ComboPainter(color: color, accent: CoreColors.brandGold),
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

class _ComboPainter extends CustomPainter {
  const _ComboPainter({required this.color, required this.accent});

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
    for (final offset in <Offset>[
      Offset(size.width * 0.34, size.height * 0.42),
      Offset(size.width * 0.62, size.height * 0.42),
      Offset(size.width * 0.50, size.height * 0.68),
    ]) {
      canvas.drawCircle(offset, radius * 0.14, garnish);
    }
  }

  @override
  bool shouldRepaint(covariant _ComboPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.accent != accent;
  }
}

List<ModelMenuItem> _itemsForStep(_ComboStep step, List<ModelMenuItem> items) {
  return switch (step) {
    _ComboStep.main =>
      items
          .where(
            (item) => {
              'shawarma',
              'sandwiches',
              'pizza',
              'snacks',
              'burgers',
            }.contains(item.categoryId),
          )
          .take(4)
          .toList(),
    _ComboStep.side =>
      items
          .where(
            (item) => {
              'hummus_ful',
              'falafel',
              'manaqeesh',
              'pastries',
            }.contains(item.categoryId),
          )
          .take(4)
          .toList(),
    _ComboStep.drink =>
      items.where((item) => item.categoryId == 'drinks').take(4).toList(),
    _ComboStep.dessert =>
      items.where((item) => item.categoryId == 'pastries').take(4).toList(),
  };
}

String _stepTitle(BuildContext context, _ComboStep step) {
  final l10n = AppLocalizations.of(context)!;
  return switch (step) {
    _ComboStep.main => l10n.rewardsMainCourse,
    _ComboStep.side => l10n.rewardsSides,
    _ComboStep.drink => l10n.rewardsDrinks,
    _ComboStep.dessert => l10n.loyaltyFreeDessert,
  };
}

Color _categoryColor(BuildContext context, String categoryId) {
  final scheme = Theme.of(context).colorScheme;
  return switch (categoryId) {
    'drinks' => CoreColors.orderTypeDelivery,
    'hummus_ful' || 'falafel' || 'manaqeesh' || 'pastries' => scheme.secondary,
    'pizza' => CoreColors.brandGold,
    'burgers' => CoreColors.semanticRevenue,
    'shawarma' => CoreColors.brandOrange,
    _ => scheme.primary,
  };
}

IconData _categoryIcon(String categoryId) {
  return switch (categoryId) {
    'drinks' => Icons.local_drink_outlined,
    'hummus_ful' => Icons.rice_bowl_outlined,
    'falafel' => Icons.circle_outlined,
    'manaqeesh' => Icons.bakery_dining_outlined,
    'pastries' => Icons.breakfast_dining_outlined,
    'pizza' => Icons.local_pizza_outlined,
    'burgers' => Icons.lunch_dining,
    'shawarma' => Icons.kebab_dining_outlined,
    'sandwiches' => Icons.lunch_dining_outlined,
    'snacks' => Icons.fastfood_outlined,
    _ => Icons.restaurant_menu_outlined,
  };
}
