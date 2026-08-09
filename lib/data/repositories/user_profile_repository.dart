import 'package:ayletna_restaurant_app/data/models/model_user_profile.dart';
import 'package:ayletna_restaurant_app/providers/user_profile_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Thin read/write layer over [userProfileProvider] for screens and future API wiring.
class UserProfileRepository {
  UserProfileRepository(this._ref);

  final Ref _ref;

  UserProfile get profile => _ref.read(userProfileProvider);

  UserProfile watchProfile(WidgetRef ref) => ref.watch(userProfileProvider);

  void setOrderAlerts(bool value) =>
      _ref.read(userProfileProvider.notifier).setOrderAlerts(value);

  void setShiftAlerts(bool value) =>
      _ref.read(userProfileProvider.notifier).setShiftAlerts(value);

  void setMarketing(bool value) =>
      _ref.read(userProfileProvider.notifier).setMarketing(value);

  void setAvatarUrl(String? value) =>
      _ref.read(userProfileProvider.notifier).setAvatarUrl(value);

  void reset() => _ref.read(userProfileProvider.notifier).reset();
}

final userProfileRepositoryProvider = Provider<UserProfileRepository>(
  UserProfileRepository.new,
);
