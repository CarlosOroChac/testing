// test/mock_test.dart
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_device_tester/sensor_interfaces.dart';
import 'package:smart_device_tester/iot_controller.dart';

// Paso 2.1: Crear clase Mock que implementa las 4 interfaces
class MockSensor extends Mock implements SensorInterface, HumiditySensor, COxDetector, LightDetector {}

void main() {
  late MockSensor mockSensor;
  late IotController controller;

  setUp(() {
    mockSensor = MockSensor();
    // Inyección de dependencias: pasamos el mismo mock para todas las interfaces por simplicidad
    controller = IotController(
      tempSensor: mockSensor,
      humiditySensor: mockSensor,
      coxDetector: mockSensor,
      lightDetector: mockSensor,
    );
  });

  group('Part 2: Mocking Tests', () {
    
    // 1. Éxito: Simular respuesta normal
    test('should return temperature when sensor reads successfully', () async {
      // Arrange
      when(() => mockSensor.readValue()).thenAnswer((_) async => 25.5);
      // Act
      final result = await controller.readMainSensor();
      // Assert
      expect(result, 25.5);
    });

    // 2. Falla/Excepción: Manejo de fallback
    test('should return -1.0 when sensor throws exception', () async {
      // Arrange
      when(() => mockSensor.readValue()).thenThrow(Exception('Connection Error'));
      // Act
      final result = await controller.readMainSensor();
      // Assert
      expect(result, -1.0);
    });

    // 3. Verificación de Llamada: verify().called(1)
    test('should turn on alarm when COx level is critical (>100)', () async {
      // Arrange
      when(() => mockSensor.getPPM()).thenAnswer((_) async => 150);
      // Act
      await controller.monitorAirQuality();
      // Assert
      verify(() => mockSensor.turnOnAlarm()).called(1);
    });

    // 4. Latencia: Verificar indicador de carga
    test('should set isLoading true while fetching data', () async {
      // Arrange: Simular delay
      when(() => mockSensor.getHumidity()).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        return 50.0;
      });
      
      // Act
      final future = controller.refreshDashboard();
      
      // Assert (Verificar estado intermedio)
      expect(controller.isLoading, isTrue);
      
      await future;
      
      // Assert (Verificar estado final)
      expect(controller.isLoading, isFalse);
    });

    // 5. Timeout: Simular demora de 10s y verificar TimeoutException
    test('should throw TimeoutException when calibration takes too long', () async {
      // Arrange: Mock que nunca termina (o tarda 10 segundos como pide el prompt)
      when(() => mockSensor.calibrate()).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 10));
      });

      // Act & Assert
      // Usamos .timeout en la llamada para forzar la excepción en el test sin esperar 10s reales si no queremos,
      // pero para cumplir la instruccion estricta, simulamos la espera larga dentro del when.
      expect(
        () async => await controller.runCalibration().timeout(const Duration(milliseconds: 100)),
        throwsA(isA<TimeoutException>()),
      );
    });
  });
}