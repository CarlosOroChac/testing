// lib/widgets.dart
import 'package:flutter/material.dart';

/// 1. LEDWidget
class LEDWidget extends StatelessWidget {
  final bool isOn;

  const LEDWidget({super.key, required this.isOn});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.lightbulb,
      color: isOn ? Colors.green : Colors.grey,
      size: 50,
    );
  }
}

/// 2. ControlPanelWidget
class ControlPanelWidget extends StatefulWidget {
  const ControlPanelWidget({super.key});

  @override
  State<ControlPanelWidget> createState() => _ControlPanelWidgetState();
}

class _ControlPanelWidgetState extends State<ControlPanelWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter:'),
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