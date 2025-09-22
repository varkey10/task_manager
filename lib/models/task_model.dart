// lib/models/task_model.dart
class Task {
  final String title;
  final String dueDate;
  final bool isCompleted;

  Task({
    required this.title,
    required this.dueDate,
    this.isCompleted = false,
  });

  Task copyWith({String? title, String? dueDate, bool? isCompleted}) {
    return Task(
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
