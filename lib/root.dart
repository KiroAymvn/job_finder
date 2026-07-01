import 'package:flutter/material.dart';
import 'package:job_finder/core/utils/app_colors.dart';
import 'package:job_finder/features/onboarding/presentation/screen/splash_screen.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.kPrimary
        ),
      ),
    );
  }
}
