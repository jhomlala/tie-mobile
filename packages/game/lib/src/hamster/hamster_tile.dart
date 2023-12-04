import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

enum HamsterTileType {
  leftHeader,
  topHeader,
  normal,
}

class HamsterTile {
  HamsterTile({
    required this.type,
    required this.boardX,
    required this.boardY,
    required this.rect,
    required this.opened,
    required this.config,
  });

  final HamsterTileType type;
  final int boardX;
  final int boardY;
  final Rect rect;
  final bool opened;
  final HamsterMaterialTile? config;
}
