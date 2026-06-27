import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

class WidgetsOrderStatusTimeline extends StatelessWidget {
  const WidgetsOrderStatusTimeline({
    required this.steps,
    required this.currentIndex,
    super.key,
  });

  final List<String> steps;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: List.generate(steps.length, (i) {
        final done = i <= currentIndex;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Icon(
                  done ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: done ? scheme.primary : scheme.outline,
                  size: CoreContentSizes.timelineIcon(context),
                ),
                if (i < steps.length - 1)
                  Container(
                    width: CoreContentSizes.timelineLineWidth(context),
                    height: CoreContentSizes.timelineLineHeight(context),
                    color: scheme.outline,
                  ),
              ],
            ),
            SizedBox(width: CoreSpacing.md(context)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: CoreSpacing.md(context)),
                child: Text(
                  steps[i],
                  style: CoreTypography.bodyMedium(
                    context,
                    done ? scheme.onSurface : scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
