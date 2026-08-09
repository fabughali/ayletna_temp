import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_audit_event.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/audit_log_providers.dart';
import 'package:ayletna_restaurant_app/providers/support_order_lookup_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_confirm_dialog.dart';
import 'package:ayletna_restaurant_app/utilities/utility_demo_actions.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Order lookup for support agents — refund & cancel with audit (UI mock).
class SupportOrderLookupScreen extends ConsumerWidget {
  const SupportOrderLookupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final results = ref.watch(supportOrderLookupResultsProvider);

    return WidgetsScaffoldPage(
      title: l10n.supportOrderLookupTitle,
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(supportOrderLookupRowsProvider);
          UtilityMockFeedback.showInfo(
            context,
            l10n.supportOrderLookupSubtitle,
          );
        },
        child: ListView(
          padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
          children: [
            WidgetsInfoBanner(
              message: l10n.supportOrderLookupActionsBanner,
              icon: Icons.support_agent_outlined,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            Text(
              l10n.supportOrderLookupSubtitle,
              style: CoreTypography.caption(context, scheme.onSurfaceVariant),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAppTextField(
              label: l10n.supportOrderLookupSearchLabel,
              hintText: l10n.supportOrderLookupSearchHint,
              prefixIcon: Icons.search,
              onChanged:
                  (value) =>
                      ref.read(supportOrderLookupQueryProvider.notifier).state =
                          value,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            if (results.isEmpty)
              Center(
                child: Text(
                  l10n.supportOrderLookupNoResults,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              )
            else
              for (final row in results) _OrderLookupCard(row: row),
          ],
        ),
      ),
    );
  }
}

class _OrderLookupCard extends ConsumerWidget {
  const _OrderLookupCard({required this.row});

  final SupportOrderLookupRow row;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final order = row.order;

    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: WidgetsAppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                '#${order.id} · ${order.customerLabel}',
                style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w800),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${order.orderType.name} · ${UtilityFormatJod.format(order.totalJod)}',
                  ),
                  SizedBox(height: CoreSpacing.xs(context)),
                  Text(
                    '${l10n.supportTicketCustomerPhone}: ${row.customerPhone}',
                  ),
                  Text(
                    '${l10n.supportTicketCustomerAddress}: ${row.customerAddress}',
                  ),
                ],
              ),
              trailing: WidgetsStatusPill(
                label:
                    row.cancelled
                        ? l10n.supportOrderCancelled
                        : order.statusKey,
                color:
                    row.cancelled
                        ? CoreColors.semanticError
                        : CoreColors.semanticSuccess,
              ),
            ),
            if (row.refundedJod != null)
              Padding(
                padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
                child: Text(
                  '${l10n.supportOrderRefunded}: ${UtilityFormatJod.format(row.refundedJod!)}',
                  style: CoreTypography.caption(
                    context,
                    CoreColors.brandOrange,
                  ),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: WidgetsAppButton(
                    label: l10n.supportOrderRefundAction,
                    variant: WidgetsAppButtonVariant.outline,
                    icon: Icons.currency_exchange_outlined,
                    onPressed:
                        row.cancelled ? null : () => _refund(context, ref),
                  ),
                ),
                SizedBox(width: CoreSpacing.sm(context)),
                Expanded(
                  child: WidgetsAppButton(
                    label: l10n.supportOrderCancelAction,
                    variant: WidgetsAppButtonVariant.outline,
                    icon: Icons.cancel_outlined,
                    onPressed:
                        row.cancelled ? null : () => _cancel(context, ref),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refund(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final ok = await confirmDestructiveAction(
      context,
      title: l10n.supportOrderRefundConfirmTitle,
      message: l10n.supportOrderRefundConfirmMessage,
      confirmLabel: l10n.supportOrderRefundAction,
      cancelLabel: l10n.actionCancel,
    );
    if (!ok || !context.mounted) return;

    final amount = row.order.totalJod;
    final success = ref
        .read(supportOrderLookupRowsProvider.notifier)
        .refundOrder(row.order.id, amount);
    if (!success || !context.mounted) return;

    recordAuditEvent(
      ref,
      type: AuditEventType.refund,
      actorRole: AppRole.support,
      summaryEn: 'Refund ${row.order.id} — ${amount.toStringAsFixed(2)} JOD',
      summaryAr: 'استرداد ${row.order.id} — ${amount.toStringAsFixed(2)} د.أ',
      entityId: row.order.id,
      afterValue: amount.toStringAsFixed(2),
    );
    UtilityDemoActions.complete(
      context,
      successMessage: l10n.supportOrderRefunded,
    );
  }

  Future<void> _cancel(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final ok = await confirmDestructiveAction(
      context,
      title: l10n.supportOrderCancelConfirmTitle,
      message: l10n.supportOrderCancelConfirmMessage,
      confirmLabel: l10n.supportOrderCancelAction,
      cancelLabel: l10n.actionCancel,
    );
    if (!ok || !context.mounted) return;

    final success = ref
        .read(supportOrderLookupRowsProvider.notifier)
        .cancelOrder(row.order.id);
    if (!success) {
      if (context.mounted) {
        UtilityMockFeedback.showWarning(
          context,
          l10n.supportOrderAlreadyCancelled,
        );
      }
      return;
    }

    recordAuditEvent(
      ref,
      type: AuditEventType.orderCancel,
      actorRole: AppRole.support,
      summaryEn: 'Cancelled order ${row.order.id}',
      summaryAr: 'إلغاء الطلب ${row.order.id}',
      entityId: row.order.id,
    );
    if (context.mounted) {
      UtilityDemoActions.complete(
        context,
        successMessage: l10n.supportOrderCancelled,
      );
    }
  }
}
