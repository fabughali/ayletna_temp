import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Guest ProductPreviewModal.
class WidgetsProductPreviewSheet {
  static Future<void> show(BuildContext context) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Theme.of(context).colorScheme.scrim.withValues(alpha: 0.40),
      transitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (ctx, animation, secondaryAnimation) {
        return const _ProductPreviewDialog();
      },
      transitionBuilder: (ctx, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.94, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}

class _ProductPreviewDialog extends StatelessWidget {
  const _ProductPreviewDialog();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(CoreSpacing.lg(context)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Material(
              color: scheme.surfaceContainerLowest,
              elevation: 12,
              shadowColor: scheme.shadow.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      CoreSpacing.xl(context),
                      CoreSpacing.xl(context),
                      CoreSpacing.xl(context),
                      CoreSpacing.lg(context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.previewProductTitle,
                          style: CoreTypography.headlineSmall(
                            context,
                            scheme.onSurface,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: CoreSpacing.md(context)),
                        Row(
                          children: [
                            Text(
                              l10n.previewPrice,
                              style: CoreTypography.headlineSmall(
                                context,
                                scheme.primary,
                              ).copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.4,
                              ),
                            ),
                            SizedBox(width: CoreSpacing.md(context)),
                            WidgetsStatusPill(
                              label: l10n.previewTaxIncluded,
                              color: scheme.onSurfaceVariant,
                              compact: true,
                            ),
                          ],
                        ),
                        SizedBox(height: CoreSpacing.lg(context)),
                        Text(
                          l10n.previewProductBody,
                          style: CoreTypography.bodyMedium(
                            context,
                            scheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: CoreSpacing.xl(context)),
                        _SectionLabel(label: l10n.previewPreferredBase),
                        SizedBox(height: CoreSpacing.md(context)),
                        Row(
                          children: [
                            Expanded(
                              child: _BaseOption(
                                label: l10n.previewToastedSourdough,
                                selected: true,
                              ),
                            ),
                            SizedBox(width: CoreSpacing.sm(context)),
                            Expanded(
                              child: _BaseOption(
                                label: l10n.previewMultigrainToast,
                                selected: false,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: CoreSpacing.xl(context)),
                        _SectionLabel(label: l10n.previewAddOns),
                        SizedBox(height: CoreSpacing.md(context)),
                        _PreviewAddon(
                          label: l10n.previewExtraSmokedSalmon,
                          price: l10n.previewSalmonPrice,
                        ),
                        SizedBox(height: CoreSpacing.sm(context)),
                        _PreviewAddon(
                          label: l10n.previewDoubleAvocado,
                          price: l10n.previewAvocadoPrice,
                        ),
                        SizedBox(height: CoreSpacing.xl(context)),
                        _SectionLabel(label: l10n.previewDietaryNotes),
                        SizedBox(height: CoreSpacing.md(context)),
                        _DietaryNote(message: l10n.previewDietaryMessage),
                        SizedBox(height: CoreSpacing.xl(context)),
                        WidgetsAppButton(
                          label: l10n.previewLoginAddCart,
                          onPressed: () {
                            Navigator.of(context).pop();
                            context.push(AppRoutePaths.login);
                          },
                          icon: Icons.login,
                        ),
                        SizedBox(height: CoreSpacing.md(context)),
                        Center(
                          child: Wrap(
                            spacing: CoreSpacing.xs(context),
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                Icons.circle,
                                size: CoreSpacing.sm(context),
                                color: scheme.outlineVariant,
                              ),
                              Text(
                                l10n.previewNewToApp,
                                style: CoreTypography.caption(
                                  context,
                                  scheme.onSurfaceVariant,
                                ),
                              ),
                              WidgetsAppButton(
                                label: l10n.previewCreateAccount,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  context.push(AppRoutePaths.register);
                                },
                                variant: WidgetsAppButtonVariant.ghost,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    top: CoreSpacing.md(context),
                    end: CoreSpacing.md(context),
                    child: WidgetsIconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icons.close,
                      tooltip:
                          MaterialLocalizations.of(context).closeButtonTooltip,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Text(
      label.toUpperCase(),
      style: CoreTypography.caption(
        context,
        scheme.onSurface,
      ).copyWith(fontWeight: FontWeight.w900, letterSpacing: 1.3),
    );
  }
}

class _BaseOption extends StatelessWidget {
  const _BaseOption({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = selected ? scheme.primary : scheme.outlineVariant;

    return DecoratedBox(
      decoration: BoxDecoration(
        color:
            selected
                ? scheme.primaryContainer.withValues(alpha: 0.08)
                : scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
        border: Border.all(color: color, width: selected ? 2 : 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: CoreTypography.bodyMedium(
                  context,
                  selected ? scheme.onSurface : scheme.onSurfaceVariant,
                ),
              ),
            ),
            Icon(
              selected ? Icons.check_circle_outline : Icons.circle_outlined,
              color: selected ? scheme.primary : scheme.outline,
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewAddon extends StatelessWidget {
  const _PreviewAddon({required this.label, required this.price});

  final String label;
  final String price;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        child: Row(
          children: [
            Icon(Icons.add_circle_outline, color: scheme.outline),
            SizedBox(width: CoreSpacing.md(context)),
            Expanded(
              child: Text(
                label,
                style: CoreTypography.bodyMedium(context, scheme.onSurface),
              ),
            ),
            Text(
              price,
              textAlign: TextAlign.end,
              style: CoreTypography.caption(
                context,
                scheme.onSurfaceVariant,
              ).copyWith(letterSpacing: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}

class _DietaryNote extends StatelessWidget {
  const _DietaryNote({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        child: Text(
          message,
          style: CoreTypography.bodyMedium(
            context,
            scheme.onSurfaceVariant,
          ).copyWith(fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
