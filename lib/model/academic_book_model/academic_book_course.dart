
class CourseBook {
  final int id;
  // final String semester;
  final String courseName;
  final String symbol;
  final String points;


  CourseBook(
 {
    required this.id,
    // required this.semester,
    required this.courseName,
    required this.symbol,
    required this.points,
  });

  factory CourseBook.fromJson(Map<String, dynamic> parsedJson) {
    return CourseBook(
      id: parsedJson['course_id'],
      // semester: parsedJson['semester'],
      courseName: parsedJson['course_name'],
      symbol:parsedJson['grade'],
      points:parsedJson['grade_num'],
    );
  }


}
