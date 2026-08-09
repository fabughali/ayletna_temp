import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:flutter/material.dart';

/// Viewport-scaled Material [Switch] for preference / config toggles.
class WidgetsAppSwitch extends StatelessWidget {
  const WidgetsAppSwitch({
    required this.value,
    required this.onChanged,
    this.activeTrackColor,
    super.key,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeTrackColor;

  @override
  Widget build(BuildContext context) {
    final scale = UtilitySizer.scaleOf(context).clamp(0.78, 1.12);
    final switchWidget = Switch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: activeTrackColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
    if ((scale - 1.0).abs() < 0.01) {
      return switchWidget;
    }
    return Transform.scale(
      scale: scale,
      alignment: AlignmentDirectional.center,
      child: switchWidget,
    );
  }
}
