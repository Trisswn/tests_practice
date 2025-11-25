abstract class SensorInterface {
  Future<double> readValue();
}

abstract class HumiditySensor implements SensorInterface {}

abstract class COxDetector implements SensorInterface {}

abstract class LightDetector implements SensorInterface {}

// Interfaz para la acción de alarma requerida
abstract class AlarmService {
  void triggerAlarm(String message);
}