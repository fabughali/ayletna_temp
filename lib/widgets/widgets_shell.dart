import 'package:flutter/material.dart';

/// Customer route shell — passthrough wrapper for grouped customer routes.
class WidgetsShell extends StatelessWidget {
  const WidgetsShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
