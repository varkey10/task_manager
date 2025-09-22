import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/api/api_calls/api_calls.dart';
import 'package:task_manager/cubit/task_cubit_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final NetworkRepository _network = NetworkRepository();
  AuthCubit() : super(AuthInitial());

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  List<Map<String, dynamic>> usersList = [];

  Future<void> login(String email, String password, String name) async {
    emit(AuthLoading());
    try {
      if (email.isEmpty || password.isEmpty) {
        emit(AuthError("Field cannot be empty"));
      } else {
        var param = {
          "email": email,
          "password": password,
        };
        final response = await _network.userLogin(param);
        print("response $response");
        if (response != null) {
          emit(AuthLoggedIn(email, password));
          getUsersList();
        } else {
          emit(AuthError("Login failed. Please try again."));
        }
      }
    } catch (e) {
      print(e);
      emit(AuthError(e.toString()));
    }
  }

  void register(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        var param = {
          "username": name,
          "email": email,
          "password": password,
        };
        final respnse = await _network.userRegisteration(param);
        if (respnse != null) {
          emit(AuthRegisterIn(email, password, name));
        }
      } else {
        emit(AuthError("Please fill all fields"));
      }
    } catch (e) {}
  }

  Future<void> getUsersList() async {
    emit(AuthLoading());
    try {
      final response = await _network.getUsers();
      if (response != null) {
        usersList = List<Map<String, dynamic>>.from(response["data"]);
      } else {
        emit(AuthError("Failed to load users"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void logout() {
    emit(AuthInitial());
  }
}
