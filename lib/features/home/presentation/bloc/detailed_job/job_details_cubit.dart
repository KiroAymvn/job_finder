import 'package:bloc/bloc.dart';
import 'package:job_finder/features/home/domain/uses_cases/get_job_details_use_case.dart';
import 'job_details_state.dart';

class JobDetailsCubit extends Cubit<JobDetailsState> {
  final GetJobDetailsUseCase getJobDetailsUseCase;

  JobDetailsCubit({required this.getJobDetailsUseCase}) : super(JobDetailsInitial());

  Future<void> getJobDetails(String jobSlug) async {
    emit(JobDetailsLoading());

    final failureOrSuccess = await getJobDetailsUseCase.call(jobSlug: jobSlug);

    failureOrSuccess.fold(
          (failure) => emit(JobDetailsFailed(errorMessage: failure.errMessage)),
          (success) => emit(JobDetailsSuccess(jobDetailsEntity: success)),
    );
  }
}