import 'package:flutter/material.dart';

/// Persistent prototype banner — disabled product-wide (2026-07-27).
/// Mock/in-memory data behavior is unrelated and stays enabled elsewhere.
class WidgetsDemoModeBanner extends StatelessWidget {
  const WidgetsDemoModeBanner({super.key});

  static bool showsForPath(String path) => false;

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
