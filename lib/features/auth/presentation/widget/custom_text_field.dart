import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextInputType keyboardType;
TextEditingController controller = TextEditingController();
   CustomTextField({
    super.key,
    required this.label,
     required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h), // مسافة ثابتة بين الحقول
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: Styles.smallTitle, // لون النص المدخل أسود كما في التصميم
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Styles.body?.copyWith(color: AppColors.kPrimary,fontWeight: FontWeight.bold), // لون الـ Label أخضر[cite: 2]
          hintStyle: Styles.smallTitle, // جعلنا الـ hint يشبه النص المدخل ليطابق الصورة
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

          // إعدادات الحدود (Borders)
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: AppColors.kPrimary, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: AppColors.kPrimary, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: AppColors.kPrimary, width: 1.5),
          ),
        ),
      ),
    );
  }
}