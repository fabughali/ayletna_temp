import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/marketing_campaign_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_catalog_images.dart';
import 'package:ayletna_restaurant_app/utilities/utility_confirm_dialog.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_campaign_create_fields.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_campaign_schedule_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_image_editor.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_points_image_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_product_cards.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Marketing combos — campaign-gated visibility, points-only reward value.
class AdminCombosManagementScreen extends ConsumerWidget {
  const AdminCombosManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return WidgetsScaffoldPage(
      title: l10n.marketingTabCombos,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.combos),
          icon: Icons.room_service_outlined,
          tooltip: l10n.homeCombos,
        ),
      ],
      child: ListView(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        children: [
          _AddComboSection(isAr: isAr),
          SizedBox(height: CoreSpacing.lg(context)),
          _CombosListSection(isAr: isAr),
        ],
      ),
    );
  }
}

class _AddComboSection extends ConsumerStatefulWidget {
  const _AddComboSection({required this.isAr});
  final bool isAr;

  @override
  ConsumerState<_AddComboSection> createState() => _AddComboSectionState();
}

class _AddComboSectionState extends ConsumerState<_AddComboSection> {
  bool _expanded = false;
  final _titleEn = TextEditingController();
  final _titleAr = TextEditingController();
  final _subtitleEn = TextEditingController();
  final _subtitleAr = TextEditingController();
  final _price = TextEditingController(text: '18.5');
  final _discount = TextEditingController(text: '12');
  final _rewardPoints = TextEditingController(text: '0');
  var _comboIsPopular = false;
  List<String> _comboImages = const [];
  String? _campaignId;

  @override
  void dispose() {
    _titleEn.dispose();
    _titleAr.dispose();
    _subtitleEn.dispose();
    _subtitleAr.dispose();
    _price.dispose();
    _discount.dispose();
    _rewardPoints.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: CoreSpacing.xs(context)),
              child: Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: CoreColors.brandOrange.withValues(alpha: 0.14),
                      borderRadius:
                          BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(CoreSpacing.md(context)),
                      child: Icon(
                        Icons.room_service_outlined,
                        color: CoreColors.brandOrange,
                      ),
                    ),
                  ),
                  SizedBox(width: CoreSpacing.md(context)),
                  Expanded(
                    child: Text(
                      l10n.promoMgmtCreateCombo,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: scheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppTextField(
              controller: _titleEn,
              label: l10n.catalogCrudNameEn,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _titleAr,
              label: l10n.catalogCrudNameAr,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _subtitleEn,
              label: l10n.catalogCrudDescriptionEn,
              maxLines: 2,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _subtitleAr,
              label: l10n.catalogCrudDescriptionAr,
              maxLines: 2,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _price,
              label: l10n.catalogCrudPrice,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _discount,
              label: l10n.promoMgmtDiscountPercent,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _rewardPoints,
              label: l10n.marketingRewardPointsLabel,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.homePopularThisWeek),
              value: _comboIsPopular,
              onChanged: (v) => setState(() => _comboIsPopular = v),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsCatalogImageEditor(
              imageUrls: _comboImages,
              onChanged: (urls) => setState(() => _comboImages = urls),
              isAr: widget.isAr,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsCampaignCreateFields(
              kind: CampaignEntityKind.combo,
              campaignId: _campaignId,
              onCampaignIdChanged: (id) => setState(() => _campaignId = id),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppButton(
              label: l10n.actionAdd,
              icon: Icons.add_outlined,
              onPressed: _submit,
            ),
          ],
        ],
      ),
    );
  }

  void _submit() {
    final l10n = AppLocalizations.of(context)!;
    if (_comboImages.length < CatalogImageLimits.minProductImages) {
      UtilityMockFeedback.showWarning(
        context,
        l10n.productEditorAddMinImages,
      );
      return;
    }
    final comboId = nextCatalogId('combo');
    final campaignId = _campaignId;
    final ok = ref.read(adminCatalogProvider.notifier).addCombo(
          ModelCatalogCombo(
            id: comboId,
            titleEn: _titleEn.text,
            titleAr: _titleAr.text,
            subtitleEn: _subtitleEn.text,
            subtitleAr:
                _subtitleAr.text.isNotEmpty ? _subtitleAr.text : null,
            priceJod: double.tryParse(_price.text) ?? 0,
            discountPercent: double.tryParse(_discount.text) ?? 12,
            rewardPoints: int.tryParse(_rewardPoints.text) ?? 0,
            imageUrls: _comboImages,
            isAvailable: false,
            isPopular: _comboIsPopular,
            campaignId: campaignId,
          ),
        );
    if (!mounted) return;
    if (ok) {
      if (campaignId != null && campaignId.isNotEmpty) {
        attachEntityToCampaign(
          ref: ref,
          campaignId: campaignId,
          kind: CampaignEntityKind.combo,
          entityId: comboId,
        );
      }
      _titleEn.clear();
      _titleAr.clear();
      _subtitleEn.clear();
      _subtitleAr.clear();
      _rewardPoints.text = '0';
      setState(() {
        _comboImages = const [];
        _campaignId = null;
        _expanded = false;
      });
      UtilityMockFeedback.showSuccess(context, l10n.catalogCrudAdded);
    } else {
      UtilityMockFeedback.showWarning(
        context,
        l10n.catalogCrudCheckFields,
      );
    }
  }
}

