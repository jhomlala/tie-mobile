import 'package:freezed_annotation/freezed_annotation.dart';
part 'tie_material.freezed.dart';
part 'tie_material.g.dart';
@freezed
class TieMaterial with _$TieMaterial {
  const factory TieMaterial({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'image') required String image,
    @JsonKey(name: 'config') required String config,
  }) = _TieMaterial;

  factory TieMaterial.fromJson(Map<String, Object?> json) =>
      _$TieMaterialFromJson(json);
}
