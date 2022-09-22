// var myData={"status": true,"errNum": "S000","msg": "success",
//     "courses": { //address
//       "free_choice": [ //images
//             {
//                 "id": 20,
//                 "semester": "summer2010",
//                 "course_name": "Presentation skills",
//                 "course_dep": "free_choice",
//                 "final": "12/12/2020",
//                 "lecture": "sat 4 pm hall 4",
//                 "created_at": null,
//                 "updated_at": null,
//                 "deleted_at": null
//             },
//             {
//                 "id": 19,
//                 "semester": "summer2010",
//                 "course_name": "ecotourism",
//                 "course_dep": "free_choice",
//                 "final": "12/12/2020",
//                 "lecture": "sat 4 pm hall 4",
//                 "created_at": null,
//                 "updated_at": null,
//                 "deleted_at": null
//             }
//         ],}
// };


// class CoursesList1{
//   final Course1 courses;

//   CoursesList1( 
//  {required this.courses,
//   });

//   factory CoursesList1.fromJson(Map<String, dynamic> jsonData) {
//     return CoursesList1(
//       courses: Course1.fromJson(jsonData['courses']),
//     );
//   }

// }


// class Course1{
//   final List<Map<String,CourseKind1>> cs;
//   final List<Map<String,CourseKind1>> stat;
//   final List<Map<String,CourseKind1>> freeChoice;
//   final List<Map<String,CourseKind1>> univRequire;

//   Course1( 
//  {required this.cs,
//     required this.stat,
//     required this.freeChoice,
//     required this.univRequire,
//   });

//   factory Course1.fromJson(Map<String, dynamic> jsonData) {
//     return Course1(
//       cs: parseCourses(jsonData,'cs'),
//       freeChoice: parseCourses(jsonData,'free_choice'),
//       stat: parseCourses(jsonData,'stat'),
//       univRequire: parseCourses(jsonData,'univ_require'),
//     );
//   }

//     static List<Map<String,CourseKind1>> parseCourses(courseJson, String kind){   
//     var list = courseJson[kind] as List;
//     List<Map<String,CourseKind1>> courseList =list.map((data) => CourseKind1.fromJson(data));
//     return courseList;
//   }

// }


// class CourseKind1{
//   final int id;
//   final String semester;
//   final String courseName;
//   final String courseDep;
//   final String finalExam;
//   final String lecture;

//   CourseKind1( 
//  {required this.lecture,
//     required this.id,
//     required this.semester,
//     required this.courseName,
//     required this.courseDep,
//     required this.finalExam,
//   });

//   factory CourseKind1.fromJson(Map<String, dynamic> parsedJson) {
//     return CourseKind1(
//       id: parsedJson['id'] as int,
//       semester: parsedJson['semester'],
//       courseName: parsedJson['course_name'],
//       courseDep: parsedJson['course_dep'],
//       finalExam: parsedJson['final'],
//       lecture: parsedJson['lecture'],
//     );
//   }

// }