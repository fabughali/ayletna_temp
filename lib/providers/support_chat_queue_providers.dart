import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SupportChatQueuePriority { high, normal }

class SupportChatQueueEntry {
  const SupportChatQueueEntry({
    required this.id,
    required this.customer,
    required this.topicAr,
    required this.topicEn,
    required this.waitMinutes,
    required this.priority,
  });

  final String id;
  final String customer;
  final String topicAr;
  final String topicEn;
  final int waitMinutes;
  final SupportChatQueuePriority priority;

  String topic(bool isAr) => isAr ? topicAr : topicEn;
}

class SupportChatQueueNotifier
    extends StateNotifier<List<SupportChatQueueEntry>> {
  SupportChatQueueNotifier()
    : super(const [
        SupportChatQueueEntry(
          id: 'CH-1042',
          customer: 'Layla H.',
          topicAr: 'تأخر التوصيل — طلب #4821',
          topicEn: 'Late delivery — order #4821',
          waitMinutes: 4,
          priority: SupportChatQueuePriority.high,
        ),
        SupportChatQueueEntry(
          id: 'CH-1041',
          customer: 'Omar K.',
          topicAr: 'استرداد عنصر مفقود',
          topicEn: 'Refund for missing item',
          waitMinutes: 11,
          priority: SupportChatQueuePriority.normal,
        ),
        SupportChatQueueEntry(
          id: 'CH-1040',
          customer: 'Sara M.',
          topicAr: 'لم يُطبّق عرض الكومبو',
          topicEn: 'Combo offer not applied',
          waitMinutes: 18,
          priority: SupportChatQueuePriority.normal,
        ),
      ]);

  bool acceptChat(String id) {
    final index = state.indexWhere((entry) => entry.id == id);
    if (index == -1) return false;
    state = [
      for (var i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
    return true;
  }

  void refreshQueue() {
    state = [
      for (final entry in state)
        SupportChatQueueEntry(
          id: entry.id,
          customer: entry.customer,
          topicAr: entry.topicAr,
          topicEn: entry.topicEn,
          waitMinutes: entry.waitMinutes,
          priority: entry.priority,
        ),
    ];
  }
}

final supportChatQueueProvider = StateNotifierProvider<
  SupportChatQueueNotifier,
  List<SupportChatQueueEntry>
>((ref) => SupportChatQueueNotifier());
