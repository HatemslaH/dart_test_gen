import 'package:dart_test_gen/gen_config.dart';

import 'src/application/cli_generation_orchestrator.dart';
import 'src/application/generation_single_library.dart' as gen_single;
import 'src/application/snapshot_unit_test_generation.dart' as snap;
import 'src/domain/check_failure.dart';
import 'src/domain/generator_module.dart';
import 'src/generators/snapshot_unit_test_generator_module.dart';
import 'src/infrastructure/io_generation_filesystem.dart';
import 'src/ports/generation_filesystem.dart';
import 'src/wiring/app_dependencies.dart';

export 'src/application/cli_args.dart' show parseCliArgs;
export 'src/application/generation_isolate.dart'
    show generationIsolateMain, generationIsolateSpawnMessage, isolateDoneSentinel, isolateResultPrefix;
export 'src/application/snapshot_failure_formatting.dart' show formatSnapshotRunnerFailure;
export 'src/domain/check_failure.dart' show CheckFailure;
export 'src/domain/generator_module.dart'
    show
        EmitGenerationUi,
        GeneratorModule,
        GeneratorRunCheckMismatch,
        GeneratorRunContext,
        GeneratorRunOutcome,
        GeneratorRunSkipped,
        GeneratorRunSuccess,
        kDefaultGeneratorModuleId;

/// All `.dart` files under [dirAbs] (recursive), using the default I/O filesystem.
List<String> dartFilesUnderDirectory(String dirAbs) => IoGenerationFilesystem().dartFilesUnderDirectory(dirAbs);

/// Expands files and directories into a sorted list of absolute `.dart` paths (default I/O).
List<String> expandGenerationTargets(String cwd, List<String> inputs) =>
    snap.expandGenerationTargetsWithFs(IoGenerationFilesystem(), cwd, inputs);

/// `lib/a/b.dart` → `test/a/b_test.dart`
String testOutputPathForLib(String packageRoot, String absoluteLibPath) => snap.testOutputPathForLib(packageRoot, absoluteLibPath);

String shortLibLabel(String absoluteLibPath, String packageRoot) => snap.shortLibLabel(absoluteLibPath, packageRoot);

/// Runs generation for a single library file.
///
/// Uses [filesystem] / [generator] when provided; otherwise default I/O and the
/// built-in snapshot unit-test module.
Future<CheckFailure?> generateSingleLibraryFile({
  required String absoluteLibPath,
  required String packageRoot,
  required String packageName,
  required String? className,
  required String displayLabel,
  required bool verbose,
  required GeneratorConfig config,
  required EmitGenerationUi emit,
  GenerationFilesystem? filesystem,
  GeneratorModule? generator,
}) =>
    gen_single.generateSingleLibraryFile(
      filesystem: filesystem ?? IoGenerationFilesystem(),
      generator: generator ?? const SnapshotUnitTestGeneratorModule(),
      absoluteLibPath: absoluteLibPath,
      packageRoot: packageRoot,
      packageName: packageName,
      className: className,
      displayLabel: displayLabel,
      verbose: verbose,
      config: config,
      emit: emit,
    );

/// CLI entry: parse args, load config, run registered generator module(s).
Future<void> generateFromCli(List<String> args) async {
  await CliGenerationOrchestrator(AppDependencies.production()).run(args);
}
