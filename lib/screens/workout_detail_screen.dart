import 'package:flutter/material.dart';
import '../models/workout_day.dart';
import '../utils/data.dart';
import '../theme/app_theme.dart';
import 'workout_timer_screen.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final int dayIndex;
  const WorkoutDetailScreen({Key? key, this.dayIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WorkoutDay day = hiitProgram[dayIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Jour ${day.day} - ${day.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: day.isRestDay
            ? Center(
                child: Text(
                  'Jour de repos 💤',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppTheme.primaryColor),
                  textAlign: TextAlign.center,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Exercices:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: day.exercises.length,
                      itemBuilder: (context, idx) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppTheme.primaryColor,
                              child: Text('${idx + 1}', style: const TextStyle(color: Colors.white)),
                            ),
                            title: Text(day.exercises[idx]),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkoutTimerScreen(dayIndex: dayIndex),
                          ),
                        );
                      },
                      child: const Text('Démarrer'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}