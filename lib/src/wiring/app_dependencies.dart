import 'package:dart_test_gen/dart_test_gen.dart';

/// Composition root: default filesystem and registered generator modules.
final class AppDependencies {
  AppDependencies({
    required this.cli,
    required this.filesystem,
    required this.isolateMessageSpawner,
    required this.singleLibraryGenerator,
    required this.configReader,
    required List<GeneratorModule> modules,
  }) : modules = List<GeneratorModule>.unmodifiable(modules);

  final CliDependencies cli;
  final GenerationFilesystem filesystem;
  final IsolateMessageSpawner isolateMessageSpawner;
  final SingleLibraryGenerator singleLibraryGenerator;
  final ConfigReader configReader;
  final List<GeneratorModule> modules;

  GeneratorModule get defaultGenerator =>
      modules.firstWhere((m) => m.id == kDefaultGeneratorModuleId, orElse: () => modules.first);

  /// Production wiring (real I/O, built-in snapshot unit-test generator).
  factory AppDependencies.production() {
    final cli = CliDependencies.production();
    final fs = IoGenerationFilesystem();
    final singleLibraryGenerator = SingleLibraryGenerator();
    final isolateMessageSpawner = IsolateMessageSpawner(
      singleLibraryGenerator,
      cli.snapshotFailureFormatter,
    );

    return AppDependencies(
      cli: cli,
      filesystem: fs,
      isolateMessageSpawner: isolateMessageSpawner,
      singleLibraryGenerator: singleLibraryGenerator,
      configReader: const IoConfigReader(),
      modules: const [SnapshotUnitTestGeneratorModule()],
    );
  }
}
