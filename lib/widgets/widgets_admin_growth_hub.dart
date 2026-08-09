import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_filter_chip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_bubble.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_soft_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum WidgetsAdminGrowthHubSection { staff, privacy, loyalty, offers }

/// Shared admin hub for team hours, owner privacy, loyalty, and offers.
class WidgetsAdminGrowthHub extends ConsumerStatefulWidget {
  const WidgetsAdminGrowthHub({required this.initialSection, super.key});

  final WidgetsAdminGrowthHubSection initialSection;

  @override
  ConsumerState<WidgetsAdminGrowthHub> createState() =>
      _WidgetsAdminGrowthHubState();
}

class _WidgetsAdminGrowthHubState extends ConsumerState<WidgetsAdminGrowthHub> {
  late WidgetsAdminGrowthHubSection _section = widget.initialSection;
  var _hideRawCosts = true;
  var _hideStaffSalaries = true;
  var _netProfitOnly = false;
  var _doublePoints = true;
  var _birthdayDessert = true;
  var _lunchOffer = true;
  var _familyTrayOffer = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsScaffoldPage(
      title: _screenTitle(l10n),
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(
            switch (_section) {
              WidgetsAdminGrowthHubSection.staff => AppRoutePaths.operatorStaffHours,
              WidgetsAdminGrowthHubSection.privacy => AppRoutePaths.appAdminOwnerConfig,
              WidgetsAdminGrowthHubSection.loyalty => AppRoutePaths.marketingLoyalty,
              WidgetsAdminGrowthHubSection.offers => AppRoutePaths.marketingOffers,
            },
          ),
          icon: Icons.settings_outlined,
          tooltip: l10n.screenSettings,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(
            switch (_section) {
              WidgetsAdminGrowthHubSection.staff => AppRoutePaths.operatorReports,
              WidgetsAdminGrowthHubSection.privacy => AppRoutePaths.ownerHub,
              WidgetsAdminGrowthHubSection.loyalty => AppRoutePaths.marketingHub,
              WidgetsAdminGrowthHubSection.offers => AppRoutePaths.marketingHub,
            },
          ),
          icon: Icons.assessment_outlined,
          tooltip: l10n.screenReports,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh:
            () async =>
                UtilityMockFeedback.showInfo(context, _screenTitle(l10n)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 920;
            return ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.md(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
                _HubHero(section: _section),
                SizedBox(height: CoreSpacing.lg(context)),
                _HubTabs(
                  selected: _section,
                  onSelected: (section) => setState(() => _section = section),
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: _buildPrimary(context)),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 4, child: _buildSideRail(context)),
                    ],
                  )
                else ...[
                  _buildPrimary(context),
                  SizedBox(height: CoreSpacing.lg(context)),
                  _buildSideRail(context),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  String _screenTitle(AppLocalizations l10n) {
    return switch (_section) {
      WidgetsAdminGrowthHubSection.staff => l10n.screenStaffHoursReport,
      WidgetsAdminGrowthHubSection.privacy => l10n.screenOwnerViewConfig,
      WidgetsAdminGrowthHubSection.loyalty => l10n.screenLoyaltyConfig,
      WidgetsAdminGrowthHubSection.offers => l10n.screenOffersManagement,
    };
  }

  Widget _buildPrimary(BuildContext context) {
    return switch (_section) {
      WidgetsAdminGrowthHubSection.staff => const _StaffHoursPanel(),
      WidgetsAdminGrowthHubSection.privacy => _PrivacyPanel(
        hideRawCosts: _hideRawCosts,
        hideStaffSalaries: _hideStaffSalaries,
        netProfitOnly: _netProfitOnly,
        onHideRawCosts: (value) => setState(() => _hideRawCosts = value),
        onHideStaffSalaries:
            (value) => setState(() => _hideStaffSalaries = value),
        onNetProfitOnly: (value) => setState(() => _netProfitOnly = value),
      ),
      WidgetsAdminGrowthHubSection.loyalty => _LoyaltyPanel(
        doublePoints: _doublePoints,
        birthdayDessert: _birthdayDessert,
        onDoublePoints: (value) {
          setState(() => _doublePoints = value);
          final current = ref.read(adminGrowthConfigProvider);
          ref
              .read(adminGrowthConfigProvider.notifier)
              .update(current.copyWith(doublePoints: value));
        },
        onBirthdayDessert: (value) => setState(() => _birthdayDessert = value),
      ),
      WidgetsAdminGrowthHubSection.offers => _OffersPanel(
        lunchOffer: _lunchOffer,
        familyTrayOffer: _familyTrayOffer,
        onLunchOffer: (value) => setState(() => _lunchOffer = value),
        onFamilyTrayOffer: (value) => setState(() => _familyTrayOffer = value),
      ),
    };
  }

  void _saveGrowthSettings() {
    ref.read(adminGrowthConfigProvider.notifier).update(
      AdminGrowthConfigState(
        hideRawCosts: _hideRawCosts,
        hideStaffSalaries: _hideStaffSalaries,
        netProfitOnly: _netProfitOnly,
        doublePoints: _doublePoints,
        birthdayDessert: _birthdayDessert,
        lunchOffer: _lunchOffer,
        familyTrayOffer: _familyTrayOffer,
      ),
    );
    ref.read(adminGrowthConfigProvider.notifier).save();
    UtilityMockFeedback.showSuccess(
      context,
      AppLocalizations.of(context)!.adminGrowthSettingsSaved,
    );
  }

  Widget _buildSideRail(BuildContext context) {
    return Column(
      children: [
        _DecisionCard(section: _section),
        SizedBox(height: CoreSpacing.lg(context)),
        _ActionCard(section: _section, onSave: _saveGrowthSettings),
      ],
    );
  }
}

class _HubHero extends StatelessWidget {
  const _HubHero({required this.section});

