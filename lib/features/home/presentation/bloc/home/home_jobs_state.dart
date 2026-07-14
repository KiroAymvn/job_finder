part of 'home_jobs_bloc.dart';

@immutable
sealed class HomeJobsState {}

final class HomeJobsInitial extends HomeJobsState {}
final class HomeJobsLoading extends HomeJobsState {}
final class HomeJobsSuccess extends HomeJobsState {
  final HomeEntity homeEntity;
  final String userName;
  HomeJobsSuccess({required this.homeEntity, required this.userName});
}
final class HomeJobsFailed extends HomeJobsState {
  final String errorMessage;
  HomeJobsFailed({required this.errorMessage});
}



