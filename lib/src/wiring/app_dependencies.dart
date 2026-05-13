import '../domain/generator_module.dart';
import '../generators/snapshot_unit_test_generator_module.dart';
import '../infrastructure/io_generation_filesystem.dart';
import '../ports/generation_filesystem.dart';

/// Composition root: default filesystem and registered generator modules.
final class AppDependencies {
  AppDependencies({
    required this.filesystem,
    required List<GeneratorModule> modules,
  }) : modules = List<GeneratorModule>.unmodifiable(modules);

  final GenerationFilesystem filesystem;
  final List<GeneratorModule> modules;

  GeneratorModule get defaultGenerator =>
      modules.firstWhere((m) => m.id == kDefaultGeneratorModuleId, orElse: () => modules.first);

  /// Production wiring (real I/O, built-in snapshot unit-test generator).
  factory AppDependencies.production() {
    final fs = IoGenerationFilesystem();
    return AppDependencies(
      filesystem: fs,
      modules: const [SnapshotUnitTestGeneratorModule()],
    );
  }
}
