// lib/main.dart
import 'package:flutter/material.dart';
import 'package:task_manager/cubit/authentication/Auth_cubit_cubit.dart';
import 'package:task_manager/cubit/task/task_cubit.dart';
import 'package:task_manager/screen/authentication/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/screen/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => TaskCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
