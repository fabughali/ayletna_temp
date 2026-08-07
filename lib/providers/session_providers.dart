import 'package:ayletna_restaurant_app/core/app_config.dart';
import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Auth session (in-memory — swap for Supabase Auth later).
class SessionState {
  const SessionState({
    this.isAuthenticated = false,
    this.isPendingApproval = false,
    this.approvedRoles = const {AppRole.customer},
    this.pendingRequestedRoles = const {},
    this.userId,
  });

  final bool isAuthenticated;
  final bool isPendingApproval;

  /// Roles this account may activate (admin-assigned multi-role, or full set for admin).
  final Set<AppRole> approvedRoles;

  /// Roles requested at registration awaiting app-admin approval.
  final Set<AppRole> pendingRequestedRoles;

  /// Linked RBAC user id when known (for syncing role assignments).
  final String? userId;

  SessionState copyWith({
    bool? isAuthenticated,
    bool? isPendingApproval,
    Set<AppRole>? approvedRoles,
    Set<AppRole>? pendingRequestedRoles,
    String? userId,
    bool clearUserId = false,
  }) {
    return SessionState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isPendingApproval: isPendingApproval ?? this.isPendingApproval,
      approvedRoles: approvedRoles ?? this.approvedRoles,
      pendingRequestedRoles:
          pendingRequestedRoles ?? this.pendingRequestedRoles,
      userId: clearUserId ? null : (userId ?? this.userId),
    );
  }
}

/// Roles an app admin may switch into from Settings (demo / ops).
const Set<AppRole> kAdminSwitchableRoles = {
  AppRole.customer,
  AppRole.admin,
  AppRole.operator,
  AppRole.owner,
  AppRole.support,
  AppRole.marketing,
  AppRole.cashier,
  AppRole.kitchen,
  AppRole.delivery,
  AppRole.inventory,
  AppRole.staff,
};

/// Admin accounts unlock the full switcher; everyone else keeps only assigned roles.
Set<AppRole> expandApprovedRolesForSession(Set<AppRole> assigned) {
  if (assigned.contains(AppRole.admin)) {
    return Set<AppRole>.from(kAdminSwitchableRoles);
  }
  return Set<AppRole>.from(assigned);
}

class SessionNotifier extends StateNotifier<SessionState> {
  SessionNotifier() : super(const SessionState());

  void signIn({Set<AppRole>? roles, String? userId}) {
    // Mock/dev: unlock every portal so login OTP can land on role selection.
    final assigned =
        AppConfig.forcePostOtpRoleSelection
            ? Set<AppRole>.from(kAdminSwitchableRoles)
            : (roles ?? const {AppRole.customer});
    state = SessionState(
      isAuthenticated: true,
      approvedRoles: expandApprovedRolesForSession(assigned),
      userId: userId,
    );
  }

  /// Called when app admin changes this user's assigned roles while they are signed in.
  void syncApprovedRoles(Set<AppRole> assigned) {
    if (!state.isAuthenticated) return;
    state = state.copyWith(
      approvedRoles: expandApprovedRolesForSession(assigned),
    );
  }

  void signInPendingApproval({Set<AppRole>? requestedRoles}) {
    state = SessionState(
      isAuthenticated: true,
      isPendingApproval: true,
      approvedRoles: const {},
      pendingRequestedRoles: requestedRoles ?? const {},
    );
  }

  void signOut() {
    state = const SessionState();
  }
}

final sessionProvider = StateNotifierProvider<SessionNotifier, SessionState>((
  ref,
) {
  return SessionNotifier();
});

/// Default home route after login / splash / role switch for [AppRole].
String homeRouteForRole(AppRole role) => switch (role) {
  AppRole.customer || AppRole.guest => AppRoutePaths.home,
  AppRole.admin => AppRoutePaths.appAdmin,
  AppRole.operator => AppRoutePaths.operatorHub,
  AppRole.owner => AppRoutePaths.ownerHub,
  AppRole.support => AppRoutePaths.supportDesk,
  AppRole.marketing => AppRoutePaths.marketingHub,
  AppRole.cashier => AppRoutePaths.cashier,
  AppRole.kitchen => AppRoutePaths.kitchen,
  AppRole.delivery => AppRoutePaths.delivery,
  AppRole.inventory => AppRoutePaths.inventory,
  AppRole.staff => AppRoutePaths.staffAttendance,
};
