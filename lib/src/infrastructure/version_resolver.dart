import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

/// Resolves this package's version by scanning candidate `pubspec.yaml` locations.
String resolveVersion() {
  try {
    final candidates = <String>[];
    final scriptPath = Platform.script.toFilePath();
    if (scriptPath.isNotEmpty) {
      candidates.add(p.normalize(p.join(p.dirname(scriptPath), '..', 'pubspec.yaml')));
      candidates.add(p.normalize(p.join(p.dirname(scriptPath), 'pubspec.yaml')));
    }
    candidates.add(p.normalize(p.join(Directory.current.path, 'pubspec.yaml')));
    for (final c in candidates) {
      final f = File(c);
      if (!f.existsSync()) continue;
      final yaml = loadYaml(f.readAsStringSync());
      if (yaml is YamlMap) {
        final v = yaml['version'];
        if (v is String && v.trim().isNotEmpty) return v.trim();
      }
    }
  } catch (_) {}
  return 'unknown';
}
