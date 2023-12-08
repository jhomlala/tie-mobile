import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

enum HamsterTileType {
  leftHeader,
  topHeader,
  normal,
}

class HamsterTile extends Equatable {
  const HamsterTile({
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
  final GameRect rect;
  final bool opened;
  final HamsterMaterialTile? config;

  @override
  List<Object?> get props => [type, boardY, boardY, rect, opened, config];
}
