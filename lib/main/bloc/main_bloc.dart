import 'dart:async';
import 'dart:collection';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_bloc.freezed.dart';
part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState.initial()) {
    on<MainSetPage>(_onSetPage);
  }

  FutureOr<void> _onSetPage(MainSetPage event, Emitter<MainState> emit) {
    emit(state.copyWith(pageIndex: event.pageIndex));
  }
}