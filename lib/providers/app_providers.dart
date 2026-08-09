import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Active UI role for [CoreTheme.themeFor] and hub routing.
/// Default [AppRole.customer] — use login demo hubs or role selection for management roles.
final appRoleProvider = StateProvider<AppRole>((ref) => AppRole.customer);

/// Default Arabic per PRD.
final appLocaleProvider = StateProvider<Locale>((ref) => const Locale('ar'));

/// App appearance. Defaults to system; settings can force light/dark.
final appThemeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
