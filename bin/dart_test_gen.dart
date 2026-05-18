import 'package:dart_test_gen/cli/cli_help.dart';
import 'package:dart_test_gen/generate_pipeline.dart';

Future<void> main(List<String> args) async {
  if (handleEarlyExitFlags(args)) return;
  await GeneratePipeline.generateFromCli(args);
}
