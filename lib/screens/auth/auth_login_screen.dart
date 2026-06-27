import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/auth_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD LoginScreen.
class AuthLoginScreen extends ConsumerStatefulWidget {
  const AuthLoginScreen({super.key});

  @override
  ConsumerState<AuthLoginScreen> createState() => _AuthLoginScreenState();
}

class _AuthLoginScreenState extends ConsumerState<AuthLoginScreen> {
  bool _obscurePassword = true;
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    final l10n = AppLocalizations.of(context)!;
    final ok = ref.read(authSessionProvider.notifier).submitLogin(
      identifier: _identifierController.text,
      password: _passwordController.text,
    );
    if (!ok) {
      UtilityMockFeedback.showError(context, l10n.authLoginRequiredFields);
      return;
    }
    context.push('${AppRoutePaths.otp}?source=login');
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _LoginBackgroundPainter(
                  primary: scheme.primary,
                  tertiary: scheme.tertiary,
                ),
              ),
            ),
            WidgetsScreenLayout(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    vertical: CoreSpacing.xxl(context),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _LoginCard(
                        identifierController: _identifierController,
                        passwordController: _passwordController,
                        obscurePassword: _obscurePassword,
                        onTogglePassword:
                            () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                        onLogin: _submitLogin,
                        onForgotPassword:
                            () => context.push(AppRoutePaths.forgotPassword),
                        onGuest: () {
                          ref.read(appRoleProvider.notifier).state =
                              AppRole.guest;
                          context.go(AppRoutePaths.home);
                        },
                        onRegister: () => context.push(AppRoutePaths.register),
                      ),
                      SizedBox(height: CoreSpacing.xl(context)),
                      const _TrustIndicators(),
                    ],
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

class _LoginCard extends StatelessWidget {
  const _LoginCard({
    required this.identifierController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.onLogin,
    required this.onForgotPassword,
    required this.onGuest,
    required this.onRegister,
  });

  final TextEditingController identifierController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;
  final VoidCallback onGuest;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: CoreContentSizes.authCardMaxWidth(context),
      ),
      child: WidgetsAppCard(
        variant: WidgetsAppCardVariant.elevated,
        padding: EdgeInsets.all(CoreSpacing.xl(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.loginWelcomeBack,
              textAlign: TextAlign.center,
              style: CoreTypography.headlineLarge(
                context,
                scheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w800),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            Text(
              l10n.loginOperationalSubtitle,
              textAlign: TextAlign.center,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: CoreSpacing.xl(context)),
            WidgetsAppTextField(
              label: l10n.loginPhoneOrEmail,
              hintText: l10n.loginEmailHint,
              prefixIcon: Icons.alternate_email,
              keyboardType: TextInputType.emailAddress,
              controller: identifierController,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAppTextField(
              label: l10n.fieldPassword,
              hintText: l10n.loginPasswordHint,
              prefixIcon: Icons.lock_outline,
              showLabel: false,
              controller: passwordController,
              suffixIcon: WidgetsIconButton(
                onPressed: onTogglePassword,
                icon:
                    obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                tooltip: l10n.fieldPassword,
              ),
              obscureText: obscurePassword,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => onLogin(),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: WidgetsAppButton(
                label: l10n.actionForgotPassword,
                onPressed: onForgotPassword,
                variant: WidgetsAppButtonVariant.ghost,
              ),
            ),
            SizedBox(height: CoreSpacing.xl(context)),
            WidgetsAppButton(
              label: l10n.loginAction,
              onPressed: onLogin,
              icon: Icons.arrow_forward,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _DividerLabel(label: l10n.loginOr),
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAppButton(
              label: l10n.loginContinueGuest,
              onPressed: onGuest,
              variant: WidgetsAppButtonVariant.outline,
              icon: Icons.person_pin_circle_outlined,
            ),
            SizedBox(height: CoreSpacing.xl(context)),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: CoreSpacing.xs(context),
              children: [
                Text(
                  l10n.loginNoAccount,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
                WidgetsAppButton(
                  label: l10n.actionRegister,
                  onPressed: onRegister,
                  variant: WidgetsAppButtonVariant.ghost,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DividerLabel extends StatelessWidget {
  const _DividerLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: CoreSpacing.lg(context)),
          child: Text(
            label,
            style: CoreTypography.bodyMedium(
              context,
              scheme.onSurfaceVariant,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class _TrustIndicators extends StatelessWidget {
  const _TrustIndicators();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _TrustIndicator(
          icon: Icons.enhanced_encryption_outlined,
          label: l10n.loginTrustSecure,
        ),
        _TrustIndicator(
          icon: Icons.cloud_done_outlined,
          label: l10n.loginTrustCloudSync,
        ),
        _TrustIndicator(
          icon: Icons.support_agent_outlined,
          label: l10n.loginTrustSupport,
        ),
      ],
    );
  }
}

class _TrustIndicator extends StatelessWidget {
  const _TrustIndicator({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Opacity(
      opacity: 0.58,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: scheme.onSurfaceVariant),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            label,
            textAlign: TextAlign.center,
            style: CoreTypography.caption(
              context,
              scheme.onSurfaceVariant,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _LoginBackgroundPainter extends CustomPainter {
  const _LoginBackgroundPainter({
    required this.primary,
    required this.tertiary,
  });

  final Color primary;
  final Color tertiary;

  @override
  void paint(Canvas canvas, Size size) {
    final primaryPaint = Paint()..color = primary.withValues(alpha: 0.06);
    final tertiaryPaint = Paint()..color = tertiary.withValues(alpha: 0.06);

    canvas.drawCircle(
      Offset(size.width * 0.02, size.height * 0.08),
      size.shortestSide * 0.34,
      primaryPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.98, size.height * 0.92),
      size.shortestSide * 0.32,
      tertiaryPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _LoginBackgroundPainter oldDelegate) {
    return oldDelegate.primary != primary || oldDelegate.tertiary != tertiary;
  }
}
