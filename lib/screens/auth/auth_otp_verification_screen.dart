import 'dart:async';

import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/auth_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_otp_input.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_phone_text.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD OTPVerificationScreen.
class AuthOtpVerificationScreen extends ConsumerWidget {
  const AuthOtpVerificationScreen({required this.source, super.key});

  final String source;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final otpSource = authOtpSourceFromQuery(source);

    Future<void> completeVerification(String code) async {
      final l10n = AppLocalizations.of(context)!;
      final auth = ref.read(authSessionProvider.notifier);
      final verified = await auth.verifyOtp(code);
      if (!context.mounted) {
        return;
      }
      if (!verified) {
        UtilityMockFeedback.showError(context, l10n.authOtpInvalid);
        return;
      }

      if (otpSource == AuthOtpFlowSource.register) {
        final authState = ref.read(authSessionProvider);
        if (authState.isOperationalRegistration) {
          ref.read(sessionProvider.notifier).signInPendingApproval();
          ref.read(authSessionProvider.notifier).reset();
          context.go(AppRoutePaths.pendingApproval);
          return;
        }
        context.go('${AppRoutePaths.register}?step=3');
        return;
      }
      if (otpSource == AuthOtpFlowSource.forgot) {
        UtilityMockFeedback.showSuccess(context, l10n.authPasswordResetSuccess);
        auth.reset();
        context.go(AppRoutePaths.login);
        return;
      }

      ref.read(sessionProvider.notifier).signIn();
      final session = ref.read(sessionProvider);
      ref.read(appRoleProvider.notifier).state = session.approvedRoles.first;
      context.go(routeAfterLoginVerification(session));
    }

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            PositionedDirectional(
              top: -CoreSpacing.xxl(context),
              end: -CoreSpacing.xxl(context),
              child: _GlowOrb(color: scheme.primary),
            ),
            PositionedDirectional(
              bottom: CoreSpacing.xxl(context),
              start: -CoreSpacing.xxl(context),
              child: _GlowOrb(color: CoreColors.orderTypePlated),
            ),
            WidgetsScreenLayout(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    vertical: CoreSpacing.xxl(context),
                  ),
                  child: AuthOtpCard(
                    source: otpSource,
                    onVerify: completeVerification,
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

class AuthOtpCard extends ConsumerStatefulWidget {
  const AuthOtpCard({
    required this.source,
    required this.onVerify,
    this.showBackButton = true,
    this.showSignupProgress = true,
    super.key,
  });

  final AuthOtpFlowSource source;
  final Future<void> Function(String code) onVerify;
  final bool showBackButton;
  final bool showSignupProgress;

  @override
  ConsumerState<AuthOtpCard> createState() => _AuthOtpCardState();
}

class _AuthOtpCardState extends ConsumerState<AuthOtpCard> {
  static const int _initialCountdownSeconds = 56;

  Timer? _timer;
  int _remainingSeconds = _initialCountdownSeconds;
  String _otpCode = '';

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }

      if (_remainingSeconds <= 1) {
        _timer?.cancel();
        setState(() => _remainingSeconds = 0);
        return;
      }

      setState(() => _remainingSeconds -= 1);
    });
  }

  void _resendCode() {
    final l10n = AppLocalizations.of(context)!;
    final auth = ref.read(authSessionProvider.notifier);
    final sent = auth.resendOtp();
    if (!sent) {
      return;
    }
    setState(() => _remainingSeconds = _initialCountdownSeconds);
    _startCountdown();
    UtilityMockFeedback.showSuccess(context, l10n.authOtpResent);
  }

  Future<void> _submitVerification() async {
    await widget.onVerify(_otpCode);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final authState = ref.watch(authSessionProvider);
    final resendAttempts = authState.resendCount;
    final maskedPhone = l10n.otpMaskedPhone;

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
            if (widget.showBackButton) ...[
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: WidgetsAppButton(
                  label:
                      widget.source == AuthOtpFlowSource.register
                          ? l10n.actionRegister
                          : l10n.screenLogin,
                  onPressed:
                      () => context.go(authOtpBackRoute(widget.source)),
                  icon: Icons.arrow_back,
                  variant: WidgetsAppButtonVariant.ghost,
                ),
              ),
              SizedBox(height: CoreSpacing.xl(context)),
            ],
            if (widget.source == AuthOtpFlowSource.register &&
                widget.showSignupProgress) ...[
              const _SignupOtpProgress(),
              SizedBox(height: CoreSpacing.xl(context)),
            ],
            const _OtpHeroIcon(),
            SizedBox(height: CoreSpacing.xl(context)),
            Text(
              l10n.otpTitle,
              textAlign: TextAlign.center,
              style: CoreTypography.headlineLarge(
                context,
                scheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsMixedPhoneText(
              prefix: _messagePrefix(
                l10n.otpSentCode(maskedPhone),
                maskedPhone,
              ),
              phone: maskedPhone,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: CoreSpacing.xxl(context)),
            WidgetsOtpInput(
              onCompleted: (code) {
                setState(() => _otpCode = code);
              },
            ),
            SizedBox(height: CoreSpacing.xl(context)),
            _ResendCountdownAction(
              remainingSeconds: _remainingSeconds,
              resendAttempts: resendAttempts,
              maxResendAttempts: AuthSessionNotifier.maxResendAttempts,
              onResend: _resendCode,
            ),
            SizedBox(height: CoreSpacing.xxl(context)),
            WidgetsAppButton(
              label: l10n.actionVerify,
              onPressed: authState.isVerifyingOtp ? null : _submitVerification,
              icon:
                  authState.isVerifyingOtp
                      ? null
                      : Icons.verified_user_outlined,
            ),
            SizedBox(height: CoreSpacing.xxl(context)),
            const Divider(),
            SizedBox(height: CoreSpacing.lg(context)),
            _SecurityNote(label: l10n.otpSecurityNote),
          ],
        ),
      ),
    );
  }
}