  final WidgetsAdminGrowthHubSection section;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        gradient: const LinearGradient(
          colors: [CoreColors.brandOlive, CoreColors.brandBrown],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetsSoftBadge(
            label: l10n.adminGrowthHubBadge,
            color: CoreColors.surfaceLight,
            foreground: CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.adminGrowthHubHero,
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
              _HeroMetric(
                label: l10n.adminGrowthHubTodayHours,
                value: '124.5',
                icon: Icons.schedule_outlined,
              ),
              _HeroMetric(
                label: l10n.adminGrowthHubLoyaltyGuests,
                value: '2.4K',
                icon: Icons.workspace_premium_outlined,
              ),
              _HeroMetric(
                label: l10n.adminGrowthHubActiveOffers,
                value: '6',
                icon: Icons.local_offer_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HubTabs extends StatelessWidget {
  const _HubTabs({required this.selected, required this.onSelected});

  final WidgetsAdminGrowthHubSection selected;
  final ValueChanged<WidgetsAdminGrowthHubSection> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final labels = {
      WidgetsAdminGrowthHubSection.staff: l10n.screenStaffHoursReport,
      WidgetsAdminGrowthHubSection.privacy: l10n.screenOwnerViewConfig,
      WidgetsAdminGrowthHubSection.loyalty: l10n.screenLoyaltyConfig,
      WidgetsAdminGrowthHubSection.offers: l10n.screenOffersManagement,
    };

    return Wrap(
      spacing: CoreSpacing.sm(context),
      runSpacing: CoreSpacing.sm(context),
      children:
          WidgetsAdminGrowthHubSection.values.map((section) {
            return WidgetsFilterChip(
              label: labels[section]!,
              selected: selected == section,
              onSelected: (_) => onSelected(section),
            );
          }).toList(),
    );
  }
}

class _StaffHoursPanel extends StatelessWidget {
  const _StaffHoursPanel();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      title: l10n.adminGrowthStaffTitle,
      subtitle: l10n.adminGrowthStaffSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.groups_2_outlined,
        color: CoreColors.semanticTip,
      ),
      child: Column(
        children: [
          _DataRow(
            label: l10n.adminGrowthKitchen,
            value: '42.5h',
            detail: l10n.adminGrowthKitchenDetail,
            color: CoreColors.brandOlive,
          ),
          _DataRow(
            label: l10n.adminGrowthCashier,
            value: '31h',
            detail: l10n.adminGrowthCashierDetail,
            color: CoreColors.orderTypeDineIn,
          ),
          _DataRow(
            label: l10n.adminGrowthDelivery,
            value: '28h',
            detail: l10n.adminGrowthDeliveryDetail,
            color: CoreColors.orderTypeDelivery,
          ),
          _DataRow(
            label: l10n.adminGrowthTips,
            value: '312 JOD',
            detail: l10n.adminGrowthTipsDetail,
            color: CoreColors.semanticTip,
          ),
        ],
      ),
    );
  }
}

class _PrivacyPanel extends StatelessWidget {
  const _PrivacyPanel({
    required this.hideRawCosts,
    required this.hideStaffSalaries,
    required this.netProfitOnly,
    required this.onHideRawCosts,
    required this.onHideStaffSalaries,
    required this.onNetProfitOnly,
  });

