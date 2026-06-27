import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Horizontal checkout progress for the unified cart screen.
class WidgetsCheckoutStepStrip extends StatelessWidget {
  const WidgetsCheckoutStepStrip({
    required this.activeStep,
    required this.completedThrough,
    this.onStepTapped,
    super.key,
  });

  /// Zero-based index of the current step (0 = basket).
  final int activeStep;

  /// Highest step index that is fully complete (inclusive).
  final int completedThrough;

  final ValueChanged<int>? onStepTapped;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final labels = [
      l10n.cartCheckoutStepBasket,
      l10n.cartCheckoutStepFulfillment,
      l10n.cartCheckoutStepPayment,
      l10n.cartCheckoutStepReview,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: CoreSpacing.md(context)),
      child: Row(
        children: [
          for (var index = 0; index < labels.length; index++) ...[
            if (index > 0)
              Expanded(
                child: Container(
                  height: 2,
                  color:
                      index <= completedThrough
                          ? theme.colorScheme.primary
                          : theme.dividerColor,
                ),
              ),
            _StepDot(
              label: labels[index],
              index: index,
              isActive: index == activeStep,
              isComplete: index <= completedThrough,
              onTap: onStepTapped == null ? null : () => onStepTapped!(index),
            ),
          ],
        ],
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({
    required this.label,
    required this.index,
    required this.isActive,
    required this.isComplete,
    this.onTap,
  });

  final String label;
  final int index;
  final bool isActive;
  final bool isComplete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dotColor =
        isComplete || isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.outline;
    final textColor =
        isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isActive ? 28 : 22,
              height: isActive ? 28 : 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isComplete
                        ? dotColor
                        : isActive
                        ? dotColor.withValues(alpha: 0.15)
                        : theme.colorScheme.surfaceContainerHighest,
                border: Border.all(color: dotColor, width: isActive ? 2 : 1),
              ),
              alignment: Alignment.center,
              child:
                  isComplete && !isActive
                      ? Icon(
                        Icons.check,
                        size: 14,
                        color: theme.colorScheme.onPrimary,
                      )
                      : Text(
                        '${index + 1}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isActive ? dotColor : textColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
            ),
            SizedBox(height: CoreSpacing.xs(context)),
            SizedBox(
              width: 72,
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: textColor,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  height: 1.15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
