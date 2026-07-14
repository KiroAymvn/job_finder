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
import '../../../shared/job_card_widget.dart';

// استدعاء المكونات (Widgets) التي سنقوم بإنشائها

class HomeScreen extends StatelessWidget {
  const HomeScreen(this.userName, {super.key});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeScreenBloc, HomeJobsState>(
          builder: (context, state) {
            final userName=state is HomeJobsSuccess ? state.userName:"User";
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpaces.largeW,
                vertical: AppSpaces.smallH,
              ),
              child: Skeletonizer(
                enabled: state is HomeJobsLoading,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeaderWidget(userName:userName ),
                    Gap(AppSpaces.largeH),

                    Image.asset(AppImages.cover),
                    Gap(AppSpaces.largeH),

                    const FindJobSectionWidget(),
                    Gap(AppSpaces.largeH),

                    const BrowseCategorySectionWidget(),
                    Gap(AppSpaces.largeH),

                    Text('All Jobs', style: Styles.mediumTitle),
                    Gap(16.h),
                    state is HomeJobsSuccess
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.homeEntity.homeDataEntity.length,
                            itemBuilder: (context, index) {
                              final HomeEntity homeEntity = state.homeEntity;
                              return GestureDetector(
                                onTap: () {
                                  GoRouter.of(context).push(
                                    AppRouter.kGetJobBySlugScreen,
                                    extra:
                                        homeEntity!.homeDataEntity[index].slug,
                                  );
                                },
                                child: JobCardWidget(
                                  homeEntity: homeEntity,
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
