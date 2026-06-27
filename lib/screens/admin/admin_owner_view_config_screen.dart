import 'package:ayletna_restaurant_app/widgets/widgets_admin_growth_hub.dart';
import 'package:flutter/material.dart';

/// PRD [OwnerViewConfigScreen].
class AdminOwnerViewConfigScreen extends StatelessWidget {
  const AdminOwnerViewConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WidgetsAdminGrowthHub(
      initialSection: WidgetsAdminGrowthHubSection.privacy,
    );
  }
}
