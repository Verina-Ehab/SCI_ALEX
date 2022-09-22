// import 'package:meta/meta.dart';
import 'package:sci_alex/trash/model/course.dart';

class Semester {
  final String id;
  final String name;
  final String gpa;
  final String cgpa;
  final String hours;
  List<Course> allCoursesOfSemester;

  Semester({
    required this.gpa,
    required this.cgpa,
    required this.hours,
    required this.name,
    required this.id,
    required this.allCoursesOfSemester,
  });

  factory Semester.fromJson(Map<String, dynamic> json) => Semester(
      name: json['name'],
      id: json['id'],
      gpa: json['gpa'],
      cgpa: json['cgpa'],
      hours: json['hours'],
      allCoursesOfSemester: toListOfCourse(json['allCoursesOfSemester']));

  static List<String> toList(List<dynamic> list) {
    return List<String>.from(list);
  }

  static List<Course> toListOfCourse(List<dynamic> list) {
    List<Course> subjectsList = list.map((e) => Course.fromJson(e)).toList();
    return subjectsList;
  }
}
