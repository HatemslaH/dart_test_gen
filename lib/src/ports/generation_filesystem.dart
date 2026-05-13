/// Resolved node kind for path expansion (no `dart:io` types on the port).
enum PathNodeKind {
  file,
  directory,
  notFound,
  unsupported,
}

/// Filesystem boundary for generation (expand targets, read/write tests).
abstract class GenerationFilesystem {
  /// Current working directory (e.g. `Directory.current.path`).
  String get currentWorkingDirectory;

  PathNodeKind pathKind(String absolutePath);

  /// All `.dart` files under [directoryAbsolute] (recursive), sorted, normalized paths.
  List<String> dartFilesUnderDirectory(String directoryAbsolute);

  bool fileExistsSync(String absoluteFilePath);

  String readFileAsStringSync(String absoluteFilePath);

  void writeFileSyncEnsuringParents(String absoluteFilePath, String content);
}
