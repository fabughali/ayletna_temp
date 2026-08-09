import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/support_chat_queue_providers.dart';
import 'package:ayletna_restaurant_app/providers/support_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Agent view — live chat queue for support staff (UI mock).
class SupportChatQueueScreen extends ConsumerWidget {
  const SupportChatQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final queue = ref.watch(supportChatQueueProvider);

    return WidgetsScaffoldPage(
      title: l10n.supportChatQueueTitle,
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.read(supportChatQueueProvider.notifier).refreshQueue();
          UtilityMockFeedback.showInfo(context, l10n.supportChatQueueSubtitle);
        },
        child: ListView.builder(
          padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
          itemCount: queue.isEmpty ? 2 : queue.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.supportChatQueueSubtitle,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: CoreSpacing.lg(context)),
                  if (queue.isEmpty)
                    Center(
                      child: Text(
                        l10n.supportOrderLookupNoResults,
                        style: CoreTypography.bodyMedium(
                          context,
                          scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                ],
              );
            }
            if (queue.isEmpty) return const SizedBox.shrink();
            final entry = queue[index - 1];
            return Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.md(context)),
              child: WidgetsAppCard(
                variant: WidgetsAppCardVariant.dashboard,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.customer,
                            style: CoreTypography.titleMedium(
                              context,
                              scheme.onSurface,
                            ).copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        WidgetsStatusPill(
                          label:
                              entry.priority == SupportChatQueuePriority.high
                                  ? l10n.supportChatPriorityHigh
                                  : l10n.supportChatPriorityNormal,
                          color:
                              entry.priority == SupportChatQueuePriority.high
                                  ? scheme.error
                                  : scheme.outline,
                        ),
                      ],
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      entry.topic(isAr),
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: CoreSpacing.sm(context)),
                    Text(
                      l10n.supportChatWaitingMinutes(
                        entry.waitMinutes,
                        entry.id,
                      ),
                      style: CoreTypography.caption(context, scheme.primary),
                    ),
                    SizedBox(height: CoreSpacing.md(context)),
                    WidgetsAppButton(
                      label: l10n.supportChatAcceptAction,
                      icon: Icons.chat_bubble_outline,
                      onPressed: () {
                        final accepted = ref
                            .read(supportChatQueueProvider.notifier)
                            .acceptChat(entry.id);
                        if (!context.mounted) return;
                        if (!accepted) {
                          UtilityMockFeedback.showError(
                            context,
                            l10n.supportChatAcceptFailed,
                          );
                          return;
                        }

                        final ticket = ref
                            .read(supportTicketsProvider.notifier)
                            .createTicket(
                              titleAr: entry.topicAr,
                              titleEn: entry.topicEn,
                              bodyAr: l10n.supportChatAcceptBodyAr(
                                entry.customer,
                                entry.id,
                              ),
                              bodyEn: l10n.supportChatAcceptBodyEn(
                                entry.customer,
                                entry.id,
                              ),
                            );
                        if (ticket != null) {
                          ref
                              .read(supportChatProvider.notifier)
                              .linkTicket(ticket.id);
                          ref
                              .read(supportTicketsProvider.notifier)
                              .addStaffReply(
                                ticketId: ticket.id,
                                bodyAr: l10n.supportChatAcceptReplyAr,
                                bodyEn: l10n.supportChatAcceptReplyEn,
                              );
                        }

                        UtilityMockFeedback.showSuccess(
                          context,
                          l10n.supportChatAccepted,
                        );
                        context.push(AppRoutePaths.supportDeskTickets);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
