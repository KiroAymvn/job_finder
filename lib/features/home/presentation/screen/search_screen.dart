import 'package:flutter/material.dart';
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

            ],
          ),
        ),
      ),
    );
  }
}