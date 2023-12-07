import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/src/hamster/bloc/hamster_bloc.dart';
import 'package:game/src/hamster/view/hamster_game.dart';

class HamsterFactory {
  HamsterFactory._internal();
  static final HamsterFactory _instance = HamsterFactory._internal();
  static HamsterFactory get instance => _instance;

  final controller = GameController();
  Tuple2<GameController, Widget> getHamsterGame(
    TieMaterial material,
  ) {
    return Tuple2(
      controller,
      BlocProvider<HamsterBloc>(
        create: (context) {
          return HamsterBloc(gameController: controller);
        },
        child: _getGame(material),
      ),
    );
  }

  Widget _getGame(TieMaterial material) {
    return HamsterGame(material: material);
  }
}
