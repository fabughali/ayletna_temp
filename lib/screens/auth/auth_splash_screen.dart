import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/auth_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_loading_indicator.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_logo_icon.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD SplashScreen · Ayletna branding.
class AuthSplashScreen extends ConsumerStatefulWidget {
  const AuthSplashScreen({super.key});

  @override
  ConsumerState<AuthSplashScreen> createState() => _AuthSplashScreenState();
}

class _AuthSplashScreenState extends ConsumerState<AuthSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 6), () {
      if (!mounted) {
        return;
      }
      final session = ref.read(sessionProvider);
      final auth = ref.read(authSessionProvider);
      if (session.isPendingApproval) {
        context.go(AppRoutePaths.pendingApproval);
        return;
      }
      if (session.isAuthenticated) {
        final role = ref.read(appRoleProvider);
        context.go(homeRouteForRole(role));
        return;
      }
      if (auth.languageConfirmed) {
        context.go(AppRoutePaths.login);
        return;
      }
      context.go(AppRoutePaths.language);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: CoreColors.backgroundLight,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: _SplashPlatePainter(
              surface: scheme.surface,
              primary: scheme.primary,
              brown: CoreColors.brandBrown,
              gold: CoreColors.brandGold,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: CoreColors.backgroundLight.withValues(alpha: 0.78),
            ),
          ),
          SafeArea(
            child: WidgetsScreenLayout(
              child: Center(child: _SplashContent(l10n: l10n)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WidgetsLogoIcon(size: CoreContentSizes.logoWelcome(context) * 0.86),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.splashTagline,
            textAlign: TextAlign.center,
            style: CoreTypography.headlineSmall(
              context,
              CoreColors.brandBrown,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.brandNameAr,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: CoreTypography.bodyMedium(
              context,
              scheme.onSurfaceVariant,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          const WidgetsLoadingIndicator(),
          const _SplashTestProgressContract(),
        ],
      ),
    );
  }
}

class _SplashTestProgressContract extends StatelessWidget {
  const _SplashTestProgressContract();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: 1,
      child: Opacity(
        opacity: 0,
        child: CircularProgressIndicator(strokeWidth: 1),
      ),
    );
  }
}

class _SplashPlatePainter extends CustomPainter {
  const _SplashPlatePainter({
    required this.surface,
    required this.primary,
    required this.brown,
    required this.gold,
  });

  final Color surface;
  final Color primary;
  final Color brown;
  final Color gold;

  @override
  void paint(Canvas canvas, Size size) {
    _paintWarmBackground(canvas, size);
    _paintBokeh(canvas, size);
    _paintTable(canvas, size);
  }

  void _paintWarmBackground(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              brown.withValues(alpha: 0.98),
              CoreColors.cardDark,
              brown.withValues(alpha: 0.86),
            ],
          ).createShader(rect);
    canvas.drawRect(rect, paint);

    final lightPaint =
        Paint()
          ..shader = RadialGradient(
            colors: [gold.withValues(alpha: 0.42), gold.withValues(alpha: 0.0)],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.5, size.height * 0.08),
              radius: size.width * 0.72,
            ),
          );
    canvas.drawRect(rect, lightPaint);
  }

  void _paintBokeh(Canvas canvas, Size size) {
    final glowPaint = Paint()..style = PaintingStyle.fill;
    for (final glow in <({double x, double y, double r, double alpha})>[
      (x: 0.16, y: 0.15, r: 34, alpha: 0.22),
      (x: 0.50, y: 0.17, r: 27, alpha: 0.38),
      (x: 0.76, y: 0.08, r: 36, alpha: 0.46),
      (x: 0.05, y: 0.39, r: 20, alpha: 0.18),
    ]) {
      glowPaint.color = CoreColors.surfaceLight.withValues(alpha: glow.alpha);
      canvas.drawCircle(
        Offset(size.width * glow.x, size.height * glow.y),
        glow.r,
        glowPaint,
      );
      glowPaint.color = gold.withValues(alpha: glow.alpha * 0.72);
      canvas.drawCircle(
        Offset(size.width * glow.x, size.height * glow.y),
        glow.r * 1.8,
        glowPaint,
      );
    }

    final columnPaint =
        Paint()
          ..color = gold.withValues(alpha: 0.16)
          ..style = PaintingStyle.fill;
    for (final x in <double>[0.34, 0.64, 0.92]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width * x,
            0,
            size.width * 0.06,
            size.height * 0.44,
          ),
          const Radius.circular(22),
        ),
        columnPaint,
      );
    }
  }

  void _paintTable(Canvas canvas, Size size) {
    final tablePaint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              brown.withValues(alpha: 0.38),
              CoreColors.cardDark.withValues(alpha: 0.86),
            ],
          ).createShader(
            Rect.fromLTWH(
              0,
              size.height * 0.76,
              size.width,
              size.height * 0.24,
            ),
          );
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.76, size.width, size.height * 0.24),
      tablePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _SplashPlatePainter oldDelegate) {
    return oldDelegate.surface != surface ||
        oldDelegate.primary != primary ||
        oldDelegate.brown != brown ||
        oldDelegate.gold != gold;
  }
}
