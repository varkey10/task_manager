// lib/cubits/task_state.dart
import '../../api/models/task_model.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  TaskLoaded(this.tasks);
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}

class TaskFilterUpdated extends TaskState {
  final String status;
  final String priority;

  TaskFilterUpdated({required this.status, required this.priority});
}

class TaskDeleted extends TaskState {}
