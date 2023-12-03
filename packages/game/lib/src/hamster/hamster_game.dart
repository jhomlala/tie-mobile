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
    Log.info("Render here");
    return Text(widget.material.name);
  }
}
