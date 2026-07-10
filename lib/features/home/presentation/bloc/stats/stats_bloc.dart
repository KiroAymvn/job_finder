import 'package:bloc/bloc.dart';
import 'package:job_finder/features/home/domain/entities/stats_entity.dart';
import 'package:job_finder/features/home/domain/uses_cases/get_stats_use_case.dart';
import 'package:meta/meta.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final GetStatsUseCase getStatsUseCase;

  StatsBloc({required this.getStatsUseCase}) : super(StatsInitial()) {
    on<FetchStatsEvent>(_onFetchStats);
  }

  Future<void> _onFetchStats(
    FetchStatsEvent event,
    Emitter<StatsState> emit,
  ) async {
    emit(StatsLoading());
    final result = await getStatsUseCase.call();
    result.fold(
      (failure) => emit(StatsFailed(errorMessage: failure.errMessage)),
      (stats) => emit(StatsSuccess(statsEntity: stats)),
    );
  }
}
