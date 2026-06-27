import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_inventory_mock.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/data/models/model_staff_mock.dart';
import 'package:ayletna_restaurant_app/providers/admin_dashboard_providers.dart';
import 'package:ayletna_restaurant_app/providers/attendance_hr_providers.dart';
import 'package:intl/intl.dart';

String buildReportsCsv({
  required AdminDashboardMetrics metrics,
  required AttendanceHrState hr,
}) {
  final buffer = StringBuffer();
  buffer.writeln('section,metric,value');
  buffer.writeln('orders,active,${metrics.activeOrderCount}');
  buffer.writeln('orders,dine_in,${metrics.dineInCount}');
  buffer.writeln('orders,takeaway,${metrics.takeawayCount}');
  buffer.writeln('orders,delivery,${metrics.deliveryCount}');
  buffer.writeln('orders,plated,${metrics.platedCount}');
  buffer.writeln('finance,revenue_jod,${metrics.revenueTodayJod.toStringAsFixed(2)}');
  buffer.writeln('finance,tips_jod,${metrics.tipsPoolJod.toStringAsFixed(2)}');
  buffer.writeln('finance,breakage_jod,${metrics.breakageLossJod.toStringAsFixed(2)}');
  buffer.writeln('hr,total_payable_jod,${hr.totalPayableJod.toStringAsFixed(2)}');
  buffer.writeln('hr,period,${hr.period}');
  buffer.writeln('');
  buffer.writeln('employee,role,payable_jod,outcome,delay_min');
  for (final row in hr.reportRows) {
    buffer.writeln(
      '"${row.record.employeeNameEn}","${row.record.roleEn}",'
      '${row.result.payableJod.toStringAsFixed(2)},'
      '${row.result.outcome.name},${row.result.delayMinutes}',
    );
  }
  return buffer.toString();
}

String buildReportsPrintableHtml({
  required AdminDashboardMetrics metrics,
  required AttendanceHrState hr,
  required bool isAr,
}) {
  final generated = DateFormat.yMMMd().add_jm().format(DateTime.now());
  final title = isAr ? 'تقرير عيلتنا' : 'Ayletna Report';
  final rows = hr.reportRows
      .map(
        (row) =>
            '<tr><td>${row.record.employeeNameEn}</td>'
            '<td>${row.result.payableJod.toStringAsFixed(2)} JOD</td>'
            '<td>${row.result.outcome.name}</td></tr>',
      )
      .join();

  return '''
<!DOCTYPE html>
<html lang="${isAr ? 'ar' : 'en'}">
<head>
  <meta charset="utf-8"/>
  <title>$title</title>
  <style>
    body { font-family: sans-serif; padding: 32px; color: #2b2118; }
    h1 { margin-bottom: 4px; }
    .meta { color: #666; margin-bottom: 24px; }
    table { border-collapse: collapse; width: 100%; margin-top: 12px; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align: start; }
    th { background: #f5efe3; }
  </style>
</head>
<body>
  <h1>$title</h1>
  <div class="meta">$generated</div>
  <h2>${isAr ? 'ملخص التشغيل' : 'Operations summary'}</h2>
  <ul>
    <li>${isAr ? 'طلبات نشطة' : 'Active orders'}: ${metrics.activeOrderCount}</li>
    <li>${isAr ? 'إيراد اليوم' : 'Revenue today'}: ${metrics.revenueTodayJod.toStringAsFixed(2)} JOD</li>
    <li>${isAr ? 'البقشيش' : 'Tips pool'}: ${metrics.tipsPoolJod.toStringAsFixed(2)} JOD</li>
    <li>${isAr ? 'كسر/هدر' : 'Breakage loss'}: ${metrics.breakageLossJod.toStringAsFixed(2)} JOD</li>
  </ul>
  <h2>${isAr ? 'الموارد البشرية' : 'HR payroll'}</h2>
  <p>${isAr ? 'إجمالي المستحق' : 'Total payable'}: ${hr.totalPayableJod.toStringAsFixed(2)} JOD (${hr.period})</p>
  <table>
    <thead><tr><th>${isAr ? 'الموظف' : 'Employee'}</th><th>${isAr ? 'المستحق' : 'Payable'}</th><th>${isAr ? 'الحالة' : 'Outcome'}</th></tr></thead>
    <tbody>$rows</tbody>
  </table>
</body>
</html>
''';
}

String buildHrPayrollCsv({
  required AttendanceHrState hr,
  required List<AttendanceHrReportRow> rows,
}) {
  final buffer = StringBuffer();
  buffer.writeln('period,total_payable_jod');
  buffer.writeln('${hr.period},${hr.totalPayableJod.toStringAsFixed(2)}');
  buffer.writeln('');
  buffer.writeln('employee,role,payable_jod,outcome,delay_min,overtime_hrs,salary_pct');
  for (final row in rows) {
    buffer.writeln(
      '"${row.record.employeeNameEn}","${row.record.roleEn}",'
      '${row.result.payableJod.toStringAsFixed(2)},'
      '${row.result.outcome.name},${row.result.delayMinutes},'
      '${row.result.overtimeHours.toStringAsFixed(1)},'
      '${row.result.salaryPercent.toStringAsFixed(0)}',
    );
  }
  return buffer.toString();
}

