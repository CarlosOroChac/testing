// test/mock_sensor.dart
import 'package:mocktail/mocktail.dart';
// Asegúrate de que el nombre del paquete coincida con tu pubspec.yaml
import 'package:testing_final_project/sensor_interfaces.dart'; 

// Create Mock class. Extends Mock and implements interface to simulate.
class MockSensor extends Mock implements SensorInterface {} 