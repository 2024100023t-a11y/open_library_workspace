enum TerminalColor {
  red('\x1B[31m'),
  green('\x1B[32m'),
  cyan('\x1B[36m'),
  yellow('\x1B[33m'),
  reset('\x1B[0m');

  final String ansiCode;
  const TerminalColor(this.ansiCode);
}

extension Colorizer on String {
  String get styleError => '${TerminalColor.red.ansiCode}$this${TerminalColor.reset.ansiCode}';
  String get styleSuccess => '${TerminalColor.green.ansiCode}$this${TerminalColor.reset.ansiCode}';
  String get styleHeader => '${TerminalColor.cyan.ansiCode}$this${TerminalColor.reset.ansiCode}';
  String get styleWarning => '${TerminalColor.yellow.ansiCode}$this${TerminalColor.reset.ansiCode}';
}