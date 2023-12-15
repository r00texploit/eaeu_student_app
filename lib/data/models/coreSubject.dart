import 'package:student/data/models/subject.dart';

class CoreSubject extends Subject {
  late final String classId;

  CoreSubject.fromJson({required Map<String, dynamic> json})
      : super.fromJson(Map.from(json['subject'] ?? {})) {
    classId = json['class_id'] ?? 0;
  }
}
