import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_inventory_mock.dart';
import 'package:ayletna_restaurant_app/data/models/model_list_entry.dart';
import 'package:ayletna_restaurant_app/data/models/model_support_ticket_record.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_plates_providers.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/inventory_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/support_session_providers.dart';
import 'package:intl/intl.dart';
import 'package:ayletna_restaurant_app/utilities/utility_file_download.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_report_export.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_hub_nav_actions.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_bubble.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_read_only_hub_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_soft_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [AuditLogScreen].
class AdminAuditLogScreen extends ConsumerWidget {
  const AdminAuditLogScreen({this.readOnly = false, super.key});

  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return WidgetsScaffoldPage(
      title: l10n.screenAuditLog,
      actions: readOnly
          ? WidgetsHubNavActions.forContext(context, readOnlyOwner: true)
          : [
              WidgetsIconButton(
                onPressed: () => context.push(AppRoutePaths.notifications),
                icon: Icons.notifications_outlined,
                tooltip: l10n.screenNotifications,
              ),
              ...WidgetsHubNavActions.forContext(context),
            ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.read(supportTicketsProvider.notifier).refreshQueue();
          ref.invalidate(inventoryAuditHistoryProvider);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 880;
            final timeline = _AuditTimeline(l10n: l10n, isAr: isAr);
            final controls = Column(
              children: [
                _AuditFiltersCard(l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                _SecuritySnapshotCard(l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                _InventoryAuditCard(l10n: l10n, isAr: isAr),
              ],
            );

            return ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.md(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
                if (readOnly) const WidgetsReadOnlyHubBanner(),
                _AuditHero(l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: timeline),
                      if (!readOnly) ...[
                        SizedBox(width: CoreSpacing.lg(context)),
                        Expanded(flex: 4, child: controls),
                      ],
                    ],
                  )
                else ...[
                  timeline,
                  if (!readOnly) ...[
                    SizedBox(height: CoreSpacing.lg(context)),
                    controls,
                  ],
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AuditHero extends ConsumerWidget {
  const _AuditHero({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final financial = ref.watch(adminFinancialProvider);
    final openTickets =
        ref
            .watch(supportTicketsProvider)
            .tickets
            .where(
              (ticket) =>
                  ticket.status == SupportTicketStatus.open ||
                  ticket.status == SupportTicketStatus.inProgress,
            )
            .length;
    final permissionChanges =
        ref.watch(adminUsersProvider).activeOverrides.length;
    final todayEvents = 14 + openTickets + permissionChanges;
    final sensitiveChanges = permissionChanges + (financial.shiftCloseApproved ? 1 : 0);
    final needsReview =
        openTickets +
        (financial.auditRequestedAt == null ? 1 : 0) +
        (ref.watch(adminTipDistributionProvider).approved ? 0 : 1);

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
          WidgetsSoftBadge(
            label: l10n.auditLogTrueTrailBadge,
            color: CoreColors.surfaceLight,
            foreground: CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
l10n.auditLogHeroHeadline,
            style: CoreTypography.headlineSmall(
              context,
              CoreColors.surfaceLight,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              _HeroChip(
                label: l10n.auditLogTodayEvents,
                value: '$todayEvents',
                icon: Icons.fact_check_outlined,
              ),
              _HeroChip(
                label: l10n.auditLogSensitiveChanges,
                value: '$sensitiveChanges',
                icon: Icons.privacy_tip_outlined,
              ),
              _HeroChip(
                label: l10n.auditLogNeedsReview,
                value: '$needsReview',
                icon: Icons.priority_high_outlined,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              WidgetsAppButton(
                label: l10n.ownerRequestAudit,
                onPressed:
                    financial.auditRequestedAt != null
                        ? null
                        : () async {
                          final confirmed = await UtilityMockFeedback.confirm(
                            context: context,
                            title: l10n.ownerRequestAudit,
                            message:
l10n.auditLogRequestConfirmMessage,
                            confirmLabel: l10n.actionConfirm,
                            cancelLabel: l10n.actionCancel,
                            icon: Icons.assignment_outlined,
                          );
                          if (!context.mounted || !confirmed) return;
                          ref
                              .read(adminFinancialProvider.notifier)
                              .requestDetailedAudit();
                          UtilityMockFeedback.showSuccess(
                            context,
                            l10n.ownerRequestAudit,
                          );
                        },
                icon: Icons.assignment_outlined,
              ),
              WidgetsAppButton(
                label: l10n.auditLogExportLog,
                onPressed: () async {
                  final filter = ref.read(adminAuditFilterProvider);
                  ref.read(adminFinancialProvider.notifier).recordAuditExport();
                  final csv = buildAuditLogCsv(
                    category: filter.category,
                    lastExportAt: DateTime.now(),
                  );
                  await downloadTextFile(
                    'ayletna-audit-${filter.category}.csv',
                    csv,
                    mimeType: 'text/csv',
                  );
                  if (!context.mounted) return;
                  UtilityMockFeedback.showSuccess(
                    context,
                    l10n.auditLogExportDownloaded,
                  );
                },
                icon: Icons.ios_share_outlined,
                variant: WidgetsAppButtonVariant.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AuditTimeline extends ConsumerWidget {
  const _AuditTimeline({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(adminAuditFilterProvider).category;
    final financial = ref.watch(adminFinancialProvider);
    final deposit = ref.watch(adminDepositConfigProvider);
    final users = ref.watch(adminUsersProvider);
    final plates = ref.watch(adminPlatesProvider);
    final inventoryAudit = ref.watch(inventoryAuditHistoryProvider);

    final events = _buildAuditEvents(
      isAr: isAr,
      l10n: l10n,
      financial: financial,
      deposit: deposit,
      users: users,
      plates: plates,
      inventoryAudit: inventoryAudit,
    );
    final filtered =
        category == 'all'
            ? events
            : events.where((event) => event.category == category).toList();

    return WidgetsAppCard(
      title: l10n.screenAuditLog,
      subtitle:
l10n.auditLogTimelineSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.history_edu_outlined,
        color: CoreColors.brandBrown,
      ),
      child:
          filtered.isEmpty
              ? Padding(
                padding: EdgeInsets.symmetric(vertical: CoreSpacing.md(context)),
                child: Text(
l10n.auditLogNoEventsInScope,
                  style: CoreTypography.bodyMedium(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              )
              : Column(
                children: [
                  for (var index = 0; index < filtered.length; index++)
                    _AuditTimelineRow(
                      event: filtered[index],
                      isLast: index == filtered.length - 1,
                    ),
                ],
              ),
    );
  }
}

List<_AuditEvent> _buildAuditEvents({
  required bool isAr,
  required AppLocalizations l10n,
  required AdminFinancialState financial,
  required AdminDepositConfigState deposit,
  required AdminUsersState users,
  required AdminPlatesState plates,
  required List<ModelInventoryAuditRow> inventoryAudit,
}) {
  final events = <_AuditEvent>[];

  if (financial.auditRequestedAt != null) {
    events.add(
      _AuditEvent(
        category: 'finance',
        title: l10n.auditLogDetailedAuditRequested,
        actor: l10n.auditLogActorOwner,
        area: l10n.auditLogAreaGovernance,
        time: DateFormat.jm().format(financial.auditRequestedAt!),
        detail:
l10n.auditLogAuditRequestDetail,
        color: CoreColors.semanticTip,
        icon: Icons.assignment_outlined,
      ),
    );
  }
  if (financial.lastAuditExportAt != null) {
    events.add(
      _AuditEvent(
        category: 'finance',
        title: l10n.auditLogAuditExported,
        actor: l10n.auditLogActorOperator,
        area: l10n.auditLogAreaReports,
        time: DateFormat.jm().format(financial.lastAuditExportAt!),
        detail:
l10n.auditLogAuditExportDetail,
        color: CoreColors.brandBrown,
        icon: Icons.ios_share_outlined,
      ),
    );
  }
  if (financial.shiftCloseApproved) {
    events.add(
      _AuditEvent(
        category: 'finance',
        title: l10n.auditLogShiftCloseApproved,
        actor: l10n.auditLogActorFinance,
        area: l10n.auditLogAreaCashClose,
        time: l10n.auditLogToday,
        detail:
l10n.auditLogShiftCloseDetail,
        color: CoreColors.semanticRevenue,
        icon: Icons.point_of_sale_outlined,
      ),
    );
  }
  for (final entry in users.activeOverrides.entries) {
    final matched =
        users.allMembers.where((member) => member.email == entry.key);
    final member = matched.isEmpty ? null : matched.first;
    events.add(
      _AuditEvent(
        category: 'users',
        title:
            entry.value
                ? l10n.auditLogUserActivated
                : l10n.auditLogUserDeactivated,
        actor: l10n.auditLogActorOperator,
        area:
            member == null
                ? entry.key
                : (isAr ? member.nameAr : member.nameEn),
        time: l10n.auditLogToday,
        detail: entry.key,
        color: CoreColors.orderTypeDelivery,
        icon: Icons.admin_panel_settings_outlined,
      ),
    );
  }
  if (deposit.saved) {
    events.add(
      _AuditEvent(
        category: 'plates',
        title: l10n.auditLogDepositSettingsSaved,
        actor: l10n.auditLogActorOwner,
        area: l10n.screenDepositConfig,
        time: l10n.auditLogToday,
        detail:
l10n.auditLogDepositSavedDetail(deposit.globalDepositJod.toStringAsFixed(2), '${deposit.returnWindowHours.round()}'),
        color: CoreColors.semanticDeposit,
        icon: Icons.room_service_outlined,
      ),
    );
  }
  for (final report in plates.breakageReports.take(2)) {
    events.add(
      _AuditEvent(
        category: 'plates',
        title: isAr ? report.titleAr : report.titleEn,
        actor: l10n.auditLogActorLogistics,
        area: l10n.auditLogTrayBreakageArea,
        time: isAr ? report.timeAr : report.timeEn,
        detail: isAr ? report.metaAr : report.metaEn,
        color: CoreColors.semanticError,
        icon: Icons.broken_image_outlined,
      ),
    );
  }
  for (final row in inventoryAudit.take(2)) {
    events.add(
      _AuditEvent(
        category: 'inventory',
        title: isAr ? row.typeAr : row.typeEn,
        actor: isAr ? row.userAr : row.userEn,
        area: l10n.auditLogInventoryArea,
        time: isAr ? row.dateAr : row.dateEn,
        detail: isAr ? row.balanceAr : row.balanceEn,
        color:
            row.isNegative ? CoreColors.semanticError : CoreColors.brandOlive,
        icon: Icons.inventory_2_outlined,
      ),
    );
  }

  events.addAll([
    _AuditEvent(
      category: 'users',
      title: l10n.auditLogUserRoleChanged,
      actor: l10n.auditLogActorOperatorAhmad,
      area: l10n.auditLogAreaRolesPrivacy,
      time: l10n.auditLogToday0942,
      detail:
l10n.auditLogRoleChangeDetail,
      color: CoreColors.orderTypeDelivery,
      icon: Icons.admin_panel_settings_outlined,
    ),
    _AuditEvent(
      category: 'finance',
      title: l10n.auditLogCashierShiftClosed,
      actor: l10n.auditLogActorCashierLayla,
      area: l10n.auditLogAreaFinance,
      time: l10n.auditLogToday0858,
      detail:
l10n.auditLogCashierCloseDetail,
      color: CoreColors.semanticRevenue,
      icon: Icons.point_of_sale_outlined,
    ),
    _AuditEvent(
      category: 'plates',
      title: l10n.auditLogTrayDepositEdited,
      actor: l10n.auditLogActorOwner,
      area: l10n.screenDepositConfig,
      time: l10n.auditLogYesterday1820,
      detail:
          isAr
              ? 'تم تغيير نافذة الإرجاع إلى ٤٨ ساعة.'
              : 'Return window changed to 48 hours.',
      color: CoreColors.semanticDeposit,
      icon: Icons.room_service_outlined,
    ),
    for (final entry in MockupCatalog.auditLogs)
      _AuditEvent.fromEntry(entry: entry, isAr: isAr, l10n: l10n),
  ]);

  return events;
}

class _AuditFiltersCard extends ConsumerWidget {
  const _AuditFiltersCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  static const _filters = [
    ('all', 'All events', 'كل الأحداث'),
    ('finance', 'Finance', 'مالية'),
    ('users', 'Users', 'مستخدمون'),
    ('inventory', 'Inventory', 'مخزون'),
    ('plates', 'Plates', 'صواني'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(adminAuditFilterProvider).category;

    return WidgetsAppCard(
      title: l10n.auditLogFiltersTitle,
      subtitle: l10n.auditLogFiltersSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.filter_list,
        color: CoreColors.brandOlive,
      ),
      child: Wrap(
        spacing: CoreSpacing.sm(context),
        runSpacing: CoreSpacing.sm(context),
        children: [
          for (final filter in _filters)
            _FilterChip(
              label: isAr ? filter.$3 : filter.$2,
              selected: selected == filter.$1,
              onSelected:
                  () =>
                      ref
                          .read(adminAuditFilterProvider.notifier)
                          .setCategory(filter.$1),
            ),
        ],
      ),
    );
  }
}

class _SecuritySnapshotCard extends ConsumerWidget {
  const _SecuritySnapshotCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final financial = ref.watch(adminFinancialProvider);
    final deposit = ref.watch(adminDepositConfigProvider);
    final permissionChanges = ref.watch(adminUsersProvider).activeOverrides.length;
    final financialEdits =
        (financial.shiftCloseApproved ? 1 : 0) +
        (deposit.saved ? 1 : 0) +
        (financial.lastAuditExportAt != null ? 1 : 0) +
        (financial.auditRequestedAt != null ? 1 : 0);

    return WidgetsAppCard(
      title: l10n.auditLogGovernanceTitle,
      subtitle:
          isAr
              ? 'ملخص لما يحتاج مراجعة قبل نهاية اليوم.'
              : 'What needs review before end of day.',
      leading: WidgetsIconBubble(
        icon: Icons.security_outlined,
        color: CoreColors.semanticTip,
      ),
      child: Column(
        children: [
          _SnapshotLine(
            label: l10n.auditLogFailedLogins,
            value: '0',
            color: CoreColors.semanticSuccess,
          ),
          _SnapshotLine(
            label: l10n.auditLogPermissionChanges,
            value: '$permissionChanges',
            color: CoreColors.orderTypeDelivery,
          ),
          _SnapshotLine(
            label: l10n.auditLogFinancialEdits,
            value: '$financialEdits',
            color: CoreColors.semanticRevenue,
          ),
        ],
      ),
    );
  }
}

class _InventoryAuditCard extends ConsumerWidget {
  const _InventoryAuditCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rows = ref.watch(inventoryAuditHistoryProvider).take(3).toList();

    return WidgetsAppCard(
      title: l10n.inventoryRecentHistoryAudit,
      subtitle:
          isAr
              ? 'آخر تغيرات المخزون كجزء من التدقيق.'
              : 'Recent stock changes as part of the audit trail.',
      leading: WidgetsIconBubble(
        icon: Icons.inventory_2_outlined,
        color: CoreColors.brandOlive,
      ),
      child:
          rows.isEmpty
              ? Text(
                l10n.auditLogNoStockChanges,
                style: CoreTypography.bodyMedium(
                  context,
                  Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              )
              : Column(
                children: [
                  for (final row in rows)
                    _InventoryAuditRow(row: row, isAr: isAr),
                ],
              ),
    );
  }
}

class _AuditTimelineRow extends StatelessWidget {
  const _AuditTimelineRow({required this.event, required this.isLast});

  final _AuditEvent event;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            WidgetsIconBubble(icon: event.icon, color: event.color),
            if (!isLast)
              Container(
                width: 2,
                height: UtilitySizer.of(context, 72),
                color: event.color.withValues(alpha: 0.20),
              ),
          ],
        ),
        SizedBox(width: CoreSpacing.md(context)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: CoreSpacing.md(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        event.title,
                        style: CoreTypography.titleMedium(
                          context,
                          Theme.of(context).colorScheme.onSurface,
                        ).copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                    WidgetsSoftBadge(label: event.time, color: event.color),
                  ],
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  '${event.actor} · ${event.area}',
                  style: CoreTypography.caption(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ).copyWith(fontWeight: FontWeight.w800),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  event.detail,
                  style: CoreTypography.bodyMedium(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InventoryAuditRow extends StatelessWidget {
  const _InventoryAuditRow({required this.row, required this.isAr});

  final ModelInventoryAuditRow row;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final color =
        row.isNegative ? CoreColors.semanticError : CoreColors.brandOlive;
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      ),
      child: Row(
        children: [
          WidgetsIconBubble(
            icon: Icons.inventory_outlined,
            color: color,
            size: UtilitySizer.of(context, 36), iconSize: CoreContentSizes.orderTypeIcon(context),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAr ? row.typeAr : row.typeEn,
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  '${isAr ? row.dateAr : row.dateEn} · ${isAr ? row.userAr : row.userEn}'
                  '${row.evidenceKey != null && row.evidenceKey!.isNotEmpty ? ' · ${row.evidenceKey}' : ''}',
                  style: CoreTypography.caption(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            isAr ? row.amountAr : row.amountEn,
            style: CoreTypography.titleMedium(
              context,
              color,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _SnapshotLine extends StatelessWidget {
  const _SnapshotLine({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: CoreTypography.caption(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          WidgetsSoftBadge(label: value, color: color),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    this.selected = false,
    this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      avatar:
          selected
              ? Icon(Icons.check, size: CoreContentSizes.orderTypeIcon(context), color: CoreColors.brandOlive)
              : null,
      onPressed: onSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
        side: BorderSide(
          color:
              selected
                  ? CoreColors.brandOlive
                  : Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.22),
        ),
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UtilitySizer.of(context, 168),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: CoreColors.surfaceLight.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        border: Border.all(
          color: CoreColors.surfaceLight.withValues(alpha: 0.30),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: CoreColors.surfaceLight),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: CoreTypography.titleMedium(
                    context,
                    CoreColors.surfaceLight,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    CoreColors.surfaceLight.withValues(alpha: 0.84),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AuditEvent {
  const _AuditEvent({
    required this.category,
    required this.title,
    required this.actor,
    required this.area,
    required this.time,
    required this.detail,
    required this.color,
    required this.icon,
  });

  factory _AuditEvent.fromEntry({
    required ModelListEntry entry,
    required bool isAr,
    required AppLocalizations l10n,
  }) {
    final category = switch (entry.id) {
      'log1' => 'users',
      'log2' => 'finance',
      _ => 'finance',
    };
    return _AuditEvent(
      category: category,
      title: isAr ? entry.titleAr : entry.titleEn,
      actor: l10n.auditLogActorSystem,
      area: l10n.auditLogAreaAdminLog,
      time: isAr ? entry.subtitleAr ?? '' : entry.subtitleEn ?? '',
      detail: l10n.auditLogSystemEntryDetail,
      color: CoreColors.brandBrown,
      icon: Icons.fact_check_outlined,
    );
  }

  final String category;
  final String title;
  final String actor;
  final String area;
  final String time;
  final String detail;
  final Color color;
  final IconData icon;
}
