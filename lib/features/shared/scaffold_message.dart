import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_finder/core/utils/app_colors.dart';

import '../../core/utils/text_styles.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
scaffoldMessengerError(
  BuildContext context,
  String errorMessage, {
  Color? color,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      padding: EdgeInsetsGeometry.all(8.sp),
      margin: EdgeInsets.all(50.sp),
      elevation: 10.h,
      behavior: SnackBarBehavior.floating,
      clipBehavior: Clip.none,
      content: Text(
        errorMessage,
        style: Styles.mediumTitle.copyWith(color: AppColors.kWhite),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color ?? Colors.red,
    ),
  );
}
