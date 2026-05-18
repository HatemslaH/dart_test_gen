import 'package:dart_test_gen/generate_pipeline.dart';
import 'package:dart_test_gen/src/cli/early_exit_handler.dart';

Future<void> main(List<String> args) async {
  if (handleEarlyExitFlags(args)) return;
  await GeneratePipeline.generateFromCli(args);
}
