import 'package:flutter/material.dart';
import 'package:sci_alex/controller/database_helper.dart';
import 'package:sci_alex/reusable_components/background.dart';
import 'package:sci_alex/reusable_components/colors.dart';

// import 'package:sci_alex/reusable_components/alert.dart';
// import 'package:collection/collection.dart';
// import 'package:flutter/cupertino.dart';

class OpenCoursesReq extends StatefulWidget {
  const OpenCoursesReq({Key? key}) : super(key: key);

  @override
  State<OpenCoursesReq> createState() => _OpenCoursesReqState();
}

class _OpenCoursesReqState extends State<OpenCoursesReq> {
  var listOfCourses = DatabaseHelper()
      .getOpenCourses("http://192.168.1.11:8000/api/open_course/show");

  var courseIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        const BackgroundImg(),
        Padding(
          padding: const EdgeInsets.only(
            left: 60, /*top: 15, bottom: 15*/
          ),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      alignment: Alignment.center,
                      width: 90,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: shadowTextFieldBlue,
                      ),
                      child: InkWell(
                          child: const Text(
                            "Send",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          onTap: () {
                            DatabaseHelper().postOpenCourse(
                                "http://192.168.1.11:8000/api/open_course/store",
                                courseIDController.text);
                            setState(() {
                              courseIDController.text = "";
                            });
                          }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        style: const TextStyle(color: darkBlue),
                        controller: courseIDController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Enter cours code';
                          }
                          return null;
                        },
                        cursorColor: darkBlue,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                            fillColor: textFieldBlue,
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 14),
                            hintText: "Enter course code..",
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    color: darkBlue))),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Expanded(
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
                              headingRowColor:
                                  MaterialStateProperty.all(textFieldBlue),
                              showBottomBorder: true,
                              showCheckboxColumn: true,
                              columns: const [
                                DataColumn(label: Text("Code")),
                                DataColumn(label: Text("Name")),
                                DataColumn(label: Text("Hours")),
                                DataColumn(label: Text("Depaertment")),
                                DataColumn(label: Text("Instructor")),
                                DataColumn(label: Text("Require")),
                              ],
                              rows: List<DataRow>.generate(
                                snapshot.data.length,
                                (int i) => DataRow(
                                  color:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    if (i.isEven) {
                                      return Colors.white.withOpacity(0.5);
                                    }
                                    return null; // Use default value for other states and odd rows.
                                  }),
                                  cells: <DataCell>[
                                    DataCell(Text("${snapshot.data[i]['id']}")),
                                    DataCell(
                                        Text(snapshot.data[i]['course_name'])),
                                    DataCell(
                                        Text("${snapshot.data[i]['hours']}")),
                                    DataCell(
                                        Text(snapshot.data[i]['course_dep'])),
                                    DataCell(Text(
                                        snapshot.data[i]['instractor_name'])),
                                    DataCell(Text(
                                        snapshot.data[i]['course_require'])),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
