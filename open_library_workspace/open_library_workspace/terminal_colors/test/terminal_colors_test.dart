import 'package:terminal_colors/terminal_colors.dart';
import 'package:test/test.dart';

void main() {
  test('applies ANSI colors to text', () {
    expect('error'.styleError, contains('error'));
    expect('error'.styleError, startsWith('\x1B[31m'));
    expect('error'.styleError, endsWith('\x1B[0m'));
  });
}
