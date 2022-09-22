class SearchCourse {
  final int id;
  final String courseName;
  final String courseDep;
  final String courseRequire;
  final String courseType;
  final String instractorName;
  final String description;
  final String hours;

  SearchCourse({
    required this.id,
    required this.courseName,
    required this.courseDep,
    required this.courseRequire,
    required this.courseType,
    required this.instractorName,
    required this.description,
    required this.hours,
  });

  factory SearchCourse.fromJson(Map<String, dynamic> parsedJson) {
    return SearchCourse(
      id: parsedJson['id'],
      courseName: parsedJson['course_name'],
      courseDep: parsedJson['course_dep'],
      courseRequire: parsedJson['course_require'],
      courseType: parsedJson['course_type'],
      instractorName: parsedJson['instractor_name'],
      description: parsedJson['description'],
      hours: parsedJson['hours'],
    );
  }
}
