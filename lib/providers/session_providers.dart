import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Auth session (UI mock — replace with Supabase later).
class SessionState {
  const SessionState({
    this.isAuthenticated = false,
    this.isPendingApproval = false,
    this.approvedRoles = const {AppRole.customer},
  });

  final bool isAuthenticated;
  final bool isPendingApproval;
  final Set<AppRole> approvedRoles;

  SessionState copyWith({
    bool? isAuthenticated,
    bool? isPendingApproval,
    Set<AppRole>? approvedRoles,
  }) {
    return SessionState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isPendingApproval: isPendingApproval ?? this.isPendingApproval,
      approvedRoles: approvedRoles ?? this.approvedRoles,
    );
  }
}

class SessionNotifier extends StateNotifier<SessionState> {
  SessionNotifier() : super(const SessionState());

  void signIn({Set<AppRole>? roles}) {
    state = SessionState(
      isAuthenticated: true,
      approvedRoles: roles ??
          {
            AppRole.customer,
            AppRole.cashier,
            AppRole.kitchen,
            AppRole.delivery,
            AppRole.inventory,
            AppRole.staff,
            AppRole.operator,
            AppRole.owner,
          },
    );
  }

  void signInPendingApproval() {
    state = const SessionState(
      isAuthenticated: true,
      isPendingApproval: true,
      approvedRoles: {},
    );
  }

  void signOut() {
    state = const SessionState();
  }
}

final sessionProvider =
    StateNotifierProvider<SessionNotifier, SessionState>((ref) {
  return SessionNotifier();
});

/// Default home route after login / splash for [AppRole].
String homeRouteForRole(AppRole role) => switch (role) {
      AppRole.customer || AppRole.guest => AppRoutePaths.home,
      AppRole.cashier => AppRoutePaths.cashier,
      AppRole.kitchen => AppRoutePaths.kitchen,
      AppRole.delivery => AppRoutePaths.delivery,
      AppRole.inventory => AppRoutePaths.inventory,
      AppRole.staff => AppRoutePaths.staffAttendance,
      AppRole.operator || AppRole.owner => AppRoutePaths.admin,
    };
