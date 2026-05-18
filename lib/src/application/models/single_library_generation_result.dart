import 'package:dart_test_gen/dart_test_gen.dart';

/// Outcome of generating a single library (check diff and optional stdout line, e.g. dry-run path).
final class SingleLibraryGenerationResult {
  const SingleLibraryGenerationResult({this.checkFailure, this.stdoutLine});

  final CheckFailure? checkFailure;
  final String? stdoutLine;
}
