
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hamster_bloc.freezed.dart';

part 'hamster_event.dart';

part 'hamster_state.dart';

class HamsterBloc extends Bloc<HamsterEvent, HamsterState> {
  HamsterBloc()
      : super(HamsterState.initial()) {

  }
}