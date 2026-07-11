import 'package:flutter/material.dart';
import 'package:job_finder/features/home/presentation/widget/search_widget.dart';

import '../../../../core/utils/app_spaces.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpaces.largeW,
          vertical: AppSpaces.smallH,
        ),
        child: SafeArea(
          child: Column(children: [SearchBarWidget()]),
        ),
      ),
    );
  }
}
