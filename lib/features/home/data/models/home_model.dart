import 'package:job_finder/features/home/data/models/sub_models/home_data_model.dart';
import 'package:job_finder/features/home/domain/entities/home_entity.dart';
// تأكد من مسار هذا الملف لديك
import 'sub_models/home_pagination_model.dart';

class HomeModel extends HomeEntity {
  HomeModel({
    required super.isSuccess,
    required super.homeDataEntity,
    required super.homePaginationEntity,
  });

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      isSuccess: map["success"] ?? false, // تم تصحيح المفتاح ليكون "success"
      homeDataEntity: (map["data"] as List?)
          ?.map((e) => HomeDataModel.fromJson(e))
          .toList() ?? [],
      // يجب تحويل الكائن باستخدام الـ Model الخاص به
      homePaginationEntity: HomePaginationModel.fromJson(map["pagination"] ?? {}),
    );
  }
}