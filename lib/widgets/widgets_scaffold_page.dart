import 'package:ayletna_restaurant_app/core/core_typography.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_drawer.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_demo_mode_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Standard PRD screen shell: AppBar + [WidgetsScreenLayout] body.
class WidgetsScaffoldPage extends ConsumerWidget {
  const WidgetsScaffoldPage({
    required this.title,
    required this.child,
    this.actions,
    this.floatingActionButton,
    this.bottomSheet,
    this.fullWidth = false,
    super.key,
  });

  final String title;
  final Widget child;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final bool fullWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final role = ref.watch(appRoleProvider);
    final currentPath = GoRouterState.of(context).uri.path;
    final showBackButton = !_usesDrawerLeading(currentPath) && context.canPop();
    return Scaffold(
      drawer: WidgetsAppDrawer(role: role, currentPath: currentPath),
      appBar: AppBar(
        title: Text(
          title,
          style: CoreTypography.titleMedium(
            context,
            theme.colorScheme.onSurface,
          ),
        ),
        leading:
            showBackButton
                ? WidgetsIconButton(
                  onPressed: () => context.pop(),
                  icon: Icons.arrow_back,
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                )
                : Builder(
                  builder: (drawerContext) {
                    return WidgetsIconButton(
                      tooltip:
                          MaterialLocalizations.of(
                            context,
                          ).openAppDrawerTooltip,
                      onPressed: () => Scaffold.of(drawerContext).openDrawer(),
                      icon: Icons.menu,
                    );
                  },
                ),
        actions: actions,
      ),
      floatingActionButton: floatingActionButton,
      bottomSheet: bottomSheet,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (WidgetsDemoModeBanner.showsForPath(currentPath))
              const WidgetsDemoModeBanner(),
            Expanded(
              child: WidgetsScreenLayout(fullWidth: fullWidth, child: child),
            ),
          ],
        ),
      ),
    );
  }

  bool _usesDrawerLeading(String path) {
    const drawerShellRoutes = {
      AppRoutePaths.home,
      AppRoutePaths.search,
      AppRoutePaths.cart,
      AppRoutePaths.orderHistory,
      AppRoutePaths.notifications,
      AppRoutePaths.profile,
      AppRoutePaths.cashier,
      AppRoutePaths.cashierOrderHistory,
      AppRoutePaths.cashierTip,
      AppRoutePaths.cashierDepositRefund,
      AppRoutePaths.accountSettings,
      AppRoutePaths.kitchen,
      AppRoutePaths.delivery,
      AppRoutePaths.inventory,
      AppRoutePaths.staffAttendance,
    };
    return drawerShellRoutes.contains(path);
  }
}
