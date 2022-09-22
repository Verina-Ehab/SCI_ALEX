import 'package:flutter/material.dart';
import 'package:sci_alex/controller/database_helper.dart';
import 'package:sci_alex/reusable_components/alert.dart';
import 'package:sci_alex/reusable_components/background.dart';
import 'package:sci_alex/reusable_components/colors.dart';
import '../../model/courses_regestration_model/courses_regestration_course.dart';

class CoursesRegistration extends StatefulWidget {
  const CoursesRegistration({Key? key}) : super(key: key);

  @override
  _CoursesRegistrationState createState() => _CoursesRegistrationState();
}

class _CoursesRegistrationState extends State<CoursesRegistration> {
  List<CourseReg> courses = [];
  var listOfCourses = DatabaseHelper().getAcademicBook(
      "http://192.168.1.11:8000/api/registration/registration");
  List<CourseReg> selectedcourses = [];

  // sum() {
  //   List<dynamic> hoursList =
  //       selectedcourses.map((course) => course.hours).toList();
  //   int hoursSum = hoursList.sum;
  //   return '$hoursSum';
  // }

  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    final courses = await DatabaseHelper().getAcademicBook(
        "http://192.168.1.11:8000/api/registration/registration");

    // setState(() => this.courses = courses);
  }

  Widget buildDataTable() {
    final columns = [
      'Code',
      'Course',
      'courseDep',
      // 'Hours',
      // 'Recommended',
      'Lecture',
      'finalExam',
      // 'Doctor',
    ];

    return FutureBuilder(
        future: listOfCourses,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return DataTable(
            onSelectAll: (isSelectedAll) {
              setState(() => selectedcourses = isSelectedAll! ? courses : []);

              // Utils.showSnackBar(context, 'All Selected: $isSelectedAll');
            },
            columns: getColumns(columns),
            rows: getRows(
              courses,
              snapshot.data.id,
              snapshot.data.courseName,
              snapshot.data.courseDep,
              snapshot.data.finalExam,
              snapshot.data.lecture,
            ),
          );
        });
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
          ))
      .toList();

  List<DataRow> getRows(List<CourseReg> courses, int id, String courseName,
          String courseDep, String finalExam, String lecture) =>
      courses
          .map((CourseReg course) => DataRow(
                selected: selectedcourses.contains(course),
                onSelectChanged: (isSelected) => setState(() {
                  final isAdding = isSelected != null && isSelected;

                  isAdding
                      ? selectedcourses.add(course)
                      : selectedcourses.remove(course);
                }),
                cells: [
                  const DataCell(SizedBox(
                    width: 100,
                    child: Text('course.code'),
                  )),
                  const DataCell(SizedBox(
                    width: 100,
                    child: Text('course.name'),
                  )),
                  DataCell(SizedBox(
                    width: 100,
                    child: Text(('course.hours').toString()),
                  )),
                  const DataCell(SizedBox(
                    width: 100,
                    child: Text('course.recommended'),
                  )),
                  // DataCell(Container(
                  //   width: 100,
                  //   child: Text((course.lecture).toString()),
                  // )),
                  const DataCell(SizedBox(
                    width: 100,
                    child: Text('course.doc'),
                  )),
                ],
              ))
          .toList();

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: darkBlue,
            onPressed: () {
              final names =
                  selectedcourses.map((course) => course.courseName).join(', ');

              // Utils.showSnackBar(context, 'Selected courses: $names');
              myDialog(context, "Registered Courses", names, 'DONE!');
              setState(() {
                selectedcourses.clear();
              });
            },
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('0' /*sum()*/),
                ),
                Icon(Icons.done)
              ],
            ),
          ),
          body: courses.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                  ),
                )
              : Stack(
                  children: [
                    const BackgroundImg(),
                    Padding(
                      padding: const EdgeInsets.only(left: 60.0),
                      child: FutureBuilder(
                          future: listOfCourses,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int i) {
                                  //   return
                                  //   ListView.builder(
                                  // physics: const BouncingScrollPhysics(),
                                  // itemCount: snapshot.data/*.courses*/.length,
                                  // itemBuilder: (BuildContext context, int i1) {
                                  return Column(
                                    children: [
                                      Container(
                                        decoration:
                                            const BoxDecoration(boxShadow: [
                                          BoxShadow(
                                              color: tableBackground,
                                              spreadRadius: 0,
                                              blurRadius: 10,
                                              offset: Offset(0, 0))
                                        ]),
                                        child: Column(
                                          children: [
                                            // TableLabel('snapshot.data[i].content'),
                                            SingleChildScrollView(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: buildDataTable()),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 80),
                                    ],
                                  );
                                },
                                // );;
                                // },
                              );
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                    ),
                  ],
                ),
        ),
      );
}

// ListView(
//   children: [
// ListView.builder(
//     physics: const BouncingScrollPhysics(),
//     itemCount: 1,
//     itemBuilder: (BuildContext context, int i) {
//       return Column(
//         children: [

//           Container(
//         decoration: const BoxDecoration(boxShadow: [
//           BoxShadow(
//               color: tableBackground,
//               spreadRadius: 0,
//               blurRadius: 10,
//               offset: Offset(0, 0))
//         ]),
//         child: Column(
//           children: [
//             TableLabel("Major Mendatory"),
//             SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 child: buildDataTable()),
//           ],
//         ),
//       ),
//       const SizedBox(height: 80),
//         ],
//       );
//     },
// ),
// ListView.builder(
//     physics: const BouncingScrollPhysics(),
//     itemCount: 1,
//     itemBuilder: (BuildContext context, int i) {
//       return Column(
//         children: [

//           Container(
//         decoration: const BoxDecoration(boxShadow: [
//           BoxShadow(
//               color: tableBackground,
//               spreadRadius: 0,
//               blurRadius: 10,
//               offset: Offset(0, 0))
//         ]),
//         child: Column(
//           children: [
//             TableLabel("Major Optional"),
//             SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 child: buildDataTable()),
//           ],
//         ),
//       ),
//       const SizedBox(height: 80),
//         ],
//       );
//     },
// ),
// ListView.builder(
//     physics: const BouncingScrollPhysics(),
//     itemCount: 1,
//     itemBuilder: (BuildContext context, int i) {
//       return Column(
//         children: [

//           Container(
//         decoration: const BoxDecoration(boxShadow: [
//           BoxShadow(
//               color: tableBackground,
//               spreadRadius: 0,
//               blurRadius: 10,
//               offset: Offset(0, 0))
//         ]),
//         child: Column(
//           children: [
//             TableLabel("Minor Mendatory"),
//             SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 child: buildDataTable()),
//           ],
//         ),
//       ),
//       const SizedBox(height: 80),
//         ],
//       );
//     },
// ),
// ListView.builder(
//     physics: const BouncingScrollPhysics(),
//     itemCount: 1,
//     itemBuilder: (BuildContext context, int i) {
//       return Column(
//         children: [

//           Container(
//         decoration: const BoxDecoration(boxShadow: [
//           BoxShadow(
//               color: tableBackground,
//               spreadRadius: 0,
//               blurRadius: 10,
//               offset: Offset(0, 0))
//         ]),
//         child: Column(
//           children: [
//             TableLabel("Minor Optional"),
//             SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 child: buildDataTable()),
//           ],
//         ),
//       ),
//       const SizedBox(height: 80),
//         ],
//       );
//     },
// ),
// ListView.builder(
//     physics: const BouncingScrollPhysics(),
//     itemCount: 1,
//     itemBuilder: (BuildContext context, int i) {
//       return Column(
//         children: [

//           Container(
//         decoration: const BoxDecoration(boxShadow: [
//           BoxShadow(
//               color: tableBackground,
//               spreadRadius: 0,
//               blurRadius: 10,
//               offset: Offset(0, 0))
//         ]),
//         child: Column(
//           children: [
//             TableLabel("Free Choice"),
//             SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 child: buildDataTable()),
//           ],
//         ),
//       ),
//       const SizedBox(height: 80),
//         ],
//       );
//     },
// ),
// ListView.builder(
//     physics: const BouncingScrollPhysics(),
//     itemCount: 1,
//     itemBuilder: (BuildContext context, int i) {
//       return Column(
//         children: [

//           Container(
//         decoration: const BoxDecoration(boxShadow: [
//           BoxShadow(
//               color: tableBackground,
//               spreadRadius: 0,
//               blurRadius: 10,
//               offset: Offset(0, 0))
//         ]),
//         child: Column(
//           children: [
//             TableLabel("College Requirement"),
//             SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 child: buildDataTable()),
//           ],
//         ),
//       ),
//       const SizedBox(height: 80),
//         ],
//       );
//     },
// ),

//   ],
// );
