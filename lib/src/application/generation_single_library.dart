import 'package:dart_test_gen/gen_config.dart';

import '../domain/check_failure.dart';
import '../domain/generator_module.dart';
import '../ports/generation_filesystem.dart';

/// Runs generation for a single library file via a [GeneratorModule].
///
/// Returns a [CheckFailure] when `config.check` is true and the generated
/// content differs from the existing test file; returns `null` otherwise.
Future<CheckFailure?> generateSingleLibraryFile({
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
    return outcome.failure;
  }
  return null;
}
