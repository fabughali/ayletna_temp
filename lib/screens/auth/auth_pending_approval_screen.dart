import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/auth_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_role_labels.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Staff / management registration pending app-admin approval (PRD §3.2).
class AuthPendingApprovalScreen extends ConsumerWidget {
  const AuthPendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final session = ref.watch(sessionProvider);
    final requested =
        session.pendingRequestedRoles.toList()
          ..sort((a, b) => a.name.compareTo(b.name));
    final roleLabels = requested.map((r) => roleLabel(l10n, r)).join(', ');

    return WidgetsScaffoldPage(
      showAppBar: false,
      showDrawer: false,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: CoreSpacing.xxl(context)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: WidgetsAppCard(
              variant: WidgetsAppCardVariant.elevated,
              padding: EdgeInsets.all(CoreSpacing.xl(context)),
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: CoreColors.brandGold.withValues(alpha: 0.16),
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox.square(
                      dimension: 72,
                      child: Icon(
                        Icons.hourglass_top_rounded,
                        color: CoreColors.brandBrown,
                        size: UtilitySizer.of(context, 36),
                      ),
                    ),
                  ),
                  SizedBox(height: CoreSpacing.lg(context)),
                  Text(
                    l10n.screenPendingApproval,
                    textAlign: TextAlign.center,
                    style: CoreTypography.headlineSmall(
                      context,
                      theme.colorScheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: CoreSpacing.md(context)),
                  Text(
                    l10n.pendingApprovalNote,
                    textAlign: TextAlign.center,
                    style: CoreTypography.bodyMedium(
                      context,
                      theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (requested.isNotEmpty) ...[
                    SizedBox(height: CoreSpacing.md(context)),
                    Text(
                      l10n.pendingApprovalRequestedRoles(roleLabels),
                      textAlign: TextAlign.center,
                      style: CoreTypography.caption(
                        context,
                        theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  SizedBox(height: CoreSpacing.xl(context)),
                  const _ApprovalTimeline(),
                  SizedBox(height: CoreSpacing.xl(context)),
                  WidgetsAppButton(
                    label: l10n.pendingApprovalContactSupport,
                    onPressed: () => context.push(AppRoutePaths.faq),
                    icon: Icons.support_agent_outlined,
                    fullWidth: true,
                  ),
                  SizedBox(height: CoreSpacing.md(context)),
                  WidgetsAppButton(
                    label: l10n.actionSignOut,
                    onPressed: () {
                      ref.read(sessionProvider.notifier).signOut();
                      ref.read(authSessionProvider.notifier).reset();
                      context.go(AppRoutePaths.login);
                    },
                    variant: WidgetsAppButtonVariant.ghost,
                    fullWidth: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ApprovalTimeline extends StatelessWidget {
  const _ApprovalTimeline();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        _TimelineStep(
          label: l10n.pendingApprovalStepSubmitted,
          icon: Icons.check,
          color: CoreColors.brandBrown,
          isLast: false,
          active: true,
        ),
        _TimelineStep(
          label: l10n.pendingApprovalStepReview,
          icon: Icons.circle,
          color: CoreColors.brandBrown,
          isLast: false,
          active: true,
          current: true,
        ),
        _TimelineStep(
          label: l10n.pendingApprovalStepActivated,
          icon: Icons.circle_outlined,
          color: scheme.outline,
          isLast: true,
          active: false,
        ),
      ],
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.label,
    required this.icon,
    required this.color,
    required this.isLast,
    required this.active,
    this.current = false,
  });

  final String label;
  final IconData icon;
  final Color color;
  final bool isLast;
  final bool active;
  final bool current;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: UtilitySizer.of(context, 28),
              height: UtilitySizer.of(context, 28),
              decoration: BoxDecoration(
                color:
                    active
                        ? color.withValues(alpha: current ? 0.12 : 0.9)
                        : scheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      active ? color : scheme.outline.withValues(alpha: 0.35),
                ),
              ),
              child: Icon(
                icon,
                color: active && !current ? scheme.surface : color,
                size: current ? 10 : 16,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: UtilitySizer.of(context, 32),
                color:
                    active
                        ? color.withValues(alpha: 0.35)
                        : scheme.outline.withValues(alpha: 0.2),
              ),
          ],
        ),
        SizedBox(width: CoreSpacing.md(context)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: CoreSpacing.xs(context),
              bottom: isLast ? 0 : CoreSpacing.lg(context),
            ),
            child: Text(
              label,
              style: CoreTypography.bodyMedium(
                context,
                active ? scheme.onSurface : scheme.onSurfaceVariant,
              ).copyWith(
                fontWeight: active ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
