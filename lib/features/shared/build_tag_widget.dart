import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_radius.dart';
import '../../core/utils/text_styles.dart';


class BuildTagWidget extends StatelessWidget {
   BuildTagWidget({
    super.key,
     this.isSelected=true, required this.title
  });
bool isSelected;
final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.kPrimary.withOpacity(0.15):AppColors.kGreyDE,
        borderRadius: BorderRadius.circular(
          AppRadius.smallR,
        ),
      ),
      child: Text(
        title,
        style:  Styles.smallBody?.copyWith(
          color: isSelected? AppColors.kPrimary:AppColors.kGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}