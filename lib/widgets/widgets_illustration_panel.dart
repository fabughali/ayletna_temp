import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Shared frame for CustomPaint, map, food, route, chart, and visual panels.
class WidgetsIllustrationPanel extends StatelessWidget {
  const WidgetsIllustrationPanel({
    required this.child,
    this.height,
    this.badge,
    this.backgroundColor,
    super.key,
  });

  final Widget child;
  final double? height;
  final Widget? badge;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      child: ColoredBox(
        color: backgroundColor ?? scheme.surfaceContainerHighest,
        child: SizedBox(
          height: height ?? CoreContentSizes.heroImageHeight(context),
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              child,
              if (badge != null)
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: EdgeInsets.all(CoreSpacing.md(context)),
                    child: badge,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
