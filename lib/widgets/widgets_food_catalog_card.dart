import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_responsive_card_grid.dart';
import 'package:flutter/material.dart';

/// Responsive grid for customer/cashier food catalog cards.
class WidgetsFoodCatalogGrid extends StatelessWidget {
  const WidgetsFoodCatalogGrid({
    required this.children,
    this.minCardWidth = 280,
    this.maxCardWidth = 360,
    this.heightRatio = 1.68,
    super.key,
  });

  final List<Widget> children;
  final double minCardWidth;
  final double maxCardWidth;
  final double heightRatio;

  @override
  Widget build(BuildContext context) {
    return WidgetsResponsiveCardGrid(
      minCardWidth: minCardWidth,
      maxCardWidth: maxCardWidth,
      heightRatio: heightRatio,
      children: children,
    );
  }
}

/// Shared merchandising card for menu items, offers, and combos.
class WidgetsFoodCatalogCard extends StatelessWidget {
  const WidgetsFoodCatalogCard({
    required this.title,
    required this.description,
    required this.priceLabel,
    required this.imageUrl,
    required this.badgeLabel,
    required this.actionLabel,
    required this.loyaltyLabel,
    required this.index,
    required this.onAction,
    required this.onTap,
    this.ratingLabel,
    this.actionIcon = Icons.add_shopping_cart_outlined,
    super.key,
  });

  final String title;
  final String description;
  final String priceLabel;
  final String? imageUrl;
  final String badgeLabel;
  final String actionLabel;
  final String loyaltyLabel;
  final String? ratingLabel;
  final int index;
  final VoidCallback onAction;
  final VoidCallback onTap;
  final IconData actionIcon;

  @override
  Widget build(BuildContext context) {
    return WidgetsFoodCard(
      title: title,
      description: description,
      priceLabel: priceLabel,
      media: WidgetsMockFoodImage(
        imageUrl: imageUrl,
        fallback: WidgetsFoodCatalogFallback(index: index),
      ),
      actionLabel: actionLabel,
      onAction: onAction,
      onTap: onTap,
      fillHeight: true,
      badgeLabel: badgeLabel,
      ratingLabel: ratingLabel,
      loyaltyLabel: loyaltyLabel,
      actionIcon: actionIcon,
      badges: [
        WidgetsFoodCatalogTag(
          label: badgeLabel,
          color: foodCatalogBadgeColor(context, index),
        ),
      ],
    );
  }
}

Color foodCatalogBadgeColor(BuildContext context, int index) {
  final scheme = Theme.of(context).colorScheme;
  return switch (index % 4) {
    0 => scheme.primary,
    1 => CoreColors.brandGold,
    2 => CoreColors.orderTypePlated,
    _ => scheme.secondary,
  };
}

class WidgetsFoodCatalogTag extends StatelessWidget {
  const WidgetsFoodCatalogTag({
    required this.label,
    required this.color,
    super.key,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
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

class WidgetsFoodCatalogFallback extends StatelessWidget {
  const WidgetsFoodCatalogFallback({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final icons = [
      Icons.dinner_dining_outlined,
      Icons.fastfood_outlined,
      Icons.tapas_outlined,
      Icons.outdoor_grill_outlined,
    ];

    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: _FoodCatalogFallbackPainter(
            color: foodCatalogBadgeColor(context, index),
            accent: CoreColors.brandGold,
          ),
        ),
        Center(
          child: Icon(
            icons[index % icons.length],
            size: CoreContentSizes.categoryMenuImageIcon(context),
            color: scheme.primary,
          ),
        ),
      ],
    );
  }
}

class _FoodCatalogFallbackPainter extends CustomPainter {
  const _FoodCatalogFallbackPainter({
    required this.color,
    required this.accent,
  });

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
          ..color = accent.withValues(alpha: 0.26)
          ..style = PaintingStyle.fill;

    final center = Offset(size.width * 0.50, size.height * 0.54);
    final radius = size.shortestSide * 0.34;
    canvas.drawCircle(center, radius, plate);
    canvas.drawCircle(center, radius, rim);
    canvas.drawCircle(
      Offset(size.width * 0.34, size.height * 0.36),
      radius * 0.18,
      garnish,
    );
    canvas.drawCircle(
      Offset(size.width * 0.64, size.height * 0.30),
      radius * 0.14,
      garnish,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width * 0.55, size.height * 0.66),
        width: radius * 1.15,
        height: radius * 0.55,
      ),
      0.1,
      2.8,
      false,
      rim,
    );
  }

  @override
  bool shouldRepaint(covariant _FoodCatalogFallbackPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.accent != accent;
  }
}
