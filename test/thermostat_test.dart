import 'package:flutter_test/flutter_test.dart';
import 'package:tests/thermostat.dart';

void main() {
  late Thermostat thermostat;

  setUp(() {
    thermostat = Thermostat();
  });

  test('should set temperature within range', () {
    thermostat.setTemperature(20.0);
    expect(thermostat.temperature, 20.0);
  });

  test('should set temperature to lower limit when below 15', () {
    thermostat.setTemperature(10.0);
    expect(thermostat.temperature, 15.0);
  });

  test('should set temperature to upper limit when above 30', () {
    thermostat.setTemperature(35.0);
    expect(thermostat.temperature, 30.0);
  });
}
