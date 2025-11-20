// test/thermostat_mock_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// Ajusta los imports según el nombre de tu proyecto
import 'package:smart_device_tester/thermostat.dart'; 
import 'mock_sensor.dart'; 

void main() {
  late Thermostat thermostat;
  late MockSensor mockSensor; // The mock instance

  setUp(() {
    // Arrange: Initialize mock and thermostat with injected mock
    mockSensor = MockSensor();
    thermostat = Thermostat(mockSensor);
  });

  group('Thermostat Integration with Mocked Sensor', () {
    test('should return temperature when sensor responds correctly', () async {
      const expectedTemp = 23.5;

      // Arrange: Use when() to tell Mocktail what to return
      when(() => mockSensor.getCurrentTemperature())
          .thenAnswer((_) async => expectedTemp);

      // Act: Execute the unit
      final currentTemp = await thermostat.checkCurrentTemperature();

      // Assert: Verify the result matches mock value
      expect(currentTemp, expectedTemp);
    });
  });
}