import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/src/hamster/bloc/hamster_bloc.dart';
import 'package:game/src/hamster/hamster_game.dart';

class HamsterFactory {
  Widget getHamsterGame(TieMaterial material) {
    return _build(material);
  }

  Widget _build(TieMaterial material) {
    return BlocProvider<HamsterBloc>(
      create: (context) {
        return HamsterBloc();
      },
      child: _getGame(material),
    );
  }

  Widget _getGame(TieMaterial material) {
    return HamsterGame(material: material);
  }
}
