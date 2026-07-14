import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../auth/presentation/widget/custom_text_field.dart';

class LocationDropdownWidget extends StatefulWidget {
  const LocationDropdownWidget({super.key, required this.onLocationChanged});

  // هذه الدالة ترسل المدينة المختارة (سواء من القائمة أو المكتوبة يدوياً) إلى الشاشة الأب
  final Function(String) onLocationChanged;

  @override
  State<LocationDropdownWidget> createState() => _LocationDropdownWidgetState();
}

class _LocationDropdownWidgetState extends State<LocationDropdownWidget> {
  String? selectedCity;

  // متحكم للبحث داخل القائمة المنسدلة
  final TextEditingController _searchController = TextEditingController();

  // متحكم لحقل النص اليدوي (عند اختيار Other)
  final TextEditingController _customCityController = TextEditingController();

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
        widget.onLocationChanged(_customCityController.text);
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
                constraints: BoxConstraints(maxHeight: 48.h),
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

                if (value == null) {
                  widget.onLocationChanged("");
                } else if (value == 'Other') {
                  widget.onLocationChanged(_customCityController.text);
                } else {
                  widget.onLocationChanged(value);
                  _customCityController.clear();
                }
              },

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

        if (selectedCity == 'Other') ...[
          Gap(16.h),
          CustomTextField(
            label: "Enter your specific city",
            controller: _customCityController,
          ),
        ],
      ],
    );
  }
}
