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
                _GameWrapper(
                  disableInput: state.isFinished,
                  size: shortestSize,
                  gameKey: _gameKey,
                  child: _getGame(),
                ),
                if (state.isFinished)
                  _GameFinished(
                    onRetryClicked: _restartGame,
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
  });

  final bool disableInput;
  final double size;
  final Widget child;
  final Key gameKey;

  @override
  Widget build(BuildContext context) {
    final widget = SizedBox(
      width: size,
      height: size,
      key: gameKey,
      child: child,
    );

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
    return Column(
      children: [
        const Text('Game has finished!'),
        ElevatedButton(onPressed: onRetryClicked, child: const Text('Retry')),
      ],
    );
  }
}
