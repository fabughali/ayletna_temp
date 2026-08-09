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
///
/// Height matches single-line [WidgetsAppTextField] via [CoreThemeExtensions.buttonMinHeight].
class WidgetsAppButton extends StatelessWidget {
  const WidgetsAppButton({
    required this.label,
    required this.onPressed,
    this.variant = WidgetsAppButtonVariant.primary,
    this.icon,
    this.iconAlignment = IconAlignment.start,
    this.fullWidth = false,
    this.compact = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final WidgetsAppButtonVariant variant;
  final IconData? icon;
  final IconAlignment iconAlignment;
  final bool fullWidth;

  /// Size width to the label (for Wrap / inline action rows).
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final controlH = context.coreTheme.buttonMinHeight;
    final labelStyle = CoreTypography.bodyMedium(
      context,
      _foreground(scheme),
    ).copyWith(fontWeight: FontWeight.w700, height: 1.2);
    final iconSize = CoreContentSizes.buttonIcon(context);
    final padH =
        compact
            ? context.coreTheme.buttonPaddingH * 0.72
            : context.coreTheme.buttonPaddingH;
    // Never put infinity into minimumSize — inside Expanded/Row that creates
    // invalid BoxConstraints. fullWidth is handled by width sizing below.
    final minimumSize = Size(0, controlH);
    final maximumSize = Size(double.infinity, controlH);
    // Size.fromHeight uses infinite width — keep that for default (Column) layout.
    // compact omits fixed width so Wrap/Row actions size to their labels.
    final Size? fixedSize =
        fullWidth
            ? Size.fromHeight(controlH)
            : compact
            ? null
            : Size.fromHeight(controlH);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
    );
    final foreground = _foreground(scheme);
    final background = _background(scheme);
    final side = _side(scheme);

    ButtonStyle baseStyle({
      required Color fg,
      Color? bg,
      BorderSide? border,
    }) {
      return ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(fg),
        backgroundColor: bg == null ? null : WidgetStatePropertyAll(bg),
        textStyle: WidgetStatePropertyAll(labelStyle),
        minimumSize: WidgetStatePropertyAll(minimumSize),
        maximumSize: WidgetStatePropertyAll(maximumSize),
        fixedSize:
            fixedSize == null ? null : WidgetStatePropertyAll(fixedSize),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: padH),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity:
            compact ? VisualDensity.compact : VisualDensity.standard,
        shape: WidgetStatePropertyAll(shape),
        side: border == null ? null : WidgetStatePropertyAll(border),
      );
    }

    final child =
        icon == null
            ? Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: labelStyle,
            )
            : null;

    final Widget button = switch (variant) {
      WidgetsAppButtonVariant.outline =>
        icon == null
            ? OutlinedButton(
              onPressed: onPressed,
              style: baseStyle(fg: foreground, border: side),
              child: child!,
            )
            : OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: iconSize),
              iconAlignment: iconAlignment,
              label: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: labelStyle,
              ),
              style: baseStyle(fg: foreground, border: side),
            ),
      WidgetsAppButtonVariant.ghost =>
        icon == null
            ? TextButton(
              onPressed: onPressed,
              style: baseStyle(fg: foreground),
              child: child!,
            )
            : TextButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: iconSize),
              iconAlignment: iconAlignment,
              label: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: labelStyle,
              ),
              style: baseStyle(fg: foreground),
            ),
      WidgetsAppButtonVariant.primary ||
      WidgetsAppButtonVariant.secondary ||
      WidgetsAppButtonVariant.danger ||
      WidgetsAppButtonVariant.success =>
        icon == null
            ? FilledButton(
              onPressed: onPressed,
              style: baseStyle(fg: foreground, bg: background),
              child: child!,
            )
            : FilledButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: iconSize),
              iconAlignment: iconAlignment,
              label: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: labelStyle,
              ),
              style: baseStyle(fg: foreground, bg: background),
            ),
    };

    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: label,
      child:
          fullWidth
              ? SizedBox(width: double.infinity, child: button)
              : button,
    );
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
