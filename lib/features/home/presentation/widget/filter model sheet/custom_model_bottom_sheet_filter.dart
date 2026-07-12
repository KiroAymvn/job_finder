import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/params/list_all_jobs.dart';
import 'package:job_finder/core/utils/app_colors.dart';
import 'package:job_finder/features/home/presentation/widget/filter%20model%20sheet/search_widget.dart';
import 'package:job_finder/features/shared/build_tag_widget.dart';
import 'package:job_finder/features/shared/custom_button.dart';

import '../../../../../core/utils/app_radius.dart';
import '../../../../../core/utils/app_spaces.dart';
import '../../../../../core/utils/text_styles.dart';
import 'location_drop_down.dart';

class CustomModelBottomSheetFilter extends StatefulWidget {
  const CustomModelBottomSheetFilter({super.key});

  @override
  State<CustomModelBottomSheetFilter> createState() =>
      _CustomModelBottomSheetFilterState();
}

final List<String> jobLevelsList = [
  "Entry Level",
  "Mid Level",
  "Senior Level",
  "Executive",
];
String finalLocation = '';
final List<String> jobTypeList = [
  "Full Time",
  "Part Time",
  "Contract",
  "Internship",
];
String selectedJobLevel = jobLevelsList[0];
String selectedJobType = jobTypeList[0];

class _CustomModelBottomSheetFilterState
    extends State<CustomModelBottomSheetFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 530.h,
      width: double.maxFinite,
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: AppSpaces.smallW,
        vertical: AppSpaces.smallH,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(
          AppRadius.largeR,
        ),
      ),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          Align(
            alignment: AlignmentGeometry.center,
            child: Text(
              "Filter",
              style: Styles.largeTitle.copyWith(),
            ),
          ),
          Gap(AppSpaces.mediumH),
          Text("Location", style: Styles.mediumTitle),
          Gap(AppSpaces.smallH),
          LocationDropdownWidget(
            onLocationChanged: (selectedOrTypedCity) {
              finalLocation = selectedOrTypedCity;
              print("User location is now: $finalLocation");
            },
          ),
          Gap(AppSpaces.mediumH),
          _jobTypeSelectionWidget(),
          Gap(AppSpaces.mediumH),
          _jobLevelSelectionWidget(),
          Spacer(),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Close",
                  textColor: AppColors.kGrey,
                  buttonColor: AppColors.kGreyDE,
                ),
              ),
              Gap(AppSpaces.smallW),
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  text: "Apply",

                ),
              ),

            ],
          ),
          Gap(AppSpaces.smallH),
        ],
      ),
    );
  }

  Column _jobTypeSelectionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Job Type", style: Styles.mediumTitle),
        Gap(AppSpaces.smallH),
        Wrap(
          spacing: AppSpaces.smallW,
          runSpacing: AppSpaces.smallH,
          children: jobTypeList
              .map(
                (type) => InkWell(
                  onTap: () {
                    setState(() {
                      selectedJobType = type;
                    });
                  },
                  child: BuildTagWidget(
                    title: type,
                    isSelected: selectedJobType == type,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Column _jobLevelSelectionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Job Level", style: Styles.mediumTitle),
        Gap(AppSpaces.smallH),
        Wrap(
          spacing: AppSpaces.smallW,
          runSpacing: AppSpaces.smallH,
          children: jobLevelsList
              .map(
                (level) => InkWell(
                  onTap: () {
                    setState(() {
                      selectedJobLevel = level;
                    });
                  },
                  child: BuildTagWidget(
                    title: level,
                    isSelected: selectedJobLevel == level,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
