import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_staff_mock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum StaffTipAckStatus { pending, acknowledged, disputed }

/// Staff attendance + daily tip acknowledgement for the mock session.
class StaffSessionState {
  const StaffSessionState({
    this.isOnShift = false,
    this.checkInAt,
    this.checkOutAt,
    this.tipAckStatus = StaffTipAckStatus.pending,
    this.tipHistoryRange = 'thisMonth',
    this.customRangeApplied = false,
    this.customRangeStart,
    this.customRangeEnd,
    this.sessionHistoryRows = const [],
    this.recordedWifiSsid,
    this.recordedWifiBssid,
  });

  final bool isOnShift;
  final DateTime? checkInAt;
  final DateTime? checkOutAt;
  final String? recordedWifiSsid;
  final String? recordedWifiBssid;
  final StaffTipAckStatus tipAckStatus;
  final String tipHistoryRange;
  final bool customRangeApplied;
  final DateTime? customRangeStart;
  final DateTime? customRangeEnd;
  final List<ModelStaffTipHistory> sessionHistoryRows;

  Duration? get shiftDuration {
    if (checkInAt == null) return null;
    final end = checkOutAt ?? DateTime.now();
    return end.difference(checkInAt!);
  }

  String formatShiftDuration() {
    final duration = shiftDuration;
    if (duration == null) return '00:00:00';
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  /// Parse a date string like "Jun 12" into a DateTime.
  static DateTime? _parseDate(String dateStr) {
    try {
      return DateTime.tryParse('2026 $dateStr');
    } catch (_) {
      return null;
    }
  }

  List<ModelStaffTipHistory> get filteredTipHistory {
    if (tipHistoryRange == 'custom' && customRangeStart != null && customRangeEnd != null) {
      final base = MockupCatalog.staffTipHistory.where((row) {
        final rowDate = _parseDate(row.dateEn);
        if (rowDate == null) return false;
        return !rowDate.isBefore(customRangeStart!) && !rowDate.isAfter(customRangeEnd!);
      }).toList();
      return [...sessionHistoryRows, ...base];
    }
    final baseline = switch (tipHistoryRange) {
      'lastMonth' =>
        MockupCatalog.staffTipHistory
            .where((row) => row.weekKey == 'last')
            .toList(),
      _ => MockupCatalog.staffTipHistory,
    };
    return [...sessionHistoryRows, ...baseline];
  }

  List<ModelStaffTipHistory> tipHistoryForWeek(String weekKey) =>
      filteredTipHistory.where((row) => row.weekKey == weekKey).toList();

  StaffSessionState copyWith({
    bool? isOnShift,
    DateTime? checkInAt,
    DateTime? checkOutAt,
    StaffTipAckStatus? tipAckStatus,
    String? tipHistoryRange,
    bool? customRangeApplied,
    DateTime? customRangeStart,
    DateTime? customRangeEnd,
    List<ModelStaffTipHistory>? sessionHistoryRows,
    String? recordedWifiSsid,
    String? recordedWifiBssid,
    bool clearCheckIn = false,
    bool clearCheckOut = false,
    bool clearCustomRangeStart = false,
    bool clearCustomRangeEnd = false,
  }) {
    return StaffSessionState(
      isOnShift: isOnShift ?? this.isOnShift,
      checkInAt: clearCheckIn ? null : (checkInAt ?? this.checkInAt),
      checkOutAt: clearCheckOut ? null : (checkOutAt ?? this.checkOutAt),
      recordedWifiSsid: recordedWifiSsid ?? this.recordedWifiSsid,
      recordedWifiBssid: recordedWifiBssid ?? this.recordedWifiBssid,
      tipAckStatus: tipAckStatus ?? this.tipAckStatus,
      tipHistoryRange: tipHistoryRange ?? this.tipHistoryRange,
      customRangeApplied: customRangeApplied ?? this.customRangeApplied,
      customRangeStart: clearCustomRangeStart ? null : (customRangeStart ?? this.customRangeStart),
      customRangeEnd: clearCustomRangeEnd ? null : (customRangeEnd ?? this.customRangeEnd),
      sessionHistoryRows: sessionHistoryRows ?? this.sessionHistoryRows,
    );
  }
}

class StaffSessionNotifier extends StateNotifier<StaffSessionState> {
  StaffSessionNotifier() : super(const StaffSessionState());

  bool checkIn({required String wifiSsid, String? wifiBssid}) {
    if (state.isOnShift) return false;
    state = state.copyWith(
      isOnShift: true,
      checkInAt: DateTime.now(),
      clearCheckOut: true,
      recordedWifiSsid: wifiSsid,
      recordedWifiBssid: wifiBssid,
    );
    return true;
  }

  bool checkOut({required String wifiSsid, String? wifiBssid}) {
    if (!state.isOnShift || state.checkInAt == null) return false;
    final checkOutAt = DateTime.now();
    final duration = checkOutAt.difference(state.checkInAt!);
    final hours = duration.inMinutes / 60.0;
    final hoursLabelEn =
        hours >= 1
            ? '${hours.toStringAsFixed(1)} hrs'
            : '${duration.inMinutes} mins';
    final hoursLabelAr = hoursLabelEn;

    state = state.copyWith(
      isOnShift: false,
      checkOutAt: checkOutAt,
      recordedWifiSsid: wifiSsid,
      recordedWifiBssid: wifiBssid,
      sessionHistoryRows: [
        ModelStaffTipHistory(
          weekKey: 'this',
          dateAr: 'اليوم',
          dateEn: 'Today',
          titleAr: 'وردية مسجلة',
          titleEn: 'Recorded Shift',
          timeAr: 'تم تسجيل الخروج',
          timeEn: 'Checked out',
          hoursAr: hoursLabelAr,
          hoursEn: hoursLabelEn,
          tipsAr: '—',
          tipsEn: '—',
          colorKey: 'success',
        ),
        ...state.sessionHistoryRows,
      ],
    );
    return true;
  }

  void acknowledgeTips() {
    if (state.tipAckStatus != StaffTipAckStatus.pending) return;
    state = state.copyWith(tipAckStatus: StaffTipAckStatus.acknowledged);
  }

  void disputeTips() {
    if (state.tipAckStatus != StaffTipAckStatus.pending) return;
    state = state.copyWith(tipAckStatus: StaffTipAckStatus.disputed);
  }

  void setTipHistoryRange(String range) {
    state = state.copyWith(
      tipHistoryRange: range,
      customRangeApplied: range == 'custom' ? state.customRangeApplied : false,
    );
  }

  void applyCustomRange({DateTime? start, DateTime? end}) {
    state = state.copyWith(
      tipHistoryRange: 'custom',
      customRangeApplied: true,
      customRangeStart: start,
      customRangeEnd: end,
    );
  }
}

final staffSessionProvider =
    StateNotifierProvider<StaffSessionNotifier, StaffSessionState>(
      (ref) => StaffSessionNotifier(),
    );
