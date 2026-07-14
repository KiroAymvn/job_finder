import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/params/list_all_jobs.dart';
import 'package:job_finder/core/utils/app_colors.dart';
import 'package:job_finder/features/home/presentation/bloc/home/home_jobs_bloc.dart';
import 'package:job_finder/features/home/presentation/widget/filter%20model%20sheet/search_widget.dart';
import 'package:job_finder/features/shared/build_tag_widget.dart';
import 'package:job_finder/features/shared/custom_button.dart';
import 'package:job_finder/features/shared/scaffold_message.dart';

import '../../../../../core/utils/app_radius.dart';
import '../../../../../core/utils/app_spaces.dart';
import '../../../../../core/utils/text_styles.dart';
import 'location_drop_down.dart';

class CustomModelBottomSheetFilter extends StatefulWidget {
  const CustomModelBottomSheetFilter({
    super.key,
    required this.searchController,
  });

  @override
  State<CustomModelBottomSheetFilter> createState() =>
      _CustomModelBottomSheetFilterState();
  final TextEditingController searchController;
}

String finalLocation = '';
final List<String> jobLevelsList = [
  "Entry Level",
  "Mid Level",
  "Senior Level",
  "Executive",
];
final List<String> jobTypeList = [
  "Full Time",
  "Part Time",
  "Contract",
  "Internship",
];
String selectedJobLevel = "";
String selectedJobType = "";

class _CustomModelBottomSheetFilterState
    extends State<CustomModelBottomSheetFilter> {
  @override
  Widget build(BuildContext context) {
    ListAllJobsParams params = ListAllJobsParams.fromFilter(
      jobType: selectedJobType,
      jobLevel: selectedJobLevel,
      location: finalLocation,
      search: widget.searchController.text,
    );
    return Container(
      height: 500.h,
      width: double.maxFinite,
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: AppSpaces.smallW,
        vertical: AppSpaces.smallH,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(AppRadius.largeR),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentGeometry.center,
            child: Text("Filter", style: Styles.largeTitle.copyWith()),
          ),
          Gap(AppSpaces.mediumH),
          Text("Location", style: Styles.mediumTitle),
          Gap(AppSpaces.smallH),
          LocationDropdownWidget(
            onLocationChanged: (selectedOrTypedCity) {
              setState(() {
                finalLocation = selectedOrTypedCity;
              });
              print("User location is now: $finalLocation");
            },
          ),
          Gap(AppSpaces.mediumH),
          _jobTypeSelectionWidget(),
          Gap(AppSpaces.mediumH),
          _jobLevelSelectionWidget(),
          Spacer(),
          Gap(AppSpaces.mediumH),

          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Close",
                  textColor: AppColors.kRed,
                  buttonColor: AppColors.kPrimary.withOpacity(0.3),
                ),
              ),
              Gap(AppSpaces.smallW),
              Expanded(
                child: CustomButton(
                  isDisable: params.isInstanceNull(),
                  onPressed: () {
                    if (params.isInstanceNull() == false) {
                      context.read<SearchScreenBloc>().add(
                        HomeJobsSearchEvent(params: params),
                      );
                      Navigator.pop(context);
                    }
                  },
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
                      if (selectedJobType == type) {
                        selectedJobType = '';
                      } else {
                        selectedJobType = type;
                      }
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
                      if (selectedJobLevel == level) {
                        selectedJobLevel = '';
                      } else {
                        selectedJobLevel = level;
                      }
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
