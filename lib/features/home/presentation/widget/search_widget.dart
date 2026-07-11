import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:job_finder/core/utils/app_spaces.dart';
import 'package:job_finder/core/utils/images.dart';
import 'package:job_finder/core/utils/text_styles.dart';
import 'package:job_finder/features/auth/presentation/widget/custom_text_field.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_radius.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key});

  final TextEditingController controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      // أو 0.1.sh حسب ما تفضله، هذا سيتحكم في ارتفاع الحقل والزر معاً
      child: Row(
        // stretch: تجبر جميع العناصر على التمدد لملء الارتفاع المتاح (56.h)
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. حقل البحث
          Expanded(
            child: CustomTextField(
              label: "Search",
              controller: controller,
            ),
          ),
          Gap(AppSpaces.smallW),

          // 2. زر الفلتر
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) =>
                    CustomModelBottomSheetFilter(),
              );
            },
            child: AspectRatio(
              aspectRatio: 1,
              // هذه الأداة تضمن أن العرض سيكون دائماً مساوياً للطول (مربع مثالي)
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.kPrimary.withOpacity(
                    0.2,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppRadius.smallR,
                  ),
                ),
                // 3. LayoutBuilder يقرأ الحجم الذي أعطاه له الـ AspectRatio
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      // padding = ربع الارتفاع الفعلي للمربع من كل الاتجاهات
                      padding: EdgeInsets.all(
                        constraints.maxHeight / 4,
                      ),
                      child: SvgPicture.asset(
                        AppImages.filterIcon,
                        color: AppColors.kPrimary,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomModelBottomSheetFilter extends StatelessWidget {
  const CustomModelBottomSheetFilter({super.key});

  @override
  Widget build(BuildContext context) {
    String finalLocation = '';
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
              // هذه الدالة ستعمل كلما اختار المستخدم مدينة، أو كلما كتب حرفاً في حقل Other
              finalLocation = selectedOrTypedCity;
              print("User location is now: $finalLocation");
            },
          ),
        ],
      ),
    );
  }
}

class LocationDropdownWidget extends StatefulWidget {
  const LocationDropdownWidget({
    super.key,
    required this.onLocationChanged,
  });

  // هذه الدالة ترسل المدينة المختارة (سواء من القائمة أو المكتوبة يدوياً) إلى الشاشة الأب
  final Function(String) onLocationChanged;

  @override
  State<LocationDropdownWidget> createState() =>
      _LocationDropdownWidgetState();
}

class _LocationDropdownWidgetState
    extends State<LocationDropdownWidget> {
  String? selectedCity;

  // متحكم للبحث داخل القائمة المنسدلة
  final TextEditingController _searchController =
      TextEditingController();

  // متحكم لحقل النص اليدوي (عند اختيار Other)
  final TextEditingController _customCityController =
      TextEditingController();

  // 1. قائمة المدن المصرية + خيار Other
  final List<String> egyptCities = [
    'Cairo',
    'Giza',
    'Alexandria',
    'Port Said',
    'Suez',
    'Luxor',
    'Mansoura',
    'El-Mahalla El-Kubra',
    'Tanta',
    'Asyut',
    'Ismailia',
    'Fayoum',
    'Zagazig',
    'Aswan',
    'Damietta',
    'Damanhur',
    'Minya',
    'Beni Suef',
    'Qena',
    'Sohag',
    'Hurghada',
    'Sharm El Sheikh',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    // مراقبة ما يكتبه المستخدم في حقل "Other" لكي نرسله للشاشة الأب
    _customCityController.addListener(() {
      if (selectedCity == 'Other') {
        widget.onLocationChanged(
          _customCityController.text,
        );
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _customCityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 2. استخدام LayoutBuilder لضمان العرض الكامل بدون أخطاء
        LayoutBuilder(
          builder: (context, constraints) {
            return DropdownMenu<String>(
              width: constraints.maxWidth,
              menuHeight: 250.h,
              enableSearch: true,
              // 3. تفعيل البحث
              controller: _searchController,
              hintText: "Select Your Location",
              textStyle: Styles.smallTitle,

              // التعديل السحري لضبط الارتفاع والشكل (Matching App Identity)
              inputDecorationTheme: InputDecorationTheme(
                // ضبط الارتفاع ليكون 48.h بالضبط
                constraints: BoxConstraints(
                  maxHeight: 48.h,
                ),
                // جعل Padding العمودي 0 حتى يتمركز النص والأيقونة في المنتصف تماماً
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 0,
                ),
                hintStyle: Styles.body?.copyWith(
                  color: AppColors.kPrimary,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColors.kPrimary,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColors.kPrimary,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColors.kPrimary,
                    width: 1.5,
                  ),
                ),
              ),

              onSelected: (String? value) {
                setState(() {
                  selectedCity = value;
                });

                // إذا اختار مدينة من القائمة (وليست Other)، أرسلها مباشرة
                if (value != null && value != 'Other') {
                  widget.onLocationChanged(value);
                  _customCityController
                      .clear(); // تنظيف الحقل المخصص
                }
              },

              // بناء العناصر
              dropdownMenuEntries: egyptCities.map((city) {
                return DropdownMenuEntry<String>(
                  value: city,
                  label: city,
                  style: MenuItemButton.styleFrom(
                    textStyle: Styles.smallTitle,
                    foregroundColor: AppColors.kBlack,
                  ),
                );
              }).toList(),
            );
          },
        ),

        // 4. إظهار حقل إضافي إذا اختار المستخدم "Other"
        if (selectedCity == 'Other') ...[
          Gap(16.h),
          // استخدام حقل النص المخصص الخاص بك
          CustomTextField(
            label: "Enter your specific city",
            controller: _customCityController,
          ),
        ],
      ],
    );
  }
}
