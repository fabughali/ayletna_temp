import 'package:ayletna_restaurant_app/core/app_config.dart';
import 'package:ayletna_restaurant_app/providers/admin_integration_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:network_info_plus/network_info_plus.dart';

/// Result of comparing the device network to admin-configured restaurant WiFi.
class AttendanceWifiStatus {
  const AttendanceWifiStatus({
    required this.isOnWifi,
    required this.isRestaurantWifi,
    required this.isDemoSimulation,
    this.currentSsid,
    this.currentBssid,
    this.expectedSsid,
    this.expectedBssid,
  });

  final bool isOnWifi;
  final bool isRestaurantWifi;
  final bool isDemoSimulation;
  final String? currentSsid;
  final String? currentBssid;
  final String? expectedSsid;
  final String? expectedBssid;

  bool get isConfigured =>
      expectedSsid != null && expectedSsid!.trim().isNotEmpty;
}

/// Reads WiFi SSID/BSSID and validates against admin router registration.
abstract final class ServiceAttendanceWifi {
  static final _networkInfo = NetworkInfo();

  static Future<AttendanceWifiStatus> evaluate(
    AdminIntegrationConfigState config,
  ) async {
    final expectedSsid = config.restaurantWifiSsid.trim();
    final expectedBssid = config.restaurantWifiBssid.trim();

    if (expectedSsid.isEmpty) {
      return AttendanceWifiStatus(
        isOnWifi: false,
        isRestaurantWifi: false,
        isDemoSimulation: false,
        expectedSsid: expectedSsid,
        expectedBssid: expectedBssid,
      );
    }

    if (kIsWeb) {
      if (AppConfig.demoModeEnabled) {
        return AttendanceWifiStatus(
          isOnWifi: true,
          isRestaurantWifi: true,
          isDemoSimulation: true,
          currentSsid: expectedSsid,
          currentBssid: expectedBssid.isEmpty ? null : expectedBssid,
          expectedSsid: expectedSsid,
          expectedBssid: expectedBssid,
        );
      }
      return AttendanceWifiStatus(
        isOnWifi: false,
        isRestaurantWifi: false,
        isDemoSimulation: false,
        expectedSsid: expectedSsid,
        expectedBssid: expectedBssid,
      );
    }

    final rawSsid = await _networkInfo.getWifiName();
    final rawBssid = await _networkInfo.getWifiBSSID();
    final currentSsid = _normalizeSsid(rawSsid);
    final currentBssid = _normalizeBssid(rawBssid);
    final isOnWifi = currentSsid != null && currentSsid.isNotEmpty;
    final ssidMatches =
        isOnWifi &&
        currentSsid.toLowerCase() == expectedSsid.toLowerCase();
    final bssidMatches =
        expectedBssid.isEmpty ||
        (currentBssid != null &&
            currentBssid.toLowerCase() == expectedBssid.toLowerCase());

    return AttendanceWifiStatus(
      isOnWifi: isOnWifi,
      isRestaurantWifi: ssidMatches && bssidMatches,
      isDemoSimulation: false,
      currentSsid: currentSsid,
      currentBssid: currentBssid,
      expectedSsid: expectedSsid,
      expectedBssid: expectedBssid,
    );
  }

  static String? _normalizeSsid(String? value) {
    if (value == null) return null;
    final trimmed = value.replaceAll('"', '').trim();
    if (trimmed.isEmpty ||
        trimmed == '<unknown ssid>' ||
        trimmed == 'null') {
      return null;
    }
    return trimmed;
  }

  static String? _normalizeBssid(String? value) {
    if (value == null) return null;
    final trimmed = value.trim();
    if (trimmed.isEmpty || trimmed == '02:00:00:00:00:00') {
      return null;
    }
    return trimmed;
  }
}
