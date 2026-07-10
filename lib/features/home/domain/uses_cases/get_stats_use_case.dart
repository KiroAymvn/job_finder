import 'package:dartz/dartz.dart';
import 'package:job_finder/core/errors/failure.dart';
import 'package:job_finder/features/home/domain/entities/stats_entity.dart';
import 'package:job_finder/features/home/domain/repo/home_repo.dart';

class GetStatsUseCase {
  final HomeRepo homeRepo;

  GetStatsUseCase({required this.homeRepo});

  Future<Either<Failure, StatsEntity>> call() async {
    return homeRepo.getStats();
  }
}
