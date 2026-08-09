import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_push_campaign_draft.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/marketing_push_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MarketingPushCampaignsScreen extends ConsumerWidget {
  const MarketingPushCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final campaigns = ref.watch(pushCampaignsProvider);

    return WidgetsScaffoldPage(
      title: l10n.marketingPushCampaignsTitle,
      child: ListView(
        padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
        children: [
          WidgetsAppCard(
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.lg(context)),
              child: Text(
                l10n.marketingPushCampaignsSubtitle,
                style: CoreTypography.bodyMedium(
                  context,
                  Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.marketingPushAddDraft,
            icon: Icons.notifications_active_outlined,
            onPressed: () {
              ref.read(pushCampaignsProvider.notifier).addDraft(
                titleAr: l10n.marketingPushNewDraftAr,
                titleEn: l10n.marketingPushNewDraftEn,
              );
              UtilityMockFeedback.showSuccess(context, l10n.marketingPushDraftAdded);
            },
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          for (final campaign in campaigns)
            Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
              child: WidgetsAppCard(
                child: Padding(
                  padding: EdgeInsets.all(CoreSpacing.lg(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              campaign.title(isAr),
                              style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w900),
                            ),
                          ),
                          WidgetsStatusPill(
                            label: _statusLabel(campaign.status, l10n),
                            color: _statusColor(campaign.status),
                          ),
                        ],
                      ),
                      SizedBox(height: CoreSpacing.sm(context)),
                      Text(campaign.body(isAr)),
                      if (campaign.scheduledAt != null) ...[
                        SizedBox(height: CoreSpacing.sm(context)),
                        Text(
                          '${l10n.marketingPushScheduled}: ${DateFormat.yMMMd(isAr ? 'ar' : 'en').format(campaign.scheduledAt!)}',
                          style: CoreTypography.caption(
                            context,
                            Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                      if (campaign.status == PushCampaignStatus.draft) ...[
                        SizedBox(height: CoreSpacing.md(context)),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _editCampaign(
                                  context,
                                  ref,
                                  campaign,
                                  l10n,
                                ),
                                child: Text(l10n.actionEdit),
                              ),
                            ),
                            SizedBox(width: CoreSpacing.sm(context)),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _scheduleCampaign(
                                  context,
                                  ref,
                                  campaign,
                                  l10n,
                                ),
                                child: Text(l10n.marketingPushScheduleAction),
                              ),
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: CoreSpacing.sm(context)),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton.icon(
                          onPressed: () async {
                            final confirmed = await UtilityMockFeedback.confirm(
                              context: context,
                              title: l10n.marketingPushDeleteConfirmTitle,
                              message: l10n.marketingPushDeleteConfirmMessage,
                              confirmLabel: l10n.addressesDelete,
                              cancelLabel: l10n.actionCancel,
                              icon: Icons.delete_outline,
                            );
                            if (!context.mounted || !confirmed) return;
                            final deleted = ref
                                .read(pushCampaignsProvider.notifier)
                                .deleteCampaign(campaign.id);
                            if (!context.mounted) return;
                            if (deleted) {
                              UtilityMockFeedback.showSuccess(
                                context,
                                l10n.catalogCrudDeleted,
                              );
                            }
                          },
                          icon: Icon(Icons.delete_outline, size: CoreContentSizes.orderTypeIcon(context)),
                          label: Text(l10n.addressesDelete),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _statusLabel(PushCampaignStatus status, AppLocalizations l10n) =>
      switch (status) {
        PushCampaignStatus.draft => l10n.marketingPushDraft,
        PushCampaignStatus.scheduled => l10n.marketingPushScheduledStatus,
        PushCampaignStatus.sent => l10n.marketingPushSent,
      };

  Color _statusColor(PushCampaignStatus status) => switch (status) {
        PushCampaignStatus.draft => CoreColors.brandGold,
        PushCampaignStatus.scheduled => CoreColors.orderTypeDelivery,
        PushCampaignStatus.sent => CoreColors.semanticSuccess,
      };

  Future<void> _editCampaign(
    BuildContext context,
    WidgetRef ref,
    PushCampaignDraft campaign,
    AppLocalizations l10n,
  ) async {
    final titleAr = TextEditingController(text: campaign.titleAr);
    final titleEn = TextEditingController(text: campaign.titleEn);
    final bodyAr = TextEditingController(text: campaign.bodyAr);
    final bodyEn = TextEditingController(text: campaign.bodyEn);
    var scheduledAt = campaign.scheduledAt;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (ctx, setSheetState) => Padding(
                  padding: EdgeInsets.only(
                    left: CoreSpacing.lg(ctx),
                    right: CoreSpacing.lg(ctx),
                    top: CoreSpacing.lg(ctx),
                    bottom:
                        MediaQuery.viewInsetsOf(ctx).bottom +
                        CoreSpacing.lg(ctx),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WidgetsAppTextField(
                          controller: titleAr,
                          label: l10n.marketingPushFieldTitleAr,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: titleEn,
                          label: l10n.marketingPushFieldTitleEn,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: bodyAr,
                          label: l10n.marketingPushFieldBodyAr,
                          maxLines: 3,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: bodyEn,
                          label: l10n.marketingPushFieldBodyEn,
                          maxLines: 3,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        ListTile(
                          title: Text(
                            scheduledAt != null
                                ? '${l10n.marketingPushScheduled}: ${DateFormat.yMMMd(l10n.localeName).format(scheduledAt!)}'
                                : l10n.marketingPushNoSchedule,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: ctx,
                                initialDate: scheduledAt ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 365),
                                ),
                              );
                              if (!ctx.mounted) return;
                              if (date != null) {
                                final time = await showTimePicker(
                                  context: ctx,
                                  initialTime: TimeOfDay.fromDateTime(
                                    scheduledAt ?? DateTime.now(),
                                  ),
                                );
                                if (time != null) {
                                  setSheetState(
                                    () => scheduledAt = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      time.hour,
                                      time.minute,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(height: CoreSpacing.md(ctx)),
                        WidgetsAppButton(
                          label: l10n.actionSave,
                          onPressed: () {
                            ref.read(pushCampaignsProvider.notifier).updateDraft(
                              campaign.copyWith(
                                titleAr: titleAr.text,
                                titleEn: titleEn.text,
                                bodyAr: bodyAr.text,
                                bodyEn: bodyEn.text,
                                scheduledAt: scheduledAt,
                              ),
                            );
                            Navigator.pop(ctx);
                            UtilityMockFeedback.showSuccess(
                              context,
                              l10n.catalogCrudUpdated,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }

  Future<void> _scheduleCampaign(
    BuildContext context,
    WidgetRef ref,
    PushCampaignDraft campaign,
    AppLocalizations l10n,
  ) async {
    if (campaign.bodyEn.trim().isEmpty && campaign.bodyAr.trim().isEmpty) {
      UtilityMockFeedback.showWarning(context, l10n.marketingPushBodyRequired);
      return;
    }

    final confirmed = await UtilityMockFeedback.confirm(
      context: context,
      title: l10n.marketingPushScheduleConfirmTitle,
      message: l10n.marketingPushScheduleConfirmMessage,
      confirmLabel: l10n.marketingPushScheduleAction,
      cancelLabel: l10n.actionCancel,
      icon: Icons.notifications_active_outlined,
    );
    if (!context.mounted || !confirmed) return;

    final scheduled =
        ref.read(pushCampaignsProvider.notifier).schedule(campaign.id);
    if (!context.mounted) return;
    if (scheduled) {
      UtilityMockFeedback.showSuccess(context, l10n.marketingPushScheduledMock);
    } else {
      UtilityMockFeedback.showError(context, l10n.marketingPushScheduleFailed);
    }
  }
}