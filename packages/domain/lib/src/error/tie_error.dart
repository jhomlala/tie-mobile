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

class TieUnknownGameError extends TieError {
  TieUnknownGameError(String message) : super('Unsupported game: $message');
}

class TieUnknownError extends TieError {
  TieUnknownError(String message) : super('Unknown error: $message');
}

class TieAuthError extends TieError {
  TieAuthError(String message) : super('Auth error: $message');
}
