import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

enum WidgetsIconButtonVariant { plain, tonal, filled, outline }

/// Unified icon-only action with consistent hit target, radius, and tonal variants.
class WidgetsIconButton extends StatelessWidget {
  const WidgetsIconButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.variant = WidgetsIconButtonVariant.plain,
    this.color,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final WidgetsIconButtonVariant variant;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = color ?? scheme.primary;
    final size = context.coreTheme.iconButtonSize;
    final iconSize = CoreContentSizes.buttonIcon(context);

    if (variant == WidgetsIconButtonVariant.plain) {
      return SizedBox.square(
        dimension: size,
        child: IconButton(
          onPressed: onPressed,
          tooltip: tooltip,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints.tight(Size.square(size)),
          icon: Icon(icon, size: iconSize, color: accent),
        ),
      );
    }

    return Tooltip(
      message: tooltip,
      child: Material(
        color: _background(scheme, accent),
        shape: _shape(scheme, accent),
        child: InkWell(
          onTap: onPressed,
          customBorder: _shape(scheme, accent),
          child: SizedBox.square(
            dimension: size,
            child: Icon(
              icon,
              size: iconSize,
              color: _foreground(scheme, accent),
            ),
          ),
        ),
      ),
    );
  }

  ShapeBorder _shape(ColorScheme scheme, Color accent) {
    return switch (variant) {
      WidgetsIconButtonVariant.outline => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      _ => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
      ),
    };
  }

  Color _background(ColorScheme scheme, Color accent) {
    return switch (variant) {
      WidgetsIconButtonVariant.plain => scheme.surface,
      WidgetsIconButtonVariant.tonal => accent.withValues(alpha: 0.12),
      WidgetsIconButtonVariant.filled => accent,
      WidgetsIconButtonVariant.outline => scheme.surface,
    };
  }

  Color _foreground(ColorScheme scheme, Color accent) {
    return switch (variant) {
      WidgetsIconButtonVariant.filled => scheme.onPrimary,
      _ => accent,
    };
  }
}
