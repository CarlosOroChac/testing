// lib/sensor_interfaces.dart

/// Interfaz principal que usa el Termostato (del PDF) y el Controlador IoT (de la Rúbrica)
abstract class SensorInterface {
  // --- Requerido por el PDF Lab (Pág 98) ---
  Future<double> getCurrentTemperature();

  // --- Requerido por la Rúbrica (Parte 2) ---
  Future<double> readValue(); 
  Future<void> calibrate();
}

// --- Interfaces adicionales de la Rúbrica ---
abstract class HumiditySensor {
  Future<double> getHumidity();
}

abstract class COxDetector {
  Future<int> getPPM();
}

abstract class LightDetector {
  void turnOnAlarm();
}