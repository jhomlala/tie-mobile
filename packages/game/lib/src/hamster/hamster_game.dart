import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:game/src/common/game.dart';

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
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _HamsterPainter());
  }
}


class _HamsterPainter extends CustomPainter {
  static const _leftHeader = 'LEFT';
  static const _topHeader = 'TOP';
  static const _normalTile = 'NORMAL';

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
    final tilesPositions = _getTilesPosition(size);

    // ignore: cascade_invocations
    tilesPositions.forEach((key, value) {
      canvas.drawRect(value, Paint()..color = Colors.blue);
      if (key.startsWith(_normalTile) || key == '${_leftHeader}_0') {
        return;
      }

      final textStyle = const TextStyle(
        color: Colors.black,
        fontSize: 12,
      );
      final textSpan = TextSpan(
        text: _getTileName(key),
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
      );

      final offset = Offset(
          (value.left + value.right) / 2, (value.top + value.bottom) / 2);
      textPainter.paint(canvas, offset);
    });
  }

  String _getTileName(String keyName) {
    if (keyName.startsWith(_leftHeader)) {
      final split = keyName.split('_');
      return split[1];
    } else if (keyName.startsWith(_topHeader)) {
      final split = keyName.split('_');
      return split[1];
    } else {
      return keyName;
    }
  }

  Map<String, Rect> _getTilesPosition(Size size) {
    final width = size.width;
    final height = size.height;
    final tileWidth = width / 6;
    final tileHeight = height / 6;

    final tilesPositions = <String, Rect>{};
    for (var horizontalIndex = 0; horizontalIndex < 6; horizontalIndex++) {
      for (var verticalIndex = 0; verticalIndex < 6; verticalIndex++) {
        final startX = horizontalIndex * tileWidth + 2.5;
        final startY = verticalIndex * tileHeight + 2.5;
        final endX = startX + tileWidth - 5;
        final endY = startY + tileHeight - 5;
        final rect = Rect.fromLTRB(startX, startY, endX, endY);
        var tileName = '';
        if (horizontalIndex == 0) {
          tileName = '${_leftHeader}_$verticalIndex';
        } else if (verticalIndex == 0) {
          tileName = '${_topHeader}_$horizontalIndex';
        } else {
          tileName = '${_normalTile}_${horizontalIndex}_$verticalIndex';
        }
        tilesPositions[tileName] = rect;
      }
    }
    return tilesPositions;
  }

  Paint _getLinePaint() {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 5;
    return paint;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
