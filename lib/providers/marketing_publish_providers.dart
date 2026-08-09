import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MarketingPublishStatus { draft, pendingOperator, published, rejected }

class MarketingPublishDraft {
  const MarketingPublishDraft({
    required this.id,
    required this.kindKey,
    required this.titleEn,
    required this.titleAr,
    required this.status,
    required this.submittedAt,
    this.entityId,
    this.operatorApprovedAt,
  });

  final String id;
  final String kindKey;
  final String titleEn;
  final String titleAr;
  final MarketingPublishStatus status;
  final DateTime submittedAt;

  /// Catalog entity id (e.g. offer id) controlled by this approval draft.
  final String? entityId;
  final DateTime? operatorApprovedAt;

  MarketingPublishDraft copyWith({
    MarketingPublishStatus? status,
    DateTime? operatorApprovedAt,
    String? entityId,
  }) {
    return MarketingPublishDraft(
      id: id,
      kindKey: kindKey,
      titleEn: titleEn,
      titleAr: titleAr,
      status: status ?? this.status,
      submittedAt: submittedAt,
      entityId: entityId ?? this.entityId,
      operatorApprovedAt: operatorApprovedAt ?? this.operatorApprovedAt,
    );
  }
}

class MarketingPublishNotifier
    extends StateNotifier<List<MarketingPublishDraft>> {
  MarketingPublishNotifier() : super(const []);

  bool submitForApproval({
    required String kindKey,
    required String titleEn,
    required String titleAr,
    String? entityId,
  }) {
    if (titleEn.trim().isEmpty) return false;
    final id = 'PUB-${DateTime.now().millisecondsSinceEpoch}';
    state = [
      MarketingPublishDraft(
        id: id,
        kindKey: kindKey,
        titleEn: titleEn.trim(),
        titleAr: titleAr.trim(),
        status: MarketingPublishStatus.pendingOperator,
        submittedAt: DateTime.now(),
        entityId: entityId,
      ),
      ...state,
    ];
    return true;
  }

  bool approve(String draftId) {
    final index = state.indexWhere((d) => d.id == draftId);
    if (index == -1) return false;
    final draft = state[index];
    if (draft.status != MarketingPublishStatus.pendingOperator) return false;
    final now = DateTime.now();
    final updated = draft.copyWith(
      status: MarketingPublishStatus.published,
      operatorApprovedAt: now,
    );
    final next = [...state]..[index] = updated;
    state = next;
    return true;
  }

  MarketingPublishDraft? draftById(String id) {
    for (final draft in state) {
      if (draft.id == id) return draft;
    }
    return null;
  }

  bool reject(String draftId) {
    final index = state.indexWhere((d) => d.id == draftId);
    if (index == -1) return false;
    final draft = state[index];
    if (draft.status != MarketingPublishStatus.pendingOperator) return false;
    final next = [...state]
      ..[index] = draft.copyWith(status: MarketingPublishStatus.rejected);
    state = next;
    return true;
  }
}

final marketingPublishProvider = StateNotifierProvider<
  MarketingPublishNotifier,
  List<MarketingPublishDraft>
>((ref) => MarketingPublishNotifier());

final marketingPendingApprovalProvider = Provider<List<MarketingPublishDraft>>((
  ref,
) {
  return ref
      .watch(marketingPublishProvider)
      .where((d) => d.status == MarketingPublishStatus.pendingOperator)
      .toList();
});
