import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/src/hamster/bloc/hamster_bloc.dart';
import 'package:game/src/hamster/model/hamster_config.dart';
import 'package:game/src/hamster/model/hamster_tile.dart';
import 'package:game/src/hamster/view/hamster_dialog.dart';
import 'package:ui/ui.dart';

class HamsterGame extends StatefulWidget {
  const HamsterGame({required this.material, super.key});

  final TieMaterial material;

  @override
  State<HamsterGame> createState() => _HamsterGameState();
}

class _HamsterGameState extends State<HamsterGame> {
  HamsterBloc get bloc => context.bloc<HamsterBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HamsterBloc, HamsterState>(
      builder: (context, state) {
        return OrientationBuilder(builder: (context, orientation) {
          return Column(
            children: [
              Text('Score: ${state.score} steps: ${state.steps}'),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (bloc.shouldInitialise(
                      portraitMode: orientation == Orientation.portrait,
                    )) {
                      bloc.add(
                        HamsterEvent.initialise(
                          material: widget.material,
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          portraitMode: orientation == Orientation.portrait,
                        ),
                      );
                    }

                    final hamsterTiles = state.tiles;

                    if (hamsterTiles.isEmpty) {
                      return const CircularProgressIndicator();
                    }

                    return Stack(
                      children: [
                        CustomPaint(
                          painter: _HamsterPainter(
                            config: bloc.hamsterConfig,
                            tiles: hamsterTiles,
                          ),
                          size:
                              Size(constraints.maxWidth, constraints.maxHeight),
                        ),
                        ...hamsterTiles.map((tile) => _HamsterItem(tile: tile)),
                        ...bloc.hamsterTilesNotOpened.map(
                          (tile) => _HamsterCard(
                            tile: tile,
                            onPressed: _onCardPressed,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> _onCardPressed(HamsterTile tile) async {
    if (tile.config!.isHamster) {
      _updateScore(scoreToAdd: 100);
      bloc
        ..add(const HamsterEvent.onGameFinished())
        ..add(HamsterEvent.onTileOpened(tile: tile));
      await HamsterDialog.showHamsterDialog(context, tile);
    } else {
      await HamsterDialog.showTileQuestionDialog(
        context: context,
        tile: tile,
        onWrongAnswer: _updateSteps,
      );
      _updateSteps();
      _updateScore(scoreToAdd: 10);
      bloc.add(HamsterEvent.onTileOpened(tile: tile));
    }
  }

  void _updateSteps() {
    bloc.add(HamsterEvent.updateSteps(steps: bloc.state.steps + 1));
  }

  void _updateScore({required int scoreToAdd}) {
    bloc.add(HamsterEvent.updateScore(score: bloc.state.score + scoreToAdd));
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
      canvas.drawRect(
        Rect.fromLTRB(
          value.rect.left,
          value.rect.top,
          value.rect.right,
          value.rect.bottom,
        ),
        Paint()..color = Colors.blue,
      );
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
