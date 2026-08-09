import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/data/models/model_permission_rule.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Factory defaults — seeded from matrix §3 (UI mock).
Map<AppRole, Map<String, PermissionAccess>> _factoryRoleDefaults() {
  PermissionAccess fullFor(AppRole role, String key) {
    if (!PermissionCatalog.keysForRole(role).contains(key)) {
      return PermissionAccess.denied;
    }
    return PermissionAccess.full;
  }

  final map = <AppRole, Map<String, PermissionAccess>>{};
  for (final role in AppRole.values) {
    map[role] = {
      for (final key in PermissionCatalog.keysForRole(role))
        key: fullFor(role, key),
    };
  }
  return map;
}

class RolePermissionsNotifier
    extends StateNotifier<Map<AppRole, Map<String, PermissionAccess>>> {
  RolePermissionsNotifier() : super(_factoryRoleDefaults());

  void setAccess(AppRole role, String key, PermissionAccess access) {
    final roleMap = Map<String, PermissionAccess>.from(state[role] ?? {});
    roleMap[key] = access;
    state = {...state, role: roleMap};
  }

  void resetRole(AppRole role) {
    state = {...state, role: Map.from(_factoryRoleDefaults()[role] ?? {})};
  }

  PermissionAccess accessFor(AppRole role, String key) {
    return state[role]?[key] ?? PermissionAccess.denied;
  }
}

final rolePermissionsProvider = StateNotifierProvider<
  RolePermissionsNotifier,
  Map<AppRole, Map<String, PermissionAccess>>
>((ref) => RolePermissionsNotifier());

class UserOverridesNotifier
    extends StateNotifier<Map<String, Map<String, PermissionRule>>> {
  UserOverridesNotifier() : super({});

  void setOverride(String userId, PermissionRule rule) {
    final userMap = Map<String, PermissionRule>.from(state[userId] ?? {});
    userMap[rule.key] = rule;
    state = {...state, userId: userMap};
  }

  void removeOverride(String userId, String key) {
    final userMap = Map<String, PermissionRule>.from(state[userId] ?? {});
    userMap.remove(key);
    state = {...state, userId: userMap};
  }

  Map<String, PermissionRule> overridesFor(String userId) =>
      state[userId] ?? {};
}

final userPermissionOverridesProvider = StateNotifierProvider<
  UserOverridesNotifier,
  Map<String, Map<String, PermissionRule>>
>((ref) => UserOverridesNotifier());

/// UNION(role defaults) + user overrides.
Map<String, PermissionAccess> effectivePermissions(
  Ref ref,
  String userId,
  Set<AppRole> assignedRoles,
) {
  final roleDefaults = ref.read(rolePermissionsProvider);
  final overrides = ref.read(userPermissionOverridesProvider)[userId] ?? {};
  final inherited = <String, PermissionAccess>{};

  for (final role in assignedRoles) {
    for (final entry
        in roleDefaults[role]?.entries ??
            <MapEntry<String, PermissionAccess>>[]) {
      final existing = inherited[entry.key];
      if (existing == null || existing == PermissionAccess.denied) {
        inherited[entry.key] = entry.value;
      } else if (entry.value == PermissionAccess.full) {
        inherited[entry.key] = PermissionAccess.full;
      }
    }
  }

  final effective = Map<String, PermissionAccess>.from(inherited);
  for (final entry in overrides.entries) {
    effective[entry.key] = entry.value.access;
  }
  return effective;
}

final rbacUsersProvider =
    StateNotifierProvider<RbacUsersNotifier, List<RbacUserRecord>>(
      (ref) => RbacUsersNotifier(),
    );

class RbacUsersNotifier extends StateNotifier<List<RbacUserRecord>> {
  RbacUsersNotifier()
    : super(const [
        RbacUserRecord(
          id: 'u-admin',
          nameEn: 'App Administrator',
          nameAr: 'مدير التطبيق',
          email: 'admin@ayletna.test',
          assignedRoles: {AppRole.admin},
        ),
        RbacUserRecord(
          id: 'u-operator',
          nameEn: 'Restaurant Operator',
          nameAr: 'مشغل المطعم',
          email: 'operator@ayletna.test',
          assignedRoles: {AppRole.operator, AppRole.cashier},
        ),
        RbacUserRecord(
          id: 'u-owner',
          nameEn: 'Shareholder Owner',
          nameAr: 'مالك مساهم',
          email: 'owner@ayletna.test',
          assignedRoles: {AppRole.owner},
          ownershipPercentage: 35,
        ),
        RbacUserRecord(
          id: 'u-support',
          nameEn: 'Support Agent',
          nameAr: 'موظف الدعم',
          email: 'support@ayletna.test',
          assignedRoles: {AppRole.support},
        ),
        RbacUserRecord(
          id: 'u-marketing',
          nameEn: 'Marketing Lead',
          nameAr: 'مسؤول التسويق',
          email: 'marketing@ayletna.test',
          assignedRoles: {AppRole.marketing},
        ),
        RbacUserRecord(
          id: 'u-multi',
          nameEn: 'Multi-Role User',
          nameAr: 'مستخدم متعدد الأدوار',
          email: 'multi@ayletna.test',
          assignedRoles: {AppRole.operator, AppRole.support, AppRole.marketing},
        ),
        RbacUserRecord(
          id: 'u-pending',
          nameEn: 'Pending Operator',
          nameAr: 'مشغل بانتظار الموافقة',
          email: 'pending@ayletna.test',
          assignedRoles: {AppRole.operator},
          status: 'pending_approval',
        ),
        RbacUserRecord(
          id: 'u-suspended',
          nameEn: 'Suspended Staff',
          nameAr: 'موظف موقوف',
          email: 'suspended@ayletna.test',
          assignedRoles: {AppRole.cashier},
          status: 'suspended',
        ),
      ]);