class _CombosListSection extends ConsumerWidget {
  const _CombosListSection({required this.isAr});
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final combos = ref.watch(adminCatalogProvider).resolvedCombos;

    if (combos.isEmpty) {
      return WidgetsAppCard(
        variant: WidgetsAppCardVariant.food,
        padding: EdgeInsets.all(CoreSpacing.lg(context)),
        child: Column(
          children: [
            Icon(
              Icons.room_service_outlined,
              color: CoreColors.brandOrange,
              size: CoreContentSizes.productHeroIcon(context) * 0.36,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            Text(
              l10n.catalogBrowseEmpty,
              textAlign: TextAlign.center,
              style: CoreTypography.bodyMedium(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return WidgetsFoodCatalogGrid(
      children: [
        for (var i = 0; i < combos.length; i++)
          _MarketingComboCard(combo: combos[i], isAr: isAr, index: i),
      ],
    );
  }
}

class _MarketingComboCard extends ConsumerWidget {
  const _MarketingComboCard({
    required this.combo,
    required this.isAr,
    required this.index,
  });

  final ModelCatalogCombo combo;
  final bool isAr;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Stack(
      fit: StackFit.expand,
      children: [
        WidgetsComboProductCard(
          combo: combo,
          isAr: isAr,
          l10n: l10n,
          index: index,
          actionLabel: l10n.actionEdit,
          actionIcon: Icons.edit_outlined,
          onAction: () => _editCombo(context, ref, combo),
          onTap: () => _editCombo(context, ref, combo),
        ),
        Positioned(
          top: CoreSpacing.sm(context),
          right: CoreSpacing.sm(context),
          child: Material(
            color: Colors.black45,
            shape: const CircleBorder(),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) async {
                if (value == 'edit') {
                  _editCombo(context, ref, combo);
                } else if (value == 'campaign') {
                  await _scheduleCampaign(context, ref, combo);
                } else if (value == 'delete') {
                  confirmAdminDelete(
                    context,
                    isAr: isAr,
                    onConfirmed:
                        () => ref
                            .read(adminCatalogProvider.notifier)
                            .deleteCombo(combo.id),
                  );
                }
              },
              itemBuilder:
                  (_) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text(l10n.actionEdit),
                    ),
                    PopupMenuItem(
                      value: 'campaign',
                      child: Text(l10n.marketingCampaignAdjust),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text(l10n.addressesDelete),
                    ),
                  ],
            ),
          ),
        ),
      ],
    );
  }

    String _campaignLabel(
    WidgetRef ref,
    String? campaignId,
    bool isAr,
    AppLocalizations l10n,
  ) {
    final events = ref.watch(marketingCampaignEventsProvider);
    final fmt = DateFormat.MMMd(l10n.localeName).add_jm();
    if (campaignId != null) {
      for (final e in events) {
        if (e.id == campaignId) {
          return '${e.title(isAr)} · ${fmt.format(e.startAt)} → ${fmt.format(e.endAt)}';
        }
      }
    }
    for (final e in events) {
      if (e.comboIds.contains(combo.id)) {
        return '${e.title(isAr)} · ${fmt.format(e.startAt)} → ${fmt.format(e.endAt)}';
      }
    }
    return l10n.marketingVisibilityNeedsSchedule;
  }

  Future<void> _onVisibilityChanged(
    BuildContext context,
    WidgetRef ref,
    ModelCatalogCombo combo,
    bool show,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    if (!show) {
      ref.read(adminCatalogProvider.notifier).updateCombo(
            combo.copyWith(isAvailable: false),
          );
      return;
    }
    final campaignId = await showCampaignScheduleSheet(
      context: context,
      ref: ref,
      kind: CampaignEntityKind.combo,
      entityId: combo.id,
      currentCampaignId: combo.campaignId,
    );
    if (!context.mounted) return;
    if (campaignId == null) {
      UtilityMockFeedback.showWarning(
        context,
        l10n.marketingVisibilityNeedsSchedule,
      );
      return;
    }
    ref.read(adminCatalogProvider.notifier).updateCombo(
          combo.copyWith(isAvailable: true, campaignId: campaignId),
        );
    UtilityMockFeedback.showSuccess(context, l10n.catalogCrudUpdated);
  }

  Future<void> _scheduleCampaign(
    BuildContext context,
    WidgetRef ref,
    ModelCatalogCombo combo,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final campaignId = await showCampaignScheduleSheet(
      context: context,
      ref: ref,
      kind: CampaignEntityKind.combo,
      entityId: combo.id,
      currentCampaignId: combo.campaignId,
    );
    if (!context.mounted || campaignId == null) return;
    ref.read(adminCatalogProvider.notifier).updateCombo(
          combo.copyWith(campaignId: campaignId),
        );
    UtilityMockFeedback.showSuccess(context, l10n.catalogCrudUpdated);
  }

  void _editCombo(
    BuildContext context,
    WidgetRef ref,
    ModelCatalogCombo combo,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final titleEn = TextEditingController(text: combo.titleEn);
    final titleAr = TextEditingController(text: combo.titleAr);
    final subtitleEn = TextEditingController(text: combo.subtitleEn);
    final subtitleAr = TextEditingController(text: combo.subtitleAr);
    final price = TextEditingController(text: combo.priceJod.toString());
    final discount = TextEditingController(
      text: combo.discountPercent.toString(),
    );
    final rewardPoints = TextEditingController(
      text: '${combo.rewardPoints}',
    );
    var isPopular = combo.isPopular;
    var imageUrls = [...combo.imageUrls];

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.only(
            left: CoreSpacing.lg(ctx),
            right: CoreSpacing.lg(ctx),
            top: CoreSpacing.lg(ctx),
            bottom: MediaQuery.viewInsetsOf(ctx).bottom + CoreSpacing.lg(ctx),
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
                  controller: subtitleEn,
                  label: l10n.catalogCrudDescriptionEn,
                  maxLines: 2,
                ),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(
                  controller: subtitleAr,
                  label: l10n.catalogCrudDescriptionAr,
                  maxLines: 2,
                ),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(
                  controller: price,
                  label: l10n.catalogCrudPrice,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(
                  controller: discount,
                  label: l10n.promoMgmtDiscountPercent,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(
                  controller: rewardPoints,
                  label: l10n.marketingRewardPointsLabel,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: CoreSpacing.sm(ctx)),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.homePopularThisWeek),
                  value: isPopular,
                  onChanged: (v) => setSheetState(() => isPopular = v),
                ),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsCatalogImageEditor(
                  imageUrls: imageUrls,
                  onChanged: (urls) => setSheetState(() => imageUrls = urls),
                  isAr: isAr,
                ),
                SizedBox(height: CoreSpacing.md(ctx)),
                WidgetsAppButton(
                  label: l10n.marketingCampaignAdjust,
                  variant: WidgetsAppButtonVariant.outline,
                  onPressed: () async {
                    Navigator.pop(ctx);
                    await _scheduleCampaign(context, ref, combo);
                  },
                ),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppButton(
                  label: l10n.actionSave,
                  onPressed: () {
                    if (imageUrls.length <
                        CatalogImageLimits.minProductImages) {
                      UtilityMockFeedback.showWarning(
                        ctx,
                        l10n.catalogCrudMinOneImage,
                      );
                      return;
                    }
                    final ok = ref
                        .read(adminCatalogProvider.notifier)
                        .updateCombo(
                          combo.copyWith(
                            titleEn: titleEn.text,
                            titleAr: titleAr.text,
                            subtitleEn: subtitleEn.text,
                            subtitleAr: subtitleAr.text.isNotEmpty
                                ? subtitleAr.text
                                : null,
                            priceJod:
                                double.tryParse(price.text) ?? combo.priceJod,
                            discountPercent:
                                double.tryParse(discount.text) ??
                                combo.discountPercent,
                            rewardPoints:
                                int.tryParse(rewardPoints.text) ??
                                combo.rewardPoints,
                            isPopular: isPopular,
                            imageUrls: imageUrls,
                          ),
                        );
                    if (ok) {
                      Navigator.pop(ctx);
                      UtilityMockFeedback.showSuccess(
                        context,
                        l10n.catalogCrudUpdated,
                      );
                    } else {
                      UtilityMockFeedback.showWarning(
                        ctx,
                        l10n.catalogCrudUpdateFailed,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
