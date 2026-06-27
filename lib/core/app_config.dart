/// Global runtime flags (replace with remote config / env later).
abstract final class AppConfig {
  /// When true, ops screens show the demo banner and mock actions stay non-destructive.
  static const demoModeEnabled = true;

  /// When false, `/checkout`, `/payment`, and related paths redirect to `/cart`.
  /// Set true to use stepped checkout screens (backend-ready flow).
  static const useSteppedCheckoutRoutes = false;
}
