import 'package:ayletna_restaurant_app/data/models/model_customer_notification.dart';
import 'package:ayletna_restaurant_app/data/models/model_push_campaign_draft.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PushCampaignsNotifier extends StateNotifier<List<PushCampaignDraft>> {
  PushCampaignsNotifier(this._ref)
    : super([
        PushCampaignDraft(
          id: 'push-1',
          titleAr: 'عرض الغداء',
          titleEn: 'Lunch offer push',
          bodyAr: 'خصم 15% على وجبات الغداء حتى 3 مساءً.',
          bodyEn: '15% off lunch meals until 3 PM.',
          status: PushCampaignStatus.draft,
        ),
        PushCampaignDraft(
          id: 'push-2',
          titleAr: 'نقاط مضاعفة',
          titleEn: 'Double loyalty points',
          bodyAr: 'اكسب نقاطاً مضاعفة هذا الأسبوع.',
          bodyEn: 'Earn double loyalty points this week.',
          status: PushCampaignStatus.scheduled,
          scheduledAt: DateTime.now().add(const Duration(days: 2)),
        ),
        PushCampaignDraft(
          id: 'push-3',
          titleAr: 'افتتاح فرع جديد',
          titleEn: 'New branch opening',
          bodyAr: 'احتفل معنا — عروض افتتاحية.',
          bodyEn: 'Celebrate with us — opening offers.',
          status: PushCampaignStatus.sent,
        ),
      ]);

  final Ref _ref;

  void addDraft({required String titleAr, required String titleEn}) {
    state = [
      PushCampaignDraft(
        id: 'push-${DateTime.now().millisecondsSinceEpoch}',
        titleAr: titleAr,
        titleEn: titleEn,
        bodyAr: 'مسودة إشعار',
        bodyEn: 'Notification draft',
        status: PushCampaignStatus.draft,
      ),
      ...state,
    ];
  }

  void updateDraft(PushCampaignDraft updated) {
    state = [
      for (final campaign in state)
        if (campaign.id == updated.id) updated else campaign,
    ];
  }

  bool schedule(String id) {
    final index = state.indexWhere((campaign) => campaign.id == id);
    if (index == -1) return false;
    final scheduledAt =
        state[index].scheduledAt ?? DateTime.now().add(const Duration(days: 1));
    final updated = state[index].copyWith(
      status: PushCampaignStatus.scheduled,
      scheduledAt: scheduledAt,
    );
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == index) updated else state[i],
    ];
    _ref.read(customerInjectedNotificationsProvider.notifier).prepend(
      ModelCustomerNotification(
        id: 'push-${updated.id}',
        titleAr: updated.titleAr,
        titleEn: updated.titleEn,
        bodyAr: updated.bodyAr,
        bodyEn: updated.bodyEn,
        timeAr: 'الآن',
        timeEn: 'Just now',
        iconKey: 'campaign',
        colorKey: 'primary',
        actionRoutes: const [AppRoutePaths.offers],
      ),
    );
    return true;
  }

  PushCampaignDraft? byId(String id) {
    for (final campaign in state) {
      if (campaign.id == id) return campaign;
    }
    return null;
  }

  bool deleteCampaign(String id) {
    final before = state.length;
    state = [for (final campaign in state) if (campaign.id != id) campaign];
    return state.length < before;
  }
}

final pushCampaignsProvider =
    StateNotifierProvider<PushCampaignsNotifier, List<PushCampaignDraft>>(
      (ref) => PushCampaignsNotifier(ref),
    );
