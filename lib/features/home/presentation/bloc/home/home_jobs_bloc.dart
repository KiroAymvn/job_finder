import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:job_finder/core/params/list_all_jobs.dart';
import 'package:job_finder/core/storage/app_cache_key.dart';
import 'package:job_finder/core/storage/shared_pref.dart';
import 'package:job_finder/features/home/domain/entities/home_entity.dart';
import 'package:job_finder/features/home/domain/uses_cases/home_jobs_use_case.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/failure.dart';

part 'home_jobs_event.dart';

part 'home_jobs_state.dart';

class HomeJobsBloc extends Bloc<HomeJobsEvent, HomeJobsState> {
  HomeJobsBloc({required this.homeJobsUseCase}) : super(HomeJobsInitial()) {
    on<HomeJobsSearchEvent>(_getHomeJobs);
  }

  final HomeJobsUseCase homeJobsUseCase;

  Future<void> _getHomeJobs(
    HomeJobsSearchEvent event,
    Emitter<HomeJobsState> emit,
  ) async {
    emit(HomeJobsLoading());


    final instances = await Future.wait([
      homeJobsUseCase.call(params: event.params),
      SharedPreferences.getInstance(),
    ]);

    final failureOrSuccess = instances[0] as Either<Failure, HomeEntity>;
    final prefs = instances[1] as SharedPreferences;
    final shared = SharedPref(prefs);

    failureOrSuccess.fold(
      (failure) {
        emit(HomeJobsFailed(errorMessage: failure.errMessage));
      },
      (success) {
        emit(
          HomeJobsSuccess(
            homeEntity: success,
            userName: shared.getString(key: AppCacheKey.userName).toString(),
          ),
        );
      },
    );
  }
}

class HomeScreenBloc extends HomeJobsBloc {
  HomeScreenBloc({required super.homeJobsUseCase});
}

class SearchScreenBloc extends HomeJobsBloc {
  SearchScreenBloc({required super.homeJobsUseCase});
}
