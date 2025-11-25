import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tests/iot_controller.dart';
import 'mock_sensor.dart';

void main() {
  late MockSensor mockHumidity;
  late MockSensor mockCox;
  late MockSensor mockLight;
  late MockSensor mockAlarm;
  late IotController controller;

  setUp(() {
    mockHumidity = MockSensor();
    mockCox = MockSensor();
    mockLight = MockSensor();
    mockAlarm = MockSensor();

    controller = IotController(
      humiditySensor: mockHumidity,
      coXDetector: mockCox,
      lightDetector: mockLight,
      alarmService: mockAlarm,
    );
  });

  group('IotController Mocking Tests', () {
    // 1. Éxito
    test('should update sensorData successfully when sensors return valid values', () async {
      when(() => mockHumidity.readValue()).thenAnswer((_) async => 45.0);
      when(() => mockCox.readValue()).thenAnswer((_) async => 10.0);
      when(() => mockLight.readValue()).thenAnswer((_) async => 300.0);

      await controller.readAllSensors();

      expect(controller.sensorData['humidity'], 45.0);
      expect(controller.isLoading, false);
    });

    // 2. Falla/Excepción
    test('should set fallback values when a sensor throws an exception', () async {
      when(() => mockHumidity.readValue()).thenThrow(Exception('Error'));
      
      try {
        await controller.readAllSensors();
      } catch (_) {}

      expect(controller.sensorData['humidity'], -1.0);
    });

    // 3. Verificación de Llamada
    test('should trigger alarm service when COx level is critical (> 100)', () async {
      when(() => mockHumidity.readValue()).thenAnswer((_) async => 50.0);
      when(() => mockCox.readValue()).thenAnswer((_) async => 150.0); // Crítico
      when(() => mockLight.readValue()).thenAnswer((_) async => 300.0);

      await controller.readAllSensors();

      verify(() => mockAlarm.triggerAlarm(any())).called(1);
    });

    // 4. Latencia (isLoading)
    test('should set isLoading to true while fetching data', () async {
      final completer = Completer<double>();
      when(() => mockHumidity.readValue()).thenAnswer((_) => completer.future);
      when(() => mockCox.readValue()).thenAnswer((_) async => 10.0);
      when(() => mockLight.readValue()).thenAnswer((_) async => 300.0);

      final future = controller.readAllSensors();

      expect(controller.isLoading, true); // Verifica estado cargando
      completer.complete(50.0);
      await future;
      expect(controller.isLoading, false); // Verifica estado finalizado
    });

    // 5. Timeout
    test('should throw TimeoutException when sensor takes too long', () async {
      when(() => mockHumidity.readValue()).thenAnswer(
        (_) async => await Future.delayed(const Duration(seconds: 10), () => 50.0),
      );

      expect(
        () async => await controller.readWithTimeout(),
        throwsA(isA<TimeoutException>()),
      );
    });
  });
}