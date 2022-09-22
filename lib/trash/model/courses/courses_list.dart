// import 'package:sci_alex/model/courses/course_kind.dart';

// class CoursesList{

//   final Map<String,CourseKind> courses;

//   CoursesList({required this.courses});
  
//   factory CoursesList.fromJson(Map<String, dynamic> jsonData) {
//     return CoursesList(
//      courses: jsonData['courses'],
//     );
//   }
// }


  // Future<List<CoursesList1>> getCourses(String url,) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.get('api-Token');

  //   Response response =
  //       await get(Uri.parse(url), headers: {'auth.token': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC4xLjExOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNjUzNjcyNjEzLCJleHAiOjE2NTQyNzc0MTMsIm5iZiI6MTY1MzY3MjYxMywianRpIjoiSGNyNG9rdEdlOEliM1A4UCIsInN1YiI6IjIwMTkiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.JvE304IZ438OZTjBikaJ3wjyl0AIlRnoliPBZLCmyWY'});
  //   var responsebody = jsonDecode(response.body);
  //   // // print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++$responsebody['courses']");
  //   // // return responsebody;
  //   // CoursesList1 courses = CoursesList1.fromJson(responsebody);
  //   // print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++$courses");
  //   // return courses;
  //   CoursesList1 posts = CoursesList1.fromJson(responsebody);
  //     List<CoursesList1> postsList = posts.courses.cs.map((e) => CoursesList1.fromJson(e)).toList();
  //     return postsList;

    
  //   // List<CoursesList1>  parseCourses(String responseBody){
  //   //   final parsed= jsonDecode(response.body);
  //   //   return parsed.map<CoursesList1>((json) => CoursesList1.fromJson(json)).toList();
  //   // }
  //   // List<CoursesList1> list= parseCourses(response.body);
  //   // return list;

  //     // CoursesList courses = CoursesList.fromJson(responsebody);
  //     // List<CourseKind> coursekind = courses.courses.map((e) => CourseKind.fromJson(e)).toList();
  //     // List<Course> coursesList = courses.courses.map((e) => Course.fromJson(e)).toList();
  //     // return coursesList;

  // }