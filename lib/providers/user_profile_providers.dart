import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/data/models/model_user_profile.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileNotifier extends StateNotifier<UserProfile> {
  UserProfileNotifier(this._role) : super(UserProfile.forRole(_role));

  AppRole _role;

  void applyRole(AppRole role) {
    if (_role == role) return;
    _role = role;
    state = UserProfile.forRole(role).copyWith(
      orderAlerts: state.orderAlerts,
      shiftAlerts: state.shiftAlerts,
      marketing: state.marketing,
    );
  }

  void reset() {
    state = UserProfile.forRole(_role);
  }

  void setOrderAlerts(bool value) => state = state.copyWith(orderAlerts: value);

  void setShiftAlerts(bool value) => state = state.copyWith(shiftAlerts: value);

  void setMarketing(bool value) => state = state.copyWith(marketing: value);

  void updateProfile({
    String? displayNameAr,
    String? displayNameEn,
    String? phone,
    String? email,
  }) {
    state = state.copyWith(
      displayNameAr: displayNameAr,
      displayNameEn: displayNameEn,
      phone: phone,
      email: email,
    );
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile>((ref) {
      final notifier = UserProfileNotifier(ref.read(appRoleProvider));
      ref.listen(appRoleProvider, (_, role) => notifier.applyRole(role));
      ref.listen(sessionProvider, (_, session) {
        if (!session.isAuthenticated) notifier.reset();
      });
      return notifier;
    });
