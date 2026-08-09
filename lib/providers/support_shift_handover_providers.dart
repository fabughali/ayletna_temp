import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupportShiftHandoverState {
  const SupportShiftHandoverState({this.notes = '', this.lastHandoverAt});

  final String notes;
  final DateTime? lastHandoverAt;

  SupportShiftHandoverState copyWith({
    String? notes,
    DateTime? lastHandoverAt,
  }) {
    return SupportShiftHandoverState(
      notes: notes ?? this.notes,
      lastHandoverAt: lastHandoverAt ?? this.lastHandoverAt,
    );
  }
}

class SupportShiftHandoverNotifier
    extends StateNotifier<SupportShiftHandoverState> {
  SupportShiftHandoverNotifier() : super(const SupportShiftHandoverState());

  void saveHandover(String notes) {
    state = state.copyWith(notes: notes.trim(), lastHandoverAt: DateTime.now());
  }
}

final supportShiftHandoverProvider = StateNotifierProvider<
  SupportShiftHandoverNotifier,
  SupportShiftHandoverState
>((ref) => SupportShiftHandoverNotifier());
