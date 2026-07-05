import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:job_finder/core/utils/app_colors.dart';
import 'package:job_finder/core/utils/app_radius.dart';
import 'package:job_finder/core/utils/app_spaces.dart';
import 'package:job_finder/features/home/presentation/screen/home_screen.dart';

class Root extends StatelessWidget {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
final String userName;
  Root({super.key, required this.userName});

  late final List<Widget> _screens = [
     HomeScreen(userName),
    const Center(child: Text("Search Screen")),
    const Center(child: Text("save Screen")),
    const Center(child: Text("Settings Screen")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, index, child) {
          return IndexedStack(
            index: index,
            children: _screens,
          );
        },
      ),
      bottomNavigationBar: _buildFloatingNavBar(),
    );
  }

  Widget _buildFloatingNavBar() {
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndex,
      builder: (context, currentIndex, child) {
        return Container(
          height: 70.h,
          margin: EdgeInsets.only(
            left: AppSpaces.smallW,
            right: AppSpaces.smallW,
            bottom: AppSpaces.smallH * 1.5, // رفع الشريط عن الحافة
          ),
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(AppRadius.largeR),
            boxShadow: [
              BoxShadow(
                color: AppColors.kBlack.withOpacity(0.08),
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          // إزالة FittedBox واستخدام Row عادية لأن Expanded سيقوم بإدارة المساحات
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppSpaces.smallH),
            child: Row(
              children: [
                _buildNavItem(0, CupertinoIcons.home, "Home", currentIndex),
                _buildNavItem(1, CupertinoIcons.search, "Search", currentIndex),
                _buildNavItem(2, Icons.favorite, "Save", currentIndex),
                _buildNavItem(3, CupertinoIcons.settings, "Settings", currentIndex),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, int currentIndex) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          _currentIndex.value = index;
        },
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.kPrimary.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.mediumR),
            ),
            // قمنا بإزالة SingleChildScrollView واستخدمنا Row مباشرة
            child: Row(
              mainAxisSize: MainAxisSize.min, // مهم جداً لإبقاء العناصر بالمنتصف
              children: [
                Icon(
                  icon,
                  color: isSelected ? AppColors.kPrimary : AppColors.kGrey99,
                  size: 24.sp,
                ),
                if (isSelected)
                // 1. استخدام Flexible لضمان عدم خروج النص عن حدود الشاشة
                  Flexible(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      // 2. استخدام FittedBox مع scaleDown
                      child: FittedBox(
                        fit: BoxFit.scaleDown, // سيقوم بتصغير النص فقط إذا كان أكبر من المساحة
                        child: Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Text(
                            label,
                            style: TextStyle(
                              color: AppColors.kPrimary,
                              fontWeight: FontWeight.bold,
                              // يمكنك الآن كتابة أي رقم كبير هنا، وسيقوم بالتصغير تلقائياً
                              fontSize: 20.sp,
                              fontFamily: "DMSans",
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }}