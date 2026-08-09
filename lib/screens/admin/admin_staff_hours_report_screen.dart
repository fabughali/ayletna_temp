import 'package:ayletna_restaurant_app/screens/admin/admin_attendance_hr_screen.dart';
import 'package:flutter/material.dart';

/// PRD [StaffHoursReportScreen] — now routes to HR attendance & payroll report.
class AdminStaffHoursReportScreen extends StatelessWidget {
  const AdminStaffHoursReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminAttendanceHrScreen(staffHoursReport: true);
  }
}
