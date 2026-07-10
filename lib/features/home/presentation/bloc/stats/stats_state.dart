part of 'stats_bloc.dart';

@immutable
sealed class StatsState {}

final class StatsInitial extends StatsState {}

final class StatsLoading extends StatsState {}

final class StatsSuccess extends StatsState {
  final StatsEntity statsEntity;
  StatsSuccess({required this.statsEntity});
}

final class StatsFailed extends StatsState {
  final String errorMessage;
  StatsFailed({required this.errorMessage});
}
