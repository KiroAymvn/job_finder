import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // استخدمنا المكتبة هنا
import 'package:go_router/go_router.dart';
import 'package:job_finder/core/utils/app_colors.dart';
import 'package:job_finder/core/utils/images.dart';
import 'package:job_finder/features/auth/presentation/screen/register_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Alignment _arrowAlignment = Alignment.centerLeft;


  Future<void> startApp() async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      setState(() {
        _arrowAlignment = Alignment.centerRight;
      });
    }


    await Future.delayed(const Duration(milliseconds: 2500));

    if (mounted) {
      GoRouter.of(context).pushReplacement("/register");
    }
  }



  @override
  void initState() {
    super.initState();

    startApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      body: Stack(
        children: [
          // الشعار في المنتصف
          Center(
            child: Image.asset(
              AppImages.logoWhite,
              width: 138.57.w,
            ),
          ),

          AnimatedAlign(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeOutBack,
            alignment: _arrowAlignment,
            child: Image.asset(
              AppImages.arrow,
              width: 150.w,
              height: 133.h,
            ),
          ),
        ],
      ),
    );
  }
}
