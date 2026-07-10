import 'package:job_finder/features/home/domain/entities/sub_entity/suggested_job_company_entity.dart';

class SuggestedJobCompanyModel extends SuggestedJobCompanyEntity {
  SuggestedJobCompanyModel({
    required super.id,
    required super.fullName,
    required super.imageUrl,
  });

  factory SuggestedJobCompanyModel.fromJson(Map<String, dynamic> json) {
    return SuggestedJobCompanyModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }
}
