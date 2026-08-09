import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/marketing_campaign_providers.dart';
import 'package:ayletna_restaurant_app/providers/marketing_social_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/providers/reviews_admin_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketingTopSeller {
  const MarketingTopSeller({
    required this.itemId,
    required this.purchaseCount,
  });

  final String itemId;
  final int purchaseCount;
}

class MarketingRatingInsight {
  const MarketingRatingInsight({
    required this.reviewId,
    required this.itemId,
    required this.rating,
    required this.pendingApproval,
    required this.remarkEn,
    required this.remarkAr,
  });

  final String reviewId;
  final String itemId;
  final int rating;
  final bool pendingApproval;
  final String remarkEn;
  final String remarkAr;
}

class MarketingSocialInsight {
  const MarketingSocialInsight({
    required this.platform,
    required this.users,
    required this.blogs,
    required this.actionsToday,
    required this.actionsWeek,
  });

  final SocialPlatform platform;
  final int users;
  final int blogs;
  final int actionsToday;
  final int actionsWeek;
}

class MarketingDashboardMetrics {
  const MarketingDashboardMetrics({
    required this.visitorsToday,
    required this.purchasesToday,
    required this.activeOffers,
    required this.activeCampaigns,
    required this.topSellers,
    required this.topRatings,
    required this.pendingRatingCount,
    required this.socialInsights,
    required this.socialActionsToday,
  });

  final int visitorsToday;
  final int purchasesToday;
  final int activeOffers;
  final int activeCampaigns;
  final List<MarketingTopSeller> topSellers;
  final List<MarketingRatingInsight> topRatings;
  final int pendingRatingCount;
  final List<MarketingSocialInsight> socialInsights;
  final int socialActionsToday;
}

final marketingDashboardMetricsProvider = Provider<MarketingDashboardMetrics>((
  ref,
) {
  final offers = ref.watch(visibleOffersProvider);
  final campaigns = ref.watch(marketingCampaignEventsProvider);
  final items =
      ref.watch(menuAllItemsProvider).maybeWhen(
        data: (list) => list,
        orElse: () => MockupCatalog.items,
      );
  final reviews = ref.watch(reviewsModerationProvider).reviews;
  final social = ref.watch(socialConnectionsProvider);

  final topSellers =
      items.take(10).toList().asMap().entries.map((e) {
        return MarketingTopSeller(
          itemId: e.value.id,
          purchaseCount: 120 - e.key * 7,
        );
      }).toList();

  final ratingInsights =
      reviews
          .where((r) => r.menuItemId != null && r.menuItemId!.isNotEmpty)
          .map(
            (r) => MarketingRatingInsight(
              reviewId: r.id,
              itemId: r.menuItemId!,
              rating: r.rating,
              pendingApproval: r.status == ReviewModerationStatus.pending,
              remarkEn: r.commentEn,
              remarkAr: r.commentAr,
            ),
          )
          .toList()
        ..sort((a, b) {
          if (a.pendingApproval != b.pendingApproval) {
            return a.pendingApproval ? -1 : 1;
          }
          return b.rating.compareTo(a.rating);
        });

  final socialInsights =
      social.map((c) {
        final seed = c.platform.name.hashCode.abs();
        return MarketingSocialInsight(
          platform: c.platform,
          users: 400 + (seed % 900),
          blogs: 2 + (seed % 12),
          actionsToday: 10 + (seed % 40),
          actionsWeek: 80 + (seed % 200),
        );
      }).toList();

  final now = DateTime.now();
  final activeCampaigns =
      campaigns.where((c) => !now.isBefore(c.startAt) && !now.isAfter(c.endAt)).length;

  return MarketingDashboardMetrics(
    visitorsToday: 842,
    purchasesToday: 126,
    activeOffers: offers.length,
    activeCampaigns: activeCampaigns,
    topSellers: topSellers,
    topRatings: ratingInsights.take(10).toList(),
    pendingRatingCount: ratingInsights.where((r) => r.pendingApproval).length,
    socialInsights: socialInsights,
    socialActionsToday: socialInsights.fold<int>(
      0,
      (sum, s) => sum + s.actionsToday,
    ),
  );
});
