import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hamster_bloc.freezed.dart';

part 'hamster_event.dart';

part 'hamster_state.dart';

class HamsterBloc extends Bloc<HamsterEvent, HamsterState> {
  HamsterBloc({required this.eventCallback}) : super(HamsterState.initial()) {
    on<HamsterUpdateScore>(_onHamsterUpdateScore);
    on<HamsterUpdateStep>(_onHamsterUpdateState);
    on<HamsterGameFinished>(_onHamsterGameFinished);
  }

  final void Function(GameEvents event) eventCallback;

  FutureOr<void> _onHamsterUpdateScore(
      HamsterUpdateScore event, Emitter<HamsterState> emit) {
    emit(state.copyWith(score: event.score));
  }

  FutureOr<void> _onHamsterUpdateState(
      HamsterUpdateStep event, Emitter<HamsterState> emit) {
    emit(state.copyWith(steps: event.steps));
  }

  FutureOr<void> _onHamsterGameFinished(
    HamsterGameFinished event,
    Emitter<HamsterState> emit,
  ) {
    eventCallback(GameFinished(score: state.score, steps: state.steps));
  }
}
