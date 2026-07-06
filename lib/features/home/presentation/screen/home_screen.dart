// features/home/presentation/screen/home_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/app_colors.dart';
import 'package:job_finder/core/utils/app_spaces.dart';
import 'package:job_finder/features/home/domain/entities/home_entity.dart';
import 'package:job_finder/features/home/presentation/bloc/home_jobs_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/app_radius.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/text_styles.dart';

// استدعاء المكونات (Widgets) التي سنقوم بإنشائها


class HomeScreen extends StatelessWidget {
  const HomeScreen(this.userName, {super.key});
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: SafeArea(
        child: BlocBuilder<HomeJobsBloc, HomeJobsState>(
  builder: (context, state) {
    return Skeletonizer(
          enabled: state is HomeJobsLoading,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpaces.largeW,
              vertical: AppSpaces.smallH,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeaderWidget(userName: userName,),
                Gap(AppSpaces.largeH),

                const SearchBarWidget(),
                Gap(AppSpaces.largeH),

                Image.asset(AppImages.cover),
                Gap(AppSpaces.largeH),

                const FindJobSectionWidget(),
                Gap(AppSpaces.largeH),

                const BrowseCategorySectionWidget(),
                Gap(AppSpaces.largeH),

                Text('Suggested Job', style: Styles.mediumTitle),
                Gap(16.h),
                 state is HomeJobsSuccess? ListView.builder(
                   shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     itemCount: state.homeEntity.homeDataEntity.length,
                     itemBuilder: (context, index) {
                       final HomeEntity? homeEntity=state.homeEntity;
                     return SuggestedJobCardWidget(homeEntity: homeEntity,index: index,);
                     },
                 ):SizedBox.shrink(),
                Gap(AppSpaces.largeH * 2), // مسافة إضافية لتجنب شريط التنقل السفلي
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
// features/home/presentation/widgets/home_header_widget.dart


class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key, required this.userName});
  final String userName;

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
                Text('$userName 👋', style: Styles.mediumTitle),
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
                imageName: AppImages.remoteJob,
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
                    imageName: AppImages.partTimeJob,
                    count: "33.8K",
                    title: "Part Time",
                    height: 82.h,
                  ),
                  Gap(16.h),
                  _buildJobTypeCard(
                    imageName: AppImages.fullTimeJob,
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

  Widget _buildJobTypeCard({required String  imageName, required String count, required String title, required double height, bool isLarge = false}) {
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
          Image.asset(imageName,height: 40.h,),
          Gap(16.h),
          Text(count, style: Styles.largeTitle),
          Gap(4.h),
          Text(title, style: Styles.body),
        ],
      )
          : Row(
        children: [
          Image.asset(imageName,height: 30.h,),
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
            _buildCategoryItem(AppImages.company, "Company", isActive: true),
            _buildCategoryItem(AppImages.partTimeJob, "Part Time"),
            _buildCategoryItem(AppImages.fullTimeJob, "Full Time"),
            _buildCategoryItem(AppImages.freelancer, "Freelancer"),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String imageName, String title, {bool isActive = false}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isActive ? AppColors.kPrimary.withOpacity(0.1) : AppColors.kWhite,
            borderRadius: BorderRadius.circular(AppRadius.mediumR),
            border: isActive ? null : Border.all(color: AppColors.kGreyEE),
          ),
          child:    Image.asset(imageName,height: 40.sp,),


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
   SuggestedJobCardWidget({super.key, required this.homeEntity, required this.index});
final HomeEntity? homeEntity;
final int index;
  @override
  Widget build(BuildContext context) {
    // استخدام ValueNotifier لإدارة حالة زر الحفظ (Bookmark) بدون setState
    final ValueNotifier<bool> isSavedNotifier = ValueNotifier<bool>(false);
final item=homeEntity?.homeDataEntity[index];
final userPostedBy=item?.userPostedByEntity;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
  
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
                        Text(item!.title, style: Styles.mediumTitle),
                        Text(userPostedBy!.fullName, style: Styles.smallBody),
                      ],
                    ),
                  ),
                  // Bookmark Button managed by ValueNotifier
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: Icon(
                      item.isFavorite ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                      color: AppColors.kPrimary,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
              Gap(16.h),

              // Tags: Design, Full Time
              Row(
                children: [
                  _buildTag(item.jobType),
                  Gap(8.w),
                  _buildTag(item.jobLevel),
                ],
              ),
              Gap(16.h),

              // Footer: Location & Salary
// Footer: Location & Salary
              Row(
                children: [
                  // 1. استخدام Expanded للموقع لكي يتم قصه (ellipsis) إذا كان طويلاً جداً
                  Expanded(
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.location, color: AppColors.kBlack, size: 16.sp),
                        Gap(4.w),
                        Expanded(
                          child: Text(
                            item.location,
                            style: Styles.body?.copyWith(color: AppColors.kBlack),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // يقص النص الزائد ويضع ...
                          ),
                        ),
                      ],
                    ),
                  ),

                  Gap(12.w),

                  Flexible(
                    flex: 0,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        item.salaryRange,
                        style: Styles.mediumTitle?.copyWith(
                          color: AppColors.kPrimary,
                          fontSize: 16.sp,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),            ],
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
