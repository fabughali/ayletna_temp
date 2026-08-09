import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/auth_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/app_branding_providers.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_brand_lockup.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_loading_ring.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD SplashScreen · Stitch v2 auth-1 (minimal cream, no hero photo).
class AuthSplashScreen extends ConsumerStatefulWidget {
  const AuthSplashScreen({super.key});

  @override
  ConsumerState<AuthSplashScreen> createState() => _AuthSplashScreenState();
}

class _AuthSplashScreenState extends ConsumerState<AuthSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 6), () {
      if (!mounted) {
        return;
      }
      final session = ref.read(sessionProvider);
      final auth = ref.read(authSessionProvider);
      if (session.isPendingApproval) {
        context.go(AppRoutePaths.pendingApproval);
        return;
      }
      if (session.isAuthenticated) {
        final role = ref.read(appRoleProvider);
        context.go(homeRouteForRole(role));
        return;
      }
      if (auth.languageConfirmed) {
        context.go(AppRoutePaths.login);
        return;
      }
      context.go(AppRoutePaths.language);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final branding = ref.watch(appBrandingProvider);

    return WidgetsScaffoldPage(
      showAppBar: false,
      showDrawer: false,
      child: Column(
        children: [
          const Spacer(flex: 3),
          WidgetsBrandLockup(
            showLogo: true,
            headline: branding.slogan(isAr),
            motto: l10n.splashTagline,
          ),
          const Spacer(flex: 3),
          WidgetsLoadingRing(label: l10n.splashInitializing),
        ],
      ),
    );
  }
}
