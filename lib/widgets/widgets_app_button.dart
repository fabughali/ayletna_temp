import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

enum WidgetsAppButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  danger,
  success,
}

/// Unified Ayletna button for primary, secondary, outline, ghost, and semantic actions.
class WidgetsAppButton extends StatelessWidget {
  const WidgetsAppButton({
    required this.label,
    required this.onPressed,
    this.variant = WidgetsAppButtonVariant.primary,
    this.icon,
    this.iconAlignment = IconAlignment.start,
    this.fullWidth = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final WidgetsAppButtonVariant variant;
  final IconData? icon;
  final IconAlignment iconAlignment;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final minimumSize = Size(
      fullWidth ? double.infinity : 0,
      context.coreTheme.buttonMinHeight,
    );
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
    );
    final foreground = _foreground(scheme);
    final background = _background(scheme);
    final side = _side(scheme);

    final child = icon == null ? Text(label) : null;

    switch (variant) {
      case WidgetsAppButtonVariant.outline:
        return icon == null
            ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: foreground,
                minimumSize: minimumSize,
                side: side,
                shape: shape,
              ),
              child: child!,
            )
            : OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon),
              iconAlignment: iconAlignment,
              label: Text(label),
              style: OutlinedButton.styleFrom(
                foregroundColor: foreground,
                minimumSize: minimumSize,
                side: side,
                shape: shape,
              ),
            );
      case WidgetsAppButtonVariant.ghost:
        return icon == null
            ? TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                foregroundColor: foreground,
                minimumSize: minimumSize,
                shape: shape,
              ),
              child: child!,
            )
            : TextButton.icon(
              onPressed: onPressed,
              icon: Icon(icon),
              iconAlignment: iconAlignment,
              label: Text(label),
              style: TextButton.styleFrom(
                foregroundColor: foreground,
                minimumSize: minimumSize,
                shape: shape,
              ),
            );
      case WidgetsAppButtonVariant.primary:
      case WidgetsAppButtonVariant.secondary:
      case WidgetsAppButtonVariant.danger:
      case WidgetsAppButtonVariant.success:
        return icon == null
            ? FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: background,
                foregroundColor: foreground,
                minimumSize: minimumSize,
                shape: shape,
              ),
              child: child!,
            )
            : FilledButton.icon(
              onPressed: onPressed,
              icon: Icon(icon),
              iconAlignment: iconAlignment,
              label: Text(label),
              style: FilledButton.styleFrom(
                backgroundColor: background,
                foregroundColor: foreground,
                minimumSize: minimumSize,
                shape: shape,
              ),
            );
    }
  }

  Color _foreground(ColorScheme scheme) {
    return switch (variant) {
      WidgetsAppButtonVariant.primary => scheme.onPrimary,
      WidgetsAppButtonVariant.secondary => scheme.onSecondary,
      WidgetsAppButtonVariant.outline => scheme.primary,
      WidgetsAppButtonVariant.ghost => scheme.primary,
      WidgetsAppButtonVariant.danger => CoreColors.surfaceLight,
      WidgetsAppButtonVariant.success => CoreColors.surfaceLight,
    };
  }

  Color _background(ColorScheme scheme) {
    return switch (variant) {
      WidgetsAppButtonVariant.primary => scheme.primary,
      WidgetsAppButtonVariant.secondary => scheme.secondary,
      WidgetsAppButtonVariant.outline => scheme.surface,
      WidgetsAppButtonVariant.ghost => scheme.surface,
      WidgetsAppButtonVariant.danger => CoreColors.semanticError,
      WidgetsAppButtonVariant.success => CoreColors.semanticSuccess,
    };
  }

  BorderSide? _side(ColorScheme scheme) {
    return switch (variant) {
      WidgetsAppButtonVariant.outline => BorderSide(
        color: scheme.outlineVariant,
      ),
      _ => null,
    };
  }
}
