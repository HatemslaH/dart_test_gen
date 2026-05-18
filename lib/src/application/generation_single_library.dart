import 'package:dart_test_gen/dart_test_gen.dart';

/// Outcome of generating a single library (check diff and optional stdout line, e.g. dry-run path).
final class SingleLibraryGenerationResult {
  const SingleLibraryGenerationResult({this.checkFailure, this.stdoutLine});

  final CheckFailure? checkFailure;
  final String? stdoutLine;
}

/// Runs generation for a single library file via a [GeneratorModule].
///
/// Returns a [SingleLibraryGenerationResult] with [SingleLibraryGenerationResult.checkFailure]
/// set when `config.check` is true and the generated content differs from the existing test file.
Future<SingleLibraryGenerationResult> generateSingleLibraryFile({
  required GenerationFilesystem filesystem,
  required GeneratorModule generator,
  required String absoluteLibPath,
  required String packageRoot,
  required String packageName,
  required String? className,
  required String displayLabel,
  required bool verbose,
  required GeneratorConfig config,
  required EmitGenerationUi emit,
}) async {
  final ctx = GeneratorRunContext(
    absoluteLibPath: absoluteLibPath,
    packageRoot: packageRoot,
    packageName: packageName,
    className: className,
    displayLabel: displayLabel,
    verbose: verbose,
    config: config,
    fs: filesystem,
    emit: emit,
  );
  final outcome = await generator.run(ctx);
  if (outcome is GeneratorRunCheckMismatch) {
    return SingleLibraryGenerationResult(checkFailure: outcome.failure);
  }
  if (outcome is GeneratorRunSuccess) {
    return SingleLibraryGenerationResult(stdoutLine: outcome.emitStdoutLine);
  }
  return const SingleLibraryGenerationResult();
}
