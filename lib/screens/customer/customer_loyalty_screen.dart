import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:ayletna_restaurant_app/providers/rewards_admin_providers.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_reward.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_progress_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [LoyaltyScreen] redesigned as a food-stamp rewards home.
class CustomerLoyaltyScreen extends ConsumerStatefulWidget {
  const CustomerLoyaltyScreen({super.key});

  @override
  ConsumerState<CustomerLoyaltyScreen> createState() =>
      _CustomerLoyaltyScreenState();
}

class _CustomerLoyaltyScreenState extends ConsumerState<CustomerLoyaltyScreen> {
  var _treatsOnly = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isGuest = ref.watch(appRoleProvider) == AppRole.guest;
    final pointsBalance = ref.watch(loyaltyPointsProvider).balance;
    final rewards = ref.watch(activeRewardsProvider);
    final visibleRewards =
        _treatsOnly
            ? rewards.where((reward) => reward.categoryKey == 'sides').toList()
            : rewards.take(4).toList();

    return WidgetsScaffoldPage(
      title: l10n.loyaltyTitle,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(activeRewardsProvider);
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            _LoyaltyHero(isGuest: isGuest, pointsBalance: pointsBalance),
            SizedBox(height: CoreSpacing.lg(context)),
            _StampCard(isGuest: isGuest, pointsBalance: pointsBalance),
            SizedBox(height: CoreSpacing.lg(context)),
            _PerksCard(onExplore: () => context.push(AppRoutePaths.rewards)),
            SizedBox(height: CoreSpacing.lg(context)),
            _RewardsHeader(
              treatsOnly: _treatsOnly,
              onToggle: () => setState(() => _treatsOnly = !_treatsOnly),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            for (final reward in visibleRewards) ...[
              _RewardTreatCard(reward: reward),
              SizedBox(height: CoreSpacing.md(context)),
            ],
            if (visibleRewards.isEmpty)
              WidgetsAppCard(
                padding: EdgeInsets.all(CoreSpacing.lg(context)),
                child: Text(
                  Localizations.localeOf(context).languageCode == 'ar'
                      ? 'لا توجد مكافآت في هذا التصنيف حالياً.'
                      : 'No rewards in this filter right now.',
                  style: CoreTypography.bodyMedium(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            const _HowItWorksCard(),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _LoyaltyHero extends StatelessWidget {
  const _LoyaltyHero({required this.isGuest, required this.pointsBalance});

  final bool isGuest;
  final int pointsBalance;

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
          WidgetsFoodMediaPanel(
            height: CoreContentSizes.heroImageHeight(context),
            badge: _FoodTag(
              label:
                  isGuest
                      ? '0 ${l10n.loyaltySavorPoints}'
                      : l10n.loyaltyGoldMember,
              color: CoreColors.brandGold,
            ),
            child: CustomPaint(
              painter: _TreatPainter(
                color: scheme.primary,
                accent: CoreColors.brandGold,
              ),
              child: Center(
                child: Icon(
                  Icons.card_giftcard_outlined,
                  color: scheme.primary,
                  size: CoreContentSizes.categoryMenuImageIcon(context),
                ),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.loyaltyTitle,
            style: CoreTypography.headlineLarge(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.loyaltySubtitle,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${isGuest ? 0 : pointsBalance} ${l10n.loyaltySavorPoints}',
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.primary,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsAppButton(
                label: l10n.screenRewardsCatalog,
                onPressed: () => context.push(AppRoutePaths.rewards),
                icon: Icons.restaurant_menu_outlined,
                variant: WidgetsAppButtonVariant.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StampCard extends StatelessWidget {
  const _StampCard({required this.isGuest, required this.pointsBalance});

  final bool isGuest;
  final int pointsBalance;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final filledStamps = isGuest ? 0 : (pointsBalance ~/ 50).clamp(0, 8);
    final tierProgress = isGuest ? 0.0 : ((pointsBalance % 400) / 400).clamp(0.0, 1.0);

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.loyaltyNextTier,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.loyaltyEarnMore,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              for (var index = 0; index < 8; index++)
                _StampDot(filled: !isGuest && index < filledStamps),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsProgressBar(value: tierProgress, color: scheme.primary),
          SizedBox(height: CoreSpacing.sm(context)),
          Row(
            children: [
              Text(
                isGuest
                    ? '0 ${l10n.loyaltySavorPoints}'
                    : l10n.loyaltyCurrentGold,
                style: CoreTypography.caption(context, scheme.onSurfaceVariant),
              ),
              const Spacer(),
              Text(
                l10n.loyaltyGoalPoints,
                style: CoreTypography.caption(context, scheme.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StampDot extends StatelessWidget {
  const _StampDot({required this.filled});

  final bool filled;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = filled ? scheme.primary : scheme.outlineVariant;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: filled ? 0.16 : 0.10),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.36)),
      ),
      child: SizedBox.square(
        dimension: CoreContentSizes.timelineIcon(context),
        child: Icon(
          filled ? Icons.restaurant : Icons.restaurant_outlined,
          size: CoreContentSizes.orderTypeIcon(context),
          color: color,
        ),
      ),
    );
  }
}

class _PerksCard extends StatelessWidget {
  const _PerksCard({required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final perks = [
      l10n.loyaltyPerkMultiplier,
      l10n.loyaltyPerkPriority,
      l10n.loyaltyPerkDessert,
    ];

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.plain,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.loyaltyGoldPerks,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (final perk in perks) ...[
            _PerkLine(text: perk),
            SizedBox(height: CoreSpacing.sm(context)),
          ],
          WidgetsAppButton(
            label: l10n.loyaltyExplorePlatinum,
            onPressed: onExplore,
            icon: Icons.arrow_forward,
            variant: WidgetsAppButtonVariant.outline,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _RewardsHeader extends StatelessWidget {
  const _RewardsHeader({required this.treatsOnly, required this.onToggle});

  final bool treatsOnly;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.loyaltyAvailableRewards,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        _FoodChip(
          label: treatsOnly ? l10n.rewardsSides : l10n.rewardsAllItems,
          selected: treatsOnly,
          onTap: onToggle,
        ),
      ],
    );
  }
}

class _RewardTreatCard extends ConsumerWidget {
  const _RewardTreatCard({required this.reward});

  final ModelCustomerReward reward;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final color = _rewardColor(context, reward.colorKey);
    final title = isArabic ? reward.titleAr : reward.titleEn;
    final description = isArabic ? reward.descriptionAr : reward.descriptionEn;

    return WidgetsAppCard(
      variant:
          reward.isLocked
              ? WidgetsAppCardVariant.plain
              : WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Row(
        children: [
          SizedBox(
            width: CoreContentSizes.categoryMenuImageHeight(context),
            child: WidgetsFoodMediaPanel(
              height: CoreContentSizes.categoryMenuImageHeight(context),
              badge:
                  reward.isPopular
                      ? _FoodTag(label: l10n.loyaltyPopular, color: color)
                      : null,
              child: _RewardMedia(
                icon: _rewardIcon(reward.artKey),
                color: color,
              ),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CoreTypography.bodyMedium(
                    context,
                    reward.isLocked
                        ? scheme.onSurfaceVariant
                        : scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                Text(
                  l10n.loyaltyPointsShort(reward.points.toString()),
                  style: CoreTypography.caption(
                    context,
                    reward.isLocked ? scheme.onSurfaceVariant : scheme.primary,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: reward.isLocked ? l10n.loyaltyLocked : l10n.loyaltyRedeem,
            onPressed:
                reward.isLocked
                    ? null
                    : () {
                      ref.read(selectedRewardIdProvider.notifier).state =
                          reward.id;
                      context.push(AppRoutePaths.redemption);
                    },
            icon: reward.isLocked ? Icons.lock_outline : Icons.redeem_outlined,
            variant:
                reward.isLocked
                    ? WidgetsAppButtonVariant.outline
                    : WidgetsAppButtonVariant.primary,
          ),
        ],
      ),
    );
  }
}

class _HowItWorksCard extends StatelessWidget {
  const _HowItWorksCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        children: [
          _HowStep(
            icon: Icons.restaurant,
            title: l10n.loyaltyDine,
            body: l10n.loyaltyDineDesc,
          ),
          _HowStep(
            icon: Icons.stars_outlined,
            title: l10n.loyaltyCollect,
            body: l10n.loyaltyCollectDesc,
          ),
          _HowStep(
            icon: Icons.celebration_outlined,
            title: l10n.loyaltyEnjoy,
            body: l10n.loyaltyEnjoyDesc,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _HowStep extends StatelessWidget {
  const _HowStep({
    required this.icon,
    required this.title,
    required this.body,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final String body;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : CoreSpacing.md(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: scheme.primary),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  body,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
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

class _PerkLine extends StatelessWidget {
  const _PerkLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(Icons.check_circle_outline, color: scheme.primary),
        SizedBox(width: CoreSpacing.md(context)),
        Expanded(
          child: Text(
            text,
            style: CoreTypography.bodyMedium(context, scheme.onSurface),
          ),
        ),
      ],
    );
  }
}

class _FoodChip extends StatelessWidget {
  const _FoodChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = selected ? scheme.primary : scheme.onSurfaceVariant;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: selected ? 0.14 : 0.08),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
          border: Border.all(color: color.withValues(alpha: 0.22)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CoreSpacing.md(context),
            vertical: CoreSpacing.sm(context),
          ),
          child: Text(
            label,
            style: CoreTypography.caption(
              context,
              color,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}

class _FoodTag extends StatelessWidget {
  const _FoodTag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
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
        child: Text(
          label,
          style: CoreTypography.caption(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _RewardMedia extends StatelessWidget {
  const _RewardMedia({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: _TreatPainter(color: color, accent: CoreColors.brandGold),
        ),
        Center(
          child: Icon(
            icon,
            color: color,
            size: CoreContentSizes.orderTypeIcon(context) * 1.6,
          ),
        ),
      ],
    );
  }
}

class _TreatPainter extends CustomPainter {
  const _TreatPainter({required this.color, required this.accent});

  final Color color;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final plate = Paint()..color = color.withValues(alpha: 0.12);
    final rim =
        Paint()
          ..color = color.withValues(alpha: 0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2;
    final treat = Paint()..color = accent.withValues(alpha: 0.34);
    final center = Offset(size.width * 0.5, size.height * 0.56);
    final radius = size.shortestSide * 0.30;
    canvas.drawCircle(center, radius, plate);
    canvas.drawCircle(center, radius, rim);
    canvas.drawCircle(
      Offset(size.width * 0.38, size.height * 0.42),
      radius * 0.16,
      treat,
    );
    canvas.drawCircle(
      Offset(size.width * 0.62, size.height * 0.42),
      radius * 0.13,
      treat,
    );
    canvas.drawCircle(
      Offset(size.width * 0.52, size.height * 0.68),
      radius * 0.15,
      treat,
    );
  }

  @override
  bool shouldRepaint(covariant _TreatPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.accent != accent;
  }
}

IconData _rewardIcon(String key) {
  return switch (key) {
    'drink' => Icons.local_drink_outlined,
    'fries' => Icons.fastfood_outlined,
    'bowl' => Icons.ramen_dining_outlined,
    'donut' => Icons.donut_large_outlined,
    _ => Icons.outdoor_grill,
  };
}

Color _rewardColor(BuildContext context, String key) {
  final scheme = Theme.of(context).colorScheme;
  return switch (key) {
    'delivery' => CoreColors.orderTypeDelivery,
    'orange' => CoreColors.brandOrange,
    'dine_in' => CoreColors.orderTypeDineIn,
    'olive' => CoreColors.brandOliveLight,
    'secondary' => scheme.secondary,
    'tertiary' => scheme.tertiary,
    'outline' => scheme.outline,
    _ => scheme.primary,
  };
}
