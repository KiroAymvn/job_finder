import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/features/home/presentation/widget/filter%20model%20sheet/search_widget.dart';

import '../../../../../core/utils/app_radius.dart';
import '../../../../../core/utils/app_spaces.dart';
import '../../../../../core/utils/text_styles.dart';
import 'location_drop_dwon.dart';

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
];

class _CustomModelBottomSheetFilterState
    extends State<CustomModelBottomSheetFilter> {
  String finalLocation = '';

  String currentJobLevelOption = jobLevelsList[0];

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

          Text("Job Type", style: Styles.mediumTitle),
          Row(
            children: [
              Wrap(
              direction: Axis.horizontal,
                children: jobLevelsList.map(
                  (level) => radioAndTextWidget(
                    value: level,
                    groupValue: currentJobLevelOption,
                  ),
                ).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row radioAndTextWidget({
    required String value,
    required String groupValue,
  }) {
    return Row(
      children: [
        Radio<String>(
          // تحديد نوع الـ Radio ليكون int
          value: value,
          groupValue: groupValue,
          onChanged: (value) {
            setState(() {
              // 2. الآن سيتم تحديث المتغير ولن يتم تصفيره عند إعادة البناء
              currentJobLevelOption = value.toString();
              print(currentJobLevelOption);
            });
          },
        ),
         Text(value),
        // يفضل استخدام const للنصوص الثابتة
      ],
    );
  }
}