  final bool hideRawCosts;
  final bool hideStaffSalaries;
  final bool netProfitOnly;
  final ValueChanged<bool> onHideRawCosts;
  final ValueChanged<bool> onHideStaffSalaries;
  final ValueChanged<bool> onNetProfitOnly;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      title: l10n.screenOwnerViewConfig,
      subtitle: l10n.adminGrowthPrivacySubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.privacy_tip_outlined,
        color: CoreColors.semanticDeposit,
      ),
      child: Column(
        children: [
          _SwitchRow(
            label: l10n.ownerHideRawCosts,
            detail: l10n.ownerHideRawCostsBody,
            value: hideRawCosts,
            onChanged: onHideRawCosts,
          ),
          _SwitchRow(
            label: l10n.ownerHideStaffSalaries,
            detail: l10n.ownerHideStaffSalariesBody,
            value: hideStaffSalaries,
            onChanged: onHideStaffSalaries,
          ),
          _SwitchRow(
            label: l10n.ownerShowOnlyNetProfit,
            detail: l10n.ownerShowOnlyNetProfitBody,
            value: netProfitOnly,
            onChanged: onNetProfitOnly,
          ),
          _PreviewStrip(
            label: l10n.ownerLivePreview,
            value: netProfitOnly ? '•••••••' : '14,250 JOD / 4,280 JOD net',
          ),
        ],
      ),
    );
  }
}

class _LoyaltyPanel extends StatelessWidget {
  const _LoyaltyPanel({
    required this.doublePoints,
    required this.birthdayDessert,
    required this.onDoublePoints,
    required this.onBirthdayDessert,
  });

  final bool doublePoints;
  final bool birthdayDessert;
  final ValueChanged<bool> onDoublePoints;
  final ValueChanged<bool> onBirthdayDessert;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      title: l10n.screenLoyaltyConfig,
      subtitle: l10n.adminGrowthLoyaltySubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.workspace_premium_outlined,
        color: CoreColors.brandOrange,
      ),
      child: Column(
        children: [
          _DataRow(
            label: l10n.adminGrowthPointsRule,
            value: '1.5x',
            detail: l10n.loyaltyPerkMultiplier,
            color: CoreColors.brandOrange,
          ),
          _SwitchRow(
            label: l10n.adminGrowthEnableLunchMultiplier,
            detail: l10n.adminGrowthLunchMultiplierBody,
            value: doublePoints,
            onChanged: onDoublePoints,
          ),
          _SwitchRow(
            label: l10n.loyaltyPerkDessert,
            detail: l10n.adminGrowthBirthdayDessertBody,
            value: birthdayDessert,
            onChanged: onBirthdayDessert,
          ),
          _PreviewStrip(
            label: l10n.adminGrowthTarget,
            value: l10n.adminGrowthTargetBody,
          ),
        ],
      ),
    );
  }
}

class _OffersPanel extends StatelessWidget {
  const _OffersPanel({
    required this.lunchOffer,
    required this.familyTrayOffer,
    required this.onLunchOffer,
    required this.onFamilyTrayOffer,
  });

