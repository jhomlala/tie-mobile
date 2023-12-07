import 'package:domain/src/material/hamster_material_answer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hamster_material_tile.freezed.dart';

part 'hamster_material_tile.g.dart';

@freezed
class HamsterMaterialTile with _$HamsterMaterialTile {
  const factory HamsterMaterialTile({
    @JsonKey(name: 'boardX') required final int boardX,
    @JsonKey(name: 'boardY') required final int boardY,
    @JsonKey(name: 'imageUrl') required final String imageUrl,
    @JsonKey(name: 'isHamster') required final bool isHamster,
    @JsonKey(name: 'answers')
    required final List<HamsterMaterialAnswer> answers,
  }) = _HamsterMaterialTile;

  factory HamsterMaterialTile.fromJson(Map<String, Object?> json) =>
      _$HamsterMaterialTileFromJson(json);
}
