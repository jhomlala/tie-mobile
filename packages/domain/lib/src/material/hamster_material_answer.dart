import 'package:freezed_annotation/freezed_annotation.dart';

part 'hamster_material_answer.freezed.dart';

part 'hamster_material_answer.g.dart';

@freezed
class HamsterMaterialAnswer with _$HamsterMaterialAnswer {
  const factory HamsterMaterialAnswer({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'isCorrect') required bool isCorrect,
  }) = _HamsterMaterialAnswer;

  factory HamsterMaterialAnswer.fromJson(Map<String, Object?> json) =>
      _$HamsterMaterialAnswerFromJson(json);
}
