import 'dart:async';
import 'dart:convert';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:game/src/hamster/model/hamster_tile.dart';

part 'hamster_bloc.freezed.dart';

part 'hamster_event.dart';

part 'hamster_state.dart';

class HamsterBloc extends Bloc<HamsterEvent, HamsterState> {
  HamsterBloc({required this.eventCallback}) : super(HamsterState.initial()) {
    on<HamsterInitialise>(_onHamsterInitialise);
    on<HamsterUpdateScore>(_onHamsterUpdateScore);
    on<HamsterUpdateStep>(_onHamsterUpdateState);
    on<HamsterGameFinished>(_onHamsterGameFinished);
    on<HamsterTileOpened>(_onHamsterTileOpened);
  }

  final void Function(GameEvents event) eventCallback;

  FutureOr<void> _onHamsterUpdateScore(
      HamsterUpdateScore event, Emitter<HamsterState> emit) {
    emit(state.copyWith(score: event.score));
  }

  FutureOr<void> _onHamsterUpdateState(
      HamsterUpdateStep event, Emitter<HamsterState> emit) {
    emit(state.copyWith(steps: event.steps));
  }

  FutureOr<void> _onHamsterGameFinished(
    HamsterGameFinished event,
    Emitter<HamsterState> emit,
  ) {
    eventCallback(GameFinished(score: state.score, steps: state.steps));
  }

  FutureOr<void> _onHamsterInitialise(
      HamsterInitialise event, Emitter<HamsterState> emit) {
    if (!state.initialised) {
      emit(state.copyWith(
          initialised: true,
          tiles: _getTiles(event.material, event.width, event.height)));
    }
  }

  List<HamsterTile> _getTiles(
      TieMaterial material, double width, double height) {
    final tileWidth = width / 6;
    final tileHeight = height / 6;
    final config = _getConfig(material);

    final tiles = <HamsterTile>[];
    for (var horizontalIndex = 0; horizontalIndex < 6; horizontalIndex++) {
      for (var verticalIndex = 0; verticalIndex < 6; verticalIndex++) {
        final startX = horizontalIndex * tileWidth + 2.5;
        final startY = verticalIndex * tileHeight + 2.5;
        final endX = startX + tileWidth - 5;
        final endY = startY + tileHeight - 5;
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
        } else {
          /*opened = openedTiles
              .where(
                (element) =>
            element.boardX == horizontalIndex &&
                element.boardY == verticalIndex,
          )
              .isNotEmpty;*/
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
      HamsterTileOpened event, Emitter<HamsterState> emit) {
    final openedTile = event.tile;

    final tileIndex = state.tiles.indexWhere((element) =>
        element.boardX == openedTile.boardX &&
        element.boardY == openedTile.boardY);
    final newTiles = [...state.tiles];
    newTiles[tileIndex] = HamsterTile(
        type: openedTile.type,
        boardX: openedTile.boardX,
        boardY: openedTile.boardY,
        rect: openedTile.rect,
        opened: true,
        config: openedTile.config);
    print("Hamster opened: " + tileIndex.toString());
    emit(state.copyWith(tiles: newTiles));
  }
}
