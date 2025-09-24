import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:task_manager/cubit/authentication/Auth_cubit_cubit.dart';
import 'package:task_manager/cubit/authentication/Auth_cubit_state.dart';
import 'package:task_manager/screen/authentication/login_page.dart';
import 'package:task_manager/screen/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startTimer();
    });
  }

  startTimer() {
    var duration = const Duration(
      seconds: 4,
    );
    return Timer(duration, () {
      Timer(const Duration(seconds: 3), () async {
        final authCubit = context.read<AuthCubit>();
        await authCubit.checkSession();

        final state = authCubit.state;
        if (state is AuthLoggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const TasksDashboard()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        }
      });
    });
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => LoginScreen(),
    //       ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: initialLoader(),
    );
  }
}

Widget initialLoader() {
  return Center(
    child: Container(
      child: Lottie.network(
        "https://assets2.lottiefiles.com/packages/lf20_usmfx6bp.json",
      ),
    ),
  );
}
