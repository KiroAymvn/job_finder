// features/home/presentation/screen/home_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/app_colors.dart';
import 'package:job_finder/core/utils/app_spaces.dart';

import '../../../../core/utils/app_radius.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/text_styles.dart';

// استدعاء المكونات (Widgets) التي سنقوم بإنشائها


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpaces.largeW,
            vertical: AppSpaces.smallH,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeaderWidget(),
              Gap(AppSpaces.largeH),

              const SearchBarWidget(),
              Gap(AppSpaces.largeH),

              const PromoBannerWidget(),
              Gap(AppSpaces.largeH),

              const FindJobSectionWidget(),
              Gap(AppSpaces.largeH),

              const BrowseCategorySectionWidget(),
              Gap(AppSpaces.largeH),

              const SuggestedJobCardWidget(),
              Gap(AppSpaces.largeH * 2), // مسافة إضافية لتجنب شريط التنقل السفلي
            ],
          ),
        ),
      ),
    );
  }
}
// features/home/presentation/widgets/home_header_widget.dart


class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // User Avatar
            CircleAvatar(
              radius: 25.r,
              backgroundColor: AppColors.kGreyF3,
              backgroundImage: const AssetImage(AppImages.profile), // تأكد من وجود الصورة
            ),
            Gap(12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome back !', style: Styles.smallBody),
                Text('Laith Mahdi 👋', style: Styles.mediumTitle),
              ],
            ),
          ],
        ),
        // Notification Icon with Badge
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.kGreyF3,
            borderRadius: BorderRadius.circular(AppRadius.smallR),
          ),
          child: Icon(
            CupertinoIcons.bell,
            color: AppColors.kBlack,
            size: 20.sp,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------

// features/home/presentation/widgets/search_bar_widget.dart
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(AppRadius.mediumR),
        border: Border.all(color: AppColors.kGreyEE),
        boxShadow: [
          BoxShadow(
            color: AppColors.kBlack.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(CupertinoIcons.search, color: AppColors.kPrimary, size: 24.sp),
          Gap(12.w),
          Expanded(
            child: Text(
              'Enter job location',
              style: Styles.body?.copyWith(color: AppColors.kGreyDE),
            ),
          ),
          Icon(Icons.tune, color: AppColors.kPrimary, size: 24.sp), // Filter Icon
        ],
      ),
    );
  }
}

// ---------------------------------------------------------