  RbacUserRecord? byId(String id) {
    try {
      return state.firstWhere((u) => u.id == id);
    } catch (_) {
      return null;
    }
  }

  void updateUser(RbacUserRecord user) {
    state = [
      for (final row in state)
        if (row.id == user.id) user else row,
    ];
  }

  void assignRoles(String userId, Set<AppRole> roles) {
    final user = byId(userId);
    if (user == null) return;
    updateUser(user.copyWith(assignedRoles: roles));
  }

  RbacUserRecord? byEmail(String email) {
    final needle = email.trim().toLowerCase();
    if (needle.isEmpty) return null;
    for (final u in state) {
      if (u.email.toLowerCase() == needle && u.status == 'active') {
        return u;
      }
    }
    return null;
  }

  List<RbacUserRecord> get allActive =>
      state.where((u) => u.status == 'active').toList(growable: false);

  void updateStatus(String userId, String status) {
    final user = byId(userId);
    if (user == null) return;
    updateUser(user.copyWith(status: status));
  }

  void updateOwnership(String userId, double? percentage) {
    final user = byId(userId);
    if (user == null) return;
    updateUser(
      user.copyWith(
        ownershipPercentage: percentage,
        clearOwnership: percentage == null,
      ),
    );
  }
}

/// Resolve RBAC roles for a login identifier (email/phone mock).
({String? userId, Set<AppRole> roles}) resolveLoginAccess(
  RbacUsersNotifier users,
  String? identifier,
) {
  final raw = identifier?.trim() ?? '';
  final lower = raw.toLowerCase();

  final byEmail = users.byEmail(raw);
  if (byEmail != null) {
    return (userId: byEmail.id, roles: byEmail.assignedRoles);
  }

  // Demo shortcuts when exact email is not typed.
  if (lower.contains('admin')) {
    final u = users.byId('u-admin');
    return (userId: u?.id, roles: u?.assignedRoles ?? {AppRole.admin});
  }
  if (lower.contains('multi')) {
    final u = users.byId('u-multi');
    return (
      userId: u?.id,
      roles: u?.assignedRoles ??
          {AppRole.operator, AppRole.support, AppRole.marketing},
    );
  }
  if (lower.contains('marketing')) {
    final u = users.byId('u-marketing');
    return (userId: u?.id, roles: u?.assignedRoles ?? {AppRole.marketing});
  }
  if (lower.contains('operator')) {
    final u = users.byId('u-operator');
    return (
      userId: u?.id,
      roles: u?.assignedRoles ?? {AppRole.operator, AppRole.cashier},
    );
  }
  if (lower.contains('owner')) {
    final u = users.byId('u-owner');
    return (userId: u?.id, roles: u?.assignedRoles ?? {AppRole.owner});
  }
  if (lower.contains('support')) {
    final u = users.byId('u-support');
    return (userId: u?.id, roles: u?.assignedRoles ?? {AppRole.support});
  }
  if (lower.contains('cashier')) {
    for (final row in users.allActive) {
      if (row.assignedRoles.contains(AppRole.cashier)) {
        return (userId: row.id, roles: row.assignedRoles);
      }
    }
    return (userId: null, roles: {AppRole.cashier});
  }

  return (userId: null, roles: {AppRole.customer});
}

final effectivePermissionsProvider =
    Provider.family<Map<String, PermissionAccess>, String>((ref, userId) {
      final users = ref.watch(rbacUsersProvider);
      RbacUserRecord? user;
      for (final row in users) {
        if (row.id == userId) {
          user = row;
          break;
        }
      }
      if (user == null) return {};
      return effectivePermissions(ref, userId, user.assignedRoles);
    });

/// Active RBAC user id for the hub role (links session → Screen B users).
final activeRbacUserIdProvider = Provider<String?>((ref) {
  final session = ref.watch(sessionProvider);
  final role = ref.watch(appRoleProvider);
  if (!session.isAuthenticated || session.isPendingApproval) return null;

  const managementRoles = {
    AppRole.admin,
    AppRole.operator,
    AppRole.owner,
    AppRole.support,
    AppRole.marketing,
  };
  final assignedMgmt = session.approvedRoles.intersection(managementRoles);
  if (assignedMgmt.length > 1) return 'u-multi';

  return switch (role) {
    AppRole.admin => 'u-admin',
    AppRole.operator => 'u-operator',
    AppRole.owner => 'u-owner',
    AppRole.support => 'u-support',
    AppRole.marketing => 'u-marketing',
    _ => null,
  };
});
