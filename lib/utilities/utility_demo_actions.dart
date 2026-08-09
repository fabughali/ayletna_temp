import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:flutter/material.dart';

/// Shared success feedback for primary actions (in-memory or future API).
abstract final class UtilityDemoActions {
  static void complete(
    BuildContext context, {
    required String successMessage,
    VoidCallback? onComplete,
  }) {
    UtilityMockFeedback.showSuccess(context, successMessage);
    onComplete?.call();
  }
}
