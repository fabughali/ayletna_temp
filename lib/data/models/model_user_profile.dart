import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';

/// In-memory user profile for personal settings (UI phase — swap for Supabase later).
class UserProfile {
  const UserProfile({
    required this.displayNameAr,
    required this.displayNameEn,
    required this.phone,
    required this.email,
    this.employeeId,
    this.ownershipPercentage,
    this.ownerViewConfigId,
    this.avatarUrl,
    this.orderAlerts = true,
    this.shiftAlerts = true,
    this.marketing = false,
  });

  final String displayNameAr;
  final String displayNameEn;
  final String phone;
  final String email;
  final String? employeeId;
  final double? ownershipPercentage;
  final String? ownerViewConfigId;
  final String? avatarUrl;
  final bool orderAlerts;
  final bool shiftAlerts;
  final bool marketing;

  String displayName(bool isAr) => isAr ? displayNameAr : displayNameEn;

  UserProfile copyWith({
    String? displayNameAr,
    String? displayNameEn,
    String? phone,
    String? email,
    String? employeeId,
    double? ownershipPercentage,
    String? ownerViewConfigId,
    String? avatarUrl,
    bool? orderAlerts,
    bool? shiftAlerts,
    bool? marketing,
    bool clearOwnership = false,
    bool clearOwnerViewConfig = false,
    bool clearAvatarUrl = false,
  }) {
    return UserProfile(
      displayNameAr: displayNameAr ?? this.displayNameAr,
      displayNameEn: displayNameEn ?? this.displayNameEn,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      employeeId: employeeId ?? this.employeeId,
      ownershipPercentage:
          clearOwnership ? null : (ownershipPercentage ?? this.ownershipPercentage),
      ownerViewConfigId: clearOwnerViewConfig
          ? null
          : (ownerViewConfigId ?? this.ownerViewConfigId),
      avatarUrl: clearAvatarUrl ? null : (avatarUrl ?? this.avatarUrl),
      orderAlerts: orderAlerts ?? this.orderAlerts,
      shiftAlerts: shiftAlerts ?? this.shiftAlerts,
      marketing: marketing ?? this.marketing,
    );
  }

  static UserProfile forRole(AppRole role) {
    return switch (role) {
      AppRole.cashier => const UserProfile(
        displayNameAr: MockupCatalog.cashierNameAr,
        displayNameEn: MockupCatalog.cashierNameEn,
        phone: MockupCatalog.staffPhone,
        email: MockupCatalog.staffEmail,
        employeeId: MockupCatalog.cashierNumber,
      ),
      AppRole.customer => const UserProfile(
        displayNameAr: MockupCatalog.customerDisplayNameAr,
        displayNameEn: MockupCatalog.customerDisplayNameEn,
        phone: MockupCatalog.customerPhone,
        email: MockupCatalog.customerEmail,
      ),
      AppRole.guest => const UserProfile(
        displayNameAr: MockupCatalog.customerDisplayNameAr,
        displayNameEn: MockupCatalog.customerDisplayNameEn,
        phone: MockupCatalog.customerPhone,
        email: MockupCatalog.customerEmail,
        orderAlerts: false,
        shiftAlerts: false,
        marketing: false,
      ),
      AppRole.admin => const UserProfile(
        displayNameAr: 'مدير التطبيق',
        displayNameEn: 'App Administrator',
        phone: MockupCatalog.staffPhone,
        email: 'admin@ayletna.test',
      ),
      AppRole.operator => const UserProfile(
        displayNameAr: 'مشغّل المطعم',
        displayNameEn: 'Restaurant Operator',
        phone: MockupCatalog.staffPhone,
        email: 'operator@ayletna.test',
      ),
      AppRole.owner => const UserProfile(
        displayNameAr: 'مالك مساهم',
        displayNameEn: 'Shareholder Owner',
        phone: MockupCatalog.staffPhone,
        email: 'owner@ayletna.test',
        ownershipPercentage: 35,
        ownerViewConfigId: 'cfg-standard',
      ),
      AppRole.support => const UserProfile(
        displayNameAr: 'موظف الدعم',
        displayNameEn: 'Support Agent',
        phone: MockupCatalog.staffPhone,
        email: 'support@ayletna.test',
      ),
      AppRole.marketing => const UserProfile(
        displayNameAr: 'مسؤول التسويق',
        displayNameEn: 'Marketing Lead',
        phone: MockupCatalog.staffPhone,
        email: 'marketing@ayletna.test',
      ),
      _ => const UserProfile(
        displayNameAr: MockupCatalog.staffDisplayNameAr,
        displayNameEn: MockupCatalog.staffDisplayNameEn,
        phone: MockupCatalog.staffPhone,
        email: MockupCatalog.staffEmail,
      ),
    };
  }
}
