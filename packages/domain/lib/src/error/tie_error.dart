sealed class TieError extends Error {
  TieError(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}

class TieNavigationError extends TieError {
  TieNavigationError(String message) : super('Navigation error: $message');
}
