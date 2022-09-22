
class Course {
  final int id;
  final String semester;
  final String courseName;
  final String courseDep;
  final String finalExam;
  final String lecture;

  Course(
 {
    required this.id,
    required this.semester,
    required this.courseName,
    required this.courseDep,
    required this.finalExam,
    required this.lecture,
  });

  factory Course.fromJson(Map<String, dynamic> parsedJson) {
    return Course(
      id: parsedJson['id'] as int,
      semester: parsedJson['semester'],
      courseName: parsedJson['course_name'],
      courseDep: parsedJson['course_dep'],
      finalExam: parsedJson['final'],
      lecture: parsedJson['lecture'],
    );
  }


}
