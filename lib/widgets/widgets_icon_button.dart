import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

enum WidgetsIconButtonVariant { plain, tonal, filled, outline }

/// Unified icon-only action with consistent hit target, radius, and tonal variants.
///
/// Default size matches [CoreThemeExtensions.buttonMinHeight] (same as text fields).
/// In a stretched [Row]/[IntrinsicHeight], height grows with the sibling field.
class WidgetsIconButton extends StatelessWidget {
  const WidgetsIconButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.variant = WidgetsIconButtonVariant.plain,
    this.color,
    this.buttonSize,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final WidgetsIconButtonVariant variant;
  final Color? color;

  /// Width (and minimum height). Defaults to control height token.
  final double? buttonSize;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = color ?? scheme.primary;
    final size = buttonSize ?? context.coreTheme.iconButtonSize;
    final iconSize = CoreContentSizes.buttonIcon(context);

    if (variant == WidgetsIconButtonVariant.plain) {
      return Semantics(
        button: true,
        enabled: onPressed != null,
        label: tooltip,
        child: SizedBox(
          width: size,
          height: size,
          child: IconButton(
            onPressed: onPressed,
            tooltip: tooltip,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tightFor(width: size, height: size),
            style: IconButton.styleFrom(
              minimumSize: Size.square(size),
              maximumSize: Size.square(size),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            ),
            icon: Icon(icon, size: iconSize, color: accent),
          ),
        ),
      );
    }

    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        child: SizedBox(
          width: size,
          height: size,
          child: Material(
            color: _background(scheme, accent),
            shape: _shape(context, scheme, accent),
            child: InkWell(
              onTap: onPressed,
              customBorder: _shape(context, scheme, accent),
              child: Center(
                child: Icon(
                  icon,
                  size: iconSize,
                  color: _foreground(scheme, accent),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ShapeBorder _shape(BuildContext context, ColorScheme scheme, Color accent) {
    return switch (variant) {
      WidgetsIconButtonVariant.outline => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      _ => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
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
