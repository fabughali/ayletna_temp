import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/auth_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD ForgotPasswordScreen.
class AuthForgotPasswordScreen extends ConsumerStatefulWidget {
  const AuthForgotPasswordScreen({super.key});

  @override
  ConsumerState<AuthForgotPasswordScreen> createState() =>
      _AuthForgotPasswordScreenState();
}

class _AuthForgotPasswordScreenState
    extends ConsumerState<AuthForgotPasswordScreen> {
  final _identifierController = TextEditingController();

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  void _sendCode() {
    final l10n = AppLocalizations.of(context)!;
    final ok = ref
        .read(authSessionProvider.notifier)
        .submitForgotPassword(identifier: _identifierController.text);
    if (!ok) {
      UtilityMockFeedback.showError(context, l10n.authForgotIdentifierRequired);
      return;
    }
    context.push('${AppRoutePaths.otp}?source=forgot');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: WidgetsScreenLayout(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: CoreSpacing.xl(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _HeroHeader(l10n: l10n),
                  SizedBox(height: CoreSpacing.xl(context)),
                  _ResetCard(
                    l10n: l10n,
                    identifierController: _identifierController,
                    onSendCode: _sendCode,
                  ),
                  SizedBox(height: CoreSpacing.xl(context)),
                  _SupportFooter(l10n: l10n),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: scheme.surface,
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
            boxShadow: [
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.20),
                blurRadius: CoreSpacing.xl(context),
                offset: Offset(0, CoreSpacing.sm(context)),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
            child: Icon(
              Icons.lock_reset,
              color: scheme.onPrimary,
              size: CoreContentSizes.logoCard(context),
            ),
          ),
        ),
        SizedBox(height: CoreSpacing.xl(context)),
        Text(
          l10n.forgotPasswordTitle,
          textAlign: TextAlign.center,
          style: CoreTypography.headlineLarge(context, scheme.primary),
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: CoreSpacing.xl(context)),
          child: Text(
            l10n.forgotPasswordSubtitle,
            textAlign: TextAlign.center,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

class _ResetCard extends StatelessWidget {
  const _ResetCard({
    required this.l10n,
    required this.identifierController,
    required this.onSendCode,
  });

  final AppLocalizations l10n;
  final TextEditingController identifierController;
  final VoidCallback onSendCode;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.filled,
      padding: EdgeInsets.all(CoreSpacing.xl(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsAppTextField(
            label: l10n.forgotEmailPhoneLabel,
            hintText: l10n.forgotEmailPhoneHint,
            prefixIcon: Icons.contact_mail_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            controller: identifierController,
            onSubmitted: (_) => onSendCode(),
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          WidgetsAppButton(
            label: l10n.forgotSendCode,
            onPressed: onSendCode,
            icon: Icons.arrow_forward,
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          _OrDivider(label: l10n.dineOr),
          SizedBox(height: CoreSpacing.xl(context)),
          WidgetsAppButton(
            label: l10n.forgotBackToLogin,
            onPressed: () => context.go(AppRoutePaths.login),
            icon: Icons.arrow_back,
            variant: WidgetsAppButtonVariant.ghost,
          ),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(child: Divider(color: scheme.outlineVariant)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: CoreSpacing.md(context)),
          child: Text(
            label,
            style: CoreTypography.caption(context, scheme.outline),
          ),
        ),
        Expanded(child: Divider(color: scheme.outlineVariant)),
      ],
    );
  }
}

class _SupportFooter extends StatelessWidget {
  const _SupportFooter({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: CoreSpacing.xs(context),
      children: [
        Text(
          l10n.forgotNeedHelp,
          style: CoreTypography.bodyMedium(context, scheme.outline),
        ),
        WidgetsAppButton(
          label: l10n.forgotContactSupport,
          onPressed: () => context.push(AppRoutePaths.support),
          variant: WidgetsAppButtonVariant.ghost,
        ),
      ],
    );
  }
}