String buildAuditLogCsv({
  required String category,
  required DateTime? lastExportAt,
}) {
  final buffer = StringBuffer();
  buffer.writeln('category,actor,area,time,detail');
  final rows = [
    ('users', 'Operator Ahmad', 'Roles & Privacy', 'Today 09:42', 'User role changed'),
    ('finance', 'Cashier Layla', 'Shift Close', 'Today 08:15', 'Shift revenue reconciled'),
    ('inventory', 'Prep Lead Omar', 'Stock Adjustment', 'Yesterday 17:20', 'Salmon stock adjusted'),
    ('plates', 'Logistics Sara', 'Tray Returns', 'Yesterday 14:05', 'Breakage logged for tray batch'),
    ('finance', 'Owner Review', 'Audit Export', lastExportAt?.toIso8601String() ?? '—', 'Audit log exported'),
  ];
  for (final row in rows) {
    if (category != 'all' && row.$1 != category) continue;
    buffer.writeln(
      '${row.$1},"${row.$2}","${row.$3}","${row.$4}","${row.$5}"',
    );
  }
  return buffer.toString();
}

String buildFinancialCloseHtml({
  required bool shiftCloseApproved,
  required bool isAr,
}) {
  final generated = DateFormat.yMMMd().add_jm().format(DateTime.now());
  final title = isAr ? 'إغلاق الوردية المالي' : 'Shift Financial Close';
  final status =
      shiftCloseApproved
          ? (isAr ? 'معتمد' : 'Approved')
          : (isAr ? 'قيد المراجعة' : 'Pending review');

  return '''
<!DOCTYPE html>
<html lang="${isAr ? 'ar' : 'en'}">
<head>
  <meta charset="utf-8"/>
  <title>$title</title>
  <style>
    body { font-family: sans-serif; padding: 32px; color: #2b2118; }
    h1 { margin-bottom: 4px; }
    .meta { color: #666; margin-bottom: 24px; }
    table { border-collapse: collapse; width: 100%; margin-top: 12px; }
    th, td { border: 1px solid #ddd; padding: 8px; text-align: start; }
    th { background: #f5efe3; }
  </style>
</head>
<body>
  <h1>$title</h1>
  <div class="meta">$generated · $status</div>
  <table>
    <thead><tr><th>${isAr ? 'البند' : 'Line item'}</th><th>${isAr ? 'المبلغ (د.أ)' : 'Amount (JOD)'}</th></tr></thead>
    <tbody>
      <tr><td>${isAr ? 'إيراد إجمالي' : 'Gross revenue'}</td><td>${MockupCatalog.financialGrossRevenueJod.toStringAsFixed(2)}</td></tr>
      <tr><td>${isAr ? 'مصاريف تشغيل' : 'Operating expenses'}</td><td>-${MockupCatalog.financialOperationalExpensesJod.toStringAsFixed(2)}</td></tr>
      <tr><td>${isAr ? 'صافي الإيراد' : 'Net revenue'}</td><td>${MockupCatalog.financialNetRevenueJod.toStringAsFixed(2)}</td></tr>
      <tr><td>${isAr ? 'مجمع البقشيش' : 'Tips pool'}</td><td>${MockupCatalog.dailyTipPoolJod.toStringAsFixed(2)}</td></tr>
      <tr><td>${isAr ? 'عربون الصواني' : 'Plated deposits'}</td><td>${MockupCatalog.checkoutPlatedDepositJod.toStringAsFixed(2)}</td></tr>
    </tbody>
  </table>
</body>
</html>
''';
}

String buildStaffTipStatementCsv(List<ModelStaffTipHistory> rows) {
  final buffer = StringBuffer();
  buffer.writeln('week,date,title,time,hours,tips');
  for (final row in rows) {
    buffer.writeln(
      '${row.weekKey},"${row.dateEn}","${row.titleEn}","${row.timeEn}",'
      '"${row.hoursEn}","${row.tipsEn}"',
    );
  }
  return buffer.toString();
}

String buildCashierOrdersCsv(List<ModelOrderSummary> orders) {
  final buffer = StringBuffer();
  buffer.writeln('order_id,type,customer,total_jod,deposit_jod,status');
  for (final order in orders) {
    buffer.writeln(
      '${order.id},${order.orderType.name},"${order.customerLabel}",'
      '${order.totalJod.toStringAsFixed(2)},'
      '${order.depositJod.toStringAsFixed(2)},${order.statusKey}',
    );
  }
  return buffer.toString();
}

String buildInventoryWastageCsv(List<ModelInventoryWastageLog> logs) {
  final buffer = StringBuffer();
  buffer.writeln('item,quantity,reason,value_lost_jod,time,user');
  for (final log in logs) {
    buffer.writeln(
      '"${log.itemEn}","${log.quantityEn}","${log.reasonEn}",'
      '${log.valueLostJod.toStringAsFixed(2)},"${log.time}","${log.userEn}"',
    );
  }
  return buffer.toString();
}
