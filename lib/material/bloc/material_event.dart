part of 'material_bloc.dart';

@freezed
class MaterialEvent with _$MaterialEvent {
  const factory MaterialEvent.gameFinished() = MaterialGameFinished;

  const factory MaterialEvent.restartGame() = MaterialRestartGame;

  const factory MaterialEvent.initialiseGameController({
    required GameController gameController,
  }) = MaterialGameInitGameController;
}
