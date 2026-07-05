import 'package:job_finder/features/home/domain/entities/sub_entity/home_pagination_entity.dart';

class HomePaginationModel extends HomePaginationEntity {
  HomePaginationModel({
    required super.maxCount,
    required super.currentPage,
    required super.totalPages,
    required super.hasNext,
    required super.hasPrevious,
  });

  factory HomePaginationModel.fromJson(
    Map<String, dynamic> map,
  ) {
    return HomePaginationModel(
      maxCount: map["maxCount"],
      currentPage: map["currentPage"],
      totalPages: map["totalPages"],
      hasNext: map["hasNext"],
      hasPrevious: map["hasPrevious"],
    );
  }
}
