import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_role_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Switch active role — hot-restart navigation to hub home (UI mock).
class WidgetsRoleSwitcher extends ConsumerWidget {
  const WidgetsRoleSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final session = ref.watch(sessionProvider);
    final active = ref.watch(appRoleProvider);
    final approved = session.approvedRoles.toList()
      ..sort((a, b) => roleLabel(l10n, a).compareTo(roleLabel(l10n, b)));

    if (approved.length < 2) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.switchRoleTitle,
          style: CoreTypography.titleMedium(
            context,
            Theme.of(context).colorScheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Text(
          l10n.switchRoleSubtitle,
          style: CoreTypography.caption(
            context,
            Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: CoreSpacing.md(context)),
        Wrap(
          spacing: CoreSpacing.sm(context),
          runSpacing: CoreSpacing.sm(context),
          children: [
            for (final role in approved)
              ChoiceChip(
                label: Text(roleLabel(l10n, role)),
                selected: role == active,
                onSelected: role == active
                    ? null
                    : (_) {
                        if (!session.approvedRoles.contains(role)) return;
                        ref.read(appRoleProvider.notifier).state = role;
                        context.go(homeRouteForRole(role));
                      },
              ),
          ],
        ),
      ],
    );
  }
}
