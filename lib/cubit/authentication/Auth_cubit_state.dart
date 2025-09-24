// lib/cubits/auth_state.dart
import 'package:task_manager/api/models/task_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthRegisterIn extends AuthState {
  final String email;
  final String password;
  final String name;
  AuthRegisterIn(this.email, this.password, this.name);
}

class AuthLoggedIn extends AuthState {
  final String email;
  final String password;

  AuthLoggedIn(
    this.email,
    this.password,
  );
}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}


class TaskLoaded extends AuthState {
  final List<Task> tasks;
  TaskLoaded(this.tasks);
}
