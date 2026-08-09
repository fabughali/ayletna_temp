import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Payroll outcome codes for HR attendance reports.
enum AttendancePayOutcome {
  fullPay,
  delayFee,
  delayFeeDouble,
  absence,
  overtime,
}

class AttendancePayRuleConfig {
  const AttendancePayRuleConfig({
    this.onTimeGraceMinutes = 15,
    this.delayFeeJod = 2.0,
    this.absenceAfterMinutes = 30,
    this.overtimeThresholdMinutes = 60,
    this.overtimeMultiplier = 1.5,
    this.dailyBaseRateJod = 25.0,
  });

  final int onTimeGraceMinutes;
  final double delayFeeJod;
  final int absenceAfterMinutes;
  final int overtimeThresholdMinutes;
  final double overtimeMultiplier;
  final double dailyBaseRateJod;
}

class AttendanceDayRecord {
  const AttendanceDayRecord({
    required this.employeeNameEn,
    required this.employeeNameAr,
    required this.roleEn,
    required this.scheduledStart,
    required this.scheduledEnd,
    this.checkIn,
    this.checkOut,
  });

  final String employeeNameEn;
  final String employeeNameAr;
  final String roleEn;
  final DateTime scheduledStart;
  final DateTime scheduledEnd;
  final DateTime? checkIn;
  final DateTime? checkOut;
}

class AttendancePayResult {
  const AttendancePayResult({
    required this.outcome,
    required this.payableJod,
    required this.delayMinutes,
    required this.overtimeHours,
    required this.isAbsent,
    required this.salaryPercent,
  });

  final AttendancePayOutcome outcome;
  final double payableJod;
  final int delayMinutes;
  final double overtimeHours;
  final bool isAbsent;
  final double salaryPercent;
}

AttendancePayResult calculateAttendancePay({
  required AttendanceDayRecord record,
  required AttendancePayRuleConfig config,
}) {
  final checkIn = record.checkIn;
  final checkOut = record.checkOut;
  if (checkIn == null) {
    return AttendancePayResult(
      outcome: AttendancePayOutcome.absence,
      payableJod: 0,
      delayMinutes: 0,
      overtimeHours: 0,
      isAbsent: true,
      salaryPercent: 0,
    );
  }

  final delayMinutes =
      checkIn.isAfter(record.scheduledStart)
          ? checkIn.difference(record.scheduledStart).inMinutes
          : 0;

  if (delayMinutes > config.absenceAfterMinutes) {
    return AttendancePayResult(
      outcome: AttendancePayOutcome.absence,
      payableJod: 0,
      delayMinutes: delayMinutes,
      overtimeHours: 0,
      isAbsent: true,
      salaryPercent: 0,
    );
  }

  var payable = config.dailyBaseRateJod;
  AttendancePayOutcome outcome = AttendancePayOutcome.fullPay;

  if (delayMinutes > config.onTimeGraceMinutes) {
    if (delayMinutes <= config.absenceAfterMinutes) {
      final feeMultiplier =
          delayMinutes > config.onTimeGraceMinutes + 15 ? 2 : 1;
      payable -= config.delayFeeJod * feeMultiplier;
      outcome =
          feeMultiplier == 2
              ? AttendancePayOutcome.delayFeeDouble
              : AttendancePayOutcome.delayFee;
    }
  }

  var overtimeHours = 0.0;
  if (checkOut != null) {
    final overtimeStart = record.scheduledEnd.add(
      Duration(minutes: config.overtimeThresholdMinutes),
    );
    if (checkOut.isAfter(overtimeStart)) {
      overtimeHours = checkOut.difference(overtimeStart).inMinutes / 60.0;
      final hourly = config.dailyBaseRateJod / 8;
      payable += overtimeHours * hourly * config.overtimeMultiplier;
      outcome = AttendancePayOutcome.overtime;
    }
  }

  payable = payable.clamp(0, double.infinity);
  final percent =
      config.dailyBaseRateJod == 0
          ? 0
          : (payable / config.dailyBaseRateJod * 100).clamp(0, 200);

  return AttendancePayResult(
    outcome: outcome,
    payableJod: payable,
    delayMinutes: delayMinutes,
    overtimeHours: overtimeHours,
    isAbsent: false,
    salaryPercent: percent.toDouble(),
  );
}

class AttendanceHrReportRow {
  const AttendanceHrReportRow({required this.record, required this.result});

  final AttendanceDayRecord record;
  final AttendancePayResult result;
}

class AttendanceHrState {
  const AttendanceHrState({
    this.rules = const AttendancePayRuleConfig(),
    this.period = 'daily',
  });

  final AttendancePayRuleConfig rules;
  final String period;

  List<AttendanceHrReportRow> get reportRows {
    final now = DateTime.now();
    final scheduledStart = DateTime(now.year, now.month, now.day, 9);
    final scheduledEnd = DateTime(now.year, now.month, now.day, 17);
    final periodMultiplier = period == 'monthly' ? 22.0 : 1.0;

    return MockupCatalog.adminTeamMembers.asMap().entries.map((entry) {
      final index = entry.key;
      final member = entry.value;
      final delayMinutes = index == 0 ? 8 : (index == 1 ? 35 : 0);
      final checkIn =
          delayMinutes == 0
              ? scheduledStart
              : scheduledStart.add(Duration(minutes: delayMinutes));
      final checkOut =
          index == 2
              ? scheduledEnd.add(const Duration(minutes: 75))
              : scheduledEnd.add(const Duration(minutes: 10));
      final record = AttendanceDayRecord(
        employeeNameEn: member.nameEn,
        employeeNameAr: member.nameAr,
        roleEn: member.roleEn,
        scheduledStart: scheduledStart,
        scheduledEnd: scheduledEnd,
        checkIn: delayMinutes == 35 && period == 'monthly' ? null : checkIn,
        checkOut: checkOut,
      );
      final result = calculateAttendancePay(record: record, config: rules);
      return AttendanceHrReportRow(
        record: record,
        result: AttendancePayResult(
          outcome: result.outcome,
          payableJod: result.payableJod * periodMultiplier,
          delayMinutes: result.delayMinutes,
          overtimeHours: result.overtimeHours,
          isAbsent: result.isAbsent,
          salaryPercent: result.salaryPercent,
        ),
      );
    }).toList();
  }

  double get totalPayableJod =>
      reportRows.fold(0, (sum, row) => sum + row.result.payableJod);

  AttendanceHrState copyWith({AttendancePayRuleConfig? rules, String? period}) {
    return AttendanceHrState(
      rules: rules ?? this.rules,
      period: period ?? this.period,
    );
  }
}

class AttendanceHrNotifier extends StateNotifier<AttendanceHrState> {
  AttendanceHrNotifier() : super(const AttendanceHrState());

  void setPeriod(String period) {
    state = state.copyWith(period: period);
  }

  void updateRules(AttendancePayRuleConfig rules) {
    state = state.copyWith(rules: rules);
  }
}

final attendanceHrProvider =
    StateNotifierProvider<AttendanceHrNotifier, AttendanceHrState>(
      (ref) => AttendanceHrNotifier(),
    );

final attendanceHrReportProvider = Provider<List<AttendanceHrReportRow>>((ref) {
  return ref.watch(attendanceHrProvider).reportRows;
});
