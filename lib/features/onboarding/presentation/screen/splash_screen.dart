import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/core/utils/text_styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          style: Styles.largeTitle,
        ),
      ),
    );
  }
}
