import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';

import '../../../../core/utils/images.dart';
import '../../../../core/utils/text_styles.dart';
import '../widget/custom_text_field.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController mobileController =TextEditingController();
  TextEditingController addressController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite, //[cite: 2]
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),

              // 1. Logo
              Image.asset(
                AppImages.logoGreen, //[cite: 5]
                height: 50.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 24.h),

              // 2. Title (RichText for multiple colors)
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Styles.largeTitle, //
                  children: [
                    const TextSpan(text: 'Create Your '),
                    TextSpan(
                      text: 'NextStep',
                      style: Styles.largeTitle?.copyWith(color: AppColors.kPrimary),
                    ),
                    const TextSpan(text: ' Account'),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              // 3. Subtitle
              Text(
                'Join NextStep to find your perfect job.\nCreate an account for personalized matches\nand career resources.',
                textAlign: TextAlign.center,
                style: Styles.body?.copyWith(height: 1.5), //
              ),
              SizedBox(height: 32.h),

              // 4. Form Fields
               CustomTextField(
                 controller: emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
               CustomTextField(
                 controller: nameController,
                label: 'Name',
              ),
               CustomTextField(
                 controller: mobileController,
                label: 'Mobile Number',
                keyboardType: TextInputType.phone,
              ),
               CustomTextField(
                 controller: addressController,
                label: 'Address',
              ),
               CustomTextField(
                 controller: passwordController,
                label: 'Password',
                isPassword: true,
              ),
               CustomTextField(
                 controller: passwordController,
                label: 'Confirm Password',
                isPassword: true,
              ),

              SizedBox(height: 16.h),

              // 5. Register Button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Handle Register Logic via Cubit
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kPrimary, //[cite: 2]
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Register',
                    style: Styles.buttonText, //
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // 6. Footer (Login navigation)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a member? ',
                    style: Styles.body?.copyWith(color: AppColors.kGrey99), //[cite: 2]
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to Login
                    },
                    child: Text(
                      'Login', // ملاحظة: في التصميم مكتوب Register، لكن برمجياً ومنطقياً يجب أن تكون Login
                      style: Styles.smallTitle?.copyWith(color: AppColors.kPrimary), //
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
