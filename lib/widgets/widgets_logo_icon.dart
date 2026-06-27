import 'package:flutter/material.dart';

/// Falafel brand mark from assets (ui_design_prompt).
class WidgetsLogoIcon extends StatelessWidget {
  const WidgetsLogoIcon({required this.size, super.key});

  final double size;

  static const String assetPath = 'assets/images/logo_falafel.png';

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder:
          (_, __, ___) => Icon(
            Icons.restaurant_menu_rounded,
            size: size * 0.85,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}
