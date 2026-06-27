import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Warm food media frame for dish photos or food-specific illustrations.
class WidgetsFoodMediaPanel extends StatelessWidget {
  const WidgetsFoodMediaPanel({
    required this.child,
    this.height,
    this.badge,
    this.expand = false,
    this.borderRadius,
    super.key,
  });

  final Widget child;
  final double? height;
  final Widget? badge;
  final bool expand;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius =
        borderRadius ?? BorderRadius.circular(CoreSpacing.radiusCard);

    return ClipRRect(
      borderRadius: radius,
      child: ColoredBox(
        color: Color.alphaBlend(
          CoreColors.brandOlive.withValues(alpha: 0.08),
          CoreColors.splashGradientBottomLight,
        ),
        child: SizedBox(
          height:
              expand
                  ? double.infinity
                  : height ?? CoreContentSizes.categoryMenuImageHeight(context),
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              child,
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: scheme.primary.withValues(alpha: 0.12),
                  ),
                  borderRadius: radius,
                ),
              ),
              if (badge != null)
                PositionedDirectional(
                  top: CoreSpacing.sm(context),
                  end: CoreSpacing.sm(context),
                  child: badge!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
