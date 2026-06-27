import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

/// Fingerprint / face unlock gate before recording attendance.
abstract final class ServiceAttendanceBiometric {
  static final _localAuth = LocalAuthentication();

  static Future<bool> authenticate({
    required BuildContext context,
    required String reason,
  }) async {
    if (kIsWeb) {
      final l10n = AppLocalizations.of(context)!;
      return UtilityMockFeedback.confirm(
        context: context,
        title: l10n.attendanceBiometricTitle,
        message: reason,
        confirmLabel: l10n.attendanceBiometricConfirm,
        cancelLabel: l10n.actionCancel,
        icon: Icons.fingerprint,
      );
    }

    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isSupported = await _localAuth.isDeviceSupported();
      if (!canCheck && !isSupported) {
        if (!context.mounted) return false;
        UtilityMockFeedback.showError(
          context,
          AppLocalizations.of(context)!.attendanceBiometricUnavailable,
        );
        return false;
      }

      return _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (_) {
      if (!context.mounted) return false;
      UtilityMockFeedback.showError(
        context,
        AppLocalizations.of(context)!.attendanceBiometricFailed,
      );
      return false;
    }
  }
}
