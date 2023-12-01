part of 'main_bloc.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    required bool isLoading,
    required int pageIndex,
  }) = _MainState;

  factory MainState.initial() => MainState(
    isLoading: true,
    pageIndex: 0,
  );
}