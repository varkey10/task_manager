// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubit/authentication/Auth_cubit_cubit.dart';
import 'package:task_manager/cubit/authentication/Auth_cubit_state.dart';
import 'package:task_manager/screen/dashboard.dart';
import 'package:task_manager/screen/authentication/register.dart';
import 'package:task_manager/widgets/CustomTextfield.dart';

import '../../core/core_ui.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }
          if (state is AuthLoggedIn) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const TasksDashboard(),
                ),
              );
            });
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                   Text("Welcome back",
                      style:CommonTextStyleinAuth().heading
                          ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CustomTextField(
                        label: "Email",
                        controller: authCubit.emailCtrl,
                        keyboardType: TextInputType.emailAddress),
                  ),
                  CustomTextField(
                      label: "Password",
                      controller: authCubit.passCtrl,
                      isPassword: true),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: Loginbutton().buttonStyle,
                    child: const Text("Login"),
                    onPressed: () {
                      context.read<AuthCubit>().login(authCubit.emailCtrl.text,
                          authCubit.passCtrl.text, authCubit.username.text);
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
      ),
    );
  }
}
