part of 'hamster_bloc.dart';

@freezed
class HamsterEvent with _$HamsterEvent {
  const factory HamsterEvent.updateScore({required int score}) =
      HamsterUpdateScore;

  const factory HamsterEvent.updateSteps({required int steps}) =
      HamsterUpdateStep;

  const factory HamsterEvent.onGameFinished() = HamsterGameFinished;
}
