// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubit/Auth_cubit_cubit.dart';
import 'package:task_manager/cubit/task_cubit_state.dart';
import 'package:task_manager/screen/dashboard.dart';
import 'package:task_manager/screen/register.dart';
import 'package:task_manager/widgets/CustomTextfield.dart';

class LoginScreen extends StatelessWidget {
  final username = TextEditingController();
  final emailCtrl = TextEditingController(text: "eve.holt@reqres.in");
  final passCtrl = TextEditingController(text: "pass@123");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedIn) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const TasksDashboard()),
              );
            });
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text("Welcome back",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                CustomTextField(
                    label: "Email",
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress),
                CustomTextField(
                    label: "Password", controller: passCtrl, isPassword: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Login"),
                  onPressed: () {
                    context
                        .read<AuthCubit>()
                        .login(emailCtrl.text, passCtrl.text, username.text);
                  },
                ),
                TextButton(
                  child: const Text("Don’t have an account? Register"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegisterScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
