import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/auth_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_logo_icon.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Staff registration pending operator approval (PRD §3.2).
class AuthPendingApprovalScreen extends ConsumerWidget {
  const AuthPendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: WidgetsScreenLayout(
          child: Column(
            children: [
              SizedBox(height: CoreSpacing.xxl(context)),
              WidgetsLogoIcon(size: CoreContentSizes.logoCard(context)),
              SizedBox(height: CoreSpacing.xl(context)),
              WidgetsAppCard(
                child: Column(
                  children: [
                    Text(
                      l10n.screenPendingApproval,
                      textAlign: TextAlign.center,
                      style: CoreTypography.headlineSmall(
                        context,
                        theme.colorScheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.md(context)),
                    WidgetsInfoBanner(
                      tone: WidgetsInfoBannerTone.info,
                      message: l10n.pendingApprovalNote,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              WidgetsAppButton(
                label: l10n.actionSignOut,
                onPressed: () {
                  ref.read(sessionProvider.notifier).signOut();
                  ref.read(authSessionProvider.notifier).reset();
                  context.go(AppRoutePaths.login);
                },
              ),
              SizedBox(height: CoreSpacing.lg(context)),
            ],
          ),
        ),
      ),
    );
  }
}
