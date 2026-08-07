import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/core/core_typography.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_drawer.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Standard app shell: optional AppBar + drawer + [WidgetsScreenLayout] body.
///
/// Pre-auth routes use [showAppBar] and [showDrawer] both `false` (no chrome).
///
/// App bar chrome (all roles):
/// - Drawer primary destinations → menu leading (opens drawer)
/// - Sub-screens → back leading
/// - Pre-auth: [showAppBar]/[showDrawer] false (no chrome)
/// - Customer/guest storefront: cart action injected unless already provided
class WidgetsScaffoldPage extends ConsumerWidget {
  WidgetsScaffoldPage({
    required this.child,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.bottomSheet,
    this.fullWidth = false,
    this.showAppBar = true,
    this.showDrawer = true,
    this.backgroundColor,
    super.key,
  }) : assert(
         !showAppBar || (title != null && title.isNotEmpty),
         'title is required when showAppBar is true',
       );

  final String? title;
  final Widget child;
  /// Trailing app-bar actions (cart, notifications, etc.). Prefer ≤3.
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final bool fullWidth;
  final bool showAppBar;
  final bool showDrawer;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final role = ref.watch(appRoleProvider);
    final currentPath = GoRouterState.of(context).uri.path;
    final isDrawerShell = WidgetsAppDrawer.isPrimaryDestination(
      role: role,
      path: currentPath,
      l10n: l10n,
      isAr: isAr,
    );
    final resolvedActions = _resolveActions(role, currentPath, actions);

    return Scaffold(
      backgroundColor: backgroundColor,
      drawer:
          showDrawer
              ? WidgetsAppDrawer(role: role, currentPath: currentPath)
              : null,
      appBar:
          showAppBar
              ? AppBar(
                backgroundColor: backgroundColor,
                elevation: 0,
                scrolledUnderElevation: 0,
                title: Text(
                  title!,
                  style: CoreTypography.titleMedium(
                    context,
                    theme.colorScheme.onSurface,
                  ),
                ),
                leading:
                    isDrawerShell
                        ? Builder(
                          builder: (drawerContext) {
                            return WidgetsIconButton(
                              tooltip:
                                  MaterialLocalizations.of(
                                    context,
                                  ).openAppDrawerTooltip,
                              onPressed:
                                  () =>
                                      Scaffold.of(drawerContext).openDrawer(),
                              icon: Icons.menu,
                            );
                          },
                        )
                        : WidgetsIconButton(
                          onPressed: () => _onBack(context, role),
                          icon: Icons.arrow_back,
                          tooltip:
                              MaterialLocalizations.of(
                                context,
                              ).backButtonTooltip,
                        ),
                actions: resolvedActions,
                automaticallyImplyLeading: false,
              )
              : null,
      floatingActionButton: floatingActionButton,
      bottomSheet: bottomSheet,
      body: SafeArea(
        child: WidgetsScreenLayout(fullWidth: fullWidth, child: child),
      ),
    );
  }

  List<Widget> _resolveActions(
    AppRole role,
    String path,
    List<Widget>? actions,
  ) {
    final base = List<Widget>.of(actions ?? const <Widget>[]);
    final isStorefront = role == AppRole.customer || role == AppRole.guest;
    // Account chrome routes — no auto cart in the app bar.
    if (!isStorefront ||
        path == AppRoutePaths.cart ||
        path == AppRoutePaths.orderHistory ||
        path == AppRoutePaths.rewards ||
        path == AppRoutePaths.notifications ||
        path == AppRoutePaths.profile ||
        path == AppRoutePaths.accountSettings ||
        path == AppRoutePaths.mapPicker ||
        path == AppRoutePaths.paymentHistory ||
        path == AppRoutePaths.rewardsHistory) {
      return base;
    }
    final hasCart = base.any((widget) => widget is WidgetsCartIconButton);
    if (hasCart) return base;
    return [...base, const WidgetsCartIconButton()];
  }

  void _onBack(BuildContext context, AppRole role) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go(homeRouteForRole(role));
  }
}
