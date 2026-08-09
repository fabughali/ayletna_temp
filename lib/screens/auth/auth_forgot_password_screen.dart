import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/auth_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_form_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
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

    return WidgetsScaffoldPage(
      showAppBar: false,
      showDrawer: false,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: CoreSpacing.xl(context)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (context.canPop()) ...[
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: CoreSpacing.lg(context),
                      bottom: CoreSpacing.md(context),
                    ),
                    child: WidgetsIconButton(
                      onPressed: () => context.pop(),
                      icon: Icons.arrow_back,
                      tooltip:
                          MaterialLocalizations.of(context).backButtonTooltip,
                    ),
                  ),
                ),
              ],
              WidgetsFormCard(
            title: l10n.forgotPasswordTitle,
            subtitle: l10n.forgotPasswordSubtitle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WidgetsAppTextField(
                  label: l10n.forgotEmailPhoneLabel,
                  hintText: l10n.forgotEmailPhoneHint,
                  prefixIcon: Icons.contact_mail_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  controller: _identifierController,
                  onSubmitted: (_) => _sendCode(),
                ),
                SizedBox(height: CoreSpacing.xl(context)),
                WidgetsAppButton(
                  label: l10n.forgotSendCode,
                  onPressed: _sendCode,
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
          ),
            ],
          ),
        ),
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
