import 'dart:convert';

/// Keeps only the last [maxLines] lines of [text] (for stderr/stdout tails).
String tailLinesForLog(String text, int maxLines) {
  final lines = const LineSplitter().convert(text);
  if (lines.length <= maxLines) return text;
  return lines.sublist(lines.length - maxLines).join('\n');
}

void snapshotVerboseLine(void Function(String line)? sink, String label, String step, String detail) {
  sink?.call('[$label]\tsnapshot/$step\t$detail\n');
}
