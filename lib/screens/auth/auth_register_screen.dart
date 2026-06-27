import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/auth_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/screens/auth/auth_otp_verification_screen.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_filter_chip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum _DietaryPreference { vegetarian, halal, glutenFree }

/// PRD RegisterScreen · customer instant; ops pending (§3.2).
class AuthRegisterScreen extends ConsumerStatefulWidget {
  const AuthRegisterScreen({this.initialStep, super.key});

  final int? initialStep;

  @override
  ConsumerState<AuthRegisterScreen> createState() => _AuthRegisterScreenState();
}

class _AuthRegisterScreenState extends ConsumerState<AuthRegisterScreen> {
  bool _terms = false;
  AuthRegisterAccountType _accountType = AuthRegisterAccountType.customer;
  final Set<_DietaryPreference> _dietaryPreferences = {};
  int _step = 1;

  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final auth = ref.read(authSessionProvider);
    _accountType = auth.registerAccountType;
    if (widget.initialStep == 3 && auth.otpVerified) {
      _step = 3;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _advanceFromStep1() {
    final l10n = AppLocalizations.of(context)!;
    if (!_terms) {
      UtilityMockFeedback.showError(context, l10n.authRegisterFieldsRequired);
      return;
    }
    if (_fullNameController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      UtilityMockFeedback.showError(context, l10n.authRegisterFieldsRequired);
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      UtilityMockFeedback.showError(context, l10n.authPasswordMismatch);
      return;
    }

    ref.read(authSessionProvider.notifier).submitRegisterStep1(
      accountType: _accountType,
      fullName: _fullNameController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      termsAccepted: _terms,
    );
    setState(() => _step = 2);
  }

  Future<void> _completeRegistration() async {
    final authState = ref.read(authSessionProvider);
    if (authState.isOperationalRegistration) {
      ref.read(sessionProvider.notifier).signInPendingApproval();
      ref.read(authSessionProvider.notifier).reset();
      context.go(AppRoutePaths.pendingApproval);
      return;
    }

    ref
        .read(sessionProvider.notifier)
        .signIn(roles: approvedRolesForRegistration(authState.registerAccountType));
    ref.read(appRoleProvider.notifier).state = AppRole.customer;
    ref.read(authSessionProvider.notifier).reset();
    context.go(AppRoutePaths.home);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: AlignmentDirectional.topStart,
            radius: 1.3,
            colors: [scheme.primary.withValues(alpha: 0.08), scheme.surface],
          ),
        ),
        child: SafeArea(
          child: WidgetsScreenLayout(
            child: ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.xl(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
                if (_step > 1) ...[
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: WidgetsIconButton(
                      onPressed: _goBackFromStep,
                      icon: Icons.arrow_back,
                      tooltip:
                          MaterialLocalizations.of(context).backButtonTooltip,
                    ),
                  ),
                  SizedBox(height: CoreSpacing.lg(context)),
                ],
                if (_step == 1)
                  _RegisterCard(
                    accountType: _accountType,
                    onAccountTypeChanged:
                        (type) => setState(() => _accountType = type),
                    terms: _terms,
                    onTermsChanged: (value) => setState(() => _terms = value),
                    fullNameController: _fullNameController,
                    phoneController: _phoneController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    onRegister: _advanceFromStep1,
                  )
                else if (_step == 2)
                  AuthOtpCard(
                    source: AuthOtpFlowSource.register,
                    onVerify: (code) async {
                      final l10n = AppLocalizations.of(context)!;
                      final verified = await ref
                          .read(authSessionProvider.notifier)
                          .verifyOtp(code);
                      if (!context.mounted) {
                        return;
                      }
                      if (!verified) {
                        UtilityMockFeedback.showError(
                          context,
                          l10n.authOtpInvalid,
                        );
                        return;
                      }
                      if (!context.mounted) {
                        return;
                      }
                      if (ref
                          .read(authSessionProvider)
                          .isOperationalRegistration) {
                        ref.read(sessionProvider.notifier).signInPendingApproval();
                        ref.read(authSessionProvider.notifier).reset();
                        if (!context.mounted) {
                          return;
                        }
                        context.go(AppRoutePaths.pendingApproval);
                        return;
                      }
                      setState(() => _step = 3);
                    },
                    showBackButton: false,
                    showSignupProgress: false,
                  )
                else
                  _RegisterPreferencesStep(
                    dietaryPreferences: _dietaryPreferences,
                    onDietarySelected:
                        (preference, selected) => setState(() {
                          if (selected) {
                            _dietaryPreferences.add(preference);
                          } else {
                            _dietaryPreferences.remove(preference);
                          }
                        }),
                    onComplete: _completeRegistration,
                  ),
                SizedBox(height: CoreSpacing.xl(context)),
                _ProgressMarks(step: _step),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goBackFromStep() {
    setState(() => _step -= 1);
  }
}

class _RegisterCard extends StatelessWidget {
  const _RegisterCard({
    required this.accountType,
    required this.onAccountTypeChanged,
    required this.terms,
    required this.onTermsChanged,
    required this.fullNameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onRegister,
  });

  final AuthRegisterAccountType accountType;
  final ValueChanged<AuthRegisterAccountType> onAccountTypeChanged;
  final bool terms;
  final ValueChanged<bool> onTermsChanged;
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.filled,
      padding: EdgeInsets.all(CoreSpacing.xl(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.registerJoinTitle,
            textAlign: TextAlign.center,
            style: CoreTypography.headlineSmall(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.registerJoinSubtitle,
            textAlign: TextAlign.center,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          _SectionTitle(label: l10n.registerPrimaryRole),
          SizedBox(height: CoreSpacing.md(context)),
          _AccountTypeOption(
            title: l10n.registerRoleCustomer,
            body: l10n.registerRoleCustomerBody,
            icon: Icons.restaurant_menu_outlined,
            selected: accountType == AuthRegisterAccountType.customer,
            onTap: () => onAccountTypeChanged(AuthRegisterAccountType.customer),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _AccountTypeOption(
            title: l10n.registerRoleStaff,
            body: l10n.registerRoleStaffBody,
            icon: Icons.badge_outlined,
            selected: accountType == AuthRegisterAccountType.staff,
            onTap: () => onAccountTypeChanged(AuthRegisterAccountType.staff),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _AccountTypeOption(
            title: l10n.registerRoleAdminOwner,
            body: l10n.registerRoleAdminOwnerBody,
            icon: Icons.admin_panel_settings_outlined,
            selected: accountType == AuthRegisterAccountType.adminOwner,
            onTap:
                () => onAccountTypeChanged(AuthRegisterAccountType.adminOwner),
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          _RegisterField(
            label: l10n.registerFullName,
            hint: l10n.registerNameHint,
            icon: Icons.person_outline,
            controller: fullNameController,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _RegisterField(
            label: l10n.registerPhoneNumber,
            hint: l10n.registerPhoneHint,
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            textDirection: TextDirection.ltr,
            controller: phoneController,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _RegisterField(
            label: l10n.registerEmailAddress,
            hint: l10n.registerEmailHint,
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _RegisterField(
            label: l10n.fieldPassword,
            hint: l10n.loginPasswordHint,
            icon: Icons.lock_outline,
            obscureText: true,
            controller: passwordController,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _RegisterField(
            label: l10n.registerConfirmPassword,
            hint: l10n.loginPasswordHint,
            icon: Icons.security_outlined,
            obscureText: true,
            controller: confirmPasswordController,
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          _TermsRow(value: terms, onChanged: onTermsChanged),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppButton(
            label: l10n.actionRegister,
            onPressed: onRegister,
            icon: Icons.arrow_forward,
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          _DividerLabel(label: l10n.registerOr),
          SizedBox(height: CoreSpacing.lg(context)),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: CoreSpacing.xs(context),
            children: [
              Text(
                l10n.registerAlreadyAccount,
                style: CoreTypography.bodyMedium(
                  context,
                  scheme.onSurfaceVariant,
                ),
              ),
              WidgetsAppButton(
                label: l10n.registerLogin,
                onPressed: () => context.go(AppRoutePaths.login),
                variant: WidgetsAppButtonVariant.ghost,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AccountTypeOption extends StatelessWidget {
  const _AccountTypeOption({
    required this.title,
    required this.body,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String body;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      onTap: onTap,
      accentColor: selected ? scheme.primary : scheme.outlineVariant,
      variant:
          selected
              ? WidgetsAppCardVariant.filled
              : WidgetsAppCardVariant.outlined,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Row(
        children: [
          Icon(icon, color: selected ? scheme.primary : scheme.onSurfaceVariant),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CoreTypography.titleMedium(
                    context,
                    selected ? scheme.primary : scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900, fontSize: 14),
                ),
                Text(
                  body,
                  style: CoreTypography.caption(context, scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Icon(
            selected ? Icons.check_circle : Icons.radio_button_unchecked,
            color: selected ? scheme.primary : scheme.outline,
          ),
        ],
      ),
    );
  }
}

class _RegisterPreferencesStep extends StatelessWidget {
  const _RegisterPreferencesStep({
    required this.dietaryPreferences,
    required this.onDietarySelected,
    required this.onComplete,
  });

  final Set<_DietaryPreference> dietaryPreferences;
  final void Function(_DietaryPreference preference, bool selected)
  onDietarySelected;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.registerPreferencesTitle,
          textAlign: TextAlign.center,
          style: CoreTypography.headlineSmall(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        Text(
          l10n.registerPreferencesSubtitle,
          textAlign: TextAlign.center,
          style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
        ),
        SizedBox(height: CoreSpacing.xl(context)),
        _SectionTitle(label: l10n.registerDietaryPreferences),
        SizedBox(height: CoreSpacing.md(context)),
        WidgetsAppCard(
          variant: WidgetsAppCardVariant.food,
          padding: EdgeInsets.all(CoreSpacing.lg(context)),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(CoreSpacing.md(context)),
                  child: Icon(
                    Icons.restaurant_menu_outlined,
                    color: scheme.primary,
                  ),
                ),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Text(
                  l10n.registerRoleCustomerBody,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: CoreSpacing.md(context)),
        Wrap(
          spacing: CoreSpacing.sm(context),
          runSpacing: CoreSpacing.sm(context),
          children: [
            _DietaryChip(
              preference: _DietaryPreference.vegetarian,
              selected: dietaryPreferences.contains(
                _DietaryPreference.vegetarian,
              ),
              label: l10n.registerDietVegetarian,
              onSelected: onDietarySelected,
            ),
            _DietaryChip(
              preference: _DietaryPreference.halal,
              selected: dietaryPreferences.contains(_DietaryPreference.halal),
              label: l10n.registerDietHalal,
              onSelected: onDietarySelected,
            ),
            _DietaryChip(
              preference: _DietaryPreference.glutenFree,
              selected: dietaryPreferences.contains(
                _DietaryPreference.glutenFree,
              ),
              label: l10n.registerDietGlutenFree,
              onSelected: onDietarySelected,
            ),
          ],
        ),
        SizedBox(height: CoreSpacing.xxl(context)),
        WidgetsAppButton(
          label: l10n.registerCompleteProfile,
          onPressed: onComplete,
          icon: Icons.celebration_outlined,
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Text(
      label,
      style: CoreTypography.titleMedium(
        context,
        scheme.onSurface,
      ).copyWith(fontWeight: FontWeight.w900),
    );
  }
}

class _DietaryChip extends StatelessWidget {
  const _DietaryChip({
    required this.preference,
    required this.selected,
    required this.label,
    required this.onSelected,
  });

  final _DietaryPreference preference;
  final bool selected;
  final String label;
  final void Function(_DietaryPreference preference, bool selected) onSelected;

  @override
  Widget build(BuildContext context) {
    return WidgetsFilterChip(
      label: label,
      selected: selected,
      onSelected: (value) => onSelected(preference, value),
      icon: selected ? Icons.check_box_outlined : Icons.check_box_outline_blank,
    );
  }
}

class _RegisterField extends StatelessWidget {
  const _RegisterField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.textDirection,
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppTextField(
      label: label,
      hintText: hint,
      prefixIcon: icon,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textDirection: textDirection,
      controller: controller,
    );
  }
}

class _TermsRow extends StatelessWidget {
  const _TermsRow({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(value: value, onChanged: (next) => onChanged(next ?? false)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: CoreSpacing.sm(context)),
            child: Text.rich(
              TextSpan(
                style: CoreTypography.bodyMedium(
                  context,
                  scheme.onSurfaceVariant,
                ),
                children: [
                  TextSpan(text: '${l10n.registerAgreePrefix} '),
                  TextSpan(
                    text: l10n.registerTermsService,
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(text: ' ${l10n.registerAnd} '),
                  TextSpan(
                    text: l10n.registerPrivacyPolicy,
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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

class _ProgressMarks extends StatelessWidget {
  const _ProgressMarks({required this.step});

  final int step;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _ProgressMark(color: scheme.primary)),
            SizedBox(width: CoreSpacing.lg(context)),
            Expanded(
              child: _ProgressMark(
                color: step >= 2 ? scheme.primary : scheme.outlineVariant,
              ),
            ),
            SizedBox(width: CoreSpacing.lg(context)),
            Expanded(
              child: _ProgressMark(
                color: step >= 3 ? scheme.primary : scheme.outlineVariant,
              ),
            ),
          ],
        ),
        if (step == 2) ...[
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.registerStepTwoLabel,
            textAlign: TextAlign.center,
            style: CoreTypography.caption(
              context,
              scheme.onSurfaceVariant,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
        ] else if (step == 3) ...[
          SizedBox(height: CoreSpacing.sm(context)),
          Row(
            children: [
              Text(
                l10n.registerSetupProgress,
                style: CoreTypography.caption(
                  context,
                  scheme.primary,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
              const Spacer(),
              Text(
                l10n.registerSetupPercent,
                style: CoreTypography.caption(
                  context,
                  scheme.primary,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _ProgressMark extends StatelessWidget {
  const _ProgressMark({required this.color});

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
