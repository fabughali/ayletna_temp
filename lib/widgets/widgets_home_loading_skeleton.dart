import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Placeholder blocks while customer home menu data loads.
class WidgetsHomeLoadingSkeleton extends StatelessWidget {
  const WidgetsHomeLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final block = scheme.onSurface.withValues(alpha: 0.08);

    return ListView(
      padding: EdgeInsets.symmetric(vertical: CoreSpacing.md(context)),
      children: [
        _SkeletonBlock(height: 52, color: block),
        SizedBox(height: CoreSpacing.lg(context)),
        _SkeletonBlock(
          height: 180,
          color: block,
          radius: CoreSpacing.radiusCard,
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        Row(
          children: [
            for (var i = 0; i < 3; i++) ...[
              Expanded(child: _SkeletonBlock(height: 88, color: block)),
              if (i < 2) SizedBox(width: CoreSpacing.md(context)),
            ],
          ],
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        for (var i = 0; i < 4; i++) ...[
          _SkeletonBlock(
            height: 112,
            color: block,
            radius: CoreSpacing.radiusCard,
          ),
          SizedBox(height: CoreSpacing.md(context)),
        ],
      ],
    );
  }
}

class _SkeletonBlock extends StatelessWidget {
  const _SkeletonBlock({
    required this.height,
    required this.color,
    this.radius = CoreSpacing.radiusButton,
  });

  final double height;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: SizedBox(height: height, width: double.infinity),
    );
  }
}
