import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'material_bloc.freezed.dart';

part 'material_event.dart';

part 'material_state.dart';

class MaterialBloc extends Bloc<MaterialEvent, MaterialState> {
  MaterialBloc() : super(MaterialState.initial()) {
    on<MaterialGameFinished>(_onMaterialGameFinished);
    on<MaterialRestartGame>(_onMaterialRestartGame);
  }

  FutureOr<void> _onMaterialGameFinished(
      MaterialGameFinished event, Emitter<MaterialState> emit) {
    emit(state.copyWith(isFinished: true));
  }

  FutureOr<void> _onMaterialRestartGame(
      MaterialRestartGame event, Emitter<MaterialState> emit) {
    emit(state.copyWith(isFinished: false));
  }
}
