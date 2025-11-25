import 'dart:async';
import 'sensor_interface.dart';

class IotController {
  final HumiditySensor humiditySensor;
  final COxDetector coXDetector;
  final LightDetector lightDetector;
  final AlarmService alarmService;

  bool isLoading = false;
  Map<String, double> sensorData = {};

  IotController({
    required this.humiditySensor,
    required this.coXDetector,
    required this.lightDetector,
    required this.alarmService,
  });

  Future<void> readAllSensors() async {
    isLoading = true;
    try {
      // Leemos los sensores
      final humidity = await humiditySensor.readValue();
      final cox = await coXDetector.readValue();
      final light = await lightDetector.readValue();

      sensorData = {
        'humidity': humidity,
        'cox': cox,
        'light': light,
      };

      // Verifica condición crítica (COx > 100)
      if (cox > 100.0) {
        alarmService.triggerAlarm("Nivel de COx crítico detectado: $cox");
      }
    } catch (e) {
      // Fallback en caso de error
      sensorData = {
        'humidity': -1.0,
        'cox': -1.0,
        'light': -1.0,
      };
      // Re-lanzamos para que el test pueda confirmar la excepción si es necesario
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  // Método específico para probar el Timeout
  Future<void> readWithTimeout() async {
    try {
      await humiditySensor.readValue().timeout(const Duration(seconds: 2));
    } on TimeoutException {
      rethrow;
    }
  }
}