import 'dart:ui';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/game.dart';
import 'package:tie_mobile/material/bloc/material_bloc.dart' as material_bloc;
import 'package:ui/ui.dart';

class TieMaterialPage extends StatefulWidget {
  const TieMaterialPage({required this.material, super.key});

  final TieMaterial material;

  @override
  State<TieMaterialPage> createState() => _TieMaterialPageState();
}

class _TieMaterialPageState extends State<TieMaterialPage> {
  final GlobalKey _gameKey = GlobalKey();

  TieMaterial get material => widget.material;

  material_bloc.MaterialBloc get bloc => context.bloc();

  @override
  Widget build(BuildContext context) {
    final shortestSize = context.deviceSize().shortestSide;
    return BlocBuilder<material_bloc.MaterialBloc, material_bloc.MaterialState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                _restartGame();
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(32),
            child: Stack(
              children: [
                Center(
                  child: _GameWrapper(
                    disableInput: state.isFinished,
                    size: shortestSize,
                    gameKey: _gameKey,
                    blur: state.isFinished,
                    child: _getGame(),
                  ),
                ),
                if (state.isFinished)
                  Center(
                    child: _GameFinished(
                      onRetryClicked: _restartGame,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getGame() {
    switch (material.type) {
      case 'hamster':
        final tuple = HamsterFactory.instance.getHamsterGame(material);
        final controller = tuple.value1;
        bloc.add(
          material_bloc.MaterialGameInitGameController(
            gameController: controller,
          ),
        );
        final widget = tuple.value2;
        return widget;
    }
    throw TieUnknownGameError('Unknown game: ${material.type}');
  }

  void _restartGame() {
    bloc.add(const material_bloc.MaterialRestartGame());
  }
}

class _GameWrapper extends StatelessWidget {
  const _GameWrapper({
    required this.disableInput,
    required this.size,
    required this.child,
    required this.gameKey,
    required this.blur,
  });

  final bool disableInput;
  final double size;
  final Widget child;
  final Key gameKey;
  final bool blur;

  @override
  Widget build(BuildContext context) {
    Widget widget = SizedBox(
      width: size,
      height: size,
      key: gameKey,
      child: child,
    );

    if (blur) {
      widget = ImageFiltered(
        imageFilter:
            ImageFilter.blur(sigmaX: 10, sigmaY: 10, tileMode: TileMode.decal),
        child: widget,
      );
    }

    if (disableInput) {
      return AbsorbPointer(child: widget);
    } else {
      return widget;
    }
  }
}

class _GameFinished extends StatelessWidget {
  const _GameFinished({required this.onRetryClicked});

  final void Function() onRetryClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      color: Colors.black54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Game has finished!',
            style: TextStyle(color: Colors.white),
          ),
          ElevatedButton(onPressed: onRetryClicked, child: const Text('Retry')),
        ],
      ),
    );
  }
}
