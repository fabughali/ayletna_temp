import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Active UI role for [CoreTheme.themeFor].
final appRoleProvider = StateProvider<AppRole>((ref) => AppRole.customer);

/// Default Arabic per PRD.
final appLocaleProvider = StateProvider<Locale>((ref) => const Locale('ar'));
