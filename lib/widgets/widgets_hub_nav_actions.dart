import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/utilities/utility_hub_routes.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Hub dashboard + settings icon buttons based on current route prefix.
class WidgetsHubNavActions extends StatelessWidget {
  const WidgetsHubNavActions({
    this.readOnlyOwner = false,
    this.leading = const [],
    super.key,
  });

  final bool readOnlyOwner;
  final List<Widget> leading;

  static List<Widget> forContext(
    BuildContext context, {
    bool readOnlyOwner = false,
    List<Widget> leading = const [],
  }) {
    return WidgetsHubNavActions(
      readOnlyOwner: readOnlyOwner,
      leading: leading,
    ).buildActions(context);
  }

  List<Widget> buildActions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final path = GoRouterState.of(context).uri.path;
    final hubRoute =
        UtilityHubRoutes.hubRouteForPath(path, readOnlyOwner: readOnlyOwner);
    final settingsRoute = UtilityHubRoutes.settingsRouteForPath(
      path,
      readOnlyOwner: readOnlyOwner,
    );
    final showSettings = UtilityHubRoutes.showSettingsForPath(
      path,
      readOnlyOwner: readOnlyOwner,
    );

    return [
      ...leading,
      WidgetsIconButton(
        onPressed: () => context.push(hubRoute),
        icon: Icons.dashboard_outlined,
        tooltip: l10n.hubNavigateHint,
      ),
      if (showSettings)
        WidgetsIconButton(
          onPressed: () => context.push(settingsRoute),
          icon: Icons.settings_outlined,
          tooltip: l10n.screenSettings,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: buildActions(context),
    );
  }
}
