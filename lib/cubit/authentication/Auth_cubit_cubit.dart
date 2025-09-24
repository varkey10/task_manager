import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/api/api_calls';
import 'package:task_manager/cubit/authentication/Auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final NetworkRepository _network = NetworkRepository();
  AuthCubit() : super(AuthInitial());

  final username = TextEditingController();
  final emailCtrl = TextEditingController(text: "eve.holt@reqres.in");
  final passCtrl = TextEditingController(text: "pass@123");

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
        if (response != null && response["token"] != null) {
          final token = response["token"];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", token);
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

  Future<void> checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token != null) {
      emit(AuthLoggedIn("persisted_user@test.com", "pass@123"));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    emit(AuthInitial());
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
}
