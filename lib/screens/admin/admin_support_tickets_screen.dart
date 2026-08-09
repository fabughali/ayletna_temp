import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_support_ticket_record.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/support_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_hub_nav_actions.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Admin support ticket board — status updates, replies, and customer feedback.
class AdminSupportTicketsScreen extends ConsumerStatefulWidget {
  const AdminSupportTicketsScreen({super.key});

  @override
  ConsumerState<AdminSupportTicketsScreen> createState() =>
      _AdminSupportTicketsScreenState();
}

class _AdminSupportTicketsScreenState
    extends ConsumerState<AdminSupportTicketsScreen> {
  SupportTicketStatus? _statusFilter;
  SupportTicketPriority? _priorityFilter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final allTickets = ref.watch(supportTicketsProvider).tickets;
    final tickets =
        allTickets.where((ticket) {
          final statusOk =
              _statusFilter == null || ticket.status == _statusFilter;
          final priorityOk =
              _priorityFilter == null || ticket.priority == _priorityFilter;
          return statusOk && priorityOk;
        }).toList();

    return WidgetsScaffoldPage(
      title: l10n.supportTicketsTitle,
      actions: WidgetsHubNavActions.forContext(context),
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.read(supportTicketsProvider.notifier).refreshQueue();
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            _SupportHero(
              l10n: l10n,
              openCount:
                  allTickets
                      .where(
                        (t) =>
                            t.status == SupportTicketStatus.open ||
                            t.status == SupportTicketStatus.inProgress,
                      )
                      .length,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            Text(
              l10n.filterByStatus,
              style: CoreTypography.caption(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            Wrap(
              spacing: CoreSpacing.sm(context),
              runSpacing: CoreSpacing.sm(context),
              children: [
                FilterChip(
                  label: Text(l10n.filterAll),
                  selected: _statusFilter == null,
                  onSelected: (_) => setState(() => _statusFilter = null),
                ),
                for (final status in SupportTicketStatus.values)
                  FilterChip(
                    label: Text(_supportTicketStatusLabel(status, l10n)),
                    selected: _statusFilter == status,
                    onSelected: (_) => setState(() => _statusFilter = status),
                  ),
              ],
            ),
            SizedBox(height: CoreSpacing.md(context)),
            Text(
              l10n.filterByPriority,
              style: CoreTypography.caption(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            Wrap(
              spacing: CoreSpacing.sm(context),
              children: [
                FilterChip(
                  label: Text(l10n.filterAll),
                  selected: _priorityFilter == null,
                  onSelected: (_) => setState(() => _priorityFilter = null),
                ),
                for (final priority in SupportTicketPriority.values)
                  FilterChip(
                    label: Text(_priorityLabel(priority, l10n)),
                    selected: _priorityFilter == priority,
                    onSelected:
                        (_) => setState(() => _priorityFilter = priority),
                  ),
              ],
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            for (final ticket in tickets) ...[
              _TicketCard(
                ticket: ticket,
                isAr: isAr,
                l10n: l10n,
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
          (sheetContext) => _TicketDetailSheet(ticketId: ticket.id, isAr: isAr),
    );
  }
}

String _supportTicketStatusLabel(
  SupportTicketStatus status,
  AppLocalizations l10n,
) => switch (status) {
  SupportTicketStatus.open => l10n.supportTicketStatusOpen,
  SupportTicketStatus.inProgress => l10n.supportTicketStatusInProgress,
  SupportTicketStatus.waitingCustomer => l10n.supportTicketStatusWaiting,
  SupportTicketStatus.resolved => l10n.supportTicketStatusResolved,
  SupportTicketStatus.closed => l10n.supportTicketStatusClosed,
};

class _SupportHero extends StatelessWidget {
  const _SupportHero({required this.l10n, required this.openCount});

  final AppLocalizations l10n;
  final int openCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
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
            l10n.supportTicketsHero,
            style: CoreTypography.headlineSmall(
              context,
              CoreColors.surfaceLight,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.supportTicketsHeroBody(openCount),
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
    required this.l10n,
    required this.onTap,
  });

  final ModelSupportTicketRecord ticket;
  final bool isAr;
  final AppLocalizations l10n;
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
                label: _supportTicketStatusLabel(ticket.status, l10n),
                color: _statusColor(ticket.status),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              WidgetsStatusPill(
                label: _priorityLabel(ticket.priority, l10n),
                color: _priorityColor(ticket.priority),
              ),
              WidgetsStatusPill(
                label: _slaLabel(ticket, l10n),
                color: _slaColor(ticket.slaState()),
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
                Icon(Icons.star_rounded, color: CoreColors.brandGold, size: CoreContentSizes.orderTypeIcon(context)),
                SizedBox(width: CoreSpacing.xs(context)),
                Text(
                  '${ticket.customerRating}/5',
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
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

  Color _priorityColor(SupportTicketPriority priority) => switch (priority) {
    SupportTicketPriority.high => CoreColors.semanticError,
    SupportTicketPriority.normal => CoreColors.orderTypeDelivery,
    SupportTicketPriority.low => CoreColors.textDisabledLight,
  };

  String _slaLabel(ModelSupportTicketRecord ticket, AppLocalizations l10n) {
    return switch (ticket.slaState()) {
      SupportSlaState.onTrack => l10n.ticketSlaOnTrack,
      SupportSlaState.atRisk => l10n.ticketSlaAtRisk,
      SupportSlaState.breached => l10n.ticketSlaBreached,
    };
  }

  Color _slaColor(SupportSlaState state) => switch (state) {
    SupportSlaState.onTrack => CoreColors.semanticSuccess,
    SupportSlaState.atRisk => CoreColors.brandOrange,
    SupportSlaState.breached => CoreColors.semanticError,
  };
}

String _priorityLabel(SupportTicketPriority priority, AppLocalizations l10n) =>
    switch (priority) {
      SupportTicketPriority.low => l10n.ticketPriorityLow,
      SupportTicketPriority.normal => l10n.ticketPriorityNormal,
      SupportTicketPriority.high => l10n.ticketPriorityHigh,
    };

class _TicketDetailSheet extends ConsumerStatefulWidget {
  const _TicketDetailSheet({required this.ticketId, required this.isAr});

  final String ticketId;
  final bool isAr;

  @override
  ConsumerState<_TicketDetailSheet> createState() => _TicketDetailSheetState();
}

class _TicketDetailSheetState extends ConsumerState<_TicketDetailSheet> {
  SupportTicketStatus? _status;
  final _replyAr = TextEditingController();
  final _replyEn = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _slaController = TextEditingController();

  @override
  void dispose() {
    _replyAr.dispose();
    _replyEn.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _slaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = widget.isAr;
    final ticket = ref.watch(supportTicketByIdProvider(widget.ticketId));
    final scheme = Theme.of(context).colorScheme;

    if (ticket == null) {
      return Padding(
        padding: EdgeInsets.all(CoreSpacing.lg(context)),
        child: Text(
          l10n.supportTicketNotFound,
          style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
        ),
      );
    }

    final status = _status ?? ticket.status;

    if (_phoneController.text.isEmpty && ticket.customerPhone != null) {
      _phoneController.text = ticket.customerPhone!;
    }
    if (_addressController.text.isEmpty && ticket.customerAddress != null) {
      _addressController.text = ticket.customerAddress!;
    }
    if (_slaController.text.isEmpty) {
      _slaController.text = ticket.slaTargetMinutes.toString();
    }

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
            WidgetsAppTextField(
              controller: _phoneController,
              label: l10n.supportTicketCustomerPhone,
              onChanged: (_) {
                ref.read(supportTicketsProvider.notifier).updateTicketDetails(
                  ticket.id,
                  customerPhone: _phoneController.text,
                );
              },
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _addressController,
              label: l10n.supportTicketCustomerAddress,
              onChanged: (_) {
                ref.read(supportTicketsProvider.notifier).updateTicketDetails(
                  ticket.id,
                  customerAddress: _addressController.text,
                );
              },
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _slaController,
              label: 'SLA target (minutes)',
              keyboardType: TextInputType.number,
              onChanged: (_) {
                final mins = int.tryParse(_slaController.text);
                if (mins != null) {
                  ref.read(supportTicketsProvider.notifier).updateTicketDetails(
                    ticket.id,
                    slaTargetMinutes: mins,
                  );
                }
              },
            ),
            if (ticket.escalatedTo case final target?) ...[
              SizedBox(height: CoreSpacing.sm(context)),
              WidgetsStatusPill(
                label: l10n.supportTicketEscalated(target),
                color: CoreColors.brandOrange,
                compact: true,
              ),
            ],
            SizedBox(height: CoreSpacing.md(context)),
            Wrap(
              spacing: CoreSpacing.sm(context),
              runSpacing: CoreSpacing.sm(context),
              children: [
                ActionChip(
                  label: Text(l10n.supportTicketEscalateOperator),
                  onPressed:
                      () =>
                          _escalate(context, ref, ticket.id, 'operator', l10n),
                ),
                ActionChip(
                  label: Text(l10n.supportTicketEscalateCashier),
                  onPressed:
                      () => _escalate(context, ref, ticket.id, 'cashier', l10n),
                ),
              ],
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            DropdownButtonFormField<SupportTicketPriority>(
              initialValue: ticket.priority,
              decoration: InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
                ),
              ),
              items:
                  SupportTicketPriority.values
                      .map(
                        (p) => DropdownMenuItem(
                          value: p,
                          child: Text(_priorityLabel(p, l10n)),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                if (value == null) return;
                ref
                    .read(supportTicketsProvider.notifier)
                    .updateTicketDetails(ticket.id, priority: value);
                UtilityMockFeedback.showSuccess(
                  context,
                  l10n.catalogCrudUpdated,
                );
              },
            ),
            SizedBox(height: CoreSpacing.md(context)),
            DropdownButtonFormField<SupportTicketStatus>(
              initialValue: status,
              decoration: InputDecoration(
                labelText: l10n.supportTicketStatusLabel,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
                ),
              ),
              items:
                  SupportTicketStatus.values
                      .map(
                        (s) => DropdownMenuItem(
                          value: s,
                          child: Text(_supportTicketStatusLabel(s, l10n)),
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
                  l10n.supportTicketStatusUpdated,
                );
              },
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            if (ticket.messages.isNotEmpty) ...[
              Text(
                l10n.supportTicketConversation,
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
                        borderRadius: BorderRadius.circular(
                          CoreSpacing.radiusChipOf(context),
                        ),
                      ),
                      child: Text(
                        isAr ? msg.bodyAr : msg.bodyEn,
                        style: CoreTypography.bodyMedium(
                          context,
                          scheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppTextField(
              controller: _replyAr,
              label: l10n.supportTicketReplyArabic,
              maxLines: 2,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _replyEn,
              label: l10n.supportTicketReplyEnglish,
              maxLines: 2,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppButton(
              label: l10n.supportTicketSendReply,
              icon: Icons.send_outlined,
              onPressed: () {
                if (_replyEn.text.trim().isEmpty) return;
                final ok = ref
                    .read(supportTicketsProvider.notifier)
                    .addStaffReply(
                      ticketId: ticket.id,
                      bodyAr: _replyAr.text,
                      bodyEn: _replyEn.text,
                      nextStatus: SupportTicketStatus.resolved,
                    );
                if (!ok) {
                  UtilityMockFeedback.showWarning(
                    context,
                    l10n.supportTicketReplyFailed,
                  );
                  return;
                }
                UtilityMockFeedback.showSuccess(
                  context,
                  l10n.supportTicketReplySent,
                );
                Navigator.pop(context);
              },
            ),
            if (ticket.customerFeedback != null) ...[
              SizedBox(height: CoreSpacing.lg(context)),
              Text(
                l10n.supportTicketCustomerFeedback,
                style: CoreTypography.titleMedium(context, scheme.onSurface),
              ),
              Text(ticket.customerFeedback!),
            ],
          ],
        ),
      ),
    );
  }

  void _escalate(
    BuildContext context,
    WidgetRef ref,
    String ticketId,
    String target,
    AppLocalizations l10n,
  ) {
    final ok = ref
        .read(supportTicketsProvider.notifier)
        .escalateTicket(ticketId, target);
    if (!ok) {
      UtilityMockFeedback.showWarning(context, l10n.supportTicketNotFound);
      return;
    }
    UtilityMockFeedback.showSuccess(
      context,
      l10n.supportTicketEscalated(target),
    );
  }
}
