// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sci_alex/controller/database_helper.dart';
import 'package:sci_alex/reusable_components/background.dart';
import 'package:sci_alex/reusable_components/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AcademicBook extends StatefulWidget {
  const AcademicBook({Key? key}) : super(key: key);

  @override
  State<AcademicBook> createState() => _AcademicBookState();
}

class _AcademicBookState extends State<AcademicBook> {
  String hours = '0';
  String cgp = '0';

  gtinfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      hours = prefs.getString('hours') ?? '0';
      cgp = prefs.getString('cgp') ?? "0";
    });
  }

  // var studentInfo =DatabaseHelper().getStudentInfo("http://192.168.1.11:8000/api/profile/show");
  // String hours= studentInfo['hours'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        const BackgroundImg(),
        Padding(
          padding: const EdgeInsets.only(
            left: 60, /*top: 15, bottom: 15*/
          ),
          child: FutureBuilder(
              future: DatabaseHelper().getAcademicBook(
                  "http://192.168.1.11:8000/api/registration/show"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      separatorBuilder: (BuildContext context, int i) {
                        return const SizedBox(height: 50);
                      },
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: tableBackground,
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 0))
                          ]),
                          child: Column(
                            children: [
                              academicBookLabel(
                                  "${snapshot.data[i]["semester_name"]}",
                                  cgp,
                                  cgp,
                                  hours,
                                  context),
                              academicBookTable(
                                "${snapshot.data[i]["courses"][i]["course_id"]}",
                                "${snapshot.data[i]["courses"][i]["course_name"]}",
                                "${snapshot.data[i]["courses"][i]['grade']}",
                                "${snapshot.data[i]["courses"][i]["grade_num"]}",
                                "${snapshot.data[i]["courses"][i]["grade"]}",
                                "${snapshot.data[i]["courses"][i]["grade"]}",
                                "${snapshot.data[i]["courses"][i]["grade"]}",
                              ),
                            ],
                          ),
                        );
                      });
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ]),
    ));
  }
}

academicBookLabel(String semester, String gpa, String cgpa, String hours,
    BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: DataTable(
        columnSpacing: (size.width - 60) / 8,
        dataTextStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12),
        headingTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14),
        headingRowHeight: 35,
        dataRowHeight: 35,
        // dataRowColor: MaterialStateProperty.all(shadowTextFieldBlue),
        headingRowColor: MaterialStateProperty.all(textFieldBlue),
        showBottomBorder: true,
        sortColumnIndex: 0,
        sortAscending: true,
        columns: const [
          DataColumn(label: Text("Semester")),
          DataColumn(label: Text("GPA")),
          DataColumn(label: Text("CGPA")),
          DataColumn(label: Text("Hours")),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(semester)),
            DataCell(Text(gpa)),
            DataCell(Text(cgpa)),
            DataCell(Text(hours)),
          ]),
        ]),
  );
}

// class AcademicBookTable extends StatelessWidget {
//   const AcademicBookTable({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

academicBookTable(
  String courseCode,
  String courseName,
  String symbol,
  String points,
  String hours,
  String midGrade,
  String semesterGrades,
) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        DataTable(
            columnSpacing: 30,
            dataTextStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12),
            headingTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14),
            headingRowHeight: 40,
            // dataRowColor: MaterialStateProperty.all(shadowTextFieldBlue),
            headingRowColor: MaterialStateProperty.all(textFieldBlue),
            showBottomBorder: true,
            showCheckboxColumn: true,
            sortColumnIndex: 0,
            sortAscending: true,
            columns: const [
              DataColumn(label: Text("Course Code")),
              DataColumn(label: Text("Course Name")),
              DataColumn(label: Text("Symbol")),
              DataColumn(label: Text("Points")),
              DataColumn(label: Text("Hours")),
              DataColumn(label: Text("Mid Grade")),
              DataColumn(label: Text("Semester Grades")),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text(courseCode)),
                DataCell(Text(courseName)),
                DataCell(Text(symbol)),
                DataCell(Text(points)),
                DataCell(Text(hours)),
                DataCell(Text(midGrade)),
                DataCell(Text(semesterGrades)),
              ]),
            ]),
      ],
    ),
  );
}
//   }
// }
