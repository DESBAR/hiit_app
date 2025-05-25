import 'package:flutter/material.dart';
import '../models/workout_day.dart';
import '../utils/data.dart';
import '../theme/app_theme.dart';

class WorkoutTimerScreen extends StatefulWidget {
  final int dayIndex;
  const WorkoutTimerScreen({Key? key, this.dayIndex = 0}) : super(key: key);

  @override
  State<WorkoutTimerScreen> createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends State<WorkoutTimerScreen> {
  int currentExercise = 0;
  int secondsLeft = 40;
  bool isRest = false;
  bool isRunning = false;
  late WorkoutDay day;
  late List<String> exercises;
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    day = hiitProgram[widget.dayIndex];
    exercises = day.exercises;
    _ticker = Ticker(_onTick);
  }

  void _onTick(Duration elapsed) {
    if (!isRunning) return;
    if (secondsLeft > 0) {
      setState(() {
        secondsLeft--;
      });
    } else {
      if (!isRest) {
        setState(() {
          isRest = true;
          secondsLeft = 20;
        });
      } else {
        if (currentExercise < exercises.length - 1) {
          setState(() {
            currentExercise++;
            isRest = false;
            secondsLeft = 40;
          });
        } else {
          setState(() {
            isRunning = false;
          });
          _showCompleteDialog();
        }
      }
    }
  }

  void _startPause() {
    setState(() {
      isRunning = !isRunning;
    });
    if (isRunning) {
      _ticker.start();
    } else {
      _ticker.stop();
    }
  }

  void _next() {
    if (currentExercise < exercises.length - 1) {
      setState(() {
        currentExercise++;
        isRest = false;
        secondsLeft = 40;
      });
    } else {
      setState(() {
        isRunning = false;
      });
      _showCompleteDialog();
    }
  }

  void _showCompleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bravo!'),
        content: const Text('Entraînement terminé.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (day.isRestDay) {
      return Scaffold(
        appBar: AppBar(title: Text('Jour ${day.day} - ${day.title}')),
        body: Center(
          child: Text(
            'Jour de repos 💤',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppTheme.primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('Jour ${day.day} - ${day.title}')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isRest ? 'Repos' : exercises[currentExercise],
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: isRest ? Colors.black : AppTheme.primaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Text(
              '$secondsLeft s',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startPause,
                  child: Text(isRunning ? 'Pause' : 'Démarrer'),
                ),
                const SizedBox(width: 24),
                ElevatedButton(
                  onPressed: _next,
                  child: const Text('Suivant'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            LinearProgressIndicator(
              value: (currentExercise + (isRest ? 0.5 : 0)) / exercises.length,
              color: AppTheme.primaryColor,
              backgroundColor: Colors.black.withOpacity(0.2),
              minHeight: 8,
            ),
          ],
        ),
      ),
    );
  }
}

class Ticker {
  final void Function(Duration) onTick;
  Duration _elapsed = Duration.zero;
  bool _running = false;
  late final Stopwatch _stopwatch;
  late final Future<void> _tickerFuture;

  Ticker(this.onTick) {
    _stopwatch = Stopwatch();
  }

  void start() {
    if (_running) return;
    _running = true;
    _stopwatch.start();
    _tickerFuture = _tick();
  }

  void stop() {
    _running = false;
    _stopwatch.stop();
  }

  void dispose() {
    _running = false;
    _stopwatch.stop();
  }

  Future<void> _tick() async {
    while (_running) {
      await Future.delayed(const Duration(seconds: 1));
      if (_running) {
        _elapsed = _stopwatch.elapsed;
        onTick(_elapsed);
      }
    }
  }
}