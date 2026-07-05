import 'package:job_finder/features/home/domain/entities/sub_entity/home_data_entity.dart';
import 'package:job_finder/features/home/domain/entities/sub_entity/home_pagination_entity.dart';
import 'package:job_finder/features/home/domain/entities/sub_entity/user_posted_by_entity.dart';

class HomeEntity {
  final bool isSuccess;
  final List<HomeDataEntity> homeDataEntity;
  final HomePaginationEntity homePaginationEntity;

  HomeEntity({
    required this.isSuccess,
    required this.homeDataEntity,
    required this.homePaginationEntity,
  });
}
