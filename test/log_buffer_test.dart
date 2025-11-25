import 'package:flutter_test/flutter_test.dart';
import 'package:tests/log_buffer.dart';

void main() {
  late LogBuffer buffer;

  setUp(() {
    buffer = LogBuffer();
  });

  test('should store up to 5 logs', () {
    for (int i = 1; i <= 6; i++) {
      buffer.add('Log $i');
    }
    expect(buffer.getLogs().length, 5);
    expect(buffer.getLogs().first, 'Log 2');
  });

  test('should store logs correctly', () {
    buffer.add('Test log');
    expect(buffer.getLogs().first, 'Test log');
  });
}
