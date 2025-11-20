// test/unit_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_device_tester/business_logic.dart';

void main() {
  group('Part 1: Unit Tests Basic Logic', () {
    
    // --- 1. Thermostat Tests ---
    late Thermostat thermostat;
    setUp(() => thermostat = Thermostat());

    test('should set temp to value when within range (20.0)', () {
      // Arrange
      const input = 20.0;
      // Act
      thermostat.setTemperature(input);
      // Assert
      expect(thermostat.temperature, 20.0);
    });

    test('should clamp temp to 30.0 when input is too high (35.0)', () {
      // Act
      thermostat.setTemperature(35.0);
      // Assert
      expect(thermostat.temperature, 30.0);
    });

    test('should clamp temp to 15.0 when input is too low (10.0)', () {
      // Act
      thermostat.setTemperature(10.0);
      // Assert
      expect(thermostat.temperature, 15.0);
    });

    // --- 2. LEDController Tests ---
    test('should be true when turned on', () {
      // Arrange
      final led = LEDController();
      // Act
      led.turnOn();
      // Assert
      expect(led.isOn, isTrue);
    });

    // --- 3. DataValidator Tests ---
    test('should return false when value is out of range (101)', () {
      final validator = DataValidator();
      expect(validator.isValid(101), isFalse);
    });

    // --- 4. CommandProtocol Tests ---
    test('should return formatted string when creating command', () {
      final protocol = CommandProtocol();
      final result = protocol.createCommand('LOGIN', 'USER1');
      expect(result, 'LOGIN:USER1');
    });

    // --- 5. BatteryMonitor Tests ---
    test('should return true when battery is critical (10)', () {
      final monitor = BatteryMonitor();
      expect(monitor.isCritical(10), isTrue);
    });
    
    test('should return false when battery is normal (11)', () {
      final monitor = BatteryMonitor();
      expect(monitor.isCritical(11), isFalse);
    });

    // --- 6. LogBuffer Tests ---
    test('should maintain max 5 items when adding 6th log', () {
      // Arrange
      final buffer = LogBuffer();
      // Act
      for (int i = 1; i <= 6; i++) {
        buffer.add('Log $i');
      }
      // Assert
      final logs = buffer.getLogs();
      expect(logs.length, 5);
      expect(logs.first, 'Log 2'); // El Log 1 debió ser eliminado
      expect(logs.last, 'Log 6');
    });
  });
}