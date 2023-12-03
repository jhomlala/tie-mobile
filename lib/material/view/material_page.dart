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
    return Scaffold(
      body: Column(
        children: [
          Text(widget.material.toString()),
          _getGame(),
        ],
      ),
    );
  }

  Widget _getGame() {
    switch (material.type) {
      case 'hamster':
        return HamsterGame(material: material);
    }
    throw TieUnknownGameError('Unknown game: ${material.type}');
  }
}
