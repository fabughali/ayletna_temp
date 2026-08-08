import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_marketing_campaign_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketingCampaignNotifier
    extends StateNotifier<List<MarketingCampaignEvent>> {
  MarketingCampaignNotifier() : super(_seed());

  static List<MarketingCampaignEvent> _seed() {
    final now = DateTime.now();
    final month = DateTime(now.year, now.month);
    final allOffers = MockupCatalog.offers.map((o) => o.id).toList();
    final allCombos =
        MockupCatalog.comboHighlights.map((c) => c.id).toList();
    final allDiscounts =
        MockupCatalog.discountedMenuItemIds
            .map((id) => 'disc_$id')
            .toList();
    final allSubscriptions =
        MockupCatalog.subscriptionMenuItemIds
            .map((id) => 'sub_$id')
            .toList();

    return [
      MarketingCampaignEvent(
        id: 'camp-1',
        titleAr: 'إطلاق القائمة الحالي',
        titleEn: 'Current menu launch',
        startAt: now.subtract(const Duration(days: 1)),
        endAt: now.add(const Duration(days: 60)),
        kind: MarketingCampaignKind.offer,
        offerIds: allOffers,
        comboIds: allCombos,
        discountIds: allDiscounts,
        subscriptionIds: allSubscriptions,
      ),
      MarketingCampaignEvent(
        id: 'camp-2',
        titleAr: 'كومبو عائلي',
        titleEn: 'Family combo promo',
        startAt: month.add(const Duration(days: 5)),
        endAt: month
            .add(const Duration(days: 12))
            .add(const Duration(hours: 23, minutes: 59)),
        kind: MarketingCampaignKind.promo,
        comboIds: allCombos.take(1).toList(),
      ),
      MarketingCampaignEvent(
        id: 'camp-3',
        titleAr: 'حملة إنستغرام',
        titleEn: 'Instagram reel push',
        startAt: month.add(const Duration(days: 8)),
        endAt: month
            .add(const Duration(days: 8))
            .add(const Duration(hours: 23, minutes: 59)),
        kind: MarketingCampaignKind.social,
        channelAr: 'إنستغرام',
        channelEn: 'Instagram',
      ),
      MarketingCampaignEvent(
        id: 'camp-4',
        titleAr: 'نقاط مضاعفة',
        titleEn: 'Double loyalty points',
        startAt: month.add(const Duration(days: 14)),
        endAt: month
            .add(const Duration(days: 20))
            .add(const Duration(hours: 23, minutes: 59)),
        kind: MarketingCampaignKind.loyalty,
      ),
      MarketingCampaignEvent(
        id: 'camp-5',
        titleAr: 'عرض نهاية الأسبوع',
        titleEn: 'Weekend flash sale',
        startAt: month.add(const Duration(days: 18)),
        endAt: month
            .add(const Duration(days: 19))
            .add(const Duration(hours: 23, minutes: 59)),
        kind: MarketingCampaignKind.offer,
        offerIds: allOffers.take(1).toList(),
      ),
    ];
  }

  void addEvent(MarketingCampaignEvent event) {
    state = [...state, event];
  }

  void updateEvent(String id, MarketingCampaignEvent updated) {
    state = [
      for (final e in state)
        if (e.id == id) updated else e,
    ];
  }

  void removeEvent(String id) {
    state = state.where((e) => e.id != id).toList();
  }
}

int _campSeq = 100;

String nextCampaignId() => 'camp-${_campSeq++}';

final marketingCampaignEventsProvider = StateNotifierProvider<
  MarketingCampaignNotifier,
  List<MarketingCampaignEvent>
>((ref) => MarketingCampaignNotifier());

final marketingCampaignCalendarMonthProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month);
});

/// Live campaign IDs at [moment] (defaults to now).
Set<String> liveCampaignIdsAt(
  List<MarketingCampaignEvent> campaigns, [
  DateTime? moment,
]) {
  final now = moment ?? DateTime.now();
  return {
    for (final c in campaigns)
      if (c.isLiveAt(now)) c.id,
  };
}

bool campaignCoversOffer({
  required List<MarketingCampaignEvent> campaigns,
  required String offerId,
  String? campaignId,
  DateTime? moment,
}) {
  final now = moment ?? DateTime.now();
  if (campaignId != null) {
    for (final c in campaigns) {
      if (c.id == campaignId) return c.isLiveAt(now);
    }
    return false;
  }
  for (final c in campaigns) {
    if (c.offerIds.contains(offerId) && c.isLiveAt(now)) return true;
  }
  return false;
}

bool campaignCoversCombo({
  required List<MarketingCampaignEvent> campaigns,
  required String comboId,
  String? campaignId,
  DateTime? moment,
}) {
  final now = moment ?? DateTime.now();
  if (campaignId != null) {
    for (final c in campaigns) {
      if (c.id == campaignId) return c.isLiveAt(now);
    }
    return false;
  }
  for (final c in campaigns) {
    if (c.comboIds.contains(comboId) && c.isLiveAt(now)) return true;
  }
  return false;
}

bool campaignCoversDiscount({
  required List<MarketingCampaignEvent> campaigns,
  required String discountId,
  String? campaignId,
  DateTime? moment,
}) {
  final now = moment ?? DateTime.now();
  if (campaignId != null) {
    for (final c in campaigns) {
      if (c.id == campaignId) return c.isLiveAt(now);
    }
    return false;
  }
  for (final c in campaigns) {
    if (c.discountIds.contains(discountId) && c.isLiveAt(now)) return true;
  }
  return false;
}

bool campaignCoversSubscription({
  required List<MarketingCampaignEvent> campaigns,
  required String subscriptionId,
  String? campaignId,
  DateTime? moment,
}) {
  final now = moment ?? DateTime.now();
  if (campaignId != null) {
    for (final c in campaigns) {
      if (c.id == campaignId) return c.isLiveAt(now);
    }
    return false;
  }
  for (final c in campaigns) {
    if (c.subscriptionIds.contains(subscriptionId) && c.isLiveAt(now)) {
      return true;
    }
  }
  return false;
}
