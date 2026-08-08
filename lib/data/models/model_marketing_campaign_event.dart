enum MarketingCampaignKind { offer, promo, social, loyalty }

class MarketingCampaignEvent {
  const MarketingCampaignEvent({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.startAt,
    required this.endAt,
    required this.kind,
    this.channelAr,
    this.channelEn,
    this.offerIds = const [],
    this.comboIds = const [],
    this.discountIds = const [],
    this.subscriptionIds = const [],
  });

  final String id;
  final String titleAr;
  final String titleEn;

  /// Inclusive launch window (date + time).
  final DateTime startAt;
  final DateTime endAt;
  final MarketingCampaignKind kind;
  final String? channelAr;
  final String? channelEn;
  final List<String> offerIds;
  final List<String> comboIds;
  final List<String> discountIds;
  final List<String> subscriptionIds;

  DateTime get startDate =>
      DateTime(startAt.year, startAt.month, startAt.day);

  DateTime get endDate => DateTime(endAt.year, endAt.month, endAt.day);

  bool occursOn(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    return !d.isBefore(startDate) && !d.isAfter(endDate);
  }

  bool isLiveAt(DateTime moment) =>
      !moment.isBefore(startAt) && !moment.isAfter(endAt);

  String title(bool isAr) => isAr ? titleAr : titleEn;

  String? channel(bool isAr) => isAr ? channelAr : channelEn;

  MarketingCampaignEvent copyWith({
    String? id,
    String? titleAr,
    String? titleEn,
    DateTime? startAt,
    DateTime? endAt,
    MarketingCampaignKind? kind,
    String? channelAr,
    String? channelEn,
    List<String>? offerIds,
    List<String>? comboIds,
    List<String>? discountIds,
    List<String>? subscriptionIds,
  }) {
    return MarketingCampaignEvent(
      id: id ?? this.id,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      kind: kind ?? this.kind,
      channelAr: channelAr ?? this.channelAr,
      channelEn: channelEn ?? this.channelEn,
      offerIds: offerIds ?? this.offerIds,
      comboIds: comboIds ?? this.comboIds,
      discountIds: discountIds ?? this.discountIds,
      subscriptionIds: subscriptionIds ?? this.subscriptionIds,
    );
  }
}
