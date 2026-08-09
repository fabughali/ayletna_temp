import 'package:ayletna_restaurant_app/data/models/model_faq_entry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupportFaqNotifier extends StateNotifier<List<FaqEntry>> {
  SupportFaqNotifier()
    : super(const [
        FaqEntry(
          id: 'faq-1',
          titleAr: 'كيف تعمل تحديثات التوصيل؟',
          titleEn: 'How do delivery updates work?',
          bodyAr:
              'الطلبات النشطة تعرض خط زمني. عندما يكون الطلب في الطريق، يصبح زر التواصل مع السائق متاحاً.',
          bodyEn:
              'Active orders show a timeline. When the order is on the way, the driver contact button becomes available.',
          sortOrder: 0,
        ),
        FaqEntry(
          id: 'faq-2',
          titleAr: 'ما طرق الدفع المقبولة؟',
          titleEn: 'Which payment methods are accepted?',
          bodyAr: 'نقبل البطاقات والمحفظة والدفع عند الاستلام حسب نوع الطلب.',
          bodyEn:
              'We accept cards, wallet, and cash on delivery depending on order type.',
          sortOrder: 1,
        ),
        FaqEntry(
          id: 'faq-3',
          titleAr: 'كيف أُرجع الصواني المطلية؟',
          titleEn: 'How do plated tray returns work?',
          bodyAr:
              'سيصلك تذكير لإرجاع الصواني. يمكن للسائق استلامها عند التوصيل التالي.',
          bodyEn:
              'You will receive a reminder to return trays. The driver can collect them on your next delivery.',
          sortOrder: 2,
        ),
      ]);

  void upsert(FaqEntry entry) {
    final index = state.indexWhere((e) => e.id == entry.id);
    if (index >= 0) {
      state = [
        for (var i = 0; i < state.length; i++)
          if (i == index) entry else state[i],
      ];
    } else {
      state = [...state, entry];
    }
  }

  void remove(String id) {
    state = state.where((e) => e.id != id).toList();
  }

  void togglePublished(String id) {
    state = [
      for (final entry in state)
        if (entry.id == id)
          entry.copyWith(published: !entry.published)
        else
          entry,
    ];
  }
}

final supportFaqProvider =
    StateNotifierProvider<SupportFaqNotifier, List<FaqEntry>>(
      (ref) => SupportFaqNotifier(),
    );

final publishedFaqProvider = Provider<List<FaqEntry>>((ref) {
  final all = ref.watch(supportFaqProvider);
  return [...all.where((e) => e.published)]
    ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
});
