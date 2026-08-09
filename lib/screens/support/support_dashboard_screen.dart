import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/support_dashboard_providers.dart';
import 'package:ayletna_restaurant_app/providers/support_shift_handover_providers.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_reviews_moderation_screen.dart';
import 'package:ayletna_restaurant_app/screens/admin/admin_support_tickets_screen.dart';
import 'package:ayletna_restaurant_app/screens/support/support_chat_queue_screen.dart';
import 'package:ayletna_restaurant_app/screens/support/support_faq_editor_screen.dart';
import 'package:ayletna_restaurant_app/screens/support/support_order_lookup_screen.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_metric_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SupportDashboardScreen extends ConsumerWidget {
  const SupportDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final metrics = ref.watch(supportDashboardMetricsProvider);

    return WidgetsScaffoldPage(
      title: l10n.hubSupportDesk,
      child: ListView(
        padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
        children: [
          Text(
            l10n.hubSupportSummary,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsMetricCard(
                  label: l10n.hubOpenTickets,
                  value: '${metrics.openTickets}',
                  icon: Icons.confirmation_number_outlined,
                  accentColor: CoreColors.orderTypeDelivery,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsMetricCard(
                  label: l10n.hubChatQueue,
                  value: '${metrics.chatQueueCount}',
                  icon: Icons.chat_outlined,
                  accentColor: CoreColors.orderTypeDelivery,
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsMetricCard(
                  label: l10n.supportSlaAtRisk,
                  value: '${metrics.slaAtRisk}',
                  icon: Icons.warning_amber_outlined,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsMetricCard(
                  label: l10n.supportSlaBreached,
                  value: '${metrics.slaBreached}',
                  icon: Icons.error_outline,
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.supportAgentPerformanceTitle,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsMetricCard(
                  label: l10n.supportResolvedToday,
                  value: '${metrics.resolvedToday}',
                  icon: Icons.check_circle_outline,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsMetricCard(
                  label: l10n.supportAvgResponseTime,
                  value: l10n.supportAvgResponseMinutes(
                    metrics.avgResponseMinutes,
                  ),
                  icon: Icons.timer_outlined,
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          const _SupportShiftHandoverCard(),
          SizedBox(height: CoreSpacing.xl(context)),
          _tile(
            context,
            l10n.supportTicketsTitle,
            Icons.confirmation_number_outlined,
            AppRoutePaths.supportDeskTickets,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _tile(
            context,
            l10n.supportChatQueueTitle,
            Icons.chat_outlined,
            AppRoutePaths.supportDeskChat,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _tile(
            context,
            l10n.supportOrderLookupTitle,
            Icons.search_outlined,
            AppRoutePaths.supportDeskOrderLookup,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _tile(
            context,
            l10n.adminReviewAction,
            Icons.rate_review_outlined,
            AppRoutePaths.supportDeskReviews,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _tile(
            context,
            l10n.screenFaq,
            Icons.help_outline,
            AppRoutePaths.supportDeskFaq,
          ),
        ],
      ),
    );
  }

  Widget _tile(
    BuildContext context,
    String label,
    IconData icon,
    String route,
  ) {
    return WidgetsAppCard(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label, style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w800)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(route),
      ),
    );
  }
}

class _SupportShiftHandoverCard extends ConsumerStatefulWidget {
  const _SupportShiftHandoverCard();

  @override
  ConsumerState<_SupportShiftHandoverCard> createState() =>
      _SupportShiftHandoverCardState();
}

class _SupportShiftHandoverCardState
    extends ConsumerState<_SupportShiftHandoverCard> {
  late final TextEditingController _notes;

  @override
  void initState() {
    super.initState();
    _notes = TextEditingController();
  }

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final handover = ref.watch(supportShiftHandoverProvider);
    final openSummary = ref.watch(supportOpenTicketsSummaryProvider);
    final locale = Localizations.localeOf(context).languageCode;

    return WidgetsAppCard(
      title: l10n.supportShiftHandoverTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (openSummary.isNotEmpty)
            Text(
              openSummary,
              style: CoreTypography.caption(context, scheme.onSurfaceVariant),
            ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(
            controller: _notes,
            label: l10n.supportShiftHandoverTitle,
            hintText: l10n.supportShiftHandoverHint,
            maxLines: 3,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.actionSave,
            icon: Icons.swap_horiz_outlined,
            onPressed: () {
              if (_notes.text.trim().isEmpty) {
                UtilityMockFeedback.showWarning(
                  context,
                  l10n.supportShiftHandoverHint,
                );
                return;
              }
              ref
                  .read(supportShiftHandoverProvider.notifier)
                  .saveHandover(_notes.text);
              UtilityMockFeedback.showSuccess(
                context,
                l10n.supportShiftHandoverSaved,
              );
            },
          ),
          if (handover.lastHandoverAt case final at?) ...[
            SizedBox(height: CoreSpacing.sm(context)),
            Text(
              l10n.supportShiftHandoverLast(
                DateFormat.yMMMd(locale).add_jm().format(at),
              ),
              style: CoreTypography.caption(context, scheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}

class SupportTicketsRouteScreen extends StatelessWidget {
  const SupportTicketsRouteScreen({super.key});
  @override
  Widget build(BuildContext context) => const AdminSupportTicketsScreen();
}

class SupportChatRouteScreen extends StatelessWidget {
  const SupportChatRouteScreen({super.key});
  @override
  Widget build(BuildContext context) => const SupportChatQueueScreen();
}

class SupportOrderLookupRouteScreen extends StatelessWidget {
  const SupportOrderLookupRouteScreen({super.key});
  @override
  Widget build(BuildContext context) => const SupportOrderLookupScreen();
}

class SupportReviewsRouteScreen extends StatelessWidget {
  const SupportReviewsRouteScreen({super.key});
  @override
  Widget build(BuildContext context) => const AdminReviewsModerationScreen();
}

class SupportFaqRouteScreen extends StatelessWidget {
  const SupportFaqRouteScreen({super.key});
  @override
  Widget build(BuildContext context) => const SupportFaqEditorScreen();
}
