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
    this.showBorder = false,
    super.key,
  });

  final Widget child;
  final double? height;
  final Widget? badge;
  final bool expand;
  final BorderRadiusGeometry? borderRadius;

  /// When true, draws a subtle edge. Off by default because parent cards
  /// already provide the frame and stacking borders looks duplicated.
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius =
        borderRadius ?? BorderRadius.circular(CoreSpacing.radiusCardOf(context));

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
              if (showBorder)
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
