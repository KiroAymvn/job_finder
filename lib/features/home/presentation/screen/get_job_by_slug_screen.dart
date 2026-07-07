import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:job_finder/core/utils/app_colors.dart';
import 'package:job_finder/core/utils/app_radius.dart';
import 'package:job_finder/core/utils/app_spaces.dart';
import 'package:job_finder/core/utils/images.dart';
import 'package:job_finder/core/utils/text_styles.dart';
import 'package:job_finder/features/shared/custom_button.dart';

class GetJobBySlugScreen extends StatelessWidget {
  const GetJobBySlugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: _buildAppBar(context),

      // الزر الثابت أسفل الشاشة
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpaces.largeW,
          vertical: AppSpaces.smallH * 1.5,
        ),
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.kBlack.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: CustomButton(
          onPressed: () {
            // TODO: Implement Apply action
          },
          text: "Apply Now",
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpaces.largeW,
          vertical: AppSpaces.smallH,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _JobHeaderWidget(),
            Gap(AppSpaces.largeH),

            const _JobMetricsWidget(),
            Gap(AppSpaces.largeH),

            const _SkillsSectionWidget(),
            Gap(AppSpaces.largeH),

            _SectionTitle(title: "Job Description"),
            Gap(AppSpaces.smallH),
            Text(
              "Conduct user research to inform product design decisions. Plan and execute usability studies, interviews, and surveys.",
              style: Styles.body?.copyWith(height: 1.5),
            ),
            Gap(AppSpaces.largeH),

            _SectionTitle(title: "Responsibilities"),
            Gap(AppSpaces.smallH),
            const _BulletListWidget(
              items: [
                "Plan and conduct user research studies",
                "Analyze research data and synthesize insights",
                "Create user personas and journey maps",
                "Present findings to stakeholders",
                "Collaborate with designers and product managers",
              ],
            ),
            Gap(AppSpaces.largeH),

            _SectionTitle(title: "Requirements"),
            Gap(AppSpaces.smallH),
            const _BulletListWidget(
              items: [
                "Bachelor's degree in HCI, Psychology, or related field",
                "3+ years UX research experience",
                "Experience with qualitative and quantitative methods",
                "Strong analytical skills",
                "Excellent presentation abilities",
              ],
            ),
            Gap(AppSpaces.largeH),

            _SectionTitle(title: "Benefits"),
            Gap(AppSpaces.smallH),
            const _BulletListWidget(
              items: [
                "Competitive Salary",
                "Health Insurance",
                "Remote Work Options",
                "Research Tools",
                "Conference Budget",
              ],
            ),
            Gap(AppSpaces.largeH),
          ],
        ),
      ),
    );
  }

  // الـ AppBar المخصص
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.kWhite,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: AppColors.kBlack,
          size: 24.sp,
        ),
        onPressed: () => context.pop(),
      ),
      title: Text("Details", style: Styles.mediumTitle),
      actions: [
        IconButton(
          icon: Icon(
            CupertinoIcons.bookmark,
            color: AppColors.kPrimary,
            size: 24.sp,
          ),
          onPressed: () {
            // TODO: Toggle save job
          },
        ),
      ],
    );
  }
}

// ---------------------------------------------------------
// المكونات الداخلية (Private Widgets for Clean Code)
// ---------------------------------------------------------

class _JobHeaderWidget extends StatelessWidget {
  const _JobHeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 50.w,
              width: 50.w,
              decoration: BoxDecoration(
                color: AppColors.kGreyF3,
                borderRadius: BorderRadius.circular(
                  AppRadius.smallR,
                ),
              ),
              child: Center(
                // Placeholder for Google Logo
                child: Image.asset(AppImages.jobSearch)
              ),
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ui Designer",
                    style: Styles.largeTitle,
                  ),
                  Gap(4.h),
                  Text("Google", style: Styles.smallBody),
                ],
              ),
            ),
          ],
        ),
        Gap(16.h),
        _buildIconTextRow(
          CupertinoIcons.location,
          "California",
        ),
        Gap(8.h),
        _buildIconTextRow(
          CupertinoIcons.creditcard,
          "14.000",
        ),
      ],
    );
  }

  Widget _buildIconTextRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: AppColors.kBlack),
        Gap(8.w),
        Text(text, style: Styles.mediumTitle),
      ],
    );
  }
}

class _JobMetricsWidget extends StatelessWidget {
  const _JobMetricsWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // IntrinsicHeight مهم جداً ليجعل الـ VerticalDivider يعمل بشكل صحيح
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              _buildMetricItem("Experience", "4 - 6 years"),
              const VerticalDivider(
                color: AppColors.kGreyEE,
                thickness: 1,
              ),
              _buildMetricItem("Job Type", "Full Time"),
              const VerticalDivider(
                color: AppColors.kGreyEE,
                thickness: 1,
              ),
              _buildMetricItem("Level", "Entry level"),
            ],
          ),
        ),
        Gap(16.h),
        Text(
          "Updated 3 days ago",
          style: Styles.smallBody?.copyWith(
            color: AppColors.kGrey99,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricItem(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Styles.smallBody),
          Gap(4.h),
          Text(value, style: Styles.smallTitle),
        ],
      ),
    );
  }
}

class _SkillsSectionWidget extends StatelessWidget {
  const _SkillsSectionWidget();

  @override
  Widget build(BuildContext context) {
    final List<String> skills = [
      "User Research",
      "Usability Testing",
      "Data Analysis",
      "Interview Techniques",
      "Persona Development",
      "Journey Mapping",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: "Skills"),
        Gap(12.h),
        // Wrap ممتاز لعرض الـ Chips بشكل متجاوب وينزل لسطر جديد تلقائياً
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: skills
              .map((skill) => _buildSkillChip(skill))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.kGreyEE,
        // لون رمادي خفيف كما في التصميم
        borderRadius: BorderRadius.circular(
          AppRadius.smallR,
        ),
      ),
      child: Text(
        label,
        style: Styles.body?.copyWith(
          color: AppColors.kGrey,
        ),
      ),
    );
  }
}

class _BulletListWidget extends StatelessWidget {
  final List<String> items;

  const _BulletListWidget({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: CircleAvatar(
                  radius: 3.r,
                  backgroundColor: AppColors.kGrey99,
                ),
              ),
              Gap(8.w),
              Expanded(
                child: Text(
                  item,
                  style: Styles.body?.copyWith(height: 1.5),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Styles.mediumTitle);
  }
}
