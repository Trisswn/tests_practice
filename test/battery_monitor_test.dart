import 'package:flutter_test/flutter_test.dart';
import 'package:tests/battery_monitor.dart';

void main() {
  late BatteryMonitor bm;

  setUp(() {
    bm = BatteryMonitor();
  });

  test('should be critical at 10', () {
    expect(bm.isCritical(10), true);
  });

  test('should not be critical above 10', () {
    expect(bm.isCritical(50), false);
  });
}
