/// Thrown when CLI arguments are invalid; the CLI layer should print [message] and exit (e.g. 64).
final class InvalidCliArgumentsException implements Exception {
  const InvalidCliArgumentsException(this.message);

  final String message;

  @override
  String toString() => message;
}
