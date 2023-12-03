part of 'materials_bloc.dart';

@freezed
class MaterialsState with _$MaterialsState {
  const factory MaterialsState(
      {required bool isLoading,
      required List<TieMaterial> materials}) = _MaterialsState;

  factory MaterialsState.initial() => MaterialsState(
        isLoading: true,
        materials: [],
      );
}
