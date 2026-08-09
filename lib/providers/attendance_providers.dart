import 'package:ayletna_restaurant_app/providers/admin_integration_providers.dart';
import 'package:ayletna_restaurant_app/services/service_attendance_wifi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AttendanceActionMode { coming, leaving }

class AttendanceWifiNotifier
    extends StateNotifier<AsyncValue<AttendanceWifiStatus>> {
  AttendanceWifiNotifier(this._readConfig) : super(const AsyncValue.loading());

  final AdminIntegrationConfigState Function() _readConfig;

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(
      await ServiceAttendanceWifi.evaluate(_readConfig()),
    );
  }
}

final attendanceActionModeProvider = StateProvider<AttendanceActionMode>((ref) {
  return AttendanceActionMode.coming;
});

final attendanceWifiProvider = StateNotifierProvider<
  AttendanceWifiNotifier,
  AsyncValue<AttendanceWifiStatus>
>((ref) {
  final notifier = AttendanceWifiNotifier(
    () => ref.read(adminIntegrationConfigProvider),
  );
  notifier.refresh();
  return notifier;
});
