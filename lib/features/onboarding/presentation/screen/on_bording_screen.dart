import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:job_finder/core/utils/app_colors.dart';
import 'package:job_finder/core/utils/app_spaces.dart';
import 'package:job_finder/core/utils/images.dart';
import 'package:job_finder/core/utils/text_styles.dart';
import 'package:job_finder/features/shared/custom_button.dart';

class OnBoardingModel {
  final String image;
  final String titleText;
  final String bodyText;

  OnBoardingModel({
    required this.image,
    required this.titleText,
    required this.bodyText,
  });
}

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

  final List<OnBoardingModel> _onBoardingItems = [
    OnBoardingModel(
      image: AppImages.onboarding1,
      titleText: "Search Job Easier\nand More Effective",
      bodyText: "Make your experience of searching job\nmore easier and more effective",
    ),
    OnBoardingModel(
      image: AppImages.onboarding2,
      titleText: "Find Your Dream\nJob Quickly",
      bodyText: "Explore thousands of job opportunities\nwith just a few clicks.",
    ),
    OnBoardingModel(
      image: AppImages.onboarding3,
      titleText: "Build Your Career\nWith Us",
      bodyText: "Get connected with top companies\nand start your professional journey.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpaces.largeW, vertical: AppSpaces.largeH),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onBoardingItems.length,
                  onPageChanged: (index) {
                    _currentIndexNotifier.value = index;
                  },
                  itemBuilder: (context, index) {
                    return _buildPageContent(_onBoardingItems[index]);
                  },
                ),
              ),

              ValueListenableBuilder<int>(
                valueListenable: _currentIndexNotifier,
                builder: (context, currentIndex, child) {
                  return Column(
                    children: [
                      _buildIndicators(currentIndex),
                      Gap(AppSpaces.largeH),

                      CustomButton(
                        onPressed: () {
                          if (currentIndex == _onBoardingItems.length - 1) {
                            GoRouter.of(context).pushReplacement("/login");
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        text: currentIndex == _onBoardingItems.length - 1 ? "Get Started" : "Next",
                      ),

                      Gap(AppSpaces.smallH),

                      if (currentIndex != _onBoardingItems.length - 1)
                        CustomButton(
                          onPressed: () {
                            GoRouter.of(context).pushReplacement("/login");
                          },
                          text: "Skip",
                          buttonColor: AppColors.kPrimary.withOpacity(0.1),
                          textColor: AppColors.kPrimary,
                        )
                      else
                        SizedBox(height: 52.h),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent(OnBoardingModel item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(item.image,  fit: BoxFit.contain),
        Gap(AppSpaces.largeH),
        Text(
          item.titleText,
          style: Styles.largeTitle,
          textAlign: TextAlign.center,
        ),
        Gap(AppSpaces.smallH),
        Text(
          item.bodyText,
          style: Styles.body?.copyWith(color: AppColors.kGrey99, height: 1.5),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildIndicators(int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _onBoardingItems.length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.only(right: 6.w),
          height: 5.h,
          width: 50.w ,
          decoration: BoxDecoration(
            color: currentIndex == index ? AppColors.kPrimary : AppColors.kGreyDE,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }
}