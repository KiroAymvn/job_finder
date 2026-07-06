import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_radius.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/text_styles.dart';

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