  final bool lunchOffer;
  final bool familyTrayOffer;
  final ValueChanged<bool> onLunchOffer;
  final ValueChanged<bool> onFamilyTrayOffer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      title: l10n.screenOffersManagement,
      subtitle: l10n.adminGrowthOffersSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.local_offer_outlined,
        color: CoreColors.semanticRevenue,
      ),
      child: Column(
        children: [
          _SwitchRow(
            label: l10n.adminGrowthShawarmaOffer,
            detail: l10n.adminGrowthShawarmaOfferBody,
            value: lunchOffer,
            onChanged: onLunchOffer,
          ),
          _SwitchRow(
            label: l10n.adminGrowthFamilyTrayOffer,
            detail: l10n.adminGrowthFamilyTrayOfferBody,
            value: familyTrayOffer,
            onChanged: onFamilyTrayOffer,
          ),
          _DataRow(
            label: l10n.adminGrowthHomeOffers,
            value: MockupCatalog.offers.length.toString(),
            detail: l10n.adminGrowthHomeOffersBody,
            color: CoreColors.semanticRevenue,
          ),
          _DataRow(
            label: l10n.adminGrowthCombos,
            value: MockupCatalog.comboHighlights.length.toString(),
            detail: l10n.adminGrowthCombosBody,
            color: CoreColors.brandOrange,
          ),
          _DataRow(
            label: l10n.adminGrowthDiscountedItems,
            value: MockupCatalog.discountedMenuItemIds.length.toString(),
            detail: l10n.adminGrowthDiscountedItemsBody,
            color: CoreColors.brandGold,
          ),
          _DataRow(
            label: l10n.adminGrowthSubscriptionItems,
            value: MockupCatalog.subscriptionMenuItemIds.length.toString(),
            detail: l10n.adminGrowthSubscriptionItemsBody,
            color: CoreColors.brandOlive,
          ),
          _DataRow(
            label: l10n.adminGrowthTargetMargin,
            value: '28%',
            detail: l10n.adminGrowthTargetMarginBody,
            color: CoreColors.semanticRevenue,
          ),
        ],
      ),
    );
  }
}

class _DecisionCard extends StatelessWidget {
  const _DecisionCard({required this.section});

  final WidgetsAdminGrowthHubSection section;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final decision = switch (section) {
      WidgetsAdminGrowthHubSection.staff => l10n.adminGrowthDecisionStaff,
      WidgetsAdminGrowthHubSection.privacy => l10n.adminGrowthDecisionPrivacy,
      WidgetsAdminGrowthHubSection.loyalty => l10n.adminGrowthDecisionLoyalty,
      WidgetsAdminGrowthHubSection.offers => l10n.adminGrowthDecisionOffers,
    };

    return WidgetsAppCard(
      title: l10n.adminGrowthSuggestedDecision,
      subtitle: decision,
      leading: WidgetsIconBubble(
        icon: Icons.lightbulb_outline,
        color: CoreColors.brandGold,
      ),
      child: _PreviewStrip(
        label: l10n.adminGrowthExpectedImpact,
        value: l10n.adminGrowthExpectedImpactValue,
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.section, required this.onSave});

  final WidgetsAdminGrowthHubSection section;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      title: l10n.adminGrowthActionsTitle,
      subtitle: l10n.adminGrowthActionsSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.admin_panel_settings_outlined,
        color: CoreColors.brandOlive,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsAppButton(
            label: l10n.adminGrowthSaveSettings,
            onPressed: onSave,
            icon: Icons.save_outlined,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.adminGrowthOpenAuditLog,
            onPressed: () => context.push(AppRoutePaths.appAdminAudit),
            icon: Icons.fact_check_outlined,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.label,
    required this.value,
    required this.detail,
    required this.color,
  });

  final String label;
  final String value;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
            icon: Icons.insights_outlined,
            color: color,
            size: UtilitySizer.of(context, 36),
            iconSize: CoreContentSizes.orderTypeIcon(context),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  detail,
                  style: CoreTypography.caption(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          WidgetsSoftBadge(label: value, color: color),
        ],
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.label,
    required this.detail,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String detail;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.36),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  detail,
                  style: CoreTypography.caption(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _PreviewStrip extends StatelessWidget {
  const _PreviewStrip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: CoreColors.brandOlive.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      ),
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
          Text(
            value,
            style: CoreTypography.titleMedium(
              context,
              CoreColors.brandOlive,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({
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
      width: UtilitySizer.of(context, 172),
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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



