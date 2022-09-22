class AllCourses{

  final Map<String,dynamic> courses;

  AllCourses({required this.courses});
  
  factory AllCourses.fromJson(Map<String, dynamic> jsonData) {
    return AllCourses(
      courses: jsonData['courses'],
    );
  }
}