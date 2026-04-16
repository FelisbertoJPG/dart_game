import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserState {
  final List<String> completedModules;
  final int hearts;
  final int xp;

  UserState({
    this.completedModules = const [],
    this.hearts = 5,
    this.xp = 0,
  });

  UserState copyWith({
    List<String>? completedModules,
    int? hearts,
    int? xp,
  }) {
    return UserState(
      completedModules: completedModules ?? this.completedModules,
      hearts: hearts ?? this.hearts,
      xp: xp ?? this.xp,
    );
  }
}

class UserStateNotifier extends StateNotifier<UserState> {
  UserStateNotifier() : super(UserState());

  void completeModule(String moduleId) {
    if (!state.completedModules.contains(moduleId)) {
      state = state.copyWith(
        completedModules: [...state.completedModules, moduleId],
        xp: state.xp + 100,
      );
    }
  }

  void loseHeart() {
    if (state.hearts > 0) {
      state = state.copyWith(hearts: state.hearts - 1);
    }
  }

  void addHearts(int amount) {
    state = state.copyWith(hearts: state.hearts + amount);
  }
}

final userStateProvider = StateNotifierProvider<UserStateNotifier, UserState>((ref) {
  return UserStateNotifier();
});
