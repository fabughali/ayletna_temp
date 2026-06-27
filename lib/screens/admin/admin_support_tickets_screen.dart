import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_support_ticket_record.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/support_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Admin support ticket board — status updates, replies, and customer feedback.
class AdminSupportTicketsScreen extends ConsumerWidget {
  const AdminSupportTicketsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final tickets = ref.watch(supportTicketsProvider).tickets;

    return WidgetsScaffoldPage(
      title: isAr ? 'تذاكر الدعم' : 'Support Tickets',
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.adminSettings),
          icon: Icons.settings_outlined,
          tooltip: l10n.screenSettings,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.read(supportTicketsProvider.notifier).refreshQueue();
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            _SupportHero(isAr: isAr, openCount: tickets.where((t) => t.status == SupportTicketStatus.open || t.status == SupportTicketStatus.inProgress).length),
            SizedBox(height: CoreSpacing.lg(context)),
            for (final ticket in tickets) ...[
              _TicketCard(
                ticket: ticket,
                isAr: isAr,
                onTap: () => _showTicketSheet(context, ref, ticket, isAr),
              ),
              SizedBox(height: CoreSpacing.md(context)),
            ],
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }

  void _showTicketSheet(
    BuildContext context,
    WidgetRef ref,
    ModelSupportTicketRecord ticket,
    bool isAr,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder:
          (sheetContext) => _TicketDetailSheet(
            ticketId: ticket.id,
            isAr: isAr,
          ),
    );
  }
}

class _SupportHero extends StatelessWidget {
  const _SupportHero({required this.isAr, required this.openCount});

  final bool isAr;
  final int openCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        gradient: const LinearGradient(
          colors: [CoreColors.brandBrown, CoreColors.brandOlive],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isAr ? 'مركز دعم العملاء' : 'Customer Support Center',
            style: CoreTypography.headlineSmall(
              context,
              CoreColors.surfaceLight,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            isAr
                ? '$openCount تذكرة نشطة — حدّث الحالة، رد على العملاء، وتابع التقييمات.'
                : '$openCount active tickets — update status, reply to customers, track feedback.',
            style: CoreTypography.bodyMedium(
              context,
              CoreColors.surfaceLight.withValues(alpha: 0.86),
            ),
          ),
        ],
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  const _TicketCard({
    required this.ticket,
    required this.isAr,
    required this.onTap,
  });

