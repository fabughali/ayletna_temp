import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_staff_mock.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/staff_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD StaffDailyTipsScreen — daily payout status and tip transparency.
class StaffDailyTipsScreen extends ConsumerWidget {
  const StaffDailyTipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final session = ref.watch(staffSessionProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenStaffDailyTips,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.staffTipHistory),
          icon: Icons.history_outlined,
          tooltip: l10n.screenStaffTipHistory,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh:
            () async => UtilityMockFeedback.showSuccess(
              context,
              l10n.screenStaffDailyTips,
            ),
        child: ListView(
          children: [
            _TipsHero(session: session),
            SizedBox(height: CoreSpacing.lg(context)),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 920;
                final shifts = Column(
                  children: [
                    for (final shift in MockupCatalog.staffTipShifts) ...[
                      _ShiftPayoutCard(shift: shift),
                      SizedBox(height: CoreSpacing.sm(context)),
                    ],
                  ],
                );
                final side = Column(
                  children: [
                    _PayoutPolicyCard(session: session),
                    SizedBox(height: CoreSpacing.lg(context)),
                    const _TransactionsCard(),
                  ],
                );
                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: shifts),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 3, child: side),
                    ],
                  );
                }
                return Column(
                  children: [
                    shifts,
                    SizedBox(height: CoreSpacing.lg(context)),
                    side,
                  ],
                );
              },
            ),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _TipsHero extends StatelessWidget {
  const _TipsHero({required this.session});

  final StaffSessionState session;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final ackLabel = switch (session.tipAckStatus) {
      StaffTipAckStatus.acknowledged => l10n.staffVerifiedRevenue,
      StaffTipAckStatus.disputed => l10n.supportTicketRequestFollowUp,
      StaffTipAckStatus.pending => l10n.staffVerifiedRevenue,
    };
    final ackColor = switch (session.tipAckStatus) {
      StaffTipAckStatus.acknowledged => CoreColors.semanticSuccess,
      StaffTipAckStatus.disputed => CoreColors.semanticError,
      StaffTipAckStatus.pending => CoreColors.semanticSuccess,
    };

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBubble(
                icon: Icons.volunteer_activism_outlined,
                color: CoreColors.brandOrange,
                large: true,
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.staffDailyTipsSummary,
                      style: CoreTypography.headlineSmall(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      l10n.staffTipsReportMeta,
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _SoftBadge(
                label: ackLabel,
                color: ackColor,
                icon:
                    session.tipAckStatus == StaffTipAckStatus.disputed
                        ? Icons.report_outlined
                        : Icons.verified_outlined,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            '${l10n.staffDailyTipsAmount} ${l10n.staffJod}',
            style: CoreTypography.headlineLarge(
              context,
              CoreColors.brandOrange,
            ).copyWith(fontWeight: FontWeight.w900, letterSpacing: 0),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              _SoftBadge(
                label: l10n.staffTipsVsYesterday,
                color: CoreColors.semanticSuccess,
                icon: Icons.trending_up,
              ),
              _SoftBadge(
                label: l10n.staffTipsLastEntry,
                color: scheme.primary,
                icon: Icons.schedule_outlined,
              ),
              _SoftBadge(
                label: l10n.staffFinalTotalAmount,
                color: CoreColors.brandGold,
                icon: Icons.payments_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShiftPayoutCard extends StatelessWidget {
  const _ShiftPayoutCard({required this.shift});
  final ModelStaffTipShift shift;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Row(
        children: [
          _IconBubble(
            icon:
                shift.iconKey == 'lunch'
                    ? Icons.wb_sunny_outlined
                    : Icons.breakfast_dining_outlined,
            color: scheme.primary,
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAr ? shift.titleAr : shift.titleEn,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  isAr ? shift.timeAr : shift.timeEn,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isAr ? shift.amountLabelAr : shift.amountLabelEn,
                style: CoreTypography.bodyMedium(
                  context,
                  scheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
              SizedBox(height: CoreSpacing.xs(context)),
              _SoftBadge(
                label: l10n.staffVerified,
                color: CoreColors.semanticSuccess,
                icon: Icons.check_circle_outline,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PayoutPolicyCard extends ConsumerWidget {
  const _PayoutPolicyCard({required this.session});

  final StaffSessionState session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final ackPending = session.tipAckStatus == StaffTipAckStatus.pending;

    Future<void> acknowledge() async {
      final confirmed = await UtilityMockFeedback.confirm(
        context: context,
        title: l10n.staffAcknowledgeReceipt,
        message: l10n.staffEarningsPolicyBody,
        confirmLabel: l10n.staffAcknowledgeReceipt,
        cancelLabel: l10n.actionCancel,
        icon: Icons.check_circle_outline,
      );
      if (!context.mounted || !confirmed) return;
      ref.read(staffSessionProvider.notifier).acknowledgeTips();
      UtilityMockFeedback.showSuccess(context, l10n.staffAcknowledgeReceipt);
    }

    Future<void> dispute() async {
      final confirmed = await UtilityMockFeedback.confirm(
        context: context,
        title: l10n.supportTicketRequestFollowUp,
        message: l10n.staffEarningsPolicyBody,
        confirmLabel: l10n.supportTicketRequestFollowUp,
        cancelLabel: l10n.actionCancel,
        confirmVariant: WidgetsAppButtonVariant.danger,
        icon: Icons.report_outlined,
      );
      if (!context.mounted || !confirmed) return;
      ref.read(staffSessionProvider.notifier).disputeTips();
      UtilityMockFeedback.showWarning(context, l10n.supportTicketRequestFollowUp);
    }

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      accentColor: CoreColors.brandOrange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconBubble(
                icon: Icons.policy_outlined,
                color: CoreColors.brandOrange,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.staffEarningsPolicy,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.staffEarningsPolicyBody,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _AmountLine(
            label: l10n.staffCashTips,
            value: l10n.staffCashTipsAmount,
          ),
          _AmountLine(
            label: l10n.staffDigitalTips,
            value: l10n.staffDigitalTipsAmount,
          ),
          Divider(
            height: CoreSpacing.lg(context),
            color: scheme.outlineVariant,
          ),
          _AmountLine(
            label: l10n.staffFinalTotal,
            value: l10n.staffFinalTotalAmount,
            strong: true,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.staffAcknowledgeReceipt,
            onPressed: ackPending ? acknowledge : null,
            icon: Icons.check_circle_outline,
            fullWidth: true,
          ),
          if (ackPending) ...[
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppButton(
              label: l10n.supportTicketRequestFollowUp,
              onPressed: dispute,
              icon: Icons.report_outlined,
              variant: WidgetsAppButtonVariant.outline,
              fullWidth: true,
            ),
          ] else ...[
            SizedBox(height: CoreSpacing.sm(context)),
            _SoftBadge(
              label:
                  session.tipAckStatus == StaffTipAckStatus.acknowledged
                      ? l10n.staffVerified
                      : l10n.supportTicketRequestFollowUp,
              color:
                  session.tipAckStatus == StaffTipAckStatus.acknowledged
                      ? CoreColors.semanticSuccess
                      : CoreColors.semanticError,
              icon:
                  session.tipAckStatus == StaffTipAckStatus.acknowledged
                      ? Icons.check_circle_outline
                      : Icons.report_outlined,
            ),
          ],
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.staffAcknowledgeNote,
            textAlign: TextAlign.center,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _TransactionsCard extends StatelessWidget {
  const _TransactionsCard();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.staffTransactionHistory,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsAppButton(
                label: l10n.staffViewFullLog,
                onPressed: () => context.push(AppRoutePaths.staffTipHistory),
                variant: WidgetsAppButtonVariant.ghost,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (final txn in MockupCatalog.staffTipTransactions) ...[
            _TransactionRow(transaction: txn, isAr: isAr),
            SizedBox(height: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({required this.transaction, required this.isAr});
  final ModelStaffTipTransaction transaction;
  final bool isAr;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (transaction.colorKey) {
      'dineIn' => CoreColors.orderTypeDineIn,
      'takeaway' => CoreColors.orderTypeTakeaway,
      _ => CoreColors.orderTypePlated,
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Row(
          children: [
            _IconBubble(icon: Icons.receipt_long_outlined, color: color),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAr ? transaction.metaAr : transaction.metaEn,
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    isAr ? transaction.timeAr : transaction.timeEn,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            _SoftBadge(
              label:
                  isAr ? transaction.amountLabelAr : transaction.amountLabelEn,
              color: color,
              icon: Icons.payments_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class _AmountLine extends StatelessWidget {
  const _AmountLine({
    required this.label,
    required this.value,
    this.strong = false,
  });
  final String label;
  final String value;
  final bool strong;
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: CoreTypography.bodyMedium(
              context,
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Text(
          value,
          style: CoreTypography.bodyMedium(
            context,
            strong
                ? CoreColors.brandOrange
                : Theme.of(context).colorScheme.onSurface,
          ).copyWith(fontWeight: strong ? FontWeight.w900 : FontWeight.w800),
        ),
      ],
    ),
  );
}

class _SoftBadge extends StatelessWidget {
  const _SoftBadge({
    required this.label,
    required this.color,
    required this.icon,
  });
  final String label;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
      border: Border.all(color: color.withValues(alpha: 0.24)),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: CoreSpacing.sm(context),
        vertical: CoreSpacing.xs(context),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: CoreContentSizes.orderTypeIcon(context),
            color: color,
          ),
          SizedBox(width: CoreSpacing.xs(context)),
          Text(
            label,
            style: CoreTypography.caption(
              context,
              color,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    ),
  );
}

class _IconBubble extends StatelessWidget {
  const _IconBubble({
    required this.icon,
    required this.color,
    this.large = false,
  });
  final IconData icon;
  final Color color;
  final bool large;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
    ),
    child: Padding(
      padding: EdgeInsets.all(CoreSpacing.sm(context)),
      child: Icon(
        icon,
        color: color,
        size:
            large
                ? CoreContentSizes.logoCard(context) * 0.52
                : CoreContentSizes.orderTypeIcon(context),
      ),
    ),
  );
}
