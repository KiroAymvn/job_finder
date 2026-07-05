enum JobType {
  fullTime('FULL_TIME'),
  partTime('PART_TIME'),
  contract('CONTRACT');

  final String value;
  const JobType(this.value);
}

enum JobLevel {
  entryLevel('ENTRY_LEVEL'),
  midLevel('MID_LEVEL'),
  seniorLevel('SENIOR_LEVEL');

  final String value;
  const JobLevel(this.value);
}

class ListAllJobsParams {
  final int? page;
  final int? limit;
  final JobType? jobType;
  final JobLevel? jobLevel;
  final String? location;
  final String? search;

  ListAllJobsParams({
    this.page,
    this.limit,
    this.jobType,
    this.jobLevel,
    this.location,
    this.search,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};


    if (page != null) map['page'] = page;
    if (limit != null) map['limit'] = limit;

    if (jobType != null) map['jobType'] = jobType!.value;
    if (jobLevel != null) map['jobLevel'] = jobLevel!.value;

    if (location != null) map['location'] = location;
    if (search != null) map['search'] = search;

    return map;
  }
}