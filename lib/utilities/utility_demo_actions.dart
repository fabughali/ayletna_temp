import 'package:ayletna_restaurant_app/core/app_config.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:flutter/material.dart';

/// Shared feedback for prototype primary actions on ops screens.
abstract final class UtilityDemoActions {
  static void complete(
    BuildContext context, {
    required String successMessage,
    VoidCallback? onComplete,
  }) {
    final l10n = AppLocalizations.of(context)!;
    if (AppConfig.demoModeEnabled) {
      UtilityMockFeedback.showInfo(context, l10n.demoModeBanner);
    } else {
      UtilityMockFeedback.showSuccess(context, successMessage);
    }
    onComplete?.call();
  }
}
