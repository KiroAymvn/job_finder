import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_spaces.dart';
import '../../../../core/utils/di.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/text_styles.dart';

import 'package:job_finder/features/home/domain/entities/home_entity.dart';
import 'package:job_finder/features/home/domain/entities/sub_entity/home_data_entity.dart';
import 'package:job_finder/features/home/domain/entities/sub_entity/home_pagination_entity.dart';
import 'package:job_finder/features/home/domain/entities/sub_entity/user_posted_by_entity.dart';

import '../../../shared/job_card_widget.dart';
import '../bloc/home/home_jobs_bloc.dart';
import 'package:job_finder/features/home/presentation/widget/filter%20model%20sheet/search_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  // إنشاء بيانات وهمية للـ Skeletonizer ليقوم برسم هيكل التحميل بناءً عليها
  HomeEntity _getDummyHomeEntity() {
    return HomeEntity(
      isSuccess: true,
      homePaginationEntity: HomePaginationEntity(
        maxCount: 0,
        currentPage: 0,
        totalPages: 0,
        hasNext: false,
        hasPrevious: false,
      ),
      homeDataEntity: List.generate(
        5, // عدد البطاقات الوهمية التي ستظهر وقت التحميل
        (index) => HomeDataEntity(
          id: '0',
          title: 'Loading Job Title...',
          experience: '1-3 years',
          jobLevel: 'Mid Level',
          jobType: 'Full Time',
          location: 'Loading Location...',
          salaryRange: '\$00,000 - \$00,000',
          slug: 'loading-slug',
          //  category: 'IT',
          createdAt: '2026-01-01',
          updatedAt: '2026-01-01',
          isFavorite: false,
          userPostedByEntity: UserPostedByEntity(
            id: '0',
            fullName: 'Loading Company Name...',
            email: 'test@test.com',
            imageUrl: null,
            role: 'ADMIN',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose(); // تنظيف الذاكرة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpaces.largeW,
          vertical: AppSpaces.smallH,
        ),
        child: SafeArea(
          child: Column(
            children: [
              SearchBarWidget(searchController: searchController),
              Gap(AppSpaces.mediumH),

              BlocConsumer<SearchScreenBloc, HomeJobsState>(
                listener: (context, state) {
                  if (state is HomeJobsFailed) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                  }
                },
                builder: (context, state) {
                  // أ. حالة البداية (قبل إجراء أي بحث أو فلترة)
                  if (state is HomeJobsInitial) {
                    return _initialSearchWidget();
                  }

                  // ب. حالة الفشل في جلب البيانات
                  if (state is HomeJobsFailed) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          state.errorMessage,
                          style: Styles.mediumTitle?.copyWith(
                            color: AppColors.kRed,
                          ),
                        ),
                      ),
                    );
                  }

                  // ج. تحديد حالة التحميل واختيار البيانات
                  final bool isLoading = state is HomeJobsLoading;
                  final HomeEntity currentEntity = state is HomeJobsSuccess
                      ? state.homeEntity
                      : _getDummyHomeEntity();

                  // د. حالة النجاح ولكن لا توجد نتائج مطابقة للفلتر
                  if (!isLoading && currentEntity.homeDataEntity.isEmpty) {
                    return _noResultFoundWidget();
                  }

                  // هـ. حالة التحميل، أو النجاح بوجود نتائج فعلية
                  return Expanded(
                    child: Skeletonizer(
                      enabled: isLoading,
                      child: ListView.builder(
                        itemCount: currentEntity.homeDataEntity.length,
                        itemBuilder: (context, index) {
                          return JobCardWidget(
                            homeEntity: currentEntity,
                            index: index,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // المكون الخاص برسالة البدء
  Expanded _initialSearchWidget() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.search_circle_fill,
            size: 100.sp,
            color: AppColors.kGreyEE,
          ),
          Gap(AppSpaces.largeH),
          Text("Start Your Search", style: Styles.largeTitle),
          Gap(AppSpaces.smallH),
          Text(
            "Type a job title or keyword to find\nyour next career opportunity.",
            style: Styles.body?.copyWith(color: AppColors.kGrey99),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // المكون الخاص برسالة عدم وجود نتائج
  Expanded _noResultFoundWidget() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.search1, width: 0.5.sw),
          Gap(AppSpaces.largeH),
          Text("No Results Found", style: Styles.mediumTitle),
          Gap(AppSpaces.smallH),
          Text("No jobs found matching your search.", style: Styles.body),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Try different keywords or browse all available positions.",
              style: Styles.body,
            ),
          ),
        ],
      ),
    );
  }
}
