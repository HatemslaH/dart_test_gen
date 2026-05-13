/// Holds the diff summary for a single `--check` failure.
class CheckFailure {
  final String testPath;
  final String summary;
  const CheckFailure({required this.testPath, required this.summary});
}
