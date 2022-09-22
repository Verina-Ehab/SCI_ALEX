import 'package:flutter/material.dart';
import 'package:sci_alex/controller/database_helper.dart';
import 'package:sci_alex/reusable_components/background.dart';
import 'package:sci_alex/reusable_components/colors.dart';

// import 'package:collection/collection.dart';
// import 'package:sci_alex/reusable_components/alert.dart';
// import 'package:flutter/cupertino.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({Key? key}) : super(key: key);

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  var listOfCourses = DatabaseHelper()
      .getOpenCourses("http://192.168.1.11:8000/api/open_course/show");

  @override
  Widget build(BuildContext context) {
    // Size size= MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
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
                          DataColumn(label: Text("Code")),
                          DataColumn(label: Text("Name")),
                          DataColumn(label: Text("Recommended")),
                          DataColumn(label: Text("Depaertment")),
                          DataColumn(label: Text("Instructor")),
                          DataColumn(label: Text("Require")),
                        ],
                        rows: List<DataRow>.generate(
                          snapshot.data.length,
                          (int i) => DataRow(
                            // selected: selectedCourses
                            //     .contains(snapshot.data[i]['id']),
                            // onSelectChanged: (b) {
                            //   onSelectedRow(b!, snapshot.data[i]['id'], snapshot.data[i]['course_hours']);
                            // },
                            color: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              // All rows will have the same selected color.
                              // if (states.contains(MaterialState.selected)) {
                              //   return Theme.of(context)
                              //       .colorScheme
                              //       .primary
                              //       .withOpacity(0.08);
                              // }
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
                                  Text("${snapshot.data[i]['recomended']}")),
                              DataCell(Text(snapshot.data[i]['course_dep'])),
                              DataCell(
                                  Text(snapshot.data[i]['instractor_name'])),
                              DataCell(
                                  Text(snapshot.data[i]['course_require'])),
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
