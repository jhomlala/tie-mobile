import 'dart:async';
import 'dart:convert';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game/src/hamster/model/hamster_config.dart';
import 'package:game/src/hamster/model/hamster_tile.dart';

part 'hamster_bloc.freezed.dart';

part 'hamster_event.dart';

part 'hamster_state.dart';

class HamsterBloc extends Bloc<HamsterEvent, HamsterState> {
  HamsterBloc({required this.gameController}) : super(HamsterState.initial()) {
    on<HamsterInitialise>(_onHamsterInitialise);
    on<HamsterUpdateScore>(_onHamsterUpdateScore);
    on<HamsterUpdateStep>(_onHamsterUpdateState);
    on<HamsterGameFinished>(_onHamsterGameFinished);
    on<HamsterTileOpened>(_onHamsterTileOpened);
    on<HamsterGameRestart>(_onHamsterGameRestart);
  }

  final GameController gameController;
  final HamsterConfig hamsterConfig = HamsterConfig();
  late StreamSubscription<GameCommand> _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    await super.close();
  }

  FutureOr<void> _onHamsterUpdateScore(
    HamsterUpdateScore event,
    Emitter<HamsterState> emit,
  ) {
    emit(state.copyWith(score: event.score));
  }

  FutureOr<void> _onHamsterUpdateState(
    HamsterUpdateStep event,
    Emitter<HamsterState> emit,
  ) {
    emit(state.copyWith(steps: event.steps));
  }

  FutureOr<void> _onHamsterGameFinished(
    HamsterGameFinished event,
    Emitter<HamsterState> emit,
  ) {
    gameController.handleEvent(
      GameFinished(score: state.score, steps: state.steps),
    );
  }

  FutureOr<void> _onHamsterInitialise(
    HamsterInitialise event,
    Emitter<HamsterState> emit,
  ) {
    if (shouldInitialise(portraitMode: event.portraitMode)) {
      emit(
        state.copyWith(
            initialised: true,
            tiles: _getTiles(event.material, event.width, event.height),
            portraitMode: event.portraitMode),
      );
      _streamSubscription = gameController.gameCommandsStream.listen((event) {
        switch (event.runtimeType) {
          case RestartGame:
            add(const HamsterGameRestart());
        }
      });
    }
  }

  List<HamsterTile> _getTiles(
    TieMaterial material,
    double width,
    double height,
  ) {
    final tileWidth = width / 6;
    final tileHeight = height / 6;
    final config = _getConfig(material);

    final tiles = <HamsterTile>[];
    for (var horizontalIndex = 0; horizontalIndex < 6; horizontalIndex++) {
      for (var verticalIndex = 0; verticalIndex < 6; verticalIndex++) {
        final startX =
            horizontalIndex * tileWidth + hamsterConfig.lineStrokeSize / 2;
        final startY =
            verticalIndex * tileHeight + hamsterConfig.lineStrokeSize / 2;
        final endX = startX + tileWidth - hamsterConfig.lineStrokeSize;
        final endY = startY + tileHeight - hamsterConfig.lineStrokeSize;
        final rect =
            GameRect(left: startX, right: endX, top: startY, bottom: endY);

        var tileType = HamsterTileType.normal;
        var opened = false;
        if (horizontalIndex == 0) {
          tileType = HamsterTileType.leftHeader;
          opened = true;
        } else if (verticalIndex == 0) {
          tileType = HamsterTileType.topHeader;
          opened = true;
        }

        final tileConfig = config.tiles
            .where(
              (element) =>
                  element.boardX == horizontalIndex &&
                  element.boardY == verticalIndex,
            )
            .toList()
            .firstOrNull;

        final tile = HamsterTile(
          type: tileType,
          boardX: horizontalIndex,
          boardY: verticalIndex,
          rect: rect,
          opened: opened,
          config: tileConfig,
        );
        tiles.add(tile);
      }
    }
    return tiles;
  }

  HamsterMaterial _getConfig(TieMaterial material) {
    return HamsterMaterial.fromJson(
      jsonDecode(material.config) as Map<String, dynamic>,
    );
  }

  FutureOr<void> _onHamsterTileOpened(
    HamsterTileOpened event,
    Emitter<HamsterState> emit,
  ) {
    final openedTile = event.tile;

    final tileIndex = state.tiles.indexWhere(
      (element) =>
          element.boardX == openedTile.boardX &&
          element.boardY == openedTile.boardY,
    );
    final newTiles = [...state.tiles];
    newTiles[tileIndex] = HamsterTile(
      type: openedTile.type,
      boardX: openedTile.boardX,
      boardY: openedTile.boardY,
      rect: openedTile.rect,
      opened: true,
      config: openedTile.config,
    );
    emit(state.copyWith(tiles: newTiles));
  }

  FutureOr<void> _onHamsterGameRestart(
    HamsterGameRestart event,
    Emitter<HamsterState> emit,
  ) {
    final tiles = state.tiles
        .map(
          (tile) => HamsterTile(
            type: tile.type,
            boardX: tile.boardX,
            boardY: tile.boardY,
            rect: tile.rect,
            opened: false,
            config: tile.config,
          ),
        )
        .toList();
    emit(state.copyWith(tiles: tiles, score: 0, steps: 0));
  }

  List<HamsterTile> get hamsterTilesNotOpened => state.tiles
      .where(
        (element) => element.type == HamsterTileType.normal && !element.opened,
      )
      .toList();

  bool shouldInitialise({required bool portraitMode}) {
    return !state.initialised || state.portraitMode != portraitMode;
  }
}