  final ModelSupportTicketRecord ticket;
  final bool isAr;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      onTap: onTap,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${ticket.id} • ${isAr ? ticket.titleAr : ticket.titleEn}',
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsStatusPill(
                label: isAr ? ticket.statusLabelAr() : ticket.statusLabelEn(),
                color: _statusColor(ticket.status),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            isAr ? ticket.bodyAr : ticket.bodyEn,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          if (ticket.customerRating != null) ...[
            SizedBox(height: CoreSpacing.sm(context)),
            Row(
              children: [
                Icon(Icons.star_rounded, color: CoreColors.brandGold, size: 18),
                SizedBox(width: CoreSpacing.xs(context)),
                Text(
                  '${ticket.customerRating}/5',
                  style: CoreTypography.caption(context, scheme.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Color _statusColor(SupportTicketStatus status) => switch (status) {
    SupportTicketStatus.open => CoreColors.brandOrange,
    SupportTicketStatus.inProgress => CoreColors.orderTypeDelivery,
    SupportTicketStatus.waitingCustomer => CoreColors.brandGold,
    SupportTicketStatus.resolved => CoreColors.semanticSuccess,
    SupportTicketStatus.closed => CoreColors.textDisabledLight,
  };
}

class _TicketDetailSheet extends ConsumerStatefulWidget {
  const _TicketDetailSheet({
    required this.ticketId,
    required this.isAr,
  });

  final String ticketId;
  final bool isAr;

  @override
  ConsumerState<_TicketDetailSheet> createState() => _TicketDetailSheetState();
}

class _TicketDetailSheetState extends ConsumerState<_TicketDetailSheet> {
  SupportTicketStatus? _status;
  final _replyAr = TextEditingController();
  final _replyEn = TextEditingController();

  @override
  void dispose() {
    _replyAr.dispose();
    _replyEn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAr = widget.isAr;
    final ticket = ref.watch(supportTicketByIdProvider(widget.ticketId));
    final scheme = Theme.of(context).colorScheme;

    if (ticket == null) {
      return Padding(
        padding: EdgeInsets.all(CoreSpacing.lg(context)),
        child: Text(
          isAr ? 'التذكرة غير موجودة' : 'Ticket not found',
          style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
        ),
      );
    }

    final status = _status ?? ticket.status;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        CoreSpacing.lg(context),
        0,
        CoreSpacing.lg(context),
        CoreSpacing.lg(context) + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              ticket.id,
              style: CoreTypography.titleMedium(
                context,
                scheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            DropdownButtonFormField<SupportTicketStatus>(
              value: status,
              decoration: InputDecoration(
                labelText: isAr ? 'الحالة' : 'Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
                ),
              ),
              items:
                  SupportTicketStatus.values
                      .map(
                        (s) => DropdownMenuItem(
                          value: s,
                          child: Text(isAr ? _statusAr(s) : _statusEn(s)),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() => _status = value);
                ref
                    .read(supportTicketsProvider.notifier)
                    .updateStatus(ticket.id, value);
                UtilityMockFeedback.showSuccess(
                  context,
                  isAr ? 'تم تحديث الحالة' : 'Status updated',
                );
              },
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            if (ticket.messages.isNotEmpty) ...[
              Text(
                isAr ? 'المحادثة' : 'Conversation',
                style: CoreTypography.titleMedium(context, scheme.onSurface),
              ),
              SizedBox(height: CoreSpacing.sm(context)),
              for (final msg in ticket.messages)
                Padding(
                  padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
                  child: Align(
                    alignment:
                        msg.isStaff
                            ? AlignmentDirectional.centerEnd
                            : AlignmentDirectional.centerStart,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width * 0.75,
                      ),
                      padding: EdgeInsets.all(CoreSpacing.md(context)),
                      decoration: BoxDecoration(
                        color:
                            msg.isStaff
                                ? scheme.primary.withValues(alpha: 0.12)
                                : scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
                      ),
                      child: Text(
                        isAr ? msg.bodyAr : msg.bodyEn,
                        style: CoreTypography.bodyMedium(context, scheme.onSurface),
                      ),
                    ),
                  ),
                ),
            ],
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppTextField(
              controller: _replyAr,
              label: isAr ? 'الرد بالعربية' : 'Arabic reply',
              maxLines: 2,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _replyEn,
              label: isAr ? 'الرد بالإنجليزية' : 'English reply',
              maxLines: 2,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppButton(
              label: isAr ? 'إرسال الرد' : 'Send reply',
              icon: Icons.send_outlined,
              onPressed: () {
                if (_replyEn.text.trim().isEmpty) return;
                final ok = ref.read(supportTicketsProvider.notifier).addStaffReply(
                  ticketId: ticket.id,
                  bodyAr: _replyAr.text,
                  bodyEn: _replyEn.text,
                  nextStatus: SupportTicketStatus.resolved,
                );
                if (!ok) {
                  UtilityMockFeedback.showWarning(
                    context,
                    isAr ? 'تعذر إرسال الرد' : 'Could not send reply',
                  );
                  return;
                }
                UtilityMockFeedback.showSuccess(
                  context,
                  isAr ? 'تم إرسال الرد' : 'Reply sent',
                );
                Navigator.pop(context);
              },
            ),
            if (ticket.customerFeedback != null) ...[
              SizedBox(height: CoreSpacing.lg(context)),
              Text(
                isAr ? 'ملاحظات العميل' : 'Customer feedback',
                style: CoreTypography.titleMedium(context, scheme.onSurface),
              ),
              Text(ticket.customerFeedback!),
            ],
          ],
        ),
      ),
    );
  }

  String _statusEn(SupportTicketStatus s) => switch (s) {
    SupportTicketStatus.open => 'Open',
    SupportTicketStatus.inProgress => 'In progress',
    SupportTicketStatus.waitingCustomer => 'Waiting customer',
    SupportTicketStatus.resolved => 'Resolved',
    SupportTicketStatus.closed => 'Closed',
  };

  String _statusAr(SupportTicketStatus s) => switch (s) {
    SupportTicketStatus.open => 'مفتوحة',
    SupportTicketStatus.inProgress => 'قيد المتابعة',
    SupportTicketStatus.waitingCustomer => 'بانتظار العميل',
    SupportTicketStatus.resolved => 'تم الحل',
    SupportTicketStatus.closed => 'مغلقة',
  };
}
