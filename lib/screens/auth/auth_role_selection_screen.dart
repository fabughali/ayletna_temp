import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/auth_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_screen_layout.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Mockup role chooser. In production, approved roles come from admin settings.
class AuthRoleSelectionScreen extends ConsumerWidget {
  const AuthRoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: WidgetsAppBar(
        title: l10n.roleSelectionMockTitle,
        leading: WidgetsIconButton(
          onPressed: () {
            ref.read(sessionProvider.notifier).signOut();
            ref.read(authSessionProvider.notifier).reset();
            context.go(AppRoutePaths.login);
          },
          icon: Icons.logout,
          tooltip: l10n.profileLogout,
        ),
        showAvatar: false,
        actions: [
          WidgetsIconButton(
            onPressed: () => context.push(AppRoutePaths.notifications),
            icon: Icons.notifications_outlined,
            tooltip: l10n.screenNotifications,
          ),
        ],
      ),
      body: WidgetsScreenLayout(
        child: ListView(
          padding: EdgeInsetsDirectional.only(
            top: CoreSpacing.xxl(context),
            bottom: CoreSpacing.xxl(context),
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
              style: CoreTypography.caption(context, scheme.onSurfaceVariant),
            ),
            SizedBox(height: CoreSpacing.xl(context)),
            _RolePortalCard(
              title: l10n.roleSelectionCustomerTitle,
              body: l10n.roleSelectionCustomerBody,
              icon: Icons.restaurant_menu_outlined,
              accent: CoreColors.brandGold,
              role: AppRole.customer,
              route: AppRoutePaths.home,
              ref: ref,
              metric: l10n.roleSelectionMockCustomerMetric,
              trailingArrow: true,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            _RolePortalCard(
              title: l10n.roleSelectionOwnerTitle,
              body: l10n.roleSelectionOwnerBody,
              icon: Icons.trending_up_outlined,
              accent: CoreColors.brandOrange,
              role: AppRole.owner,
              route: AppRoutePaths.adminOwnerConfig,
              ref: ref,
              metric: l10n.roleSelectionOwnerMetric,
              trailingArrow: true,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            _RolePortalCard(
              title: l10n.roleSelectionCashierTitle,
              body: l10n.roleSelectionCashierBody,
              icon: Icons.point_of_sale_outlined,
              accent: CoreColors.orderTypePlated,
              role: AppRole.cashier,
              route: AppRoutePaths.cashier,
              ref: ref,
              actionLabel: l10n.roleSelectionOpenRegister,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            _RolePortalCard(
              title: l10n.roleSelectionKitchenTitle,
              body: l10n.roleSelectionKitchenBody,
              icon: Icons.soup_kitchen_outlined,
              accent: CoreColors.brandOlive,
              role: AppRole.kitchen,
              route: AppRoutePaths.kitchen,
              ref: ref,
              metric: l10n.roleSelectionKitchenMetric,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            _RolePortalCard(
              title: l10n.roleSelectionAdminTitle,
              body: l10n.roleSelectionAdminBody,
              icon: Icons.admin_panel_settings_outlined,
              accent: CoreColors.semanticSuccess,
              role: AppRole.operator,
              route: AppRoutePaths.admin,
              ref: ref,
              metric: l10n.roleSelectionSystemOnline,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            _RolePortalCard(
              title: l10n.roleSelectionInventoryTitle,
              body: l10n.roleSelectionInventoryBody,
              icon: Icons.inventory_2_outlined,
              accent: CoreColors.semanticSuccess,
              role: AppRole.inventory,
              route: AppRoutePaths.inventory,
              ref: ref,
              actionLabel: l10n.roleSelectionOpenInventory,
              compactHorizontal: true,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            _RolePortalCard(
              title: l10n.roleSelectionStaffTitle,
              body: l10n.roleSelectionStaffBody,
              icon: Icons.badge_outlined,
              accent: CoreColors.orderTypePlated,
              role: AppRole.staff,
              route: AppRoutePaths.staffAttendance,
              ref: ref,
              actionLabel: l10n.roleSelectionOpenAttendance,
              compactHorizontal: true,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            _RolePortalCard(
              title: l10n.roleSelectionDeliveryTitle,
              body: l10n.roleSelectionDeliveryBody,
              icon: Icons.delivery_dining_outlined,
              accent: CoreColors.orderTypeDelivery,
              role: AppRole.delivery,
              route: AppRoutePaths.delivery,
              ref: ref,
              actionLabel: l10n.roleSelectionStartShift,
              compactHorizontal: true,
            ),
            SizedBox(height: CoreSpacing.xxl(context)),
            Text(
              l10n.roleSelectionFooter,
              textAlign: TextAlign.center,
              style: CoreTypography.caption(context, scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _RolePortalCard extends StatelessWidget {
  const _RolePortalCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.accent,
    required this.role,
    required this.route,
    required this.ref,
    this.metric,
    this.actionLabel,
    this.trailingArrow = false,
    this.compactHorizontal = false,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color accent;
  final AppRole role;
  final String route;
  final WidgetRef ref;
  final String? metric;
  final String? actionLabel;
  final bool trailingArrow;
  final bool compactHorizontal;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      onTap: () => _selectRole(context),
      accentColor: accent,
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(CoreSpacing.lg(context)),
                child:
                    compactHorizontal
                        ? Row(
                          children: [
                            _RoleIconBubble(icon: icon, accent: accent),
                            SizedBox(width: CoreSpacing.lg(context)),
                            Expanded(
                              child: _cardContent(context, showIcon: false),
                            ),
                          ],
                        )
                        : _cardContent(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardContent(BuildContext context, {bool showIcon = true}) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showIcon) ...[
          _RoleIconBubble(icon: icon, accent: accent),
          SizedBox(height: CoreSpacing.md(context)),
        ],
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: CoreTypography.titleMedium(
                  context,
                  scheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            if (trailingArrow)
              Icon(
                Icons.chevron_right,
                color: scheme.onSurfaceVariant,
                textDirection: TextDirection.ltr,
              ),
          ],
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Text(
          body,
          style: CoreTypography.caption(context, scheme.onSurfaceVariant),
        ),
        if (metric != null) ...[
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsStatusPill(label: metric!, color: accent, compact: true),
        ],
        if (actionLabel != null) ...[
          SizedBox(height: CoreSpacing.md(context)),
          Align(
            alignment: AlignmentDirectional.center,
            child: WidgetsAppButton(
              label: actionLabel!,
              onPressed: () => _selectRole(context),
            ),
          ),
        ],
      ],
    );
  }

  void _selectRole(BuildContext context) {
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

class _RoleIconBubble extends StatelessWidget {
  const _RoleIconBubble({required this.icon, required this.accent});

  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: SizedBox.square(
        dimension: CoreContentSizes.logoCard(context),
        child: Icon(icon, color: accent),
      ),
    );
  }
}
