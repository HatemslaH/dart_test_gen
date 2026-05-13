import 'dart:io';

import 'package:path/path.dart' as p;

import '../ports/generation_filesystem.dart';

/// Default [GenerationFilesystem] using `dart:io`.
final class IoGenerationFilesystem implements GenerationFilesystem {
  @override
  String get currentWorkingDirectory => Directory.current.path;

  @override
  PathNodeKind pathKind(String absolutePath) {
    final normalized = p.normalize(absolutePath);
    final type = FileSystemEntity.typeSync(normalized);
    return switch (type) {
      FileSystemEntityType.file => PathNodeKind.file,
      FileSystemEntityType.directory => PathNodeKind.directory,
      FileSystemEntityType.notFound => PathNodeKind.notFound,
      _ => PathNodeKind.unsupported,
    };
  }

  @override
  List<String> dartFilesUnderDirectory(String directoryAbsolute) {
    final root = Directory(directoryAbsolute);
    final out = <String>[];
    if (!root.existsSync()) return out;
    for (final entity in root.listSync(recursive: true, followLinks: false)) {
      if (entity is! File) continue;
      if (!p.basename(entity.path).endsWith('.dart')) continue;
      out.add(p.normalize(entity.path));
    }
    out.sort();
    return out;
  }

  @override
  bool fileExistsSync(String absoluteFilePath) => File(absoluteFilePath).existsSync();

  @override
  String readFileAsStringSync(String absoluteFilePath) => File(absoluteFilePath).readAsStringSync();

  @override
  void writeFileSyncEnsuringParents(String absoluteFilePath, String content) {
    final file = File(absoluteFilePath);
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(content);
  }
}
