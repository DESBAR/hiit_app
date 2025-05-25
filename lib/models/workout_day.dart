class WorkoutDay {
  final int day;
  final String title;
  final bool isRestDay;
  final List<String> exercises;
  final bool isCompleted;

  WorkoutDay({
    required this.day,
    required this.title,
    required this.isRestDay,
    required this.exercises,
    this.isCompleted = false,
  });

  WorkoutDay copyWith({
    bool? isCompleted,
  }) {
    return WorkoutDay(
      day: day,
      title: title,
      isRestDay: isRestDay,
      exercises: exercises,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}