import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_progress_bar.dart';
import 'package:flutter/material.dart';

/// Unified step/wizard progress header.
class WidgetsStepProgress extends StatelessWidget {
  const WidgetsStepProgress({
    required this.currentStep,
    required this.totalSteps,
    this.title,
    this.labels = const [],
    super.key,
  });

  final int currentStep;
  final int totalSteps;
  final String? title;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final progress = totalSteps <= 0 ? 0.0 : currentStep / totalSteps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
        ],
        WidgetsProgressBar(value: progress),
        if (labels.isNotEmpty) ...[
          SizedBox(height: CoreSpacing.sm(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var index = 0; index < labels.length; index++)
                Text(
                  labels[index],
                  style: CoreTypography.caption(
                    context,
                    index < currentStep
                        ? scheme.primary
                        : scheme.onSurfaceVariant,
                  ).copyWith(
                    fontWeight:
                        index < currentStep ? FontWeight.w900 : FontWeight.w400,
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
