import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Shared bottom action area for step flows, checkout, payment, and operations screens.
class WidgetsActionBar extends StatelessWidget {
  const WidgetsActionBar({
    required this.primary,
    this.secondary,
    this.leading,
    this.progress,
    super.key,
  });

  final Widget primary;
  final Widget? secondary;
  final Widget? leading;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(top: BorderSide(color: scheme.outlineVariant)),
        ),
        child: Padding(
          padding: EdgeInsets.all(CoreSpacing.md(context)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (progress != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: CoreSpacing.xs(context),
                    color: scheme.primary,
                    backgroundColor: scheme.surfaceContainerHighest,
                  ),
                ),
                SizedBox(height: CoreSpacing.md(context)),
              ],
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (leading != null) ...[
                    leading!,
                    SizedBox(width: CoreSpacing.md(context)),
                  ],
                  if (secondary != null) ...[
                    Expanded(child: secondary!),
                    SizedBox(width: CoreSpacing.md(context)),
                  ],
                  Expanded(flex: secondary == null && leading == null ? 1 : 2, child: primary),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
