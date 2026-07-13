enum JobType {
  fullTime('FULL_TIME'),
  partTime('PART_TIME'),
  contract('CONTRACT'),
  internship('INTERNSHIP');

  final String value;
  const JobType(this.value);
}

enum JobLevel {
  entryLevel('ENTRY_LEVEL'),
  midLevel('MID_LEVEL'),
  seniorLevel('SENIOR_LEVEL'),
  executive('EXECUTIVE');

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
  static JobType? convertJobTypeToModel({required String jobType}) {
    final normalizedString = jobType.toLowerCase();
    if (normalizedString.contains("full")) {
      return JobType.fullTime;
    } else if (normalizedString.contains("part")) {
      return JobType.partTime;
    } else if (normalizedString.contains("contract")) {
      return JobType.contract;
    } else if (normalizedString.contains("internship")) {
      return JobType.internship;
    }
    return null;
  }

  static JobLevel? convertJobLevelToModel({required String jobLevel}) {
    final normalizedString = jobLevel.toLowerCase();

    if (normalizedString.contains("entry")) {
      return JobLevel.entryLevel;
    } else if (normalizedString.contains("mid")) {
      return JobLevel.midLevel;
    } else if (normalizedString.contains("senior")) {
      return JobLevel.seniorLevel;
    } else if (normalizedString.contains("executive")) {
      return JobLevel.executive;
    }
    return null;
  }
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