class _SignupOtpProgress extends StatelessWidget {
  const _SignupOtpProgress();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          l10n.registerStepTwoTitle,
          textAlign: TextAlign.center,
          style: CoreTypography.caption(
            context,
            scheme.primary,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        Row(
          children: [
            Expanded(child: _SignupProgressMark(color: scheme.primary)),
            SizedBox(width: CoreSpacing.lg(context)),
            Expanded(child: _SignupProgressMark(color: scheme.primary)),
            SizedBox(width: CoreSpacing.lg(context)),
            Expanded(child: _SignupProgressMark(color: scheme.outlineVariant)),
          ],
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        Text(
          l10n.registerStepTwoLabel,
          textAlign: TextAlign.center,
          style: CoreTypography.caption(
            context,
            scheme.onSurfaceVariant,
          ).copyWith(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _SignupProgressMark extends StatelessWidget {
  const _SignupProgressMark({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
      ),
      child: SizedBox(height: CoreContentSizes.splashDividerHeight(context)),
    );
  }
}

class _ResendCountdownAction extends StatelessWidget {
  const _ResendCountdownAction({
    required this.remainingSeconds,
    required this.resendAttempts,
    required this.maxResendAttempts,
    required this.onResend,
  });

  final int remainingSeconds;
  final int resendAttempts;
  final int maxResendAttempts;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final canResend =
        remainingSeconds == 0 && resendAttempts < maxResendAttempts;

    if (canResend) {
      return Align(
        alignment: Alignment.center,
        child: WidgetsAppButton(
          label: l10n.otpResendCode,
          onPressed: onResend,
          icon: Icons.refresh_outlined,
          variant: WidgetsAppButtonVariant.ghost,
        ),
      );
    }

    return Text(
      remainingSeconds == 0
          ? l10n.otpResendLimitReached
          : l10n.otpResendIn(_formattedCountdown),
      textAlign: TextAlign.center,
      style: CoreTypography.bodyMedium(
        context,
        scheme.onSurfaceVariant,
      ).copyWith(fontWeight: FontWeight.w700),
    );
  }

  String get _formattedCountdown {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

String _messagePrefix(String message, String phone) {
  final index = message.indexOf(phone);
  if (index == -1) {
    return message;
  }
  return message.substring(0, index);
}

class _OtpHeroIcon extends StatelessWidget {
  const _OtpHeroIcon();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.primaryContainer.withValues(alpha: 0.40),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        ),
        child: SizedBox.square(
          dimension: CoreContentSizes.logoCard(context) * 1.35,
          child: Icon(
            Icons.vibration,
            color: scheme.primary,
            size: CoreContentSizes.productHeroIcon(context) * 0.58,
          ),
        ),
      ),
    );
  }
}

class _SecurityNote extends StatelessWidget {
  const _SecurityNote({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        WidgetsAvatar(
          icon: Icons.security_outlined,
          color: scheme.onSurfaceVariant,
        ),
        SizedBox(width: CoreSpacing.md(context)),
        Expanded(
          child: Text(
            label,
            style: CoreTypography.bodyMedium(
              context,
              scheme.onSurfaceVariant,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: CoreSpacing.xxl(context),
            spreadRadius: CoreSpacing.xxl(context),
          ),
        ],
      ),
      child: SizedBox.square(
        dimension: CoreContentSizes.categoryHeroHeight(context),
      ),
    );
  }
}
