import 'package:flutter/material.dart';
import 'package:job_finder/core/utils/app_colors.dart';
import 'package:job_finder/core/utils/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("HOME SCREEN",style: Styles.largeTitle.copyWith(color: AppColors.kBlack),),),
    );
  }
}
