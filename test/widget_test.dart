// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tests/main.dart'; // Asegúrate de que el import coincida con el nombre de tu paquete en pubspec.yaml

void main() {
  group('Widget Tests', () {
    // 1. Renderizado 1: Verificar LED encendido (Verde)
    testWidgets('LEDWidget should be green when isOn is true', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LEDWidget(isOn: true),
          ),
        ),
      );

      // Assert
      final iconFinder = find.byType(Icon);
      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.color, Colors.green);
    });

    // 2. Renderizado 2: Verificar LED apagado (Gris)
    testWidgets('LEDWidget should be grey when isOn is false', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LEDWidget(isOn: false),
          ),
        ),
      );

      // Assert
      final iconFinder = find.byType(Icon);
      final icon = tester.widget<Icon>(iconFinder);
      expect(icon.color, Colors.grey);
    });

    // 3. Estado Inicial: Verificar contador en '0'
    testWidgets('ControlPanelWidget shows 0 initially', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(const MyApp());

      // Assert
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);
    });

    // 4. Interacción 1: Simular un tap y verificar '1'
    testWidgets('Counter increments to 1 after one tap', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());

      // Act
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump(); // Reconstruir el widget después del cambio de estado

      // Assert
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);
    });

    // 5. Interacción 2: Simular cinco taps y verificar '5'
    testWidgets('Counter increments to 5 after five taps', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());

      // Act
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();
      }

      // Assert
      expect(find.text('5'), findsOneWidget);
    });
  });
}