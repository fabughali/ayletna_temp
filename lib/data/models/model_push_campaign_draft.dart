enum PushCampaignStatus { draft, scheduled, sent }

class PushCampaignDraft {
  const PushCampaignDraft({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.bodyAr,
    required this.bodyEn,
    required this.status,
    this.scheduledAt,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String bodyAr;
  final String bodyEn;
  final PushCampaignStatus status;
  final DateTime? scheduledAt;

  String title(bool isAr) => isAr ? titleAr : titleEn;
  String body(bool isAr) => isAr ? bodyAr : bodyEn;

  PushCampaignDraft copyWith({
    String? titleAr,
    String? titleEn,
    String? bodyAr,
    String? bodyEn,
    PushCampaignStatus? status,
    DateTime? scheduledAt,
    bool clearSchedule = false,
  }) {
    return PushCampaignDraft(
      id: id,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      bodyAr: bodyAr ?? this.bodyAr,
      bodyEn: bodyEn ?? this.bodyEn,
      status: status ?? this.status,
      scheduledAt: clearSchedule ? null : (scheduledAt ?? this.scheduledAt),
    );
  }
}
