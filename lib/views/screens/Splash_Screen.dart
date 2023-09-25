import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/My_Routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      Duration(seconds: 4),
      (timer) {
        Navigator.of(context).pushReplacementNamed(MyRoutes.home);
        timer.cancel();
      },
    );
    return Scaffold(
      body: Center(
        child: Container(
          // color: theme_1,

          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Music (3).gif',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
