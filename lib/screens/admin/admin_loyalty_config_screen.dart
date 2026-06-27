import 'package:ayletna_restaurant_app/widgets/widgets_admin_growth_hub.dart';
import 'package:flutter/material.dart';

/// PRD [LoyaltyConfigScreen].
class AdminLoyaltyConfigScreen extends StatelessWidget {
  const AdminLoyaltyConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WidgetsAdminGrowthHub(
      initialSection: WidgetsAdminGrowthHubSection.loyalty,
    );
  }
}
