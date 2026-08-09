import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SocialPlatform { meta, instagram }

class SocialConnectionState {
  const SocialConnectionState({
    required this.platform,
    required this.connected,
    this.accountLabel,
    this.connectedAt,
  });

  final SocialPlatform platform;
  final bool connected;
  final String? accountLabel;
  final DateTime? connectedAt;

  SocialConnectionState copyWith({
    bool? connected,
    String? accountLabel,
    DateTime? connectedAt,
    bool clearAccount = false,
  }) {
    return SocialConnectionState(
      platform: platform,
      connected: connected ?? this.connected,
      accountLabel: clearAccount ? null : (accountLabel ?? this.accountLabel),
      connectedAt: clearAccount ? null : (connectedAt ?? this.connectedAt),
    );
  }
}

class SocialConnectionsNotifier
    extends StateNotifier<List<SocialConnectionState>> {
  SocialConnectionsNotifier()
    : super(const [
        SocialConnectionState(platform: SocialPlatform.meta, connected: false),
        SocialConnectionState(
          platform: SocialPlatform.instagram,
          connected: true,
          accountLabel: '@ayletna.kitchen',
          connectedAt: null,
        ),
      ]) {
    state = [
      state[0],
      state[1].copyWith(
        connectedAt: DateTime.now().subtract(const Duration(days: 12)),
      ),
    ];
  }

  Future<void> connect(SocialPlatform platform) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    state = [
      for (final entry in state)
        if (entry.platform == platform)
          entry.copyWith(
            connected: true,
            accountLabel: switch (platform) {
              SocialPlatform.meta => 'Ayletna Restaurant Page',
              SocialPlatform.instagram => '@ayletna.kitchen',
            },
            connectedAt: DateTime.now(),
          )
        else
          entry,
    ];
  }

  Future<void> disconnect(SocialPlatform platform) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    state = [
      for (final entry in state)
        if (entry.platform == platform)
          SocialConnectionState(platform: platform, connected: false)
        else
          entry,
    ];
  }
}

final socialConnectionsProvider = StateNotifierProvider<
  SocialConnectionsNotifier,
  List<SocialConnectionState>
>((ref) => SocialConnectionsNotifier());
