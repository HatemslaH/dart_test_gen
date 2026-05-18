import 'package:dart_test_gen/dart_test_gen.dart';

final class GeneratePipeline {
  GeneratePipeline();

  /// All `.dart` files under [dirAbs] (recursive), using the default I/O filesystem.
  static List<String> dartFilesUnderDirectory(String dirAbs) =>
      IoGenerationFilesystem().dartFilesUnderDirectory(dirAbs);

  /// Expands files and directories into a sorted list of absolute `.dart` paths (default I/O).
  static List<String> expandGenerationTargets(String cwd, List<String> inputs) =>
      expandGenerationTargetsWithFs(IoGenerationFilesystem(), cwd, inputs);

  /// `lib/a/b.dart` → `test/a/b_test.dart`
  static String testOutputPathForLib(String packageRoot, String absoluteLibPath) =>
      testOutputPathForLib(packageRoot, absoluteLibPath);

  static String shortLibLabel(String absoluteLibPath, String packageRoot) =>
      shortLibLabel(absoluteLibPath, packageRoot);

  /// Runs generation for a single library file.
  ///
  /// Uses [filesystem] / [generator] when provided; otherwise default I/O and the
  /// built-in snapshot unit-test module.
  static Future<SingleLibraryGenerationResult> generateSingleLibraryFile({
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
      generateSingleLibraryFile(
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
  static Future<void> generateFromCli(
    List<String> args, {
    AppDependencies? dependencies,
  }) async =>
      await CliGenerationOrchestrator(dependencies ?? AppDependencies.production()).run(args);
}
