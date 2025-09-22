// lib/main.dart
import 'package:flutter/material.dart';
import 'package:task_manager/cubit/Auth_cubit_cubit.dart';
import 'package:task_manager/cubit/task_cubit.dart';
import 'package:task_manager/screen/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
