// lib/main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Device Tester',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ControlPanelWidget(title: 'Control Panel'),
    );
  }
}

// --- 1. LEDWidget (Requerido por las instrucciones) ---
class LEDWidget extends StatelessWidget {
  final bool isOn;

  const LEDWidget({super.key, required this.isOn});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.lightbulb,
      size: 48.0,
      // Verde si está encendido, Gris si está apagado
      color: isOn ? Colors.green : Colors.grey,
    );
  }
}

// --- 2. ControlPanelWidget (Renombrado de MyHomePage) ---
class ControlPanelWidget extends StatefulWidget {
  const ControlPanelWidget({super.key, required this.title});

  final String title;

  @override
  State<ControlPanelWidget> createState() => _ControlPanelWidgetState();
}

class _ControlPanelWidgetState extends State<ControlPanelWidget> {
  int _counter = 0;
  bool _isLedOn = false; // Estado para controlar el LED visualmente

  void _incrementCounter() {
    setState(() {
      _counter++;
      // Opcional: alternar el LED con cada tap para probar ambas cosas
      _isLedOn = !_isLedOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Agregamos el LEDWidget aquí para poder probarlo
            LEDWidget(isOn: _isLedOn),
            const SizedBox(height: 20),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}