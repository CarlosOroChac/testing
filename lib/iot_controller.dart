// lib/iot_controller.dart
import 'sensor_interfaces.dart';

class IotController {
  final SensorInterface tempSensor;
  final HumiditySensor humiditySensor;
  final COxDetector coxDetector;
  final LightDetector lightDetector;

  bool isLoading = false;

  // Constructor con Inyección de Dependencias (DI)
  IotController({
    required this.tempSensor,
    required this.humiditySensor,
    required this.coxDetector,
    required this.lightDetector,
  });

  /// Simular respuesta normal y Falla/Excepción
  Future<double> readMainSensor() async {
    try {
      return await tempSensor.readValue();
    } catch (e) {
      return -1.0; // Fallback value
    }
  }

  /// Verificar llamada: Si COx es crítico (>100), enciende alarma de luz
  Future<void> monitorAirQuality() async {
    final ppm = await coxDetector.getPPM();
    if (ppm > 100) {
      lightDetector.turnOnAlarm();
    }
  }

  /// Simular Latencia
  Future<void> refreshDashboard() async {
    isLoading = true;
    // Simula espera de red
    await humiditySensor.getHumidity();
    isLoading = false;
  }
  
  /// Método para probar Timeout
  Future<void> runCalibration() async {
    await tempSensor.calibrate();
  }
}