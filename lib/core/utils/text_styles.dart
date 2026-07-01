import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_finder/core/utils/app_colors.dart';

abstract class Styles {

  //Titles
  static final smallTitle = TextStyle(
    fontWeight: FontWeight.w600,
    color: AppColors.kBlack,
    fontSize: 14.sp,
    fontFamily: "DMSans",
  );
  static final mediumTitle = TextStyle(
    fontWeight: FontWeight.w600,
    color: AppColors.kBlack,
    fontSize: 16.sp,
    fontFamily: "DMSans",
  );

  static final largeTitle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.kBlack,
    fontSize: 20.sp,
    fontFamily: "DMSans",
  );

  //BODY
  static final smallBody = TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.kGrey99,
    fontSize: 10.sp,
    fontFamily: "DMSans",
  );

  static final body = TextStyle(
    fontWeight: FontWeight.normal,
    color: AppColors.kGrey,
    fontSize: 12.sp,
    fontFamily: "DMSans",
  );

  static final buttonText = TextStyle(
    fontWeight: FontWeight.w600,
    color: AppColors.kWhite,
    fontSize: 16.sp,
    fontFamily: "DMSans",
  );

}