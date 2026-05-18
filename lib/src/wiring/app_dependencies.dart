import '../application/snapshot_unit_test_generation.dart';
import '../domain/generator_module.dart';
import '../domain/ports/config_reader.dart';
import '../infrastructure/config/config_loader.dart';
import '../infrastructure/io_generation_filesystem.dart';
import '../ports/generation_filesystem.dart';

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
