import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:job_finder/core/utils/app_colors.dart';
import 'package:job_finder/core/utils/app_radius.dart';
import 'package:job_finder/core/utils/app_spaces.dart';
import 'package:job_finder/core/utils/images.dart';
import 'package:job_finder/core/utils/text_styles.dart';
import 'package:job_finder/features/home/presentation/bloc/home/home_jobs_bloc.dart';
import 'package:job_finder/features/shared/build_tage_widget.dart';
import 'package:job_finder/features/shared/custom_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

// تأكد من مسارات الاستيراد (Imports) حسب هيكلة مشروعك
import 'package:job_finder/features/home/domain/entities/job_details_entity.dart';
import 'package:job_finder/features/home/domain/entities/sub_entity/user_posted_by_entity.dart';

import '../bloc/detailed_job/job_details_cubit.dart';
import '../bloc/detailed_job/job_details_state.dart';

class GetJobBySlugScreen extends StatefulWidget {
  const GetJobBySlugScreen({super.key, required this.jobSlug});

  final String jobSlug;

  @override
  State<GetJobBySlugScreen> createState() => _GetJobBySlugScreenState();
}

class _GetJobBySlugScreenState extends State<GetJobBySlugScreen> {
  @override
  void initState() {
    super.initState();
    _fetchJobDetails();
  }

  void _fetchJobDetails() {
    context.read<JobDetailsCubit>().getJobDetails(widget.jobSlug);
  }

  // دالة لإنشاء بيانات وهمية ليستخدمها الـ Skeletonizer في رسم تأثير التحميل بشكل جميل
  JobDetailsEntity _getDummyJobForSkeleton() {
    return JobDetailsEntity(
      id: '0',
      title: 'Loading Job Title...',
      experience: 'Loading..',
      jobLevel: 'Loading..',
      jobType: 'Loading..',
      location: 'Loading Location...',
      salaryRange: '\$00,000 - \$00,000',
      slug: 'loading',
      category: 'Loading',
      createdAt: '',
      updatedAt: 'Loading...',
      isFavorite: false,
      userPostedByEntity: UserPostedByEntity(
        id: '0',
        fullName: 'Loading Company Name',
        email: '',
        role: '',
        imageUrl: null,
      ),
      description:
      'This is a dummy description text specifically placed here so the Skeletonizer has enough lines to display a beautiful and realistic loading effect for the user.',
      skills: ['Skill 1', 'Skill 2', 'Skill 3'],
      responsibilities: [
        'Loading responsibility number one for the skeleton',
        'Loading responsibility number two',
        'Loading responsibility number three'
      ],
      requirements: [
        'Loading requirement number one',
        'Loading requirement number two'
      ],
      benefits: ['Loading benefit 1', 'Loading benefit 2'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: _buildAppBar(context),

      body: BlocConsumer<JobDetailsCubit, JobDetailsState>( // 👈 التعديل هنا
        listener: (context, state) {
          if (state is JobDetailsFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          // 1. معالجة حالة الفشل
          if (state is JobDetailsFailed) {
            return Center(
              child: Text(state.errorMessage, style: Styles.mediumTitle?.copyWith(color: AppColors.kRed)),
            );
          }

          // 2. تحديد هل الشاشة في حالة تحميل أم لا
          final bool isLoading = state is! JobDetailsSuccess;

          // 3. اختيار البيانات
          final JobDetailsEntity job = state is JobDetailsSuccess
              ? state.jobDetailsEntity
              : _getDummyJobForSkeleton();

          // ... باقى الكود الخاص بالـ Skeletonizer يظل كما هو
          return Column(
            children: [
              Expanded(
                child: Skeletonizer(
                  enabled: state is JobDetailsLoading, // تفعيل التأثير بناءً على الحالة
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpaces.largeW,
                      vertical: AppSpaces.smallH,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // تمرير البيانات المحددة بدلاً من الـ Hardcoded
                        _JobHeaderWidget(
                          title: job.title,
                          company: job.userPostedByEntity.fullName,
                          location: job.location,
                          salary: job.salaryRange,
                        ),
                        Gap(AppSpaces.largeH),

                        _JobMetricsWidget(
                          experience: job.experience,
                          jobType: job.jobType,
                          level: job.jobLevel,
                          updatedAt: job.updatedAt,
                        ),
                        Gap(AppSpaces.largeH),

                        if (job.skills.isNotEmpty) ...[
                          _SkillsSectionWidget(skills: job.skills),
                          Gap(AppSpaces.largeH),
                        ],

                        if (job.description.isNotEmpty) ...[
                          const _SectionTitle(title: "Job Description"),
                          Gap(AppSpaces.smallH),
                          Text(
                            job.description,
                            style: Styles.body?.copyWith(height: 1.5),
                          ),
                          Gap(AppSpaces.largeH),
                        ],

                        if (job.responsibilities.isNotEmpty) ...[
                          const _SectionTitle(title: "Responsibilities"),
                          Gap(AppSpaces.smallH),
                          _BulletListWidget(items: job.responsibilities),
                          Gap(AppSpaces.largeH),
                        ],

                        if (job.requirements.isNotEmpty) ...[
                          const _SectionTitle(title: "Requirements"),
                          Gap(AppSpaces.smallH),
                          _BulletListWidget(items: job.requirements),
                          Gap(AppSpaces.largeH),
                        ],

                        if (job.benefits.isNotEmpty) ...[
                          const _SectionTitle(title: "Benefits"),
                          Gap(AppSpaces.smallH),
                          _BulletListWidget(items: job.benefits),
                          Gap(AppSpaces.largeH),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              // الزر الثابت أسفل الشاشة (تم وضعه خارج الـ Skeletonizer ليبقى نشطاً أو ظاهراً بشكل طبيعي)
              Container(
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
                  onPressed: isLoading ? () {} : () {
                    // TODO: Implement Apply action
                  },
                  text: "Apply Now",
                  buttonColor: isLoading ? AppColors.kGreyDE : AppColors.kPrimary,
                ),
              ),
            ],
          );
        },
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
// المكونات الداخلية (تستقبل البيانات عبر الـ Constructor الآن)
// ---------------------------------------------------------

class _JobHeaderWidget extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String salary;

  const _JobHeaderWidget({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
  });

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
                borderRadius: BorderRadius.circular(AppRadius.smallR),
              ),
              child: Center(
                // Placeholder for Google Logo
                child: Image.asset(AppImages.jobSearch),
              ),
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Styles.largeTitle),
                  Gap(4.h),
                  Text(company, style: Styles.smallBody),
                ],
              ),
            ),
          ],
        ),
        Gap(16.h),
        _buildIconTextRow(CupertinoIcons.location, location),
        Gap(8.h),
        _buildIconTextRow(CupertinoIcons.creditcard, salary),
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
  final String experience;
  final String jobType;
  final String level;
  final String updatedAt;

  const _JobMetricsWidget({
    required this.experience,
    required this.jobType,
    required this.level,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetricItem("Experience", experience),
              const VerticalDivider(color: AppColors.kGreyEE, thickness: 1),
              _buildMetricItem("Job Type", jobType),
              const VerticalDivider(color: AppColors.kGreyEE, thickness: 1),
              _buildMetricItem("Level", level),
            ],
          ),
        ),
        Gap(16.h),
        Text(
          "Updated: $updatedAt",
          style: Styles.smallBody?.copyWith(color: AppColors.kGrey99),
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
  final List<String> skills;

  const _SkillsSectionWidget({required this.skills});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: "Skills"),
        Gap(12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: skills.map((skill) => BuildTagWidget(title: skill,)).toList(),
        ),
      ],
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