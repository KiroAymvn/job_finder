part of 'stats_bloc.dart';

@immutable
sealed class StatsEvent {}

class FetchStatsEvent extends StatsEvent {}
