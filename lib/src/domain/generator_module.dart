import 'package:dart_test_gen/gen_config.dart';

import '../ports/generation_filesystem.dart';
import 'check_failure.dart';

/// UI callback: progress 0–100 and a detail line; [error]==true always goes to stderr.
typedef EmitGenerationUi = void Function({double? progress, String? line, bool? error});

/// Built-in generator: snapshot-driven unit tests for library members.
const String kDefaultGeneratorModuleId = 'snapshot_unit_test';

sealed class GeneratorRunOutcome {}

/// Parsed library had no supported class/methods — nothing to emit.
final class GeneratorRunSkipped extends GeneratorRunOutcome {}

/// Wrote or validated output; no `--check` mismatch.
final class GeneratorRunSuccess extends GeneratorRunOutcome {
  /// When non-null, CLI should print this line to stdout (e.g. `--dry-run` target path).
  final String? emitStdoutLine;

  GeneratorRunSuccess({this.emitStdoutLine});
}

/// `--check` found a diff vs disk.
final class GeneratorRunCheckMismatch extends GeneratorRunOutcome {
  final CheckFailure failure;
  GeneratorRunCheckMismatch(this.failure);
}

/// Inputs for one generator run (one library file).
class GeneratorRunContext {
  final String absoluteLibPath;
  final String packageRoot;
  final String packageName;
  final String? className;
  final String displayLabel;
  final bool verbose;
  final GeneratorConfig config;
  final GenerationFilesystem fs;
  final EmitGenerationUi emit;

  const GeneratorRunContext({
    required this.absoluteLibPath,
    required this.packageRoot,
    required this.packageName,
    required this.className,
    required this.displayLabel,
    required this.verbose,
    required this.config,
    required this.fs,
    required this.emit,
  });
}

/// Pluggable code generator (e.g. snapshot unit tests; future modules register alongside).
abstract class GeneratorModule {
  String get id;

  Future<GeneratorRunOutcome> run(GeneratorRunContext ctx);
}
