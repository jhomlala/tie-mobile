part of 'hamster_bloc.dart';

@freezed
class HamsterState with _$HamsterState {
  const factory HamsterState({
    required int score,
  }) = _HamsterState;

  factory HamsterState.initial() => HamsterState(
        score: 0
      );
}
