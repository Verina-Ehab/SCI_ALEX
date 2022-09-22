
class CourseReg {
  // final int id;
  final String semester;
  final String courseName;
  final String courseDep;
  final String finalExam;
  final String lecture;

  CourseReg(
 {
    // required this.id,
    required this.semester,
    required this.courseName,
    required this.courseDep,
    required this.finalExam,
    required this.lecture,
  });

  factory CourseReg.fromJson(Map<String, dynamic> parsedJson) {
    return CourseReg(
      // id: parsedJson['id'],
      semester: parsedJson['semester'],
      courseName: parsedJson['course_name'],
      courseDep: parsedJson['course_dep'],
      finalExam: parsedJson['final'],
      lecture: parsedJson['lecture'],
    );
  }


}
