// import 'package:sci_alex/model/courses/course.dart';

// class CourseKind {
//   // final List<Course> cs;
//   // final List<Course> stat;
//   // final List<Course> freeChoice;
//   // final List<Course> univRequire;

//   final Map<String, Course> cs;
//   final Map<String, Course> stat;
//   final Map<String, Course> freeChoice;
//   final Map<String, Course> univRequire;


//   CourseKind({
//     required this.cs,
//     required this.stat,
//     required this.freeChoice,
//     required this.univRequire,
//   });

//   factory CourseKind.fromJson(Map<String, dynamic> parsedJson) {
//     return CourseKind(
//       // cs: parseCourses(jsonData,'cs'),
//       // freeChoice: parseCourses(jsonData,'free_choice'),
//       // stat: parseCourses(jsonData,'stat'),
//       // univRequire: parseCourses(jsonData,'univ_require'),

//       cs: parsedJson['cs'],
//       freeChoice: parsedJson['free_choice'],
//       stat: parsedJson['stat'],
//       univRequire:parsedJson['univ_require'],

//     );
//   }

//   static List<Course> parseCourses(courseJson, String kind){
//     // static List<String> parsePlaces(placesJson) {
//     // var list = imagesJson['images'] as List;
//     // List<Images> imagesList =
//     //     list.map((data) => Images.fromJson(data)).toList();
//     // return imagesList;
    
//     var list = courseJson[kind] as List;
//     List<Course> courseList =list.map((data) => Course.fromJson(data)).toList();
//     return courseList;
//   }

// }
