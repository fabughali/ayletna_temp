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
    this.orderAlerts = true,
    this.shiftAlerts = true,
    this.marketing = false,
  });

  final String displayNameAr;
  final String displayNameEn;
  final String phone;
  final String email;
  final String? employeeId;
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
    bool? orderAlerts,
    bool? shiftAlerts,
    bool? marketing,
  }) {
    return UserProfile(
      displayNameAr: displayNameAr ?? this.displayNameAr,
      displayNameEn: displayNameEn ?? this.displayNameEn,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      employeeId: employeeId ?? this.employeeId,
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
      _ => const UserProfile(
        displayNameAr: MockupCatalog.staffDisplayNameAr,
        displayNameEn: MockupCatalog.staffDisplayNameEn,
        phone: MockupCatalog.staffPhone,
        email: MockupCatalog.staffEmail,
      ),
    };
  }
}
