import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/marketing_campaign_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_campaign_schedule_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Campaign picker for create forms (no visibility toggle — items start hidden).
class WidgetsCampaignCreateFields extends ConsumerWidget {
  const WidgetsCampaignCreateFields({
    super.key,
    required this.kind,
    required this.campaignId,
    required this.onCampaignIdChanged,
  });

  final CampaignEntityKind kind;
  final String? campaignId;
  final ValueChanged<String?> onCampaignIdChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final events = ref.watch(marketingCampaignEventsProvider);
    final fmt = DateFormat.MMMd(l10n.localeName).add_jm();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.marketingCampaignScheduleTitle,
          style: CoreTypography.titleMedium(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w800),
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Text(
          l10n.marketingCampaignScheduleHint,
          style: CoreTypography.caption(context, scheme.onSurfaceVariant),
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        if (events.isEmpty)
          Text(
            l10n.marketingVisibilityNeedsSchedule,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          )
        else
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: scheme.outlineVariant.withValues(alpha: 0.7),
              ),
              borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
            ),
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: CoreSpacing.sm(context),
                  ),
                  leading: Icon(
                    campaignId == null
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color:
                        campaignId == null
                            ? CoreColors.brandOrange
                            : scheme.onSurfaceVariant,
                  ),
                  title: Text(l10n.marketingCampaignNone),
                  onTap: () => onCampaignIdChanged(null),
                ),
                for (final e in events)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: CoreSpacing.sm(context),
                    ),
                    leading: Icon(
                      campaignId == e.id
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color:
                          campaignId == e.id
                              ? CoreColors.brandOrange
                              : scheme.onSurfaceVariant,
                    ),
                    title: Text(e.title(isAr)),
                    subtitle: Text(
                      '${fmt.format(e.startAt)} → ${fmt.format(e.endAt)}',
                    ),
                    onTap: () => onCampaignIdChanged(e.id),
                  ),
              ],
            ),
          ),
        SizedBox(height: CoreSpacing.sm(context)),
        WidgetsAppButton(
          label: l10n.marketingCampaignNew,
          icon: Icons.event_outlined,
          variant: WidgetsAppButtonVariant.secondary,
          onPressed: () async {
            final id = await showCampaignScheduleSheet(
              context: context,
              ref: ref,
              kind: kind,
              entityId: '',
              currentCampaignId: campaignId,
            );
            if (id == null) return;
            onCampaignIdChanged(id);
          },
        ),
      ],
    );
  }
}
