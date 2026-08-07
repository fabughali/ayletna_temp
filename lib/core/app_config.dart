/// Global runtime flags (replace with remote config / env later).
abstract final class AppConfig {
  /// Legacy flag — keep `false`. In-memory repositories are the current data
  /// layer; UI must not advertise “demo” or block success feedback.
  static const demoModeEnabled = false;

  /// When false, `/checkout`, `/payment`, and related paths redirect to `/cart`.
  /// Set true to use stepped checkout screens (backend-ready flow).
  static const useSteppedCheckoutRoutes = true;

  /// Mock/dev exploration: after login OTP, unlock all portals and open
  /// `/role-selection` (works in debug *and* release web builds).
  /// Set false for production-like single-role routing.
  static const forcePostOtpRoleSelection = true;
}
