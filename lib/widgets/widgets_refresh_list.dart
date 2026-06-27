import 'package:flutter/material.dart';

/// [RefreshIndicator] wrapper for scrollable lists.
class WidgetsRefreshList extends StatelessWidget {
  const WidgetsRefreshList({
    required this.onRefresh,
    required this.child,
    super.key,
  });

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: onRefresh, child: child);
  }
}
