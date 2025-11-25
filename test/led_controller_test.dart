import 'package:flutter_test/flutter_test.dart';
import 'package:tests/led_controller.dart';

void main() {
  late LEDController led;

  setUp(() {
    led = LEDController();
  });

  test('should turn on LED', () {
    led.turnOn();
    expect(led.isOn, true);
  });

  test('should turn off LED', () {
    led.turnOff();
    expect(led.isOn, false);
  });
}
