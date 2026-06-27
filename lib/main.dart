import 'package:ayletna_restaurant_app/core/core_router.dart';
import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:virtual_keypad/virtual_keypad.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeKeyboardLayouts();
  runApp(const ProviderScope(child: AyletnaRestaurantApp()));
}

class AyletnaRestaurantApp extends ConsumerWidget {
  const AyletnaRestaurantApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(appRoleProvider);
    final locale = ref.watch(appLocaleProvider);
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Ayletna Restaurant',
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supported) {
        if (locale != null) {
          for (final s in supported) {
            if (s.languageCode == locale.languageCode) return s;
          }
        }
        return const Locale('ar');
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: CoreTheme.themeFor(role, Brightness.light),
      darkTheme: CoreTheme.themeFor(role, Brightness.dark),
      themeMode: ThemeMode.system,
      routerConfig: router,
      builder: (context, child) {
        final width = MediaQuery.sizeOf(context).width;
        final brightness = Theme.of(context).brightness;
        return Theme(
          data: CoreTheme.themeFor(role, brightness, width: width),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
