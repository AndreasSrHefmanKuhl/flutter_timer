import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  int _currentSecond = 0;
  bool _runTimer = false;

  void _startTimer() {
    setState(() {
      _runTimer = true;
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (_runTimer) {
        setState(() {
          _currentSecond++;
        });
        _startTimer();
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _runTimer = false;
    });
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _currentSecond = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_currentSecond s',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _runTimer ? null : _startTimer,
                  child: const Text('Start'),
                ),
                ElevatedButton(
                  onPressed: _runTimer ? _stopTimer : null,
                  child: const Text('Stop'),
                ),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
