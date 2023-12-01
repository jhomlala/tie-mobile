import 'package:freezed_annotation/freezed_annotation.dart';
part 'material.freezed.dart';
part 'material.g.dart';
@freezed
class Material with _$Material {
  const factory Material({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'type') required String type
  }) = _Material;

  factory Material.fromJson(Map<String, Object?> json) =>
      _$MaterialFromJson(json);

}