import 'package:ayletna_restaurant_app/providers/app_branding_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Falafel brand mark — uses admin branding logo URL when set, else asset.
class WidgetsLogoIcon extends ConsumerWidget {
  const WidgetsLogoIcon({
    required this.size,
    this.scale = false,
    super.key,
  });

  final double size;

  /// When true, [size] is a design token scaled by [UtilitySizer].
  final bool scale;

  static const String assetPath = 'assets/images/logo_falafel.png';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resolved = scale ? UtilitySizer.of(context, size) : size;
    final logoUrl = ref.watch(appBrandingProvider).logoUrl;
    if (logoUrl != null && logoUrl.trim().isNotEmpty) {
      final url = logoUrl.trim();
      if (url.startsWith('http')) {
        return Image.network(
          url,
          width: resolved,
          height: resolved,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _asset(context, resolved),
        );
      }
      return Image.asset(
        url,
        width: resolved,
        height: resolved,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => _asset(context, resolved),
      );
    }
    return _asset(context, resolved);
  }

  Widget _asset(BuildContext context, double resolved) {
    return Image.asset(
      assetPath,
      width: resolved,
      height: resolved,
      fit: BoxFit.contain,
      errorBuilder:
          (_, __, ___) => Icon(
            Icons.restaurant_menu_rounded,
            size: resolved * 0.85,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}
