import 'package:bloc/bloc.dart';
import 'package:job_finder/core/params/list_all_jobs.dart';
import 'package:job_finder/features/home/domain/entities/home_entity.dart';
import 'package:job_finder/features/home/domain/uses_cases/home_jobs_use_case.dart';
import 'package:meta/meta.dart';

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
    final failureOrSuccess = await homeJobsUseCase.call(params: event.params);

    failureOrSuccess.fold(
      (failure) {
        emit(HomeJobsFailed(errorMessage: failure.errMessage));
      },
      (success) {
        emit(HomeJobsSuccess(homeEntity: success));
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
