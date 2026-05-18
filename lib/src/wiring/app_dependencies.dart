import 'package:dart_test_gen/dart_test_gen.dart';

/// Composition root: default filesystem and registered generator modules.
final class AppDependencies {
  AppDependencies({
    required this.filesystem,
    required this.configReader,
    required List<GeneratorModule> modules,
  }) : modules = List<GeneratorModule>.unmodifiable(modules);

  final GenerationFilesystem filesystem;
  final ConfigReader configReader;
  final List<GeneratorModule> modules;

  GeneratorModule get defaultGenerator =>
      modules.firstWhere((m) => m.id == kDefaultGeneratorModuleId, orElse: () => modules.first);

  /// Production wiring (real I/O, built-in snapshot unit-test generator).
  factory AppDependencies.production() {
    final fs = IoGenerationFilesystem();
    return AppDependencies(
      filesystem: fs,
      configReader: const IoConfigReader(),
      modules: const [SnapshotUnitTestGeneratorModule()],
    );
  }
}
