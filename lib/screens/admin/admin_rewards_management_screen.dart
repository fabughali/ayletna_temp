import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_reward.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/marketing_promo_codes_providers.dart';
import 'package:ayletna_restaurant_app/providers/rewards_admin_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_confirm_dialog.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Admin rewards catalog setup — points rules and reward CRUD.
class AdminRewardsManagementScreen extends ConsumerStatefulWidget {
  const AdminRewardsManagementScreen({super.key});

  @override
  ConsumerState<AdminRewardsManagementScreen> createState() =>
      _AdminRewardsManagementScreenState();
}

class _AdminRewardsManagementScreenState
    extends ConsumerState<AdminRewardsManagementScreen> {
  final _titleAr = TextEditingController();
  final _titleEn = TextEditingController();
  final _descAr = TextEditingController();
  final _descEn = TextEditingController();
  final _points = TextEditingController(text: '500');
  final _badgeAr = TextEditingController();
  final _badgeEn = TextEditingController();
  var _categoryKey = 'drinks';
  var _artKey = 'generic';
  var _colorKey = 'gold';
  var _isPopular = false;
  var _isLocked = false;
  var _isSoldOut = false;

  @override
  void dispose() {
    _titleAr.dispose();
    _titleEn.dispose();
    _descAr.dispose();
    _descEn.dispose();
    _points.dispose();
    _badgeAr.dispose();
    _badgeEn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final catalog = ref.watch(rewardsCatalogProvider);

    return WidgetsScaffoldPage(
      title: l10n.rewardsAdminSetupTitle,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.rewards),
          icon: Icons.card_giftcard_outlined,
          tooltip: l10n.rewardsCatalogTitle,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 300));
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppCard(
              title: l10n.rewardsAdminPointsRules,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.rewardsAdminTiersHint,
                    style: CoreTypography.caption(
                      context,
                      Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  for (final tier in catalog.tiers) ...[
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        l10n.rewardsAdminTierRange(
                          '${tier.minPoints}',
                          tier.maxPoints?.toString() ?? '∞',
                        ),
                      ),
                      subtitle: Text(
                        l10n.rewardsAdminTierRates(
                          tier.earnPerJod.toStringAsFixed(1),
                          tier.redeemFactor.toStringAsFixed(2),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => _editTier(context, tier),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _PromoCodesSection(isAr: isAr),
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAppCard(
              title: l10n.rewardsAdminAddReward,
              child: Column(
                children: [
                  WidgetsAppTextField(
                    controller: _titleAr,
                    label: l10n.productEditorArabicName,
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppTextField(
                    controller: _titleEn,
                    label: l10n.productEditorEnglishName,
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppTextField(
                    controller: _descAr,
                    label: l10n.productEditorArabicDesc,
                    maxLines: 2,
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppTextField(
                    controller: _descEn,
                    label: l10n.productEditorEnglishDesc,
                    maxLines: 2,
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppTextField(
                    controller: _points,
                    label: l10n.rewardsAdminPointsRequired,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  DropdownButtonFormField<String>(
                    initialValue: _categoryKey,
                    decoration: InputDecoration(
                      labelText: l10n.rewardsAdminCategory,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'drinks',
                        child: Text(l10n.rewardsAdminCategoryDrinks),
                      ),
                      DropdownMenuItem(
                        value: 'sides',
                        child: Text(l10n.rewardsAdminCategorySides),
                      ),
                      DropdownMenuItem(
                        value: 'main',
                        child: Text(l10n.rewardsAdminCategoryMain),
                      ),
                    ],
                    onChanged: (v) => setState(() => _categoryKey = v ?? 'drinks'),
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  DropdownButtonFormField<String>(
                    initialValue: _artKey,
                    decoration: InputDecoration(
                      labelText: l10n.rewardsAdminArtIcon,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(value: 'generic', child: Text(l10n.rewardsAdminArtGeneric)),
                      DropdownMenuItem(value: 'burger', child: Text(l10n.rewardsAdminArtBurger)),
                      DropdownMenuItem(value: 'drink', child: Text(l10n.rewardsAdminArtDrink)),
                      DropdownMenuItem(value: 'fries', child: Text(l10n.rewardsAdminArtFries)),
                      DropdownMenuItem(value: 'bowl', child: Text(l10n.rewardsAdminArtBowl)),
                      DropdownMenuItem(value: 'donut', child: Text(l10n.rewardsAdminArtDonut)),
                    ],
                    onChanged: (v) => setState(() => _artKey = v ?? 'generic'),
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  DropdownButtonFormField<String>(
                    initialValue: _colorKey,
                    decoration: InputDecoration(
                      labelText: l10n.rewardsAdminColorAccent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(value: 'gold', child: Text(l10n.rewardsAdminColorGold)),
                      DropdownMenuItem(value: 'orange', child: Text(l10n.rewardsAdminColorOrange)),
                      DropdownMenuItem(value: 'olive', child: Text(l10n.rewardsAdminColorOlive)),
                      DropdownMenuItem(value: 'delivery', child: Text(l10n.rewardsAdminColorDelivery)),
                      DropdownMenuItem(value: 'dine_in', child: Text(l10n.rewardsAdminColorDineIn)),
                      DropdownMenuItem(value: 'secondary', child: Text(l10n.rewardsAdminColorSecondary)),
                      DropdownMenuItem(value: 'tertiary', child: Text(l10n.rewardsAdminColorTertiary)),
                      DropdownMenuItem(value: 'outline', child: Text(l10n.rewardsAdminColorOutline)),
                    ],
                    onChanged: (v) => setState(() => _colorKey = v ?? 'gold'),
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppTextField(
                    controller: _badgeAr,
                    label: l10n.rewardsAdminBadgeAr,
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppTextField(
                    controller: _badgeEn,
                    label: l10n.rewardsAdminBadgeEn,
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  SwitchListTile(
                    title: Text(l10n.loyaltyPopular),
                    value: _isPopular,
                    onChanged: (v) => setState(() => _isPopular = v),
                  ),
                  SwitchListTile(
                    title: Text(l10n.loyaltyLocked),
                    value: _isLocked,
                    onChanged: (v) => setState(() => _isLocked = v),
                  ),
                  SwitchListTile(
                    title: Text(l10n.rewardsAdminSoldOut),
                    value: _isSoldOut,
                    onChanged: (v) => setState(() => _isSoldOut = v),
                  ),
                  SizedBox(height: CoreSpacing.md(context)),
                  WidgetsAppButton(
                    label: l10n.rewardsAdminAddToCatalog,
                    icon: Icons.add_outlined,
                    onPressed: () => _addReward(l10n),
                  ),
                ],
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            Text(
              l10n.rewardsAdminActiveRewards,
              style: CoreTypography.titleMedium(
                context,
                Theme.of(context).colorScheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            for (final reward in catalog.rewards) ...[
              _RewardAdminTile(reward: reward, isAr: isAr),
              SizedBox(height: CoreSpacing.sm(context)),
            ],
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }

  void _addReward(AppLocalizations l10n) {
    final pts = int.tryParse(_points.text) ?? 0;
    final reward = ModelCustomerReward(
      id: 'reward_${DateTime.now().millisecondsSinceEpoch}',
      titleAr: _titleAr.text,
      titleEn: _titleEn.text,
      descriptionAr: _descAr.text,
      descriptionEn: _descEn.text,
      points: pts,
      categoryKey: _categoryKey,
      artKey: _artKey,
      colorKey: _colorKey,
      badgeAr: _badgeAr.text.isNotEmpty ? _badgeAr.text : null,
      badgeEn: _badgeEn.text.isNotEmpty ? _badgeEn.text : null,
      isPopular: _isPopular,
      isLocked: _isLocked,
      isSoldOut: _isSoldOut,
    );
    final ok = ref.read(rewardsCatalogProvider.notifier).addReward(reward);
    if (!mounted) return;
    if (ok) {
      UtilityMockFeedback.showSuccess(
        context,
        l10n.rewardsAdminRewardAdded,
      );
      _titleAr.clear();
      _titleEn.clear();
      _descAr.clear();
      _descEn.clear();
      _badgeAr.clear();
      _badgeEn.clear();
      setState(() {
        _isPopular = false;
        _isLocked = false;
        _isSoldOut = false;
        _artKey = 'generic';
        _colorKey = 'gold';
      });
    } else {
      UtilityMockFeedback.showWarning(
        context,
        l10n.catalogCrudCheckFields,
      );
    }
  }

  Future<void> _editTier(BuildContext context, LoyaltyPointsTier tier) async {
    final l10n = AppLocalizations.of(context)!;
    final minCtrl = TextEditingController(text: '${tier.minPoints}');
    final maxCtrl = TextEditingController(text: tier.maxPoints?.toString() ?? '');
    final earnCtrl = TextEditingController(
      text: tier.earnPerJod.toStringAsFixed(1),
    );
    final redeemCtrl = TextEditingController(
      text: tier.redeemFactor.toStringAsFixed(2),
    );

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.only(
              left: CoreSpacing.lg(ctx),
              right: CoreSpacing.lg(ctx),
              top: CoreSpacing.lg(ctx),
              bottom:
                  MediaQuery.viewInsetsOf(ctx).bottom + CoreSpacing.lg(ctx),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetsAppTextField(
                  controller: minCtrl,
                  label: l10n.rewardsAdminTierMin,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(
                  controller: maxCtrl,
                  label: l10n.rewardsAdminTierMax,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(
                  controller: earnCtrl,
                  label: l10n.rewardsAdminTierEarn,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(
                  controller: redeemCtrl,
                  label: l10n.rewardsAdminTierRedeem,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: CoreSpacing.md(ctx)),
                WidgetsAppButton(
                  label: l10n.actionSave,
                  onPressed: () {
                    final maxRaw = maxCtrl.text.trim();
                    ref.read(rewardsCatalogProvider.notifier).upsertTier(
                      tier.copyWith(
                        minPoints: int.tryParse(minCtrl.text) ?? tier.minPoints,
                        maxPoints:
                            maxRaw.isEmpty ? null : int.tryParse(maxRaw),
                        clearMax: maxRaw.isEmpty,
                        earnPerJod:
                            double.tryParse(earnCtrl.text) ?? tier.earnPerJod,
                        redeemFactor:
                            double.tryParse(redeemCtrl.text) ??
                            tier.redeemFactor,
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
    );
  }
}

class _RewardAdminTile extends ConsumerWidget {
  const _RewardAdminTile({required this.reward, required this.isAr});

  final ModelCustomerReward reward;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAr ? reward.titleAr : reward.titleEn,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  l10n.rewardsAdminRewardMeta(
                    reward.points,
                    switch (reward.categoryKey) {
                      'sides' => l10n.rewardsAdminCategorySides,
                      'main' => l10n.rewardsAdminCategoryMain,
                      _ => l10n.rewardsAdminCategoryDrinks,
                    },
                  ),
                  style: CoreTypography.caption(context, scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _editReward(context, ref, reward),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () {
              confirmAdminDelete(
                context,
                isAr: isAr,
                onConfirmed: () {
                  ref.read(rewardsCatalogProvider.notifier).removeReward(reward.id);
                  UtilityMockFeedback.showInfo(
                    context,
                    l10n.catalogCrudDeleted,
                  );
                },
              );
            },
            icon: const Icon(Icons.delete_outline),
            color: CoreColors.semanticError,
          ),
        ],
      ),
    );
  }
}

void _editReward(BuildContext context, WidgetRef ref, ModelCustomerReward reward) {
  final l10n = AppLocalizations.of(context)!;
  final titleAr = TextEditingController(text: reward.titleAr);
  final titleEn = TextEditingController(text: reward.titleEn);
  final descAr = TextEditingController(text: reward.descriptionAr);
  final descEn = TextEditingController(text: reward.descriptionEn);
  final points = TextEditingController(text: reward.points.toString());
  final badgeAr = TextEditingController(text: reward.badgeAr);
  final badgeEn = TextEditingController(text: reward.badgeEn);
  var categoryKey = reward.categoryKey;
  var artKey = reward.artKey;
  var colorKey = reward.colorKey;
  var isPopular = reward.isPopular;
  var isLocked = reward.isLocked;
  var isSoldOut = reward.isSoldOut;

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder:
        (ctx) => StatefulBuilder(
          builder:
              (ctx, setSheetState) => Padding(
                padding: EdgeInsets.all(CoreSpacing.lg(ctx)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      WidgetsAppTextField(controller: titleAr, label: l10n.rewardsAdminTitleAr),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      WidgetsAppTextField(controller: titleEn, label: l10n.rewardsAdminTitleEn),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      WidgetsAppTextField(controller: descAr, label: l10n.rewardsAdminDescriptionAr, maxLines: 2),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      WidgetsAppTextField(controller: descEn, label: l10n.rewardsAdminDescriptionEn, maxLines: 2),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      WidgetsAppTextField(controller: points, label: l10n.rewardsAdminPointsLabel, keyboardType: TextInputType.number),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      DropdownButtonFormField<String>(
                        initialValue: categoryKey,
                        decoration: InputDecoration(
                          labelText: l10n.rewardsAdminCategory,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
                          ),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'drinks',
                            child: Text(l10n.rewardsAdminCategoryDrinks),
                          ),
                          DropdownMenuItem(
                            value: 'sides',
                            child: Text(l10n.rewardsAdminCategorySides),
                          ),
                          DropdownMenuItem(
                            value: 'main',
                            child: Text(l10n.rewardsAdminCategoryMain),
                          ),
                        ],
                        onChanged: (v) => setSheetState(() => categoryKey = v ?? categoryKey),
                      ),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      DropdownButtonFormField<String>(
                        initialValue: artKey,
                        decoration: InputDecoration(
                          labelText: l10n.rewardsAdminArtIcon,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
                          ),
                        ),
                        items: [
                          DropdownMenuItem(value: 'generic', child: Text(l10n.rewardsAdminArtGeneric)),
                          DropdownMenuItem(value: 'burger', child: Text(l10n.rewardsAdminArtBurger)),
                          DropdownMenuItem(value: 'drink', child: Text(l10n.rewardsAdminArtDrink)),
                          DropdownMenuItem(value: 'fries', child: Text(l10n.rewardsAdminArtFries)),
                          DropdownMenuItem(value: 'bowl', child: Text(l10n.rewardsAdminArtBowl)),
                          DropdownMenuItem(value: 'donut', child: Text(l10n.rewardsAdminArtDonut)),
                        ],
                        onChanged: (v) => setSheetState(() => artKey = v ?? 'generic'),
                      ),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      DropdownButtonFormField<String>(
                        initialValue: colorKey,
                        decoration: InputDecoration(
                          labelText: l10n.rewardsAdminColorAccent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
                          ),
                        ),
                        items: [
                          DropdownMenuItem(value: 'gold', child: Text(l10n.rewardsAdminColorGold)),
                          DropdownMenuItem(value: 'orange', child: Text(l10n.rewardsAdminColorOrange)),
                          DropdownMenuItem(value: 'olive', child: Text(l10n.rewardsAdminColorOlive)),
                          DropdownMenuItem(value: 'delivery', child: Text(l10n.rewardsAdminColorDelivery)),
                          DropdownMenuItem(value: 'dine_in', child: Text(l10n.rewardsAdminColorDineIn)),
                          DropdownMenuItem(value: 'secondary', child: Text(l10n.rewardsAdminColorSecondary)),
                          DropdownMenuItem(value: 'tertiary', child: Text(l10n.rewardsAdminColorTertiary)),
                          DropdownMenuItem(value: 'outline', child: Text(l10n.rewardsAdminColorOutline)),
                        ],
                        onChanged: (v) => setSheetState(() => colorKey = v ?? 'gold'),
                      ),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      WidgetsAppTextField(
                        controller: badgeAr,
                        label: l10n.rewardsAdminBadgeAr,
                      ),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      WidgetsAppTextField(
                        controller: badgeEn,
                        label: l10n.rewardsAdminBadgeEn,
                      ),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      SwitchListTile(
                        title: Text(l10n.loyaltyPopular),
                        value: isPopular,
                        onChanged: (v) => setSheetState(() => isPopular = v),
                      ),
                      SwitchListTile(
                        title: Text(l10n.loyaltyLocked),
                        value: isLocked,
                        onChanged: (v) => setSheetState(() => isLocked = v),
                      ),
                      SwitchListTile(
                        title: Text(l10n.rewardsAdminSoldOut),
                        value: isSoldOut,
                        onChanged: (v) => setSheetState(() => isSoldOut = v),
                      ),
                      SizedBox(height: CoreSpacing.md(ctx)),
                      WidgetsAppButton(
                        label: l10n.actionSave,
                        onPressed: () {
                          final ok = ref.read(rewardsCatalogProvider.notifier).updateReward(
                            ModelCustomerReward(
                              id: reward.id,
                              titleAr: titleAr.text,
                              titleEn: titleEn.text,
                              descriptionAr: descAr.text,
                              descriptionEn: descEn.text,
                              points: int.tryParse(points.text) ?? reward.points,
                              categoryKey: categoryKey,
                              artKey: artKey,
                              colorKey: colorKey,
                              badgeAr: badgeAr.text.isNotEmpty ? badgeAr.text : null,
                              badgeEn: badgeEn.text.isNotEmpty ? badgeEn.text : null,
                              isPopular: isPopular,
                              isLocked: isLocked,
                              isSoldOut: isSoldOut,
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

class _PromoCodesSection extends ConsumerStatefulWidget {
  const _PromoCodesSection({required this.isAr});

  final bool isAr;

  @override
  ConsumerState<_PromoCodesSection> createState() => _PromoCodesSectionState();
}

class _PromoCodesSectionState extends ConsumerState<_PromoCodesSection> {
  final _code = TextEditingController();
  var _category = MarketingPromoCodeCategory.discount;
  var _expanded = false;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  String _categoryLabel(AppLocalizations l10n, MarketingPromoCodeCategory c) {
    return switch (c) {
      MarketingPromoCodeCategory.discount => l10n.marketingPromoCategoryDiscount,
      MarketingPromoCodeCategory.addPoints =>
        l10n.marketingPromoCategoryAddPoints,
      MarketingPromoCodeCategory.freeMeal => l10n.marketingPromoCategoryFreeMeal,
      MarketingPromoCodeCategory.inviteFriends =>
        l10n.marketingPromoCategoryInviteFriends,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final codes = ref.watch(marketingPromoCodesProvider);

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.marketingPromoCodesTitle,
                    style: CoreTypography.titleMedium(
                      context,
                      Theme.of(context).colorScheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                ),
                Icon(
                  _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
          if (_expanded) ...[
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppTextField(
              controller: _code,
              label: l10n.marketingPromoCodeValue,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            DropdownButtonFormField<MarketingPromoCodeCategory>(
              initialValue: _category,
              decoration: InputDecoration(
                labelText: l10n.marketingPromoCodeCategory,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    CoreSpacing.radiusChipOf(context),
                  ),
                ),
              ),
              items: [
                for (final c in MarketingPromoCodeCategory.values)
                  DropdownMenuItem(
                    value: c,
                    child: Text(_categoryLabel(l10n, c)),
                  ),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _category = v);
              },
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppButton(
              label: l10n.marketingPromoCodeCreate,
              icon: Icons.add_outlined,
              onPressed: () {
                final text = _code.text.trim().toUpperCase();
                if (text.isEmpty) {
                  UtilityMockFeedback.showWarning(
                    context,
                    l10n.catalogCrudCheckFields,
                  );
                  return;
                }
                ref.read(marketingPromoCodesProvider.notifier).add(
                      MarketingPromoCode(
                        id: 'promo-${DateTime.now().millisecondsSinceEpoch}',
                        code: text,
                        category: _category,
                      ),
                    );
                _code.clear();
                setState(() => _expanded = false);
                UtilityMockFeedback.showSuccess(context, l10n.catalogCrudAdded);
              },
            ),
          ],
          SizedBox(height: CoreSpacing.md(context)),
          for (final code in codes)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(code.code, style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w800)),
              subtitle: Text(_categoryLabel(l10n, code.category)),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  ref.read(marketingPromoCodesProvider.notifier).remove(code.id);
                  UtilityMockFeedback.showSuccess(
                    context,
                    l10n.catalogCrudDeleted,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
