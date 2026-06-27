import 'package:ayletna_restaurant_app/core/core_colors.dart';
import 'package:ayletna_restaurant_app/core/core_content_sizes.dart';
import 'package:flutter/material.dart';

/// Branded loader — brand gold (ui_design_prompt).
class WidgetsLoadingIndicator extends StatelessWidget {
  const WidgetsLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CoreContentSizes.loadingIndicator(context);
    final primary = Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: primary,
        backgroundColor: CoreColors.brandGold.withAlpha20,
      ),
    );
  }
}
