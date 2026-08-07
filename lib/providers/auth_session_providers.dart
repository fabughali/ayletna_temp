import 'package:ayletna_restaurant_app/core/app_config.dart';
import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthOtpFlowSource { login, register, forgot }

enum AuthRegisterAccountType { customer, staff, operator, owner }

/// Draft auth flow state shared across login, OTP, register, and forgot-password.
class AuthSessionState {
  const AuthSessionState({
    this.languageConfirmed = false,
    this.loginIdentifier,
    this.resetIdentifier,
    this.pendingOtpSource,
    this.registerAccountType = AuthRegisterAccountType.customer,
    this.registerFullName,
    this.registerPhone,
    this.registerEmail,
    this.otpVerified = false,
    this.isVerifyingOtp = false,
    this.resendCount = 0,
  });

  final bool languageConfirmed;
  final String? loginIdentifier;
  final String? resetIdentifier;
  final AuthOtpFlowSource? pendingOtpSource;
  final AuthRegisterAccountType registerAccountType;
  final String? registerFullName;
  final String? registerPhone;
  final String? registerEmail;
  final bool otpVerified;
  final bool isVerifyingOtp;
  final int resendCount;

  String? get otpDestinationPhone =>
      registerPhone ?? loginIdentifier ?? resetIdentifier;

  bool get isOperationalRegistration =>
      registerAccountType == AuthRegisterAccountType.staff ||
      registerAccountType == AuthRegisterAccountType.operator ||
      registerAccountType == AuthRegisterAccountType.owner;

  AuthSessionState copyWith({
    bool? languageConfirmed,
    String? loginIdentifier,
    String? resetIdentifier,
    AuthOtpFlowSource? pendingOtpSource,
    AuthRegisterAccountType? registerAccountType,
    String? registerFullName,
    String? registerPhone,
    String? registerEmail,
    bool? otpVerified,
    bool? isVerifyingOtp,
    int? resendCount,
    bool clearLoginIdentifier = false,
    bool clearResetIdentifier = false,
    bool clearPendingOtp = false,
    bool clearRegisterDraft = false,
  }) {
    return AuthSessionState(
      languageConfirmed: languageConfirmed ?? this.languageConfirmed,
      loginIdentifier:
          clearLoginIdentifier
              ? null
              : (loginIdentifier ?? this.loginIdentifier),
      resetIdentifier:
          clearResetIdentifier
              ? null
              : (resetIdentifier ?? this.resetIdentifier),
      pendingOtpSource:
          clearPendingOtp ? null : (pendingOtpSource ?? this.pendingOtpSource),
      registerAccountType: registerAccountType ?? this.registerAccountType,
      registerFullName:
          clearRegisterDraft
              ? null
              : (registerFullName ?? this.registerFullName),
      registerPhone:
          clearRegisterDraft ? null : (registerPhone ?? this.registerPhone),
      registerEmail:
          clearRegisterDraft ? null : (registerEmail ?? this.registerEmail),
      otpVerified: otpVerified ?? this.otpVerified,
      isVerifyingOtp: isVerifyingOtp ?? this.isVerifyingOtp,
      resendCount: resendCount ?? this.resendCount,
    );
  }
}

class AuthSessionNotifier extends StateNotifier<AuthSessionState> {
  AuthSessionNotifier() : super(const AuthSessionState());

  static const maxResendAttempts = 2;

  void confirmLanguage() {
    state = state.copyWith(languageConfirmed: true);
  }

  void reset() {
    final languageConfirmed = state.languageConfirmed;
    state = AuthSessionState(languageConfirmed: languageConfirmed);
  }

  bool submitLogin({required String identifier, required String password}) {
    if (identifier.trim().isEmpty || password.trim().isEmpty) {
      return false;
    }
    state = state.copyWith(
      loginIdentifier: identifier.trim(),
      pendingOtpSource: AuthOtpFlowSource.login,
      otpVerified: false,
      resendCount: 0,
      clearResetIdentifier: true,
    );
    return true;
  }

