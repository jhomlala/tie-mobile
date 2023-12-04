import 'dart:convert';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:game/src/common/game.dart';
import 'package:game/src/hamster/hamster_config.dart';
import 'package:game/src/hamster/hamster_dialog.dart';
import 'package:game/src/hamster/hamster_tile.dart';

class HamsterGame extends StatefulWidget with Game {
  const HamsterGame({required this.material, super.key});

  final TieMaterial material;

  @override
  State<HamsterGame> createState() => _HamsterGameState();

  @override
  Future<void> start() {
    // TODO: implement start
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }
}

class _HamsterGameState extends State<HamsterGame> {
  late HamsterConfig _hamsterConfig;
  late List<HamsterTile> _hamsterTiles;
  List<HamsterTile> openedTiles = [];

  @override
  void initState() {
    super.initState();
    _hamsterConfig = HamsterConfig();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _hamsterTiles = _getTiles(
          Size(constraints.maxWidth, constraints.maxHeight),
        );
        final hamsterTilesNotOpened =
            _hamsterTiles.where((element) => !element.opened);

        return Stack(
          children: [
            CustomPaint(
              painter:
                  _HamsterPainter(config: _hamsterConfig, tiles: _hamsterTiles),
            ),
            ..._hamsterTiles.map((tile) => _HamsterItem(tile: tile)),
            ...hamsterTilesNotOpened.map(
              (tile) => _HamsterCard(
                tile: tile,
                onPressed: onCardPressed,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> onCardPressed(HamsterTile tile) async {
    await HamsterDialog.show(context, tile);
    setState(() {
      openedTiles.add(tile);
    });
  }

  List<HamsterTile> _getTiles(Size size) {
    final width = size.width;
    final height = size.height;
    final tileWidth = width / 6;
    final tileHeight = height / 6;
    final config = _getConfig();

    final tiles = <HamsterTile>[];
    for (var horizontalIndex = 0; horizontalIndex < 6; horizontalIndex++) {
      for (var verticalIndex = 0; verticalIndex < 6; verticalIndex++) {
        final startX = horizontalIndex * tileWidth + 2.5;
        final startY = verticalIndex * tileHeight + 2.5;
        final endX = startX + tileWidth - 5;
        final endY = startY + tileHeight - 5;
        final rect = Rect.fromLTRB(startX, startY, endX, endY);
        var tileType = HamsterTileType.normal;
        var opened = false;
        if (horizontalIndex == 0) {
          tileType = HamsterTileType.leftHeader;
          opened = true;
        } else if (verticalIndex == 0) {
          tileType = HamsterTileType.topHeader;
          opened = true;
        } else {
          opened = openedTiles
              .where(
                (element) =>
                    element.boardX == horizontalIndex &&
                    element.boardY == verticalIndex,
              )
              .isNotEmpty;
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

  HamsterMaterial _getConfig() {
    return HamsterMaterial.fromJson(
      jsonDecode(widget.material.config) as Map<String, dynamic>,
    );
  }
}

class _HamsterItem extends StatelessWidget {
  const _HamsterItem({required this.tile});

  final HamsterTile tile;

  @override
  Widget build(BuildContext context) {
    if (tile.config == null) {
      return const SizedBox();
    }
    return Positioned(
      left: tile.rect.left,
      top: tile.rect.top,
      width: tile.rect.width,
      height: tile.rect.height,
      child: Image.network(tile.config!.imageUrl),
    );
  }
}

class _HamsterCard extends StatelessWidget {
  const _HamsterCard({required this.tile, required this.onPressed});

  final HamsterTile tile;
  final void Function(HamsterTile tile) onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: tile.rect.left,
      top: tile.rect.top,
      width: tile.rect.width,
      height: tile.rect.height,
      child: Card(
        color: Colors.amber,
        child: InkWell(
          onTap: () {
            onPressed(tile);
          },
        ),
      ),
    );
  }
}

class _HamsterPainter extends CustomPainter {
  _HamsterPainter({required this.config, required this.tiles});

  final HamsterConfig config;
  final List<HamsterTile> tiles;

  @override
  void paint(Canvas canvas, Size size) {
    _paintLines(canvas, size);
    _paintHeaders(canvas, size);
  }

  void _paintLines(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final paint = _getLinePaint();
    for (var verticalLineIndex = 0;
        verticalLineIndex <= 6;
        verticalLineIndex++) {
      final xPos = width / 6 * verticalLineIndex;
      canvas.drawLine(Offset(xPos, 0), Offset(xPos, height), paint);
    }

    for (var horizontalLineIndex = 0;
        horizontalLineIndex <= 6;
        horizontalLineIndex++) {
      final yPos = height / 6 * horizontalLineIndex;
      canvas.drawLine(Offset(0, yPos), Offset(width, yPos), paint);
    }
  }

  void _paintHeaders(Canvas canvas, Size size) {
    // ignore: cascade_invocations
    for (final value in tiles) {
      canvas.drawRect(value.rect, Paint()..color = Colors.blue);
      if (value.type == HamsterTileType.normal) {
        continue;
      }

      const textStyle = TextStyle(
        color: Colors.black,
        fontSize: 12,
      );
      final textSpan = TextSpan(
        text: _getTileName(value),
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      final rect = value.rect;
      final offset =
          Offset((rect.left + rect.right) / 2, (rect.top + rect.bottom) / 2);
      textPainter.paint(canvas, offset);
    }
  }

  String _getTileName(HamsterTile hamsterTile) {
    switch (hamsterTile.type) {
      case HamsterTileType.leftHeader:
        return hamsterTile.boardY.toString();
      case HamsterTileType.topHeader:
        return hamsterTile.boardX.toString();
      case HamsterTileType.normal:
        return '';
    }
  }

  Paint _getLinePaint() {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = config.lineStrokeSize;
    return paint;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
