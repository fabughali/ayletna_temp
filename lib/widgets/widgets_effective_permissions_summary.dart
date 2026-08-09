import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_permission_rule.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_metric_card.dart';
import 'package:flutter/material.dart';

/// Compact summary of effective permission counts for RBAC Screen B.
class WidgetsEffectivePermissionsSummary extends StatelessWidget {
  const WidgetsEffectivePermissionsSummary({
    required this.effective,
    super.key,
  });

  final Map<String, PermissionAccess> effective;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var full = 0;
    var readOnly = 0;
    var denied = 0;
    var postponed = 0;

    for (final access in effective.values) {
      switch (access) {
        case PermissionAccess.full:
          full++;
        case PermissionAccess.readOnly:
          readOnly++;
        case PermissionAccess.denied:
          denied++;
        case PermissionAccess.postponed:
          postponed++;
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 520;
        final children = [
          WidgetsMetricCard(
            label: l10n.permissionAccessFull,
            value: '$full',
            icon: Icons.check_circle_outline,
          ),
          WidgetsMetricCard(
            label: l10n.permissionAccessRead,
            value: '$readOnly',
            icon: Icons.visibility_outlined,
          ),
          WidgetsMetricCard(
            label: l10n.permissionAccessDenied,
            value: '$denied',
            icon: Icons.block_outlined,
          ),
          WidgetsMetricCard(
            label: l10n.permissionAccessPostponed,
            value: '$postponed',
            icon: Icons.schedule_outlined,
          ),
        ];

        if (isWide) {
          return Row(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) SizedBox(width: CoreSpacing.sm(context)),
                Expanded(child: children[i]),
              ],
            ],
          );
        }

        return Wrap(
          spacing: CoreSpacing.sm(context),
          runSpacing: CoreSpacing.sm(context),
          children:
              children
                  .map(
                    (card) => SizedBox(
                      width:
                          (constraints.maxWidth - CoreSpacing.sm(context)) / 2,
                      child: card,
                    ),
                  )
                  .toList(),
        );
      },
    );
  }
}
