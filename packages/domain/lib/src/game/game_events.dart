sealed class GameEvents {}

class GameStarted extends GameEvents {}

class GameFinished extends GameEvents {
  GameFinished({required this.score, required this.steps});

  final int score;
  final int steps;
}
