import 'dart:async';
import 'package:flutter/material.dart';
import '../models/counter.dart';

class CounterPage extends StatelessWidget {
  final StreamController<Counter> _counterStreamController = StreamController<Counter>();

  Counter _counter = const Counter(count: 0);

  void _incrementCounter() {
    final newCounter = _counter.copyWith(count: _counter.count + 1);
    _counter = newCounter;
    _counterStreamController.add(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Counter Value:', style: TextStyle(fontSize: 24)),
            StreamBuilder<Counter>(
              stream: _counterStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('${snapshot.data!.count}', style: const TextStyle(fontSize: 48));
                } else {
                  return const Text('0', style: TextStyle(fontSize: 48));
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // Call the _incrementCounter method on button press
        child: const Icon(Icons.add),
      ),
    );
  }
}
