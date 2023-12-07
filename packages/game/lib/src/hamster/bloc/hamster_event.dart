part of 'hamster_bloc.dart';

@freezed
class HamsterEvent with _$HamsterEvent {
  const factory HamsterEvent.initialise({
    required TieMaterial material,
    required double width,
    required double height,
  }) = HamsterInitialise;

  const factory HamsterEvent.updateScore({required int score}) =
      HamsterUpdateScore;

  const factory HamsterEvent.updateSteps({required int steps}) =
      HamsterUpdateStep;

  const factory HamsterEvent.onGameFinished() = HamsterGameFinished;

  const factory HamsterEvent.onTileOpened({required HamsterTile tile}) =
      HamsterTileOpened;

  const factory HamsterEvent.onGameRestart() = HamsterGameRestart;
}
