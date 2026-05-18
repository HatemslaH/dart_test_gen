/// Invalid user path input when expanding generation targets (CLI prints and exits).
final class GenerationTargetError implements Exception {
  const GenerationTargetError(this.message, {this.exitCode = 1});

  final String message;
  final int exitCode;

  @override
  String toString() => message;
}
