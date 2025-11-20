// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_final_project/widgets.dart';

void main() {
  group('Part 3: Widget Tests', () {
    
    // --- LEDWidget Tests ---
    
    // 1. Renderizado: Color Verde cuando isOn = true
    testWidgets('should render Green icon when LED is On', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LEDWidget(isOn: true),
      ));

      final iconFinder = find.byType(Icon);
      final icon = tester.widget<Icon>(iconFinder);
      
      expect(icon.color, Colors.green);
    });

    // 2. Renderizado: Color Gris cuando isOn = false
    testWidgets('should render Grey icon when LED is Off', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LEDWidget(isOn: false),
      ));

      final iconFinder = find.byType(Icon);
      final icon = tester.widget<Icon>(iconFinder);
      
      expect(icon.color, Colors.grey);
    });

    // --- ControlPanelWidget Tests ---

    // 3. Estado Inicial
    testWidgets('should show counter at 0 initially', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ControlPanelWidget(),
      ));

      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);
    });

    // 4. Interacción 1: Un tap
    testWidgets('should increment counter to 1 when tapped once', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ControlPanelWidget(),
      ));

      // Tap al FAB
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump(); // Re-render

      expect(find.text('1'), findsOneWidget);
    });

    // 5. Interacción 2: Múltiples taps
    testWidgets('should increment counter to 5 when tapped five times', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ControlPanelWidget(),
      ));

      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();
      }

      expect(find.text('5'), findsOneWidget);
    });
  });
}