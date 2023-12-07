import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'materials_bloc.freezed.dart';

part 'materials_event.dart';

part 'materials_state.dart';

class MaterialsBloc extends Bloc<MaterialsEvent, MaterialsState> {
  MaterialsBloc({required this.materialsRepository})
      : super(MaterialsState.initial()) {
    on<MaterialsInitialise>(_initialise);
  }

  final MaterialsRepository materialsRepository;

  FutureOr<void> _initialise(
    MaterialsInitialise event,
    Emitter<MaterialsState> emit,
  ) async {
    final materialsResult = await materialsRepository.getMaterials();
    materialsResult.fold(
        (left) => {
              //TODO: Handle error
            }, (right) {
      Log.info("Selected materials: " + right.toString());
      emit(state.copyWith(materials: right));
    });
  }
}
