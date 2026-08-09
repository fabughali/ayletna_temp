import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';

/// Capability access level (maps to matrix §3 symbols).
enum PermissionAccess { full, readOnly, denied, postponed }

/// A single capability rule keyed for RBAC UI (matrix §3 rows).
class PermissionRule {
  const PermissionRule({
    required this.key,
    required this.access,
    this.postponedUntil,
  });

  final String key;
  final PermissionAccess access;
  final DateTime? postponedUntil;

  PermissionRule copyWith({
    String? key,
    PermissionAccess? access,
    DateTime? postponedUntil,
    bool clearPostponedUntil = false,
  }) {
    return PermissionRule(
      key: key ?? this.key,
      access: access ?? this.access,
      postponedUntil:
          clearPostponedUntil ? null : (postponedUntil ?? this.postponedUntil),
    );
  }
}

/// Catalog of capability keys grouped for Screen A / B matrices.
abstract final class PermissionCatalog {
  static const allKeys = [
    'perm.admin.users',
    'perm.admin.rbac_defaults',
    'perm.admin.rbac_overrides',
    'perm.admin.audit',
    'perm.admin.integrations',
    'perm.admin.system_settings',
    'perm.admin.owner_view_config',
    'perm.operator.dashboard',
    'perm.operator.orders',
    'perm.operator.menu',
    'perm.operator.tips',
    'perm.operator.plates',
    'perm.operator.hr',
    'perm.operator.reports',
    'perm.operator.financial_close',
    'perm.owner.dashboard',
    'perm.owner.reports',
    'perm.owner.financial',
    'perm.support.tickets',
    'perm.support.chat',
    'perm.support.reviews',
    'perm.support.faq',
    'perm.support.refunds',
    'perm.support.sla',
    'perm.marketing.offers',
    'perm.marketing.combos',
    'perm.marketing.subscriptions',
    'perm.marketing.promotions',
    'perm.marketing.loyalty',
    'perm.marketing.social',
    'perm.marketing.menu_pricing',
    'perm.marketing.publish',
    'perm.operator.campaign_approve',
    'perm.cashier.pos',
    'perm.kitchen.queue',
    'perm.delivery.routes',
    'perm.inventory.stock',
    'perm.staff.attendance',
  ];

  static List<String> keysForRole(AppRole role) => switch (role) {
    AppRole.admin => [
      'perm.admin.users',
      'perm.admin.rbac_defaults',
      'perm.admin.rbac_overrides',
      'perm.admin.audit',
      'perm.admin.integrations',
      'perm.admin.system_settings',
      'perm.admin.owner_view_config',
    ],
    AppRole.operator => [
      'perm.operator.dashboard',
      'perm.operator.orders',
      'perm.operator.menu',
      'perm.operator.tips',
      'perm.operator.plates',
      'perm.operator.hr',
      'perm.operator.reports',
      'perm.operator.financial_close',
      'perm.operator.campaign_approve',
    ],
    AppRole.owner => [
      'perm.owner.dashboard',
      'perm.owner.reports',
      'perm.owner.financial',
    ],
    AppRole.support => [
      'perm.support.tickets',
      'perm.support.chat',
      'perm.support.reviews',
      'perm.support.faq',
      'perm.support.refunds',
      'perm.support.sla',
    ],
    AppRole.marketing => [
      'perm.marketing.offers',
      'perm.marketing.combos',
      'perm.marketing.subscriptions',
      'perm.marketing.promotions',
      'perm.marketing.loyalty',
      'perm.marketing.social',
      'perm.marketing.menu_pricing',
      'perm.marketing.publish',
    ],
    AppRole.cashier => ['perm.cashier.pos'],
    AppRole.kitchen => ['perm.kitchen.queue'],
    AppRole.delivery => ['perm.delivery.routes'],
    AppRole.inventory => ['perm.inventory.stock'],
    AppRole.staff => ['perm.staff.attendance'],
    AppRole.customer || AppRole.guest => [],
  };
}

/// Mock user row for Screen B.
class RbacUserRecord {
  const RbacUserRecord({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.email,
    required this.assignedRoles,
    this.status = 'active',
    this.ownershipPercentage,
  });

  final String id;
  final String nameEn;
  final String nameAr;
  final String email;
  final Set<AppRole> assignedRoles;
  final String status;
  final double? ownershipPercentage;

  String displayName(bool isAr) => isAr ? nameAr : nameEn;

  RbacUserRecord copyWith({
    String? id,
    String? nameEn,
    String? nameAr,
    String? email,
    Set<AppRole>? assignedRoles,
    String? status,
    double? ownershipPercentage,
    bool clearOwnership = false,
  }) {
    return RbacUserRecord(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      email: email ?? this.email,
      assignedRoles: assignedRoles ?? this.assignedRoles,
      status: status ?? this.status,
      ownershipPercentage:
          clearOwnership
              ? null
              : (ownershipPercentage ?? this.ownershipPercentage),
    );
  }
}
