import 'package:flutter/material.dart';
import 'package:job_finder/features/home/domain/entities/job_details_entity.dart';

@immutable
sealed class JobDetailsState {}

final class JobDetailsInitial extends JobDetailsState {}
final class JobDetailsLoading extends JobDetailsState {}
final class JobDetailsSuccess extends JobDetailsState {
  final JobDetailsEntity jobDetailsEntity;
  JobDetailsSuccess({required this.jobDetailsEntity});
}
final class JobDetailsFailed extends JobDetailsState {
  final String errorMessage;
  JobDetailsFailed({required this.errorMessage});
}