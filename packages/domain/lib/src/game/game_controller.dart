import 'dart:async';

import 'package:domain/domain.dart';

class GameController {
  final StreamController<GameCommand> _gameCommandController =
      StreamController.broadcast();
  final StreamController<GameEvents> _gameEventsController =
      StreamController.broadcast();

  void handleCommand(GameCommand command) {
    _gameCommandController.sink.add(command);
  }

  void handleEvent(GameEvents event) {
    _gameEventsController.sink.add(event);
  }

  Stream<GameCommand> get gameCommandsStream => _gameCommandController.stream;

  Stream<GameEvents> get gameEventsStream => _gameEventsController.stream;
}
