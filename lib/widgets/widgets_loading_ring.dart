import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:flutter/material.dart';

class WidgetsLoadingRing extends StatelessWidget {
  const WidgetsLoadingRing({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = CoreContentSizes.loadingIndicator(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        CoreSpacing.xl(context),
        0,
        CoreSpacing.xl(context),
        CoreSpacing.xxl(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: UtilitySizer.of(context, 3),
              backgroundColor: scheme.outlineVariant.withValues(alpha: 0.25),
              color: scheme.primary,
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            label,
            textAlign: TextAlign.center,
            style: CoreTypography.caption(
              context,
              scheme.onSurfaceVariant,
            ).copyWith(fontWeight: FontWeight.w700, letterSpacing: 2),
          ),
        ],
      ),
    );
  }
}
