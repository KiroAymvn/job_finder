import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_radius.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/text_styles.dart';
import '../bloc/stats/stats_bloc.dart';

class FindJobSectionWidget extends StatelessWidget {
  const FindJobSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        final isLoading = state is StatsLoading || state is StatsInitial;
        final totalJobs =
            state is StatsSuccess ? state.statsEntity.totalJobs : null;

        // Format counts
        String remoteCount = isLoading
            ? '...'
            : totalJobs != null
                ? '${totalJobs.fullTime + totalJobs.partTime + totalJobs.freelance}'
                : '--';
        String partTimeCount = isLoading
            ? '...'
            : totalJobs != null
                ? '${totalJobs.partTime}'
                : '--';
        String fullTimeCount = isLoading
            ? '...'
            : totalJobs != null
                ? '${totalJobs.fullTime}'
                : '--';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Find Your Job', style: Styles.mediumTitle),
            Gap(16.h),
            Row(
              children: [
                // Left Large Card (Remote / Total)
                Expanded(
                  child: _buildJobTypeCard(
                    imageName: AppImages.remoteJob,
                    count: remoteCount,
                    title: 'Remote Job',
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
                        count: partTimeCount,
                        title: 'Part Time',
                        height: 82.h,
                      ),
                      Gap(16.h),
                      _buildJobTypeCard(
                        imageName: AppImages.fullTimeJob,
                        count: fullTimeCount,
                        title: 'Full Time',
                        height: 82.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildJobTypeCard({
    required String imageName,
    required String count,
    required String title,
    required double height,
    bool isLarge = false,
  }) {
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
                Image.asset(imageName, height: 40.h),
                Gap(16.h),
                Text(count, style: Styles.largeTitle),
                Gap(4.h),
                Text(title, style: Styles.body),
              ],
            )
          : Row(
              children: [
                Image.asset(imageName, height: 30.h),
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
