import 'package:flutter_test/flutter_test.dart';
import 'package:tests/command_protocol.dart';

void main() {
  late CommandProtocol cp;

  setUp(() {
    cp = CommandProtocol();
  });

  test('should create command correctly', () {
    expect(cp.createCommand('TURN', 'ON'), 'TURN:ON');
  });
}
