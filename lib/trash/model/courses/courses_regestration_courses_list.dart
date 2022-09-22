class CoursesList{

  final List<dynamic> courses;

  CoursesList({required this.courses});
  
  factory CoursesList.fromJson(Map<String, dynamic> json) {
    return CoursesList(
      courses: json['courses'],
    );
  }

  // static List<Course> parseCourse(jsonData){
  //   var list= jsonData['courses'] as List;
  //   List<Course> coursesList = list.map((e) => Course.fromJson(e)).toList();
  //   return coursesList;
  // }

}