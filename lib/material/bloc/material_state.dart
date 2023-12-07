part of 'material_bloc.dart';

@freezed
class MaterialState with _$MaterialState {
  const factory MaterialState({
    required bool isFinished,
  }) = _MaterialState;

  factory MaterialState.initial() => const MaterialState(
    isFinished: false,
  );
}
