import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:job_finder/core/database/api/dio_consumer.dart';
import 'package:job_finder/core/params/list_all_jobs.dart';
import 'package:job_finder/features/home/data/data_source/home_remote_data_source.dart';
import 'package:job_finder/features/home/data/repo/home_repo_impl.dart';
import 'package:job_finder/features/home/domain/entities/home_entity.dart';
import 'package:job_finder/features/home/domain/entities/job_details_entity.dart';
import 'package:job_finder/features/home/domain/uses_cases/get_job_details_use_case.dart';
import 'package:job_finder/features/home/domain/uses_cases/home_jobs_use_case.dart';
import 'package:meta/meta.dart';

import '../../../../../core/database/api/dio_client.dart';

part 'home_jobs_event.dart';

part 'home_jobs_state.dart';

class HomeJobsBloc
    extends Bloc<HomeJobsEvent, HomeJobsState> {
  HomeJobsBloc({
    required this.homeJobsUseCase,
    required this.jobDetailsUseCase,
  }) : super(HomeJobsInitial()) {
    on<HomeJobsSearchEvent>(_getHomeJobs);
  }

  final HomeJobsUseCase homeJobsUseCase;
  final GetJobDetailsUseCase jobDetailsUseCase;

  Future<void> _getHomeJobs(
    HomeJobsSearchEvent event,
    Emitter<HomeJobsState> emit,
  ) async {
    emit(HomeJobsLoading());
    final failureOrSuccess = await homeJobsUseCase.call(
      params: event.params,
    );

    failureOrSuccess.fold(
      (failure) {
        emit(
          HomeJobsFailed(errorMessage: failure.errMessage),
        );
      },
      (success) {
        emit(HomeJobsSuccess(homeEntity: success));
      },
    );
  }


}
