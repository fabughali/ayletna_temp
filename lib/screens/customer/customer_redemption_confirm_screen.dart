import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_reward.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:ayletna_restaurant_app/providers/rewards_admin_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_action_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Food reward checkout — uses selected reward and deducts loyalty points.
class CustomerRedemptionConfirmScreen extends ConsumerWidget {
  const CustomerRedemptionConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final reward =
        ref.watch(selectedRewardProvider) ??
        ref.watch(activeRewardsProvider).firstOrNull;
    final points = ref.watch(loyaltyPointsProvider).balance;

    if (reward == null) {
      return WidgetsScaffoldPage(
        title: l10n.screenRedemptionConfirm,
        child: Center(
          child: Text(
            l10n.redemptionNoRewardSelected,
            style: CoreTypography.bodyMedium(
              context,
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    final redeemFactor =
        ref.watch(rewardsCatalogProvider).redeemFactorForBalance(points);
    final cost = (reward.points * redeemFactor).round().clamp(1, reward.points);
    final canRedeem = points >= cost;

    return WidgetsScaffoldPage(
      title: l10n.screenRedemptionConfirm,
      bottomSheet: WidgetsActionBar(
        primary: WidgetsAppButton(
          label: l10n.loyaltyRedeem,
          onPressed:
              canRedeem
                  ? () {
                    final ok = ref
                        .read(loyaltyPointsProvider.notifier)
                        .redeem(
                          cost,
                          rewardTitleEn: reward.titleEn,
                          rewardTitleAr: reward.titleAr,
                        );
                    if (!ok) {
                      UtilityMockFeedback.showWarning(
                        context,
                        l10n.redemptionInsufficientPoints,
                      );
                      return;
                    }
                    ref.read(cartProvider.notifier).addRewardLine(reward);
                    ref.read(selectedRewardIdProvider.notifier).state = null;
                    UtilityMockFeedback.showSuccess(
                      context,
                      l10n.loyaltyRedeem,
                    );
                    context.go(AppRoutePaths.cart);
                  }
                  : null,
          icon: Icons.shopping_basket_outlined,
          fullWidth: true,
        ),
        secondary: WidgetsAppButton(
          label: l10n.screenRewardsCatalog,
          onPressed: () => context.go(AppRoutePaths.rewards),
          icon: Icons.card_giftcard_outlined,
          variant: WidgetsAppButtonVariant.outline,
          fullWidth: true,
        ),
      ),
      child: ListView(
        padding: EdgeInsetsDirectional.only(
          bottom: CoreSpacing.xxl(context) * 3,
        ),
        children: [
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsPageHeader(
            title: l10n.screenRedemptionConfirm,
            subtitle: l10n.redemptionConfirmBody,
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          _RedemptionHero(reward: reward),
          SizedBox(height: CoreSpacing.lg(context)),
          _StampSummaryCard(balance: points, cost: cost, l10n: l10n),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsInfoBanner(
            title: l10n.screenRedemptionConfirm,
            message: l10n.redemptionConfirmBody,
            icon: Icons.redeem_outlined,
            tone: WidgetsInfoBannerTone.info,
          ),
          SizedBox(height: CoreSpacing.xxl(context)),
        ],
      ),
    );
  }
}

class _RedemptionHero extends StatelessWidget {
  const _RedemptionHero({required this.reward});

  final ModelCustomerReward reward;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final color = CoreColors.brandGold;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsFoodMediaPanel(
            height: CoreContentSizes.heroImageHeight(context) * 0.55,
            child: Icon(Icons.redeem_outlined, size: CoreContentSizes.emptyStateIcon(context), color: color),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            isArabic ? reward.titleAr : reward.titleEn,
            style: CoreTypography.headlineSmall(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            l10n.loyaltyPointsShort(reward.points.toString()),
            style: CoreTypography.bodyMedium(context, scheme.primary),
          ),
        ],
      ),
    );
  }
}

class _StampSummaryCard extends StatelessWidget {
  const _StampSummaryCard({
    required this.balance,
    required this.cost,
    required this.l10n,
  });

  final int balance;
  final int cost;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      title: l10n.redemptionPointsBalanceTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.redemptionPointsBalanceValue(balance),
            style: CoreTypography.headlineSmall(
              context,
              scheme.primary,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            l10n.redemptionCostLabel(cost),
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

extension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
