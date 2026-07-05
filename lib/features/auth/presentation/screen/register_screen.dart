import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:job_finder/core/params/auth_params.dart';
import 'package:job_finder/core/utils/app_spaces.dart';
import 'package:job_finder/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:job_finder/features/shared/custom_button.dart';

// Note: scaffold_message.dart is no longer used here directly since onSuccessAuth handles it, but kept the import if needed elsewhere.
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/app_colors.dart';

import '../../../../core/utils/images.dart';
import '../../../../core/utils/text_styles.dart';
import '../widget/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Clean Code Practice: Dispose controllers when screen is closed
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    addressController.dispose();
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
            // Updated to match LoginScreen behavior
            if (state is AuthSuccess) {
              context.read<AuthCubit>().onSuccessAuth(
                  context,
                  message: "New account is created successfully",
                  userName: state.userEntity.dataEntity.name

              );
            } else if (state is AuthFailed) {
              context.read<AuthCubit>().onFailureAuth(
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
                  crossAxisAlignment: CrossAxisAlignment
                      .center,
                  children: [
                    Gap(AppSpaces.largeH),

                    // 1. Logo
                    Image.asset(
                      AppImages.logoGreen,
                      height: 50.h,
                      fit: BoxFit.contain,
                    ),
                    Gap(24.h),
                    // Replaced SizedBox with Gap

                    // 2. Title (RichText for multiple colors)
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Styles.largeTitle,
                        children: [
                          const TextSpan(
                            text: 'Create Your ',
                          ),
                          TextSpan(
                            text: 'NextStep',
                            style: Styles.largeTitle
                                ?.copyWith(
                              color: AppColors.kPrimary,
                            ),
                          ),
                          const TextSpan(text: ' Account'),
                        ],
                      ),
                    ),
                    Gap(AppSpaces.smallH),

                    // 3. Subtitle
                    Text(
                      'Join NextStep to find your perfect job.\nCreate an account for personalized matches\nand career resources.',
                      textAlign: TextAlign.center,
                      style: Styles.body?.copyWith(
                        height: 1.5,
                      ),
                    ),
                    Gap(AppSpaces.largeH),

                    // 4. Form Fields
                    CustomTextField(
                      controller: emailController,
                      label: 'Email',
                      keyboardType: TextInputType
                          .emailAddress,
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
                      // Note: You might want to use a separate confirmPasswordController later
                      label: 'Confirm Password',
                      isPassword: true,
                    ),

                    Gap(AppSpaces.mediumH),

                    // 5. Register Button
                    CustomButton(
                      onPressed: () {
                        RegisterParams registerParams = RegisterParams(
                          email: "testss5@gmail.com",
                          password: "123456",
                          fullName: "test",
                          phoneNumber: "+201598843214",
                          address: "cairo",
                          gender: "MAN",
                          role: "USER",
                        );

                        context
                            .read<AuthCubit>()
                            .registerEitherFailureOrUser(
                          registerParams: registerParams,
                        );
                      },
                      text: "Register",
                    ),

                    Gap(24.h),
                    // Replaced SizedBox with Gap

                    // 6. Footer (Login navigation)
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center,
                      children: [
                        Text(
                          'Already a member? ',
                          style: Styles.body?.copyWith(
                            color: AppColors.kGrey99,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter
                                .of(context)
                                .pushReplacement("/login");
                          },
                          child: Text(
                            'Login',
                            style: Styles.smallTitle
                                ?.copyWith(
                              color: AppColors.kPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(40.h),
                    // Replaced SizedBox with Gap
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