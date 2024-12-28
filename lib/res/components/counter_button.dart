import 'package:flutter/material.dart';

class CounterButton extends StatefulWidget {
  const CounterButton({
    super.key,
    required this.initialCounter,
    required this.onCounterValueChanged,
  });

  @override
  State<CounterButton> createState() => _CounterButtonState();

  final void Function(int) onCounterValueChanged;
  final int initialCounter;
}

class _CounterButtonState extends State<CounterButton> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialCounter;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      widget.onCounterValueChanged(_counter); // Call the callback function
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      widget.onCounterValueChanged(_counter); // Call the callback function
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Counter: $_counter'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _decrementCounter,
                child: const Text('-'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text('+'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
