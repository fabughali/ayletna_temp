import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/loyalty_occasion_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Occasion rewards that apply to all customers when active.
class AdminLoyaltyConfigScreen extends ConsumerWidget {
  const AdminLoyaltyConfigScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final occasions = ref.watch(loyaltyOccasionsProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenLoyaltyConfig,
      child: ListView(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        children: [
          WidgetsAppCard(
            variant: WidgetsAppCardVariant.food,
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
            onTap: () => _editOccasion(
              context,
              ref,
              LoyaltyOccasionReward(
                id: 'occ_custom_${DateTime.now().millisecondsSinceEpoch}',
                key: LoyaltyOccasionKey.custom,
                titleEn: '',
                titleAr: '',
                rewardTitleEn: '',
                rewardTitleAr: '',
                pointsGrant: 25,
              ),
              isNew: true,
            ),
            child: Row(
              children: [
                Icon(Icons.add_circle, color: CoreColors.brandGold),
                SizedBox(width: CoreSpacing.sm(context)),
                Expanded(
                  child: Text(
                    l10n.marketingLoyaltyCreateSheetTitle,
                    style: CoreTypography.titleMedium(
                      context,
                      Theme.of(context).colorScheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppCard(
            title: l10n.loyaltyOccasionsTitle,
            subtitle: l10n.loyaltyOccasionsSubtitle,
            child: const SizedBox.shrink(),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (final occasion in occasions) ...[
            WidgetsAppCard(
              variant: WidgetsAppCardVariant.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          occasion.title(isAr),
                          style: CoreTypography.titleMedium(
                            context,
                            Theme.of(context).colorScheme.onSurface,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                      WidgetsAppSwitch(
                        value: occasion.active,
                        onChanged: (v) {
                          ref
                              .read(loyaltyOccasionsProvider.notifier)
                              .setActive(occasion.id, v);
                          UtilityMockFeedback.showSuccess(
                            context,
                            l10n.catalogCrudUpdated,
                          );
                        },
                      ),
                    ],
                  ),
                  Text(
                    occasion.rewardTitle(isAr),
                    style: CoreTypography.bodyMedium(
                      context,
                      Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: CoreSpacing.xs(context)),
                  Text(
                    l10n.loyaltyPointsShort('${occasion.pointsGrant}'),
                    style: CoreTypography.caption(
                      context,
                      CoreColors.brandOrange,
                    ).copyWith(fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppButton(
                    label: l10n.actionEdit,
                    variant: WidgetsAppButtonVariant.outline,
                    onPressed: () => _editOccasion(context, ref, occasion),
                  ),
                ],
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
          ],
        ],
      ),
    );
  }

  Future<void> _editOccasion(
    BuildContext context,
    WidgetRef ref,
    LoyaltyOccasionReward occasion, {
    bool isNew = false,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final titleEn = TextEditingController(text: occasion.titleEn);
    final titleAr = TextEditingController(text: occasion.titleAr);
    final rewardEn = TextEditingController(text: occasion.rewardTitleEn);
    final rewardAr = TextEditingController(text: occasion.rewardTitleAr);
    final points = TextEditingController(text: '${occasion.pointsGrant}');

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.only(
              left: CoreSpacing.lg(ctx),
              right: CoreSpacing.lg(ctx),
              top: CoreSpacing.lg(ctx),
              bottom:
                  MediaQuery.viewInsetsOf(ctx).bottom + CoreSpacing.lg(ctx),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WidgetsAppTextField(
                    controller: titleEn,
                    label: l10n.catalogCrudNameEn,
                  ),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(
                    controller: titleAr,
                    label: l10n.catalogCrudNameAr,
                  ),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(
                    controller: rewardEn,
                    label: l10n.loyaltyOccasionRewardEn,
                  ),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(
                    controller: rewardAr,
                    label: l10n.loyaltyOccasionRewardAr,
                  ),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(
                    controller: points,
                    label: l10n.loyaltyOccasionPoints,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: CoreSpacing.md(ctx)),
                  WidgetsAppButton(
                    label: l10n.actionSave,
                    onPressed: () {
                      if (titleEn.text.trim().isEmpty) return;
                      ref.read(loyaltyOccasionsProvider.notifier).upsert(
                        occasion.copyWith(
                          titleEn: titleEn.text.trim(),
                          titleAr:
                              titleAr.text.trim().isEmpty
                                  ? titleEn.text.trim()
                                  : titleAr.text.trim(),
                          rewardTitleEn: rewardEn.text.trim(),
                          rewardTitleAr:
                              rewardAr.text.trim().isEmpty
                                  ? rewardEn.text.trim()
                                  : rewardAr.text.trim(),
                          pointsGrant:
                              int.tryParse(points.text) ??
                              occasion.pointsGrant,
                        ),
                      );
                      Navigator.pop(ctx);
                      UtilityMockFeedback.showSuccess(
                        context,
                        isNew ? l10n.catalogCrudAdded : l10n.catalogCrudUpdated,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
