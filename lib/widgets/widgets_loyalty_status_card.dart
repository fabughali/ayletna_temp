import 'package:flutter/material.dart';

/// Gold-member status strip on customer home (Stitch v2).
class WidgetsLoyaltyStatusCard extends StatelessWidget {
  const WidgetsLoyaltyStatusCard({
    required this.statusLabel,
    required this.tierLabel,
    required this.pointsLabel,
    required this.pointsValue,
    this.onTap,
    super.key,
  });

  final String statusLabel;
  final String tierLabel;
  final String pointsLabel;
  final String pointsValue;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
