import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/auth_session_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_brand_lockup.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_language_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD LanguageSelectionScreen · Stitch v2 auth-1.
class AuthLanguageSelectionScreen extends ConsumerWidget {
  const AuthLanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectedCode = ref.watch(appLocaleProvider).languageCode;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsScaffoldPage(
      showAppBar: false,
      showDrawer: false,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: CoreSpacing.xl(context)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WidgetsBrandLockup(
                  headline: l10n.languageWelcomeTitle,
                  motto: l10n.languageWelcomeSubtitle,
                  showWordmark: true,
                ),
                SizedBox(height: CoreSpacing.xl(context)),
                WidgetsLanguageOptionCard(
                  title: l10n.languageEnglish,
                  subtitle: l10n.languageEnglishSubtitle,
                  selected: selectedCode == 'en',
                  onTap:
                      () =>
                          ref
                              .read(appLocaleProvider.notifier)
                              .state = const Locale('en'),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                WidgetsLanguageOptionCard(
                  title: l10n.languageArabic,
                  subtitle: l10n.languageArabicSubtitle,
                  selected: selectedCode == 'ar',
                  onTap:
                      () =>
                          ref
                              .read(appLocaleProvider.notifier)
                              .state = const Locale('ar'),
                ),
                SizedBox(height: CoreSpacing.xl(context)),
                WidgetsAppButton(
                  label: l10n.actionContinue,
                  onPressed: () {
                    ref.read(authSessionProvider.notifier).confirmLanguage();
                    context.go(AppRoutePaths.login);
                  },
                  fullWidth: true,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.public, color: scheme.onSurfaceVariant),
                    SizedBox(width: CoreSpacing.md(context)),
                    Text(
                      l10n.languageAccessGateway,
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
