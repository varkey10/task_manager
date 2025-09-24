// lib/screens/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubit/authentication/Auth_cubit_cubit.dart';
import 'package:task_manager/screen/authentication/login_page.dart';
import 'package:task_manager/widgets/CustomTextfield.dart';
import '../../core/core_ui.dart';

class RegisterScreen extends StatelessWidget {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController(text: "eve.holt@reqres.in");
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text("Create your account",
                    style: CommonTextStyleinAuth().heading),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child:
                      CustomTextField(label: "Full Name", controller: nameCtrl),
                ),
                CustomTextField(
                    label: "Email",
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress),
                CustomTextField(
                    label: "Password", controller: passCtrl, isPassword: true),
                CustomTextField(
                    label: "Confirm Password",
                    controller: confirmCtrl,
                    isPassword: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: Loginbutton().buttonStyle,
                  child: const Text("Register"),
                  onPressed: () {
                    context.read<AuthCubit>().register(
                          nameCtrl.text,
                          emailCtrl.text,
                          passCtrl.text,
                        );
                  },
                ),
                TextButton(
                  child: const Text("Already have an account? Login"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
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
