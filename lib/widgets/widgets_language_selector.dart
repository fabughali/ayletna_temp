import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Language preferences block for settings and onboarding flows.
class WidgetsLanguagePreferencesSection extends ConsumerWidget {
  const WidgetsLanguagePreferencesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final selectedCode = ref.watch(appLocaleProvider).languageCode;

    return WidgetsAppCard(
      title: l10n.screenLanguageSelection,
      leading: Icon(Icons.language_outlined, color: scheme.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.selectLanguageSubtitle,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsLanguageOptionCard(
            title: l10n.languageArabic,
            subtitle: l10n.languageArabicSubtitle,
            selected: selectedCode == 'ar',
            onTap: () => _setLocale(ref, const Locale('ar')),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsLanguageOptionCard(
            title: l10n.languageEnglish,
            subtitle: l10n.languageEnglishSubtitle,
            selected: selectedCode == 'en',
            onTap: () => _setLocale(ref, const Locale('en')),
          ),
        ],
      ),
    );
  }

  void _setLocale(WidgetRef ref, Locale locale) {
    if (ref.read(appLocaleProvider) == locale) {
      return;
    }
    ref.read(appLocaleProvider.notifier).state = locale;
  }
}

/// Selectable language row used in onboarding and settings.
class WidgetsLanguageOptionCard extends StatelessWidget {
  const WidgetsLanguageOptionCard({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      onTap: onTap,
      accentColor: selected ? scheme.primary : null,
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