// features/home/presentation/widgets/promo_banner_widget.dart
class PromoBannerWidget extends StatelessWidget {
  const PromoBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.kPrimary,
        borderRadius: BorderRadius.circular(AppRadius.mediumR),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's find a new job\nsuitable for you",
                  style: Styles.mediumTitle?.copyWith(
                    color: AppColors.kWhite,
                    height: 1.4,
                  ),
                ),
                Gap(16.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.kWhite.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppRadius.smallR),
                  ),
                  child: Text(
                    'See More',
                    style: Styles.smallTitle?.copyWith(color: AppColors.kWhite),
                  ),
                ),
              ],
            ),
          ),
          // يمكنك استبدال الأيقونة بصورة المرأة الموجودة في التصميم إذا توفرت في الـ Assets
          Expanded(
            flex: 1,
            child: Icon(CupertinoIcons.briefcase, color: AppColors.kWhite, size: 80.sp),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------

// features/home/presentation/widgets/find_job_section_widget.dart
class FindJobSectionWidget extends StatelessWidget {
  const FindJobSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Find Your Job', style: Styles.mediumTitle),
        Gap(16.h),
        Row(
          children: [
            // Left Large Card (Remote Job)
            Expanded(
              child: _buildJobTypeCard(
                icon: CupertinoIcons.device_laptop,
                count: "74.5K",
                title: "Remote Job",
                height: 180.h,
                isLarge: true,
              ),
            ),
            Gap(16.w),
            // Right Column with two small cards
            Expanded(
              child: Column(
                children: [
                  _buildJobTypeCard(
                    icon: CupertinoIcons.briefcase,
                    count: "33.8K",
                    title: "Part Time",
                    height: 82.h,
                  ),
                  Gap(16.h),
                  _buildJobTypeCard(
                    icon: CupertinoIcons.person_solid,
                    count: "23.8K",
                    title: "Full Time",
                    height: 82.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildJobTypeCard({required IconData icon, required String count, required String title, required double height, bool isLarge = false}) {
    return Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(AppRadius.mediumR),
        border: Border.all(color: AppColors.kGreyEE),
      ),
      child: isLarge
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.kBlue, size: 40.sp),
          Gap(16.h),
          Text(count, style: Styles.largeTitle),
          Gap(4.h),
          Text(title, style: Styles.body),
        ],
      )
          : Row(
        children: [
          Icon(icon, color: AppColors.kBlue, size: 30.sp),
          Gap(12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(count, style: Styles.mediumTitle),
              Text(title, style: Styles.smallBody),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------

// features/home/presentation/widgets/browse_category_section_widget.dart
class BrowseCategorySectionWidget extends StatelessWidget {
  const BrowseCategorySectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Browse by category', style: Styles.mediumTitle),
        Gap(16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCategoryItem(CupertinoIcons.building_2_fill, "Company", isActive: true),
            _buildCategoryItem(CupertinoIcons.briefcase_fill, "Part Time"),
            _buildCategoryItem(CupertinoIcons.person_2_fill, "Full Time"),
            _buildCategoryItem(CupertinoIcons.person_crop_circle, "Freelancer"),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryItem(IconData icon, String title, {bool isActive = false}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isActive ? AppColors.kPrimary.withOpacity(0.1) : AppColors.kWhite,
            borderRadius: BorderRadius.circular(AppRadius.mediumR),
            border: isActive ? null : Border.all(color: AppColors.kGreyEE),
          ),
          child: Icon(
            icon,
            color: isActive ? AppColors.kPrimary : AppColors.kBlue,
            size: 28.sp,
          ),
        ),
        Gap(8.h),
        Text(
          title,
          style: Styles.smallBody?.copyWith(
            color: isActive ? AppColors.kPrimary : AppColors.kBlack,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------

// features/home/presentation/widgets/suggested_job_card_widget.dart
class SuggestedJobCardWidget extends StatelessWidget {
  const SuggestedJobCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدام ValueNotifier لإدارة حالة زر الحفظ (Bookmark) بدون setState
    final ValueNotifier<bool> isSavedNotifier = ValueNotifier<bool>(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Suggested Job', style: Styles.mediumTitle),
        Gap(16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(AppRadius.largeR),
            border: Border.all(color: AppColors.kGreyEE),
            boxShadow: [
              BoxShadow(
                color: AppColors.kBlack.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Logo, Title, Bookmark
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColors.kGreyF3,
                    child: const Text("G", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)), // Placeholder for Google Logo
                  ),
                  Gap(12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ui Designer', style: Styles.mediumTitle),
                        Text('Google', style: Styles.smallBody),
                      ],
                    ),
                  ),
                  // Bookmark Button managed by ValueNotifier
                  ValueListenableBuilder<bool>(
                    valueListenable: isSavedNotifier,
                    builder: (context, isSaved, child) {
                      return GestureDetector(
                        onTap: () => isSavedNotifier.value = !isSavedNotifier.value,
                        child: Icon(
                          isSaved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                          color: AppColors.kPrimary,
                          size: 24.sp,
                        ),
                      );
                    },
                  ),
                ],
              ),
              Gap(16.h),

              // Tags: Design, Full Time
              Row(
                children: [
                  _buildTag("Design"),
                  Gap(8.w),
                  _buildTag("Full Time"),
                ],
              ),
              Gap(16.h),

              // Footer: Location & Salary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.location, color: AppColors.kBlack, size: 16.sp),
                      Gap(4.w),
                      Text('California', style: Styles.body?.copyWith(color: AppColors.kBlack)),
                    ],
                  ),
                  Text('\$15/Mo', style: Styles.mediumTitle),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.kPrimary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppRadius.smallR),
      ),
      child: Text(
        title,
        style: Styles.smallBody?.copyWith(color: AppColors.kPrimary, fontWeight: FontWeight.bold),
      ),
    );
  }
}
