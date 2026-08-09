import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:flutter/material.dart';

enum WidgetsAppCardVariant {
  elevated,
  outlined,
  filled,
  transparent,
  food,
  dashboard,
  form,
  plain,
}

/// Default Ayletna card shell for reusable screen content.
///
/// [accentColor] tints the shell border, glow, and background wash.
/// Pass it only for selected or semantic emphasis — not on idle cards.
class WidgetsAppCard extends StatelessWidget {
  const WidgetsAppCard({
    required this.child,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.accentColor,
    this.variant = WidgetsAppCardVariant.outlined,
    this.padding,
    this.onTap,
    super.key,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Color? accentColor;
  final WidgetsAppCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final body = Padding(
      padding: padding ?? EdgeInsets.all(CoreSpacing.lg(context)),
      child:
          _hasHeader
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (leading != null) ...[
                        leading!,
                        SizedBox(width: CoreSpacing.md(context)),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (title != null)
                              Text(
                                title!,
                                style: CoreTypography.titleMedium(
                                  context,
                                  scheme.onSurface,
                                ).copyWith(fontWeight: FontWeight.w800),
                              ),
                            if (subtitle != null)
                              Text(
                                subtitle!,
                                style: CoreTypography.caption(
                                  context,
                                  scheme.onSurfaceVariant,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (trailing != null) ...[
                        SizedBox(width: CoreSpacing.md(context)),
                        trailing!,
                      ],
                    ],
                  ),
                  SizedBox(height: CoreSpacing.md(context)),
                  child,
                ],
              )
              : child,
    );

    final innerRadius = BorderRadius.circular(CoreSpacing.radiusCardOf(context));
    final card = Material(
      color: _background(scheme),
      shape: RoundedRectangleBorder(
        borderRadius: innerRadius,
        side: _side(scheme),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(onTap: onTap, borderRadius: innerRadius, child: body),
    );

    if (variant == WidgetsAppCardVariant.transparent) {
      return card;
    }

    return Padding(
      padding: EdgeInsets.all(_outerMargin(context)),
      child: DecoratedBox(
        decoration: _shellDecoration(context, scheme),
        child: Padding(padding: EdgeInsets.all(_shellInset), child: card),
      ),
    );
  }

  bool get _hasHeader =>
      title != null || subtitle != null || leading != null || trailing != null;

  Color _background(ColorScheme scheme) {
    final base = switch (variant) {
      WidgetsAppCardVariant.food => Color.alphaBlend(
        CoreColors.brandGold.withValues(alpha: 0.06),
        scheme.surface,
      ),
      WidgetsAppCardVariant.form => Color.alphaBlend(
        scheme.primary.withValues(alpha: 0.04),
        scheme.surface,
      ),
      WidgetsAppCardVariant.dashboard => scheme.surface,
      WidgetsAppCardVariant.plain => scheme.surface,
      WidgetsAppCardVariant.filled => scheme.surfaceContainerHighest.withValues(
        alpha: 0.45,
      ),
      WidgetsAppCardVariant.transparent => scheme.surface.withValues(alpha: 0),
      _ => scheme.surface,
    };

    if (accentColor == null) {
      return base;
    }

    return Color.alphaBlend(accentColor!.withValues(alpha: 0.08), base);
  }

  BorderSide _side(ColorScheme scheme) {
    // The outer shell already draws the visible border; an inner Material
    // border stacks on top and reads as a duplicated frame.
    return switch (variant) {
      WidgetsAppCardVariant.transparent => BorderSide(
        color: scheme.outlineVariant,
      ),
      _ => BorderSide.none,
    };
  }

  double _outerMargin(BuildContext context) {
    return switch (variant) {
      WidgetsAppCardVariant.plain => 0,
      _ => UtilitySizer.of(context, 4),
    };
  }

  double get _shellInset {
    return switch (variant) {
      WidgetsAppCardVariant.plain => 0,
      _ => 0,
    };
  }

  BoxDecoration _shellDecoration(BuildContext context, ColorScheme scheme) {
    final radius = BorderRadius.circular(
      CoreSpacing.radiusCardOf(context) + UtilitySizer.of(context, 7),
    );
    final glowColor = _resolvedGlowColor(scheme);
    final useGlow = variant == WidgetsAppCardVariant.food ||
        variant == WidgetsAppCardVariant.elevated;

    return BoxDecoration(
      borderRadius: radius,
      // Quiet shells: border + surface. Glow reserved for food / selected / elevated.
      color: useGlow ? null : scheme.surface,
      gradient: useGlow
          ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _resolvedShellTint(scheme).withValues(
                  alpha: variant == WidgetsAppCardVariant.food ? 0.18 : 0.08,
                ),
                scheme.surface.withValues(alpha: 0.88),
                glowColor.withValues(
                  alpha: variant == WidgetsAppCardVariant.food ? 0.08 : 0.03,
                ),
              ],
            )
          : null,
      border: Border.all(color: _resolvedShellBorder(scheme)),
      boxShadow: [
        if (useGlow)
          BoxShadow(
            color: glowColor.withValues(alpha: _shadowAlpha),
            blurRadius: _shadowBlur(context),
            spreadRadius: -UtilitySizer.of(context, 8),
            offset: Offset(0, UtilitySizer.of(context, 10)),
          ),
        BoxShadow(
          color: scheme.shadow.withValues(alpha: useGlow ? 0.04 : 0.025),
          blurRadius: UtilitySizer.of(context, useGlow ? 16 : 10),
          spreadRadius: -UtilitySizer.of(context, 10),
          offset: Offset(0, UtilitySizer.of(context, 4)),
        ),
      ],
    );
  }

  Color _resolvedShellTint(ColorScheme scheme) {
    if (accentColor != null) {
      return accentColor!;
    }
    return _shellTint(scheme);
  }

  Color _resolvedGlowColor(ColorScheme scheme) {
    if (accentColor != null) {
      return accentColor!;
    }
    return _glowColor(scheme);
  }

  Color _resolvedShellBorder(ColorScheme scheme) {
    if (accentColor != null) {
      return accentColor!.withValues(alpha: 0.40);
    }
    return _shellBorder(scheme);
  }

  Color _shellTint(ColorScheme scheme) {
    return switch (variant) {
      WidgetsAppCardVariant.food => CoreColors.brandGold,
      WidgetsAppCardVariant.form => CoreColors.brandOlive,
      WidgetsAppCardVariant.dashboard => scheme.primary,
      WidgetsAppCardVariant.filled => scheme.secondary,
      WidgetsAppCardVariant.elevated => scheme.primary,
      WidgetsAppCardVariant.outlined => scheme.outlineVariant,
      WidgetsAppCardVariant.plain => scheme.surface,
      WidgetsAppCardVariant.transparent => scheme.surface,
    };
  }

  Color _glowColor(ColorScheme scheme) {
    return switch (variant) {
      WidgetsAppCardVariant.food => CoreColors.brandGold,
      WidgetsAppCardVariant.form => CoreColors.brandOlive,
      WidgetsAppCardVariant.dashboard => scheme.primary,
      WidgetsAppCardVariant.filled => scheme.secondary,
      WidgetsAppCardVariant.elevated => scheme.primary,
      _ => scheme.shadow,
    };
  }

  Color _shellBorder(ColorScheme scheme) {
    return switch (variant) {
      WidgetsAppCardVariant.food => CoreColors.brandGold.withValues(
        alpha: 0.24,
      ),
      WidgetsAppCardVariant.form => CoreColors.brandOlive.withValues(
        alpha: 0.18,
      ),
      WidgetsAppCardVariant.dashboard => scheme.primary.withValues(alpha: 0.16),
      WidgetsAppCardVariant.plain => scheme.surface.withValues(alpha: 0),
      _ => scheme.outlineVariant.withValues(alpha: 0.52),
    };
  }

  double get _shadowAlpha {
    if (accentColor != null) {
      return 0.06;
    }
    return switch (variant) {
      WidgetsAppCardVariant.food => 0.14,
      WidgetsAppCardVariant.form => 0.05,
      WidgetsAppCardVariant.dashboard => 0.04,
      WidgetsAppCardVariant.elevated => 0.06,
      _ => 0.03,
    };
  }

  double _shadowBlur(BuildContext context) {
    final design = switch (variant) {
      WidgetsAppCardVariant.food => 28.0,
      WidgetsAppCardVariant.elevated => 22.0,
      WidgetsAppCardVariant.form => 18.0,
      _ => 16.0,
    };
    return UtilitySizer.of(context, design);
  }
}
