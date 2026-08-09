import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:flutter/material.dart';

class WidgetsDotBackground extends StatelessWidget {
  const WidgetsDotBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: _DotGridPainter(
            color: Theme.of(
              context,
            ).colorScheme.outline.withValues(alpha: 0.12),
            spacing: UtilitySizer.of(context, 22),
            radius: UtilitySizer.of(context, 1.2),
          ),
        ),
        child,
      ],
    );
  }
}

class _DotGridPainter extends CustomPainter {
  _DotGridPainter({
    required this.color,
    required this.spacing,
    required this.radius,
  });

  final Color color;
  final double spacing;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    for (var x = spacing; x < size.width; x += spacing) {
      for (var y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.spacing != spacing ||
        oldDelegate.radius != radius;
  }
}
