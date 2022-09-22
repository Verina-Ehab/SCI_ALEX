// import 'package:meta/meta.dart';

class Course {
  final String id;
  final String code;
  final String name;
  final int hours;

  final String recommended;
  final String doc;
  final String finalExam;
  // final List<String> lecture;

  // final String? symbol;
  // final String? points;
  // final String? midGradeOfCourse;
  // final String? semesterGradeOfCourse;

  const Course({
    required this.hours,
    required this.name,
    required this.code,
    required this.id,
    required this.recommended,
    required this.finalExam,
    //  required this.lecture,
    required this.doc,

    // this.symbol,
    // this.points,
    // this.midGradeOfCourse,
    // this.semesterGradeOfCourse,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        name: json['name'],
        code: json['code'],
        id: json['id'],
        recommended: json['recommended'],
        finalExam: json['finalExam'],
        // lecture: json['lecture'],
        doc: json['doc'],
        hours: json['hours'],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Course &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          code == other.code;

  @override
  int get hashCode => name.hashCode ^ code.hashCode;

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': name,
        'urlImage': code,
        'title': recommended,
        'finalExam': finalExam,
        // 'lecture': lecture,
        'doc': doc,
        'hours': hours,
      };
}
