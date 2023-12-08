import 'package:domain/src/material/hamster_material_tile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hamster_material.freezed.dart';

part 'hamster_material.g.dart';

@freezed
class HamsterMaterial with _$HamsterMaterial {
  const factory HamsterMaterial({
    @JsonKey(name: 'tiles') required List<HamsterMaterialTile> tiles,
  }) = _HamsterMaterial;

  factory HamsterMaterial.fromJson(Map<String, Object?> json) =>
      _$HamsterMaterialFromJson(json);
}
