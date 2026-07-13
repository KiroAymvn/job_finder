import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/images.dart';
import 'package:job_finder/core/utils/text_styles.dart';
import 'package:job_finder/features/home/presentation/widget/filter%20model%20sheet/search_widget.dart';
import '../../../../core/utils/app_spaces.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // 1. تعريف المتغيرات هنا (خارج دالة build) لكي تحتفظ بقيمتها عند عمل setState
  int? currentJobLevelOption = 1;

  final List<String> jobLevelsList = [
    "Entry Level",
    "Mid Level",
    "Senior Level",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpaces.largeW,
          vertical: AppSpaces.smallH,
        ),
        child: SafeArea(
          child: Column(
            children: [
              SearchBarWidget(),
              Expanded(
                child: Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  children: [
                    Image.asset(AppImages.search1, width: 0.5.sw,),
                    Gap(AppSpaces.largeH),
                    Text("No Results Found",style: Styles.mediumTitle,),
                    Gap(AppSpaces.smallH),
                    Text("No jobs found matching your search.",style: Styles.body,),
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text("Try different keywords or browse all available positions.",style: Styles.body,)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}