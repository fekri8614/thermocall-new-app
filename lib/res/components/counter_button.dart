import 'package:flutter/material.dart';

class CounterButton extends StatefulWidget {
  CounterButton({
    super.key,
    required this.counter,
    required this.onCounterValueChanged,
  });

  @override
  State<CounterButton> createState() => _CounterButtonState();

  final void Function(int) onCounterValueChanged;
  int counter;
}

class _CounterButtonState extends State<CounterButton> {
  void _incrementCounter() {
    setState(() {
      widget.counter++;
      widget
          .onCounterValueChanged(widget.counter); // Call the callback function
    });
  }

  void _decrementCounter() {
    setState(() {
      widget.counter--;
      widget
          .onCounterValueChanged(widget.counter); // Call the callback function
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: widget.counter != 0 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Text(
              '${widget.counter}',
              style: const TextStyle(
                fontSize: 48.0,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: _decrementCounter,
                backgroundColor: Colors.blue,
                child: const Icon(Icons.remove),
              ),
              const SizedBox(width: 20.0),
              FloatingActionButton(
                onPressed: _incrementCounter,
                backgroundColor: Colors.purple,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
