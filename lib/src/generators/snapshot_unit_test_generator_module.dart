import '../application/snapshot_unit_test_generation.dart';
import '../domain/generator_module.dart';

/// Built-in module: snapshot-driven unit tests.
final class SnapshotUnitTestGeneratorModule implements GeneratorModule {
  const SnapshotUnitTestGeneratorModule();

  @override
  String get id => kDefaultGeneratorModuleId;

  @override
  Future<GeneratorRunOutcome> run(GeneratorRunContext ctx) => runSnapshotUnitTestGeneration(ctx);
}