  bool submitForgotPassword({required String identifier}) {
    if (identifier.trim().isEmpty) {
      return false;
    }
    state = state.copyWith(
      resetIdentifier: identifier.trim(),
      pendingOtpSource: AuthOtpFlowSource.forgot,
      otpVerified: false,
      resendCount: 0,
    );
    return true;
  }

  bool submitRegisterStep1({
    required AuthRegisterAccountType accountType,
    required String fullName,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
    required bool termsAccepted,
  }) {
    if (!termsAccepted) {
      return false;
    }
    if (fullName.trim().isEmpty ||
        phone.trim().isEmpty ||
        email.trim().isEmpty ||
        password.trim().isEmpty) {
      return false;
    }
    if (password != confirmPassword) {
      return false;
    }
    state = state.copyWith(
      registerAccountType: accountType,
      registerFullName: fullName.trim(),
      registerPhone: phone.trim(),
      registerEmail: email.trim(),
      pendingOtpSource: AuthOtpFlowSource.register,
      otpVerified: false,
      resendCount: 0,
    );
    return true;
  }

  Future<bool> verifyOtp(String code) async {
    state = state.copyWith(isVerifyingOtp: true);
    await Future<void>.delayed(const Duration(milliseconds: 450));
    final normalized = code.trim();
    if (normalized.length != 6 || !RegExp(r'^\d{6}$').hasMatch(normalized)) {
      state = state.copyWith(isVerifyingOtp: false, otpVerified: false);
      return false;
    }
    state = state.copyWith(isVerifyingOtp: false, otpVerified: true);
    return true;
  }

  bool resendOtp() {
    if (state.resendCount >= maxResendAttempts) {
      return false;
    }
    state = state.copyWith(resendCount: state.resendCount + 1);
    return true;
  }
}

final authSessionProvider =
    StateNotifierProvider<AuthSessionNotifier, AuthSessionState>((ref) {
      return AuthSessionNotifier();
    });

AuthOtpFlowSource authOtpSourceFromQuery(String value) {
  return switch (value) {
    'register' => AuthOtpFlowSource.register,
    'forgot' => AuthOtpFlowSource.forgot,
    _ => AuthOtpFlowSource.login,
  };
}

String authOtpBackRoute(AuthOtpFlowSource source) {
  return switch (source) {
    AuthOtpFlowSource.register => AppRoutePaths.register,
    AuthOtpFlowSource.forgot => AppRoutePaths.forgotPassword,
    AuthOtpFlowSource.login => AppRoutePaths.login,
  };
}

bool isRoleApprovedForSession(SessionState session, AppRole role) {
  return session.approvedRoles.contains(role);
}

String routeAfterLoginVerification(SessionState session) {
  // Mock/dev: always open the portal chooser after login OTP.
  if (AppConfig.forcePostOtpRoleSelection) {
    return AppRoutePaths.roleSelection;
  }
  // Production-like: app admin lands on admin hub (switcher stays in Settings).
  if (session.approvedRoles.contains(AppRole.admin)) {
    return homeRouteForRole(AppRole.admin);
  }
  if (session.approvedRoles.length <= 1) {
    final role = session.approvedRoles.first;
    return homeRouteForRole(role);
  }
  return AppRoutePaths.roleSelection;
}

Set<AppRole> approvedRolesForRegistration(AuthRegisterAccountType type) {
  return switch (type) {
    AuthRegisterAccountType.customer => {AppRole.customer},
    AuthRegisterAccountType.staff => {
      AppRole.staff,
      AppRole.kitchen,
      AppRole.cashier,
      AppRole.delivery,
      AppRole.inventory,
    },
    AuthRegisterAccountType.operator => {AppRole.operator},
    AuthRegisterAccountType.owner => {AppRole.owner},
  };
}
