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

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CustomTextField(
              label: "Search",
              controller: searchController,
              isSearch: true,
            ),
          ),
          Gap(AppSpaces.smallW),

          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => CustomModelBottomSheetFilter(
                  searchController: searchController,
                ),
              );
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.kPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppRadius.smallR),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: EdgeInsets.all(constraints.maxHeight / 4),
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
