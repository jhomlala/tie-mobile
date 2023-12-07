import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:game/game.dart';

class TieMaterialPage extends StatefulWidget {
  const TieMaterialPage({required this.material, super.key});

  final TieMaterial material;

  @override
  State<TieMaterialPage> createState() => _TieMaterialPageState();
}

class _TieMaterialPageState extends State<TieMaterialPage> {
  TieMaterial get material => widget.material;

  @override
  Widget build(BuildContext context) {
    final shortestSize = context.deviceSize().shortestSide;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            //Text(widget.material.toString()),
            SizedBox(
              width: shortestSize,
              height: shortestSize,
              child: _getGame(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getGame() {
    switch (material.type) {
      case 'hamster':
        return HamsterFactory().getHamsterGame(material);
    }
    throw TieUnknownGameError('Unknown game: ${material.type}');
  }
}
