import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_radius.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/text_styles.dart';

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
