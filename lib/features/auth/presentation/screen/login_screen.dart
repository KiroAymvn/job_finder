import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:job_finder/core/params/auth_params.dart';
import 'package:job_finder/core/utils/app_spaces.dart';
import 'package:job_finder/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:job_finder/features/shared/scaffold_message.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../shared/custom_button.dart';
import '../widget/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();

  bool isRememberMe = false; // State for the checkbox

  @override
  void dispose() {
    // Best practice: Dispose controllers to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.read<AuthCubit>().onSuccessAuth(
                context,
                message: "Login Successfully",
              );
            } else if (state is AuthFailed) {
              context.read<AuthCubit>().onSuccessAuth(
                context,
                message: state.errorMessage,
              );
            }
          },
          builder: (context, state) {
            return Skeletonizer(
              enabled: state is AuthLoading,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpaces.largeW,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center,
                  children: [
                    Gap(AppSpaces.largeH * 1.5),

                    // 1. Logo
                    Image.asset(
                      AppImages.logoGreen,
                      height: 50.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 24.h),

                    // 2. Title (RichText)
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Styles.largeTitle,
                        children: [
                          const TextSpan(
                            text: 'Welcome Back to ',
                          ),
                          TextSpan(
                            text: 'NextStep',
                            style: Styles.largeTitle
                                .copyWith(
                                  color: AppColors.kPrimary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Gap(AppSpaces.smallH),

                    // 3. Subtitle
                    Text(
                      'Log in to your NextStep account to continue your job\nsearch, manage applications, and stay updated with\nthe latest job opportunities.',
                      textAlign: TextAlign.center,
                      style: Styles.body.copyWith(
                        height: 1.5,
                      ),
                    ),
                    Gap(AppSpaces.largeH),

                    // 4. Form Fields
                    CustomTextField(
                      controller: emailController,
                      label: 'Email',
                      keyboardType:
                          TextInputType.emailAddress,
                    ),
                    CustomTextField(
                      controller: passwordController,
                      label: 'Password',
                      isPassword: true,
                    ),

                    // Password Helper Text
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 4.h,
                          bottom: 8.h,
                        ),
                        child: Text(
                          'Password must be at least 8 characters long',
                          style: Styles.body?.copyWith(
                            color: AppColors.kGrey99,
                            // Assuming a grey color exists
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),

                    // 5. Remember Me & Forgot Password Row
                    Row(
                      children: [
                        SizedBox(
                          height: 24.h,
                          width: 24.w,
                          child: Checkbox(
                            value: isRememberMe,
                            onChanged: (value) {
                              setState(() {
                                isRememberMe =
                                    value ?? false;
                              });
                            },
                            activeColor: AppColors.kPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                    4.r,
                                  ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Remember me',
                          style: Styles.body?.copyWith(
                            color: AppColors.kGrey99,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            // TODO: Navigate to Forgot Password Screen
                          },
                          child: Text(
                            'Forgot Password ?',
                            style: Styles.smallTitle
                                ?.copyWith(
                                  color: AppColors.kPrimary,
                                ),
                          ),
                        ),
                      ],
                    ),

                    Gap(AppSpaces.mediumH),

                    // 6. Login Button
                    CustomButton(
                      onPressed: () {
                        LoginParams loginParams =
                            LoginParams(
                              email:
                                  "johnn.doe@example.com",
                              password: "password123",
                            );
                        context
                            .read<AuthCubit>()
                            .loginFaileOrSuccess(
                              loginParams: loginParams,
                            );
                      },
                      text: "login",
                    ),

                    SizedBox(height: 24.h),

                    // 7. Footer (Sign Up navigation)
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: Styles.body?.copyWith(
                            color: AppColors.kGrey99,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(
                              context,
                            ).pushReplacement("/register");
                          },
                          child: Text(
                            'Sign Up',
                            style: Styles.smallTitle
                                ?.copyWith(
                                  color: AppColors.kPrimary,
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
