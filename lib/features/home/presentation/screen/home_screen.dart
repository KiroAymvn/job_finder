// features/home/presentation/screen/home_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:job_finder/core/utils/app_colors.dart';
import 'package:job_finder/core/utils/app_router.dart';
import 'package:job_finder/core/utils/app_spaces.dart';
import 'package:job_finder/features/home/domain/entities/home_entity.dart';
import 'package:job_finder/features/home/presentation/bloc/home/home_jobs_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/app_radius.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/text_styles.dart';
import '../widget/browse_category_section.dart';
import '../widget/find_job_selection.dart';
import '../widget/home_header_widget.dart';
import '../widget/suggested_job_card.dart';

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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    HomeHeaderWidget(userName: userName),
                    Gap(AppSpaces.largeH),

                    Image.asset(AppImages.cover),
                    Gap(AppSpaces.largeH),

                    const FindJobSectionWidget(),
                    Gap(AppSpaces.largeH),

                    const BrowseCategorySectionWidget(),
                    Gap(AppSpaces.largeH),

                    Text(
                      'All Jobs',
                      style: Styles.mediumTitle,
                    ),
                    Gap(16.h),
                    state is HomeJobsSuccess
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics:
                                NeverScrollableScrollPhysics(),
                            itemCount: state
                                .homeEntity
                                .homeDataEntity
                                .length,
                            itemBuilder: (context, index) {
                              final HomeEntity homeEntity =
                                  state.homeEntity;
                              return GestureDetector(
                                onTap: () {
                                  GoRouter.of(context).push(
                                    AppRouter
                                        .kGetJobBySlugScreen,
                                    extra: homeEntity!
                                        .homeDataEntity[index]
                                        .slug,
                                  );
                                },
                                child:
                                    SuggestedJobCardWidget(
                                      homeEntity:
                                          homeEntity,
                                      index: index,
                                    ),
                              );
                            },
                          )
                        : SizedBox.shrink(),
                    Gap(AppSpaces.largeH * 2),
                    // مسافة إضافية لتجنب شريط التنقل السفلي
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

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(
          AppRadius.mediumR,
        ),
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
          Icon(
            CupertinoIcons.search,
            color: AppColors.kPrimary,
            size: 24.sp,
          ),
          Gap(12.w),
          Expanded(
            child: Text(
              'Enter job location',
              style: Styles.body?.copyWith(
                color: AppColors.kGreyDE,
              ),
            ),
          ),
          Icon(
            Icons.tune,
            color: AppColors.kPrimary,
            size: 24.sp,
          ), // Filter Icon
        ],
      ),
    );
  }
}
