import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:flutter/material.dart';

/// Unified add/remove quantity control.
class WidgetsQuantityStepper extends StatelessWidget {
  const WidgetsQuantityStepper({
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    this.min = 0,
    this.expanded = false,
    super.key,
  });

  final int value;
  final int min;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  /// When true, fills parent width at [CoreThemeExtensions.buttonMinHeight]
  /// with − / value / + spaced equally (e.g. product detail action bar).
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final canDecrement = value > min;
    final compactSize = CoreContentSizes.compactIconButton(context);
    final valueText = ExcludeSemantics(
      child: Text(
        '$value',
        textAlign: TextAlign.center,
        style: CoreTypography.bodyMedium(
          context,
          scheme.onSurface,
        ).copyWith(fontWeight: FontWeight.w900),
      ),
    );

    final Widget child;
    if (expanded) {
      child = Row(
        children: [
          Expanded(
            child: Center(
              child: WidgetsIconButton(
                onPressed: canDecrement ? onDecrement : null,
                icon: Icons.remove,
                tooltip: l10n.quantityDecrease,
                color: scheme.primary,
                buttonSize: compactSize,
              ),
            ),
          ),
          Expanded(child: Center(child: valueText)),
          Expanded(
            child: Center(
              child: WidgetsIconButton(
                onPressed: onIncrement,
                icon: Icons.add,
                tooltip: l10n.quantityIncrease,
                color: scheme.primary,
                buttonSize: compactSize,
              ),
            ),
          ),
        ],
      );
    } else {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          WidgetsIconButton(
            onPressed: canDecrement ? onDecrement : null,
            icon: Icons.remove,
            tooltip: l10n.quantityDecrease,
            color: scheme.primary,
            buttonSize: compactSize,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: CoreSpacing.xs(context)),
            child: valueText,
          ),
          WidgetsIconButton(
            onPressed: onIncrement,
            icon: Icons.add,
            tooltip: l10n.quantityIncrease,
            color: scheme.primary,
            buttonSize: compactSize,
          ),
        ],
      );
    }

    final box = DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(
          expanded
              ? CoreSpacing.radiusButtonOf(context)
              : CoreSpacing.radiusChipOf(context),
        ),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: child,
    );

    return Semantics(
      label: '$value',
      child:
          expanded
              ? SizedBox(
                height: context.coreTheme.buttonMinHeight,
                width: double.infinity,
                child: box,
              )
              : box,
    );
  }
}
