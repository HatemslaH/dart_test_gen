import 'dart:io';

import 'package:path/path.dart' as p;

/// Прогресс 0–100% для набора файлов: составная строка с `\r` или блок строк с ANSI.
final class GenerationProgressUi {
  GenerationProgressUi._({
    required this.labels,
    required this.useAnsiBlock,
    required this.labelWidth,
  }) : _pct = {for (final l in labels) l: 0.0};

  final List<String> labels;
  final Map<String, double> _pct;
  final bool useAnsiBlock;
  final int labelWidth;
  var _dirty = false;
  var _blockWritten = false;

  static const _barW = 22;

  factory GenerationProgressUi.create(Iterable<String> displayLabels) {
    final labels = displayLabels.toList()..sort();
    final baseNames = labels.map(p.basename).toList();
    final useAnsi =
        stdout.hasTerminal && (stdout.supportsAnsiEscapes || _windowsVt());
    final w = baseNames.isEmpty
        ? 14
        : baseNames.map((s) => s.length).reduce((a, b) => a > b ? a : b).clamp(8, 28).toInt();
    final ui = GenerationProgressUi._(
      labels: labels,
      useAnsiBlock: useAnsi,
      labelWidth: w,
    );
    ui.drawInitial();
    return ui;
  }

  /// Первый кадр сразу (все 0%).
  void drawInitial() => _redraw();

  static bool _windowsVt() {
    if (!Platform.isWindows) return false;
    return Platform.environment['WT_SESSION'] != null ||
        Platform.environment['TERM'] == 'xterm' ||
        Platform.environment['ANSICON'] != null;
  }

  void setPercent(String label, double percent) {
    if (!labels.contains(label)) return;
    final pv = percent.clamp(0.0, 100.0).toDouble();
    if (_pct[label] != pv) {
      _pct[label] = pv;
      _redraw();
    }
  }

  void _redraw() {
    _dirty = true;
    if (useAnsiBlock) {
      _redrawAnsiBlock();
    } else {
      _redrawSingleCompositeLine();
    }
    stdout.flush();
  }

  void _redrawAnsiBlock() {
    final n = labels.length;
    if (n == 0) return;
    final buf = StringBuffer();
    if (_blockWritten) {
      buf.write('\x1B[${n}A');
    }
    _blockWritten = true;
    for (final lab in labels) {
      buf.write('\x1B[2K\r');
      buf.writeln(_formatLine(lab, _pct[lab] ?? 0));
    }
    stdout.write(buf.toString());
  }

  void _redrawSingleCompositeLine() {
    final parts = <String>[];
    for (final lab in labels) {
      parts.add(_compactSegment(lab, _pct[lab] ?? 0));
    }
    var line = parts.join(' | ');
    final cols = stdout.hasTerminal ? stdout.terminalColumns : null;
    if (cols != null && cols > 16 && line.length > cols - 1) {
      line = '${line.substring(0, cols - 4)} …';
    }
    stdout.write('\r\x1B[K$line');
  }

  String _compactSegment(String label, double pct) {
    final base = p.basename(label);
    final name = base.length > 20 ? '${base.substring(0, 18)}..' : base;
    final filled = (pct / 100 * _barW).round().clamp(0, _barW);
    final bar = '${'#' * filled}${'-' * (_barW - filled)}';
    return '$name [$bar] ${pct.toStringAsFixed(0)}%';
  }

  String _formatLine(String label, double pct) {
    final base = p.basename(label);
    final trimmed = base.length > labelWidth ? '${base.substring(0, labelWidth - 2)}..' : base;
    final pad = trimmed.padRight(labelWidth);
    final filled = (pct / 100 * _barW).round().clamp(0, _barW);
    final bar = '${'#' * filled}${'-' * (_barW - filled)}';
    return '$pad  [$bar] ${pct.toStringAsFixed(0)}%';
  }

  void finish() {
    if (_dirty) {
      stdout.write('\n');
      stdout.flush();
    }
    _blockWritten = false;
    _dirty = false;
  }
}
