import 'package:student/data/models/subject.dart';

class ElectiveSubject extends Subject {
  late final String electiveSubjectGroupId;

  ElectiveSubject.fromJson({
    required Map<String, dynamic> json,
    required electiveSubjectGroupId,
  }) : super.fromJson(Map.from(json)) {
    electiveSubjectGroupId = electiveSubjectGroupId;
  }
}
