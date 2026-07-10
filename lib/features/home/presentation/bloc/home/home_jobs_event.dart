part of 'home_jobs_bloc.dart';

@immutable
sealed class HomeJobsEvent {}
class HomeJobsSearchEvent extends HomeJobsEvent{
  final ListAllJobsParams params;

  HomeJobsSearchEvent({required this.params});

}
