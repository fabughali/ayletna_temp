import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/auth_session_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD LanguageSelectionScreen.
class AuthLanguageSelectionScreen extends ConsumerWidget {
  const AuthLanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(appLocaleProvider);
    final selectedCode = locale.languageCode;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _LanguageParticlePainter(
                  color: scheme.primary.withValues(alpha: 0.16),
                ),
              ),
            ),
            WidgetsScreenLayout(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    vertical: CoreSpacing.xl(context),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _LanguageHeader(
                            title: l10n.appTitle,
                            welcome: l10n.languageWelcomeTitle,
                            subtitle: l10n.languageWelcomeSubtitle,
                          ),
                          SizedBox(height: CoreSpacing.xl(context)),
                          _LanguageOptionCard(
                            title: l10n.languageArabic,
                            subtitle: l10n.languageArabicSubtitle,
                            emblem: 'ع',
                            selected: selectedCode == 'ar',
                            onTap:
                                () =>
                                    ref
                                        .read(appLocaleProvider.notifier)
                                        .state = const Locale('ar'),
                          ),
                          SizedBox(height: CoreSpacing.sm(context)),
                          _LanguageOptionCard(
                            title: l10n.languageEnglish,
                            subtitle: l10n.languageEnglishSubtitle,
                            emblem: 'EN',
                            selected: selectedCode == 'en',
                            onTap:
                                () =>
                                    ref
                                        .read(appLocaleProvider.notifier)
                                        .state = const Locale('en'),
                          ),
                          SizedBox(height: CoreSpacing.xl(context)),
                          WidgetsAppButton(
                            label: l10n.actionContinue,
                            onPressed: () {
                              ref
                                  .read(authSessionProvider.notifier)
                                  .confirmLanguage();
                              context.go(AppRoutePaths.login);
                            },
                            fullWidth: true,
                          ),
                          SizedBox(height: CoreSpacing.lg(context)),
                          _GatewayFooter(label: l10n.languageAccessGateway),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageHeader extends StatelessWidget {
  const _LanguageHeader({
    required this.title,
    required this.welcome,
    required this.subtitle,
  });

  final String title;
  final String welcome;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: CoreTypography.headlineSmall(
            context,
            scheme.primary,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        Text(
          welcome,
          textAlign: TextAlign.center,
          style: CoreTypography.headlineSmall(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w800),
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _LanguageOptionCard extends StatelessWidget {
  const _LanguageOptionCard({
    required this.title,
    required this.subtitle,
    required this.emblem,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String emblem;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      onTap: onTap,
      accentColor: selected ? scheme.primary : scheme.outlineVariant,
      variant:
          selected
              ? WidgetsAppCardVariant.filled
              : WidgetsAppCardVariant.outlined,
      padding: EdgeInsets.symmetric(
        horizontal: CoreSpacing.md(context),
        vertical: CoreSpacing.sm(context),
      ),
      child: Row(
        children: [
          _LanguageEmblem(label: emblem, selected: selected),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CoreTypography.titleMedium(
                    context,
                    selected ? scheme.primary : scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child:
                selected
                    ? Icon(
                      Icons.check_circle,
                      key: const ValueKey('selected'),
                      color: scheme.primary,
                    )
                    : Icon(
                      Icons.radio_button_unchecked,
                      key: const ValueKey('idle'),
                      color: scheme.outline,
                    ),
          ),
        ],
      ),
    );
  }
}

class _LanguageEmblem extends StatelessWidget {
  const _LanguageEmblem({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = CoreContentSizes.logoCard(context) * 0.88;

    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [
            selected ? scheme.primary : scheme.inverseSurface,
            selected ? scheme.primaryContainer : scheme.surfaceContainerHighest,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.16),
            blurRadius: CoreSpacing.lg(context),
            offset: Offset(0, CoreSpacing.xs(context)),
          ),
        ],
      ),
      child: SizedBox.square(
        dimension: size,
        child: Center(
          child: Text(
            label,
            style: CoreTypography.headlineSmall(
              context,
              selected ? scheme.onPrimary : scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}

class _GatewayFooter extends StatelessWidget {
  const _GatewayFooter({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.public, color: scheme.onSurfaceVariant),
        SizedBox(width: CoreSpacing.md(context)),
        Text(
          label,
          style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _LanguageParticlePainter extends CustomPainter {
  const _LanguageParticlePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final points = [
      Offset(size.width * 0.06, size.height * 0.12),
      Offset(size.width * 0.22, size.height * 0.08),
      Offset(size.width * 0.88, size.height * 0.16),
      Offset(size.width * 0.94, size.height * 0.46),
      Offset(size.width * 0.12, size.height * 0.58),
      Offset(size.width * 0.78, size.height * 0.70),
      Offset(size.width * 0.36, size.height * 0.82),
    ];

    for (final point in points) {
      canvas.drawCircle(point, 2.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _LanguageParticlePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
