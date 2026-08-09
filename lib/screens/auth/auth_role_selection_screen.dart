import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/auth_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_responsive_breakpoints.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_role_portal_tile.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Approved role portal chooser · Stitch v2 auth-2.
class AuthRoleSelectionScreen extends ConsumerWidget {
  const AuthRoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final approved = ref.watch(sessionProvider).approvedRoles;
    final contentBand = UtilityResponsiveBreakpoints.contentBandOf(context);

    final portals = <_PortalSpec>[
      if (approved.contains(AppRole.admin))
        _PortalSpec(
          role: AppRole.admin,
          title: l10n.roleAdmin,
          icon: Icons.admin_panel_settings_outlined,
          accent: CoreColors.hubAdminAccentDark,
          metric: l10n.roleSelectionAdminMetric,
          route: AppRoutePaths.appAdmin,
        ),
      if (approved.contains(AppRole.operator))
        _PortalSpec(
          role: AppRole.operator,
          title: l10n.roleOperator,
          icon: Icons.restaurant_outlined,
          accent: CoreColors.semanticSuccess,
          metric: l10n.roleSelectionOperatorMetric,
          route: AppRoutePaths.operatorHub,
        ),
      if (approved.contains(AppRole.owner))
        _PortalSpec(
          role: AppRole.owner,
          title: l10n.roleSelectionOwnerTitle,
          icon: Icons.payments_outlined,
          accent: CoreColors.brandBrown,
          metric: l10n.roleSelectionOwnerMetric,
          route: AppRoutePaths.ownerHub,
        ),
      if (approved.contains(AppRole.support))
        _PortalSpec(
          role: AppRole.support,
          title: l10n.roleSupport,
          icon: Icons.support_agent_outlined,
          accent: CoreColors.orderTypeDelivery,
          metric: l10n.roleSelectionSupportMetric,
          route: AppRoutePaths.supportDesk,
        ),
      if (approved.contains(AppRole.marketing))
        _PortalSpec(
          role: AppRole.marketing,
          title: l10n.roleMarketing,
          icon: Icons.campaign_outlined,
          accent: CoreColors.hubMarketingAccent,
          metric: l10n.roleSelectionMarketingMetric,
          route: AppRoutePaths.marketingHub,
        ),
      if (approved.contains(AppRole.customer))
        _PortalSpec(
          role: AppRole.customer,
          title: l10n.roleSelectionCustomerTitle,
          icon: Icons.person_outline,
          accent: CoreColors.brandGold,
          metric: l10n.loyaltyGoldMember,
          route: AppRoutePaths.home,
        ),
      if (approved.contains(AppRole.cashier))
        _PortalSpec(
          role: AppRole.cashier,
          title: l10n.roleSelectionCashierTitle,
          icon: Icons.point_of_sale_outlined,
          accent: CoreColors.orderTypePlated,
          route: AppRoutePaths.cashier,
        ),
      if (approved.contains(AppRole.kitchen))
        _PortalSpec(
          role: AppRole.kitchen,
          title: l10n.roleSelectionKitchenTitle,
          icon: Icons.soup_kitchen_outlined,
          accent: CoreColors.brandOlive,
          metric: l10n.roleSelectionKitchenMetric,
          route: AppRoutePaths.kitchen,
        ),
      if (approved.contains(AppRole.inventory))
        _PortalSpec(
          role: AppRole.inventory,
          title: l10n.roleSelectionInventoryTitle,
          icon: Icons.inventory_2_outlined,
          accent: CoreColors.semanticSuccess,
          route: AppRoutePaths.inventory,
        ),
      if (approved.contains(AppRole.staff))
        _PortalSpec(
          role: AppRole.staff,
          title: l10n.roleSelectionStaffTitle,
          icon: Icons.badge_outlined,
          accent: CoreColors.orderTypePlated,
          route: AppRoutePaths.staffAttendance,
        ),
      if (approved.contains(AppRole.delivery))
        _PortalSpec(
          role: AppRole.delivery,
          title: l10n.roleSelectionDeliveryTitle,
          icon: Icons.delivery_dining_outlined,
          accent: CoreColors.orderTypeDelivery,
          route: AppRoutePaths.delivery,
        ),
    ];

    return WidgetsScaffoldPage(
      showAppBar: false,
      showDrawer: false,
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          CoreSpacing.lg(context),
          CoreSpacing.xl(context),
          CoreSpacing.lg(context),
          CoreSpacing.xxl(context),
        ),
        children: [
          Text(
            l10n.roleSelectionWelcome,
            textAlign: TextAlign.center,
            style: CoreTypography.headlineSmall(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.roleSelectionSubtitle,
            textAlign: TextAlign.center,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          if (portals.isEmpty)
            Text(
              l10n.roleSelectionNoApprovedRoles,
              textAlign: TextAlign.center,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurfaceVariant,
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: switch (contentBand) {
                  ContentBand.mobile => 1,
                  ContentBand.tablet => 2,
                  ContentBand.web => 3,
                },
                crossAxisSpacing: CoreSpacing.md(context),
                mainAxisSpacing: CoreSpacing.md(context),
                childAspectRatio: switch (contentBand) {
                  ContentBand.mobile => 1.8,
                  ContentBand.tablet => 1.0,
                  ContentBand.web => 0.92,
                },
              ),
              itemCount: portals.length,
              itemBuilder: (context, index) {
                final portal = portals[index];
                return WidgetsRolePortalTile(
                  title: portal.title,
                  icon: portal.icon,
                  accent: portal.accent,
                  metric: portal.metric,
                  onTap:
                      () =>
                          _selectRole(context, ref, portal.role, portal.route),
                );
              },
            ),
        ],
      ),
    );
  }

  void _selectRole(
    BuildContext context,
    WidgetRef ref,
    AppRole role,
    String route,
  ) {
    final session = ref.read(sessionProvider);
    if (!isRoleApprovedForSession(session, role)) {
      UtilityMockFeedback.showError(
        context,
        AppLocalizations.of(context)!.roleSelectionNotApproved,
      );
      return;
    }
    ref.read(appRoleProvider.notifier).state = role;
    context.go(route);
  }
}

class _PortalSpec {
  const _PortalSpec({
    required this.role,
    required this.title,
    required this.icon,
    required this.accent,
    required this.route,
    this.metric,
  });

  final AppRole role;
  final String title;
  final IconData icon;
  final Color accent;
  final String route;
  final String? metric;
}
