// import 'package:sci_alex/model/academic_book_model/academic_book_course.dart';

class CoursesListBook {
  final List<dynamic> courses;
  final String semesterName;

  CoursesListBook({required this.semesterName, required this.courses});

  factory CoursesListBook.fromJson(Map<String, dynamic> jsonData) {
    return CoursesListBook(
      courses: jsonData['courses'],
      semesterName: jsonData['semester_name'],
    );
  }

  // static List<CourseBook> parseCourse(jsonData){
  //   var list=jsonData;
  //   return ;
  // }
}
