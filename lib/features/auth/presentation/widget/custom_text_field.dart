import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController controller;

  // 1. تعريف ValueNotifier داخل الـ StatelessWidget
  late final ValueNotifier<bool> isObscureNotifier;

  CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  }) {
    // 2. إعطاء القيمة الابتدائية بناءً على نوع الحقل (كلمة مرور أم لا)
    isObscureNotifier = ValueNotifier<bool>(isPassword);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isObscureNotifier,
      builder: (context, isObscure, child) {
        return TextFormField(
          controller: controller,
          obscureText: isObscure, // الاعتماد على قيمة الـ ValueNotifier
          keyboardType: keyboardType,
          style: Styles.smallTitle,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: Styles.body?.copyWith(
              color: AppColors.kPrimary,
              fontWeight: FontWeight.bold,
            ),
            hintStyle: Styles.smallTitle,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),

            // 4. تحديث الأيقونة وتغيير القيمة بدون setState
            suffixIcon: isPassword
                ? IconButton(
              onPressed: () {
                // عكس القيمة الحالية مباشرة
                isObscureNotifier.value = !isObscureNotifier.value;
              },
              icon: Icon(
                isObscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                color: AppColors.kPrimary,
              ),
            )
                : null,

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
        );
      },
    );
  }
}