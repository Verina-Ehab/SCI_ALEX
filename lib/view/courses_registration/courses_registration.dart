// import 'package:flutter/cupertino.dart';
// import 'package:sci_alex/reusable_components/alert.dart';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:sci_alex/controller/database_helper.dart';
import 'package:sci_alex/reusable_components/background.dart';
import 'package:sci_alex/reusable_components/colors.dart';

class CoursesRegisteration extends StatefulWidget {
  const CoursesRegisteration({Key? key}) : super(key: key);

  @override
  State<CoursesRegisteration> createState() => _CoursesRegisterationState();
}

class _CoursesRegisterationState extends State<CoursesRegisteration> {
  var listOfCourses = DatabaseHelper().getCoursesRegistration(
      "http://192.168.1.11:8000/api/registration/registration");

  // List<User> users;
  List<int> selectedCourses = [];
  List<int> allHours = [];
  int hoursSum = 0;

  onSelectedRow(bool selected, int courseId, int courseHours) async {
    setState(() {
      if (selected) {
        selectedCourses.add(courseId);
        allHours.add(courseHours);
      } else {
        selectedCourses.remove(courseId);
        allHours.remove(courseHours);
      }
    });
  }

  sum() {
    // List<dynamic> hoursList =
    //     selectedcourses.map((course) => course.hours).toList();
    hoursSum = allHours.sum;
    setState(() {
      hoursSum = allHours.sum;
    });
    return '$hoursSum';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkBlue,
        onPressed: () {
          final idsString = selectedCourses.map((i) => i.toString()).join("*");
          //     selectedCourses.map((course) => course.id).join('*');
          final codes = selectedCourses.toString();
          // final codes =
          //     selectedCourses.map((course) => course.courseName).join(', ');

          // // Utils.showSnackBar(context, 'Selected courses: $names');
          DatabaseHelper().postCoursesRegistration(
              "http://192.168.1.11:8000/api/registration/create",
              idsString,
              context,
              codes);

          setState(() {
            selectedCourses.clear();
            allHours.clear();
          });
          // print(selectedCourses);
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(sum()),
            ),
            const Icon(Icons.done)
          ],
        ),
      ),
      body: Stack(children: [
        const BackgroundImg(),
        Padding(
          padding: const EdgeInsets.only(
            left: 60, /*top: 15, bottom: 15*/
          ),
          child: FutureBuilder(
              future: listOfCourses,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: tableBackground,
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 0))
                    ]),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        // sortAscending: sort,
                        sortColumnIndex: 2,
                        columnSpacing: 30,
                        dataTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 12),
                        headingTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 14),
                        headingRowHeight: 40,
                        // dataRowColor: MaterialStateProperty.all(shadowTextFieldBlue),
                        headingRowColor:
                            MaterialStateProperty.all(textFieldBlue),
                        showBottomBorder: true,
                        showCheckboxColumn: true,
                        columns: const [
                          DataColumn(label: Text("Course Code")),
                          DataColumn(label: Text("Course Name")),
                          DataColumn(label: Text("Hours")),
                          DataColumn(label: Text("Depaertment")),
                          DataColumn(label: Text("Lecture")),
                          DataColumn(label: Text("Final")),
                          // DataColumn(label: Text("Mid Grade")),
                          // DataColumn(label: Text("Semester Grades")),
                        ],
                        rows: List<DataRow>.generate(
                          snapshot.data.length,
                          (int i) => DataRow(
                            selected: selectedCourses
                                .contains(snapshot.data[i]['id']),
                            onSelectChanged: (b) {
                              onSelectedRow(b!, snapshot.data[i]['id'],
                                  snapshot.data[i]['course_hours']);
                            },
                            color: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              // All rows will have the same selected color.
                              if (states.contains(MaterialState.selected)) {
                                return Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.08);
                              }
                              // Even rows will have a grey color.
                              if (i.isEven) {
                                return Colors.white.withOpacity(0.5);
                              }
                              return null; // Use default value for other states and odd rows.
                            }),
                            cells: <DataCell>[
                              DataCell(Text("${snapshot.data[i]['id']}")),
                              DataCell(Text(snapshot.data[i]['course_name'])),
                              DataCell(
                                  Text("${snapshot.data[i]['course_hours']}")),
                              DataCell(Text(snapshot.data[i]['course_dep'])),
                              DataCell(Text(snapshot.data[i]['final'])),
                              DataCell(Text(snapshot.data[i]['lecture'])),
                            ],
                            // selected: selected[index],
                            // onSelectChanged: (bool? value) {
                            //   setState(() {
                            //     // selected[index] = value!;
                            //   });
                            // },
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ]),
    ));
  }
}




// academicBookTable(
//                                 "${snapshot.data[i]['id']}",
//                                 "${snapshot.data[i]['course_name']}",
//                                 "${snapshot.data[i]['course_dep']}",
//                                 "${snapshot.data[i]['final']}",
//                                 "${snapshot.data[i]['lecture']}",
//                                 // "${snapshot.data[i]['id']}",
//                                 // "${snapshot.data[i]['userId']}",
//                               ),


// [
//                                             DataRow(cells: [
//                                               DataCell(Text("${snapshot.data[i]['id']}")),
//                                               DataCell(Text(snapshot.data[i]['course_name'])),
//                                               DataCell(Text(snapshot.data[i]['course_dep'])),
//                                               DataCell(Text(snapshot.data[i]['final'])),
//                                               DataCell(Text(snapshot.data[i]['lecture'])),
//                                               // DataCell(Text(midGrade)),
//                                               // DataCell(Text(semesterGrades)),
//                                             ]),
//                                           ]











// import 'package:flutter/material.dart';
// import 'package:sci_alex/controller/database_helper.dart';
// import 'package:sci_alex/model/courses/course.dart';
// import 'package:sci_alex/reusable_components/background.dart';
// import 'package:sci_alex/reusable_components/colors.dart';

// class CoursesRegistration extends StatefulWidget {
//   const CoursesRegistration({Key? key}) : super(key: key);

//   @override
//   State<CoursesRegistration> createState() => _CoursesRegistrationState();
// }

// class _CoursesRegistrationState extends State<CoursesRegistration> {
//   List<Course>? courses;
//   List<Course>? selectedCourses;
//   bool sort= false;

//     Future init() async {
//     final courses = await DatabaseHelper().getCourses("http://192.168.1.11:8000/api/registration/registration");
//     // setState(() => this.courses = courses);
//   }
 
//   @override
// initState() {
//     sort= false;
//     selectedCourses = [];
//     init();
//     super.initState();
//   }
 
//   onSortColum(int columnIndex, bool ascending) {
//     if (columnIndex == 0) {
//       if (ascending) {
//         courses!.sort((a, b) => a.courseDep.compareTo(b.lecture));
//       } else {
//         courses!.sort((a, b) => b.lecture.compareTo(a.courseDep));
//       }
//     }
//   }
 
//   onSelectedRow(bool selected, Course course) async {
//     setState(() {
//       if (selected) {
//         selectedCourses!.add(course);
//       } else {
//         selectedCourses!.remove(course);
//       }
//     });
//   }

//   dataBody(){
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: DataTable(
//         sortAscending: sort,
//         sortColumnIndex: 0,
//         columns: [
//           DataColumn(
//               label: Text("FIRST NAME"),
//               numeric: false,
//               tooltip: "This is First Name",
//               onSort: (columnIndex, ascending) {
//                 setState(() {
//                   sort = !sort;
//                 });
//                 onSortColum(columnIndex, ascending);
//               }),
//           DataColumn(
//             label: Text("LAST NAME"),
//             numeric: false,
//             tooltip: "This is Last Name",
//           ),
//         ],
//         rows: courses!
//             .map(
//               (course) => DataRow(
//                       selected: selectedCourses!.contains(course),
//                       onSelectChanged: (b) {
//                         print("Onselect");
//                         onSelectedRow(b!, course);
//                       },
//                       cells: [
//                         DataCell(
//                           Text(course.courseDep),
//                           onTap: () {
//                             print('Selected ${course.courseDep}');
//                           },
//                         ),
//                         DataCell(
//                           Text(course.lecture),
//                         ),
//                       ]),
//             )
//             .toList(),
//       ),
//     );
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             floatingActionButton: FloatingActionButton(
//               backgroundColor: darkBlue,
//               onPressed: () {
//                 // final names =
//                 //     selectedcourses.map((course) => course.courseName).join(', ');

//                 // // Utils.showSnackBar(context, 'Selected courses: $names');
//                 // myDialog(context, "Registered Courses", names, 'DONE!');
//                 // setState(() {
//                 //   selectedcourses.clear();
//                 // });
//               },
//               child: Column(
//                 children: const [
//                   Padding(
//                     padding: EdgeInsets.only(top: 8.0),
//                     child: Text('0' /*sum()*/),
//                   ),
//                   const Icon(Icons.done)
//                 ],
//               ),
//             ),
//             body: Stack(
//               children: [
//                 const BackgroundImg(),
//                 Expanded(
//                     child: Center(
//                   child: dataBody(),
//                 ))
//               ],
//             )));
//   }


// }
