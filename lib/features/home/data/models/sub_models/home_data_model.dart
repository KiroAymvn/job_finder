import '../../../domain/entities/sub_entity/home_data_entity.dart';
// تأكد من مسار هذا الملف لديك
import 'user_posted_by_model.dart';

class HomeDataModel extends HomeDataEntity {
  HomeDataModel({
    required super.id,
    required super.title,
    required super.experience,
    required super.jobLevel,
    required super.jobType,
    required super.location,
    required super.salaryRange,
    required super.slug,
    required super.category,
    required super.createdAt,
    required super.updatedAt,
    required super.isFavorite,
    required super.userPostedByEntity,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> map) {
    return HomeDataModel(
      id: map["id"] ?? '',
      title: map["title"] ?? '',
      experience: map["experience"] ?? '',
      jobLevel: map["jobLevel"] ?? '',
      jobType: map["jobType"] ?? '',
      location: map["location"] ?? '',
      salaryRange: map["salaryRange"] ?? '',
      slug: map["slug"] ?? '',
      category: map["category"], // قد يكون null في الـ JSON المرفق لذا لا نعطيه قيمة افتراضية
      createdAt: map["createdAt"] ?? '',
      updatedAt: map["updatedAt"] ?? '',
      isFavorite: map["isFavorite"] ?? false,
      // يجب تحويل الكائن المتداخل باستخدام الـ Model الخاص به
      userPostedByEntity: UserPostedByModel.fromJson(map["postedBy"] ?? {}),
    );
  }
}