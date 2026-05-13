import 'dart:isolate';

import 'package:dart_test_gen/gen_config.dart';
import 'package:dart_test_gen/snapshot.dart';

import '../generators/snapshot_unit_test_generator_module.dart';
import '../infrastructure/io_generation_filesystem.dart';
import 'generation_single_library.dart';
import 'snapshot_failure_formatting.dart';

/// Messages from the isolate (sendable types only).
abstract final class GenerationIsolateProtocol {
  static const msgProgress = 'p';
  static const msgVerbose = 'v';
  static const msgError = 'e';
  static const msgCheckFail = 'cf';
}

/// [isolateDoneSentinel] follows [isolateResultPrefix].
const isolateResultPrefix = '__dart_test_gen_result__';
const isolateDoneSentinel = '__dart_test_gen_isolate_done__';

Map<String, Object?> generationIsolateSpawnMessage({
  required String absoluteLibPath,
  required String packageRoot,
  required String packageName,
  required String? className,
  required String displayLabel,
  required bool verbose,
  required GeneratorConfig config,
  required SendPort logPort,
}) =>
    <String, Object?>{
      'absoluteLibPath': absoluteLibPath,
      'packageRoot': packageRoot,
      'packageName': packageName,
      'className': className,
      'displayLabel': displayLabel,
      'verbose': verbose,
      'config': config,
      'logPort': logPort,
    };

@pragma('vm:entry-point')
Future<void> generationIsolateMain(Map<String, Object?> message) async {
  final path = message['absoluteLibPath']! as String;
  final root = message['packageRoot']! as String;
  final pkg = message['packageName']! as String;
  final className = message['className'] as String?;
  final displayLabel = message['displayLabel']! as String;
  final verbose = message['verbose']! as bool;
  final config = message['config']! as GeneratorConfig;
  final port = message['logPort']! as SendPort;

  void bridge({double? progress, String? line, bool? error}) {
    final isErr = error == true;
    if (progress != null) {
      port.send(<String, Object?>{
        't': GenerationIsolateProtocol.msgProgress,
        'l': displayLabel,
        'pct': progress,
      });
    }
    if (line != null && (verbose || isErr)) {
      port.send(<String, Object?>{
        't': isErr ? GenerationIsolateProtocol.msgError : GenerationIsolateProtocol.msgVerbose,
        'm': line,
      });
    }
  }

  var ok = false;
  try {
    final checkFailure = await generateSingleLibraryFile(
      filesystem: IoGenerationFilesystem(),
      generator: const SnapshotUnitTestGeneratorModule(),
      absoluteLibPath: path,
      packageRoot: root,
      packageName: pkg,
      className: className,
      displayLabel: displayLabel,
      verbose: verbose,
      config: config,
      emit: bridge,
    );
    if (checkFailure != null) {
      port.send(<String, Object?>{'t': GenerationIsolateProtocol.msgCheckFail, 's': checkFailure.summary});
    }
    ok = true;
  } on SnapshotRunnerFailure catch (f) {
    bridge(line: formatSnapshotRunnerFailure(f), error: true);
  } catch (e, st) {
    bridge(
      line: 'ERROR\t$e\n$st\n',
      error: true,
    );
  }
  port.send('$isolateResultPrefix:${ok ? "ok" : "fail"}');
  port.send(isolateDoneSentinel);
}
