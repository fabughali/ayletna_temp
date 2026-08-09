import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:flutter/material.dart';

class WidgetsIconBubble extends StatelessWidget {
  const WidgetsIconBubble({
    required this.icon,
    required this.color,
    this.size,
    this.iconSize,
    this.borderRadius,
    this.circular = false,
    super.key,
  });

  final IconData icon;
  final Color color;
  final double? size;
  final double? iconSize;
  final BorderRadiusGeometry? borderRadius;
  final bool circular;

  @override
  Widget build(BuildContext context) {
    final s = size ?? UtilitySizer.of(context, 42);
    return Container(
      width: s,
      height: s,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius:
            circular
                ? null
                : (borderRadius ??
                    BorderRadius.circular(CoreSpacing.radiusCardOf(context))),
        shape: circular ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Icon(icon, color: color, size: iconSize ?? 0.52 * s),
    );
  }
}
