import 'package:mocktail/mocktail.dart';
import 'package:tests/sensor_interface.dart';

// Un Mock versátil que puede actuar como cualquier sensor o servicio
class MockSensor extends Mock implements HumiditySensor, COxDetector, LightDetector, AlarmService {}