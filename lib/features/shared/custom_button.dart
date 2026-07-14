import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/text_styles.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.buttonColor = AppColors.kPrimary,
    this.textColor = AppColors.kWhite,
    required this.onPressed,
    required this.text,
    this.isDisable = false,
  });

  final Function onPressed;
  Color buttonColor;
  final String text;
  Color textColor;
  bool isDisable;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: () {
          isDisable ? null : onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisable ? AppColors.kGrey : buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: Styles.buttonText.copyWith(
            color: isDisable ? AppColors.kGreyDE : textColor,
          ),
        ),
      ),
    );
  }
}
