import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_radius.dart';
import '../../core/utils/images.dart';
import '../../core/utils/text_styles.dart';
import '../home/domain/entities/home_entity.dart';

class JobCardWidget extends StatelessWidget {
  JobCardWidget({
    super.key,
    required this.homeEntity,
    required this.index,
  });

  final HomeEntity? homeEntity;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isSavedNotifier =
        ValueNotifier<bool>(false);
    final item = homeEntity?.homeDataEntity[index];
    final userPostedBy = item?.userPostedByEntity;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(
              AppRadius.largeR,
            ),
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
                    child: userPostedBy!.imageUrl != null
                        ? Image.network(
                            userPostedBy.imageUrl
                                .toString(),
                          )
                        : Image.asset(
                            AppImages.jobSearch,
                          ), // Placeholder for Google Logo
                  ),
                  Gap(12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          item!.title,
                          style: Styles.mediumTitle,
                        ),
                        Text(
                          userPostedBy!.fullName,
                          style: Styles.smallBody,
                        ),
                      ],
                    ),
                  ),
                  // Bookmark Button managed by ValueNotifier
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      item.isFavorite
                          ? CupertinoIcons.bookmark_fill
                          : CupertinoIcons.bookmark,
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
                        Icon(
                          CupertinoIcons.location,
                          color: AppColors.kBlack,
                          size: 16.sp,
                        ),
                        Gap(4.w),
                        Flexible(
                          child: FittedBox(
                            child: Text(
                              item.location,
                              style: Styles.body?.copyWith(
                                color: AppColors.kBlack,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow
                                  .ellipsis, // يقص النص الزائد ويضع ...
                            ),
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
                        "${item.salaryRange.replaceRange(0, item.salaryRange.indexOf("-") + 1, " ")}/Month",
                        style: Styles.mediumTitle?.copyWith(
                          color: AppColors.kPrimary,
                          fontSize: 16.sp,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
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
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.kPrimary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(
          AppRadius.smallR,
        ),
      ),
      child: Text(
        title,
        style: Styles.smallBody?.copyWith(
          color: AppColors.kPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
