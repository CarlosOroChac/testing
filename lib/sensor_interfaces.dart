// lib/sensor_interfaces.dart

abstract class SensorInterface {
  Future<double> readValue();
  Future<void> calibrate(); // Método para probar timeout
}

abstract class HumiditySensor {
  Future<double> getHumidity();
}

abstract class COxDetector {
  Future<int> getPPM();
}

abstract class LightDetector {
  void turnOnAlarm(); // Void method para verificar llamadas (verify)
}