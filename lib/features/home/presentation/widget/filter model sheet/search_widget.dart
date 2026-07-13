import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/app_spaces.dart';
import 'package:job_finder/core/utils/images.dart';
import 'package:job_finder/core/utils/text_styles.dart';
import 'package:job_finder/features/auth/presentation/widget/custom_text_field.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_radius.dart';
import 'custom_model_bottom_sheet_filter.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key, required this.searchController});

  final TextEditingController searchController ;



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      // أو 0.1.sh حسب ما تفضله، هذا سيتحكم في ارتفاع الحقل والزر معاً
      child: Row(
        // stretch: تجبر جميع العناصر على التمدد لملء الارتفاع المتاح (56.h)
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. حقل البحث
          Expanded(
            child: CustomTextField(
              label: "Search",
              controller: searchController,
            ),
          ),
          Gap(AppSpaces.smallW),

          // 2. زر الفلتر
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) =>
                    CustomModelBottomSheetFilter(searchController: searchController,),
              );
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.kPrimary.withOpacity(
                    0.2,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppRadius.smallR,
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: EdgeInsets.all(
                        constraints.maxHeight / 4,
                      ),
                      child: SvgPicture.asset(
                        AppImages.filterIcon,
                        color: AppColors.kPrimary,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

