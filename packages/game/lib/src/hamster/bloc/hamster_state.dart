part of 'hamster_bloc.dart';

@freezed
class HamsterState with _$HamsterState {
  const factory HamsterState({
    required bool initialised,
    required int score,
    required int steps,
    required TieMaterial? material,
    required List<HamsterTile> tiles,
    required List<HamsterTile> openedTiles,
  }) = _HamsterState;

  factory HamsterState.initial() => const HamsterState(
    initialised: false,
        score: 0,
        steps: 0,
        tiles: [],
        openedTiles: [],
        material: null,
      );
}
