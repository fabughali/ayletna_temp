import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_reward.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:ayletna_restaurant_app/providers/rewards_admin_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [RewardsCatalogScreen] redesigned as a food treat catalog.
class CustomerRewardsCatalogScreen extends ConsumerStatefulWidget {
  const CustomerRewardsCatalogScreen({super.key});

  @override
  ConsumerState<CustomerRewardsCatalogScreen> createState() =>
      _CustomerRewardsCatalogScreenState();
}

class _CustomerRewardsCatalogScreenState
    extends ConsumerState<CustomerRewardsCatalogScreen> {
  _RewardCategory _selectedCategory = _RewardCategory.all;
  var _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isGuest = ref.watch(appRoleProvider) == AppRole.guest;
    final pointsBalance = ref.watch(loyaltyPointsProvider).balance;
    final rewards = _filteredRewards(ref);

    return WidgetsScaffoldPage(
      title: l10n.rewardsCatalogTitle,
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
            _CatalogHero(isGuest: isGuest, pointsBalance: pointsBalance),
            SizedBox(height: CoreSpacing.lg(context)),
            _SearchField(
              onChanged: (value) => setState(() => _searchQuery = value.trim()),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            _CategoryStrip(
              selected: _selectedCategory,
              onSelected:
                  (category) => setState(() => _selectedCategory = category),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            if (ref.watch(activeRewardsProvider).isNotEmpty)
              _FeaturedRewardCard(
                reward: ref.watch(activeRewardsProvider).first,
                isGuest: isGuest,
                onRedeem: (id) {
                  ref.read(selectedRewardIdProvider.notifier).state = id;
                  context.push(AppRoutePaths.redemption);
                },
              ),
            SizedBox(height: CoreSpacing.lg(context)),
            for (final reward in rewards) ...[
              _RewardTile(
                data: reward,
                isGuest: isGuest,
                onRedeem: (id) {
                  ref.read(selectedRewardIdProvider.notifier).state = id;
                  context.push(AppRoutePaths.redemption);
                },
              ),
              SizedBox(height: CoreSpacing.md(context)),
            ],
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }

  List<ModelCustomerReward> _filteredRewards(WidgetRef ref) {
    final rewards = ref.watch(activeRewardsProvider);
    final query = _searchQuery.toLowerCase();
    Iterable<ModelCustomerReward> filtered = rewards;
    if (_selectedCategory != _RewardCategory.all) {
      filtered = filtered.where(
        (reward) => reward.categoryKey == _selectedCategory.name,
      );
    }
    if (query.isNotEmpty) {
      filtered = filtered.where((reward) {
        final haystack =
            '${reward.titleEn} ${reward.titleAr} ${reward.descriptionEn} ${reward.descriptionAr}'
                .toLowerCase();
        return haystack.contains(query);
      });
    }
    return filtered.toList();
  }
}

enum _RewardCategory { all, drinks, sides, main }

class _CatalogHero extends StatelessWidget {
  const _CatalogHero({required this.isGuest, required this.pointsBalance});

  final bool isGuest;
  final int pointsBalance;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.rewardsYourBalance,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  isGuest
                      ? '0 ${l10n.rewardsSavorPoints}'
                      : '$pointsBalance ${l10n.rewardsSavorPoints}',
                  style: CoreTypography.headlineSmall(
                    context,
                    scheme.primary,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  isGuest
                      ? l10n.guestRewardsPreviewBody
                      : l10n.rewardsMemberSince,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: CoreColors.brandGold.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.lg(context)),
              child: Icon(Icons.stars_rounded, color: CoreColors.brandGold),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsAppTextField(
      label: l10n.rewardsSearchHint,
      hintText: l10n.rewardsSearchHint,
      prefixIcon: Icons.search,
      onChanged: onChanged,
    );
  }
}

class _CategoryStrip extends StatelessWidget {
  const _CategoryStrip({required this.selected, required this.onSelected});

  final _RewardCategory selected;
  final ValueChanged<_RewardCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final category in _RewardCategory.values) ...[
            _FoodChip(
              label: _categoryLabel(context, category),
              selected: selected == category,
              onTap: () => onSelected(category),
            ),
            SizedBox(width: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }

  String _categoryLabel(BuildContext context, _RewardCategory category) {
    final l10n = AppLocalizations.of(context)!;
    return switch (category) {
      _RewardCategory.all => l10n.rewardsAllItems,
      _RewardCategory.drinks => l10n.rewardsDrinks,
      _RewardCategory.sides => l10n.rewardsSides,
      _RewardCategory.main => l10n.rewardsMainCourse,
    };
  }
}

class _FeaturedRewardCard extends StatelessWidget {
  const _FeaturedRewardCard({
    required this.reward,
    required this.isGuest,
    required this.onRedeem,
  });

  final ModelCustomerReward reward;
  final bool isGuest;
  final ValueChanged<String> onRedeem;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final color = _rewardColor(context, reward.colorKey);

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsFoodMediaPanel(
            height: CoreContentSizes.heroImageHeight(context),
            badge: _FoodTag(label: l10n.rewardsFeaturedReward, color: color),
            child: _RewardMedia(icon: _rewardIcon(reward.artKey), color: color),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            isArabic ? reward.titleAr : reward.titleEn,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            isArabic ? reward.descriptionAr : reward.descriptionEn,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label:
                isGuest
                    ? l10n.guestRewardsPreviewAction
                    : '${l10n.loyaltyRedeem} · ${l10n.loyaltyPointsShort(reward.points.toString())}',
            onPressed:
                () =>
                    isGuest
                        ? context.push(AppRoutePaths.register)
                        : onRedeem(reward.id),
            icon:
                isGuest
                    ? Icons.person_add_alt_1_outlined
                    : Icons.redeem_outlined,
            variant:
                isGuest
                    ? WidgetsAppButtonVariant.secondary
                    : WidgetsAppButtonVariant.primary,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _RewardTile extends StatelessWidget {
  const _RewardTile({
    required this.data,
    required this.isGuest,
    required this.onRedeem,
  });

  final ModelCustomerReward data;
  final bool isGuest;
  final ValueChanged<String> onRedeem;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final accent = _rewardColor(context, data.colorKey);
    final title = isArabic ? data.titleAr : data.titleEn;
    final description = isArabic ? data.descriptionAr : data.descriptionEn;
    final badge = isArabic ? data.badgeAr : data.badgeEn;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Row(
        children: [
          SizedBox(
            width: CoreContentSizes.categoryMenuImageHeight(context),
            child: WidgetsFoodMediaPanel(
              height: CoreContentSizes.categoryMenuImageHeight(context),
              badge:
                  badge == null ? null : _FoodTag(label: badge, color: accent),
              child: _RewardMedia(
                icon: _rewardIcon(data.artKey),
                color: accent,
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurface,
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
                  l10n.loyaltyPointsShort(data.points.toString()),
                  style: CoreTypography.caption(
                    context,
                    data.isSoldOut || data.isLocked
                        ? scheme.onSurfaceVariant
                        : scheme.primary,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label:
                isGuest
                    ? l10n.guestSignInToOrder
                    : data.isSoldOut
                    ? l10n.rewardsSoldOut
                    : data.isLocked
                    ? l10n.loyaltyLocked
                    : l10n.loyaltyRedeem,
            onPressed:
                isGuest
                    ? () => context.push(AppRoutePaths.register)
                    : data.isSoldOut || data.isLocked
                    ? () => UtilityMockFeedback.showInfo(
                      context,
                      data.isLocked ? l10n.loyaltyLocked : l10n.rewardsSoldOut,
                    )
                    : () => onRedeem(data.id),
            icon:
                isGuest
                    ? Icons.person_add_alt_1_outlined
                    : data.isSoldOut || data.isLocked
                    ? Icons.lock_outline
                    : Icons.redeem_outlined,
            variant:
                isGuest
                    ? WidgetsAppButtonVariant.secondary
                    : data.isSoldOut || data.isLocked
                    ? WidgetsAppButtonVariant.outline
                    : WidgetsAppButtonVariant.primary,
          ),
        ],
      ),
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
            size: CoreContentSizes.categoryMenuImageIcon(context),
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
    final garnish = Paint()..color = accent.withValues(alpha: 0.34);
    final center = Offset(size.width * 0.5, size.height * 0.56);
    final radius = size.shortestSide * 0.30;
    canvas.drawCircle(center, radius, plate);
    canvas.drawCircle(center, radius, rim);
    canvas.drawCircle(
      Offset(size.width * 0.36, size.height * 0.42),
      radius * 0.15,
      garnish,
    );
    canvas.drawCircle(
      Offset(size.width * 0.62, size.height * 0.43),
      radius * 0.13,
      garnish,
    );
    canvas.drawCircle(
      Offset(size.width * 0.52, size.height * 0.68),
      radius * 0.15,
      garnish,
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
