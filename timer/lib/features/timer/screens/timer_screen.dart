import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  TimerScreenState createState() => TimerScreenState();
}

class TimerScreenState extends State<TimerScreen> {
  int _secondsLeft = 0;
  bool _runTimer = false;
  final TextEditingController _contra = TextEditingController();

  void _startTimer() {
    final durationInSeconds = int.tryParse(_contra.text);
    if (durationInSeconds == null || durationInSeconds <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte eine gültige Dauer eingeben')),
      );
      return;
    }

    setState(() {
      _secondsLeft = durationInSeconds;
      _runTimer = true;
    });

    _startCount();
  }

  Future<void> _startCount() async {
    while (_runTimer && _secondsLeft > 0) {
      await Future.delayed(const Duration(milliseconds: 900));
      if (!_runTimer) return;

      setState(() {
        _secondsLeft--;
      });

      if (_secondsLeft == 0) {
        ScaffoldMessenger.of(context.mounted as BuildContext).showSnackBar(
          const SnackBar(content: Text('Timer a!')),
        );
        _runTimer = false;
      }
    }
  }

  void _stopTimer() {
    setState(() {
      _runTimer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _contra,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Bitte gib hier die Sekunden ein',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            Text(
              'Verbleibende Zeit: ${(_secondsLeft / 60).floor()}:'
              '${_secondsLeft % 60}',
              style: const TextStyle(fontSize: 24),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
