import 'package:ayletna_restaurant_app/core/core_theme.dart';
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

    final content =
        accentColor == null
            ? body
            : IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(color: accentColor),
                    child: SizedBox(
                      width: CoreContentSizes.financialIndicatorWidth(context),
                    ),
                  ),
                  Expanded(child: body),
                ],
              ),
            );

    final innerRadius = BorderRadius.circular(CoreSpacing.radiusCard);
    final card = Material(
      color: _background(scheme),
      shape: RoundedRectangleBorder(
        borderRadius: innerRadius,
        side: _side(scheme),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(onTap: onTap, borderRadius: innerRadius, child: content),
    );

    if (variant == WidgetsAppCardVariant.transparent) {
      return card;
    }

    return Padding(
      padding: EdgeInsets.all(_outerMargin),
      child: DecoratedBox(
        decoration: _shellDecoration(scheme),
        child: Padding(padding: EdgeInsets.all(_shellInset), child: card),
      ),
    );
  }

  bool get _hasHeader =>
      title != null || subtitle != null || leading != null || trailing != null;

  Color _background(ColorScheme scheme) {
    return switch (variant) {
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
  }

  BorderSide _side(ColorScheme scheme) {
    return switch (variant) {
      WidgetsAppCardVariant.food => BorderSide(
        color: CoreColors.brandGold.withValues(alpha: 0.24),
      ),
      WidgetsAppCardVariant.form => BorderSide(
        color: scheme.primary.withValues(alpha: 0.18),
      ),
      WidgetsAppCardVariant.dashboard => BorderSide(
        color: scheme.outlineVariant,
      ),
      WidgetsAppCardVariant.plain => BorderSide.none,
      WidgetsAppCardVariant.outlined => BorderSide(
        color: scheme.outlineVariant,
      ),
      WidgetsAppCardVariant.transparent => BorderSide(
        color: scheme.outlineVariant,
      ),
      _ => BorderSide.none,
    };
  }

  double get _outerMargin {
    return switch (variant) {
      WidgetsAppCardVariant.plain => 0,
      _ => 4,
    };
  }

  double get _shellInset {
    return switch (variant) {
      WidgetsAppCardVariant.plain => 0,
      WidgetsAppCardVariant.dashboard => 1,
      _ => 2,
    };
  }

  BoxDecoration _shellDecoration(ColorScheme scheme) {
    final radius = BorderRadius.circular(CoreSpacing.radiusCard + 7);
    final glowColor = _glowColor(scheme);

    return BoxDecoration(
      borderRadius: radius,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          _shellTint(scheme).withValues(alpha: 0.22),
          scheme.surface.withValues(alpha: 0.74),
          glowColor.withValues(alpha: 0.10),
        ],
      ),
      border: Border.all(color: _shellBorder(scheme)),
      boxShadow: [
        if (variant != WidgetsAppCardVariant.plain)
          BoxShadow(
            color: glowColor.withValues(alpha: _shadowAlpha),
            blurRadius: _shadowBlur,
            spreadRadius: -8,
            offset: const Offset(0, 14),
          ),
        BoxShadow(
          color: scheme.shadow.withValues(alpha: 0.035),
          blurRadius: 18,
          spreadRadius: -12,
          offset: const Offset(0, 8),
        ),
      ],
    );
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
    return switch (variant) {
      WidgetsAppCardVariant.food => 0.16,
      WidgetsAppCardVariant.form => 0.12,
      WidgetsAppCardVariant.dashboard => 0.10,
      WidgetsAppCardVariant.elevated => 0.14,
      _ => 0.07,
    };
  }

  double get _shadowBlur {
    return switch (variant) {
      WidgetsAppCardVariant.food => 34,
      WidgetsAppCardVariant.elevated => 32,
      WidgetsAppCardVariant.form => 26,
      _ => 22,
    };
  }
}
