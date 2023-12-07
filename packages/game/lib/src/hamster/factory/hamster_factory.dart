import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/src/hamster/bloc/hamster_bloc.dart';
import 'package:game/src/hamster/view/hamster_game.dart';

class HamsterFactory {
  Widget getHamsterGame(
    TieMaterial material,
    void Function(GameEvents event) eventCallback,
  ) {
    return BlocProvider<HamsterBloc>(
      create: (context) {
        return HamsterBloc(eventCallback: eventCallback);
      },
      child: _getGame(material),
    );
  }

  Widget _getGame(TieMaterial material) {
    return HamsterGame(material: material);
  }
}
