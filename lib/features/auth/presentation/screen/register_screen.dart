import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:job_finder/core/params/auth_params.dart';
import 'package:job_finder/core/utils/app_spaces.dart';
import 'package:job_finder/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:job_finder/features/shared/custom_button.dart';
import 'package:job_finder/features/shared/scaffold_message.dart';
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
  TextEditingController nameController =
      TextEditingController();
  TextEditingController emailController =
      TextEditingController();
  TextEditingController mobileController =
      TextEditingController();
  TextEditingController addressController =
      TextEditingController();
  TextEditingController passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite, //[cite: 2]
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              scaffoldMessengerError(
                context,
                "Success reg with name ${state.userEntity.dataEntity.name}",
                color: AppColors.kPrimary,
              );
            } else if (state is AuthFailed) {
              scaffoldMessengerError(
                context,
                state.errorMessage,
                color: AppColors.kRed,
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
                    Gap(AppSpaces.largeH),

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
                      ), //
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

                    Gap(AppSpaces.mediumH),

                    // 5. Register Button
                    CustomButton(
                      onPressed: () {
                        RegisterParams registerParams =
                            RegisterParams(
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
                              registerParams:
                                  registerParams,
                            );
                      },
                      text: "Register",
                    ),

                    SizedBox(height: 24.h),

                    // 6. Footer (Login navigation)
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a member? ',
                          style: Styles.body?.copyWith(
                            color: AppColors.kGrey99,
                          ), //[cite: 2]
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(
                              context,
                            ).pushReplacement("/login");
                          },
                          child: Text(
                            'Login',
                            // ملاحظة: في التصميم مكتوب Register، لكن برمجياً ومنطقياً يجب أن تكون Login
                            style: Styles.smallTitle
                                ?.copyWith(
                                  color: AppColors.kPrimary,
                                ), //
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
