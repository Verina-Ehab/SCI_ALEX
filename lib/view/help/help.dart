import 'dart:convert';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sci_alex/reusable_components/background.dart';
import 'package:sci_alex/reusable_components/colors.dart';
import 'package:sci_alex/reusable_components/my_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:sci_alex/controller/database_helper.dart';
// import '../../model/search/search_course.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  // var courseIDcontroller = TextEditingController() ;
  // var courseInfo;
  //   _onPressed() {
  //   setState(() {
  //      courseInfo = DatabaseHelper().getCouseInfo(
  //     "http://192.168.1.11:8000/api/help/InformationAboutCourse", courseIDcontroller.text);
  //   });
  // }
  // int courseID= int.parse(courseIDcontroller);

  List<dynamic> listsearch = [];
  var country;
  Future getData() async {
    var url = "http://10.0.2.2:8080/mobtech/search.php";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('api-Token');
    var response = await get(Uri.parse(url), headers: {'auth.token': '$token'});
    var resonsebody = jsonDecode(response.body);
    for (int i = 0; i < resonsebody.length; i++) {
      listsearch.add(resonsebody['course']['course_name']);
    }
    // print(listsearch);
  }

  Future<dynamic> myBottomSheet(BuildContext context, List<dynamic> info) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        isScrollControlled: true,
        context: context,
        builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.6,
            maxChildSize: 1,
            minChildSize: 0.35,
            builder: (_, controller) => Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: ListView(
                    controller: controller,
                    children: [
                      BulletedList(
                        style: const TextStyle(
                          color: darkBlue,
                        ),
                        listItems: info,
                        // bulletType: BulletType.numbered,
                        bullet: const Icon(
                          Icons.circle,
                          color: darkBlue,
                          size: 13,
                        ),
                      ),
                    ],
                  ),
                )));
  }

  // Future<dynamic> myBottomSheetCourse(BuildContext context,) {
  //   return showModalBottomSheet(
  //       backgroundColor: Colors.transparent,
  //       // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (context) => DraggableScrollableSheet(
  //           initialChildSize: 0.6,
  //           maxChildSize: 1,
  //           minChildSize: 0.35,
  //           builder: (_, controller) => Container(
  //               decoration: const BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.all(Radius.circular(30)),
  //               ),
  //               padding: const EdgeInsets.all(8),
  //               child: Column(
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(20.0),
  //                     child: TextFormField(
  //                       // onChanged: _onPressed,
  //                       style: const TextStyle(color: darkBlue),
  //                       controller: courseIDcontroller,
  //                       cursorColor: darkBlue,
  //                       keyboardType: TextInputType.number,
  //                       decoration: const InputDecoration(
  //                           filled: true,
  //                           contentPadding: EdgeInsets.all(15),
  //                           fillColor: textFieldBlue,
  //                           prefixIcon: Padding(
  //                               padding: EdgeInsets.only(left: 20),
  //                               child: Icon(
  //                                 Icons.search,
  //                                 color: darkBlue,
  //                               )),
  //                           labelText: "Enter Course ID",
  //                           labelStyle: TextStyle(
  //                               color: darkBlue, fontWeight: FontWeight.w500),
  //                           border: OutlineInputBorder(
  //                               borderSide: BorderSide.none,
  //                               borderRadius:
  //                                   BorderRadius.all(Radius.circular(40))),
  //                           focusedBorder: OutlineInputBorder(
  //                               borderSide: BorderSide(
  //                                   style: BorderStyle.solid, color: darkBlue))),
  //                     ),
  //                   ),
  //                           FutureBuilder(future: courseInfo,
  //                   builder: (BuildContext context, AsyncSnapshot snapshot) {
  //                     if (snapshot.hasData) {
  //                           return Column();
  //                     }
  //                     return const Center(child: CircularProgressIndicator());
  //                   }
  //                     ),
  //                 ],
  //               ))));
  // }

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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // width: (size.width)-70,
                    padding: const EdgeInsets.only(top: 15),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        boxShadow: [
                          BoxShadow(
                              color: shadowTextFieldBlue,
                              spreadRadius: 0,
                              blurRadius: 50,
                              offset: Offset(-30, 0))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        BulletedList(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          listItems: [
                            '**With reference to the request for exemption from receiving the Corona vaccine. It\'s okay to do a weekly PCR swab.',
                            'The effect of the academic warning (half-load) is cancelled if a student receives a cumulative rate of at least 2.',
                            'The number of alarms is increased after each semester if the cumulative rate is less than 2.',
                            'The school burden is reduced to 12 hours if a student receives a GPA of less than 2.0.',
                            'A student is disqualified if he or she receives 4 separate academic alerts or three connected ones.',
                            'Format requests, route switching, and special class are only made through the system and on scheduled dates; no paper requests are accepted.',
                            'All students are required to register on the attached form as per the decision of the Vice Chancellor for Education and Student Affairs. Link',
                            'All student complaints and applications must be submitted on an official "complaint form" to the complaints office of Muharram Bey. Oral requests or complaints on Whatsapp or by phone or any other means are ignored.',
                            '** Student can register between 12-13 Credit Hours (Min) to 17 Credit Hours (Min).',
                            '** A student with a cumulative average of 3 points or more and who has completed at least 33 credit hours may score 19 credits in the basic term.',
                            '** A student will not be allowed to enroll in any course unless he or she meets the requirements prior to that course; a "fourth-level student" may be allowed to enrol in a course and previous requirement where he or she has "previously studied and failed" as an attendant.',
                            '** The graduation requirements may record a student for 21 hours provided that the cumulative rate is not less than 3.',
                          ],
                          // bulletType: BulletType.numbered,
                          bullet: Icon(
                            Icons.circle,
                            color: Colors.white,
                            size: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        boxShadow: [
                          BoxShadow(
                              color: shadowTextFieldBlue,
                              spreadRadius: 0,
                              blurRadius: 100,
                              offset: Offset(0, 2))
                        ]),
                    child: Column(
                      children: [
                        MyButton(
                          text: 'About Courses',
                          onPress: () => showSearch(
                              context: context,
                              delegate: DataSearch(list: listsearch)),
                          width: (size.width) - 80,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MyButton(
                          text: 'About Doctors',
                          onPress: () => showSearch(
                              context: context,
                              delegate: DataSearch(list: listsearch)),
                          width: (size.width) - 80,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MyButton(
                          text: 'About Credit Hours System',
                          onPress: () => myBottomSheet(context, [
                            '**With reference to the request for exemption from receiving the Corona vaccine. It\'s okay to do a weekly PCR swab.',
                            'The effect of the academic warning (half-load) is cancelled if a student receives a cumulative rate of at least 2.',
                            'The number of alarms is increased after each semester if the cumulative rate is less than 2.',
                            'The school burden is reduced to 12 hours if a student receives a GPA of less than 2.0.',
                            'A student is disqualified if he or she receives 4 separate academic alerts or three connected ones.',
                            'Format requests, route switching, and special class are only made through the system and on scheduled dates; no paper requests are accepted.',
                            'All students are required to register on the attached form as per the decision of the Vice Chancellor for Education and Student Affairs. Link',
                            'All student complaints and applications must be submitted on an official "complaint form" to the complaints office of Muharram Bey. Oral requests or complaints on Whatsapp or by phone or any other means are ignored.',
                            '** Student can register between 12-13 Credit Hours (Min) to 17 Credit Hours (Min).',
                            '** A student with a cumulative average of 3 points or more and who has completed at least 33 credit hours may score 19 credits in the basic term.',
                            '** A student will not be allowed to enroll in any course unless he or she meets the requirements prior to that course; a "fourth-level student" may be allowed to enrol in a course and previous requirement where he or she has "previously studied and failed" as an attendant.',
                            '** The graduation requirements may record a student for 21 hours provided that the cumulative rate is not less than 3.',
                          ]),
                          width: (size.width) - 80,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MyButton(
                          width: (size.width) - 80,
                          text: 'About APP',
                          onPress: () => myBottomSheet(context, [
                            '**With reference to the request for exemption from receiving the Corona vaccine. It\'s okay to do a weekly PCR swab.',
                            'The effect of the academic warning (half-load) is cancelled if a student receives a cumulative rate of at least 2.',
                            'The number of alarms is increased after each semester if the cumulative rate is less than 2.',
                            'The school burden is reduced to 12 hours if a student receives a GPA of less than 2.0.',
                            'A student is disqualified if he or she receives 4 separate academic alerts or three connected ones.',
                            'Format requests, route switching, and special class are only made through the system and on scheduled dates; no paper requests are accepted.',
                            'All students are required to register on the attached form as per the decision of the Vice Chancellor for Education and Student Affairs. Link',
                            'All student complaints and applications must be submitted on an official "complaint form" to the complaints office of Muharram Bey. Oral requests or complaints on Whatsapp or by phone or any other means are ignored.',
                            '** Student can register between 12-13 Credit Hours (Min) to 17 Credit Hours (Min).',
                            '** A student with a cumulative average of 3 points or more and who has completed at least 33 credit hours may score 19 credits in the basic term.',
                            '** A student will not be allowed to enroll in any course unless he or she meets the requirements prior to that course; a "fourth-level student" may be allowed to enrol in a course and previous requirement where he or she has "previously studied and failed" as an attendant.',
                            '** The graduation requirements may record a student for 21 hours provided that the cumulative rate is not less than 3.',
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ]),
    ));
  }
}

class DataSearch extends SearchDelegate<String> {
  List<dynamic> list;
  DataSearch({required this.list});
  Future getsearchdata() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('api-Token');
    var url = "http://192.168.1.11:8000/api/help/InformationAboutCourse";
    var data = {"course_id": query};
    var response = await post(Uri.parse(url),
        body: data, headers: {'auth.token': '$token'});
    var responsebody = jsonDecode(response.body);
    // SearchCourse course = SearchCourse.fromJson(responsebody['course']);

    // print(course);
    return responsebody['course'];
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // Action for AppBar
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon Leading
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Size size= MediaQuery.of(context).size;
    // Results search
    return FutureBuilder(
      future: getsearchdata(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: 1, //snapshot.data.length
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Text(
                        snapshot.data['course_name'],
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Department:  ${snapshot.data['course_dep']}",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Instractor:  ${snapshot.data['instractor_name']}",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Description:  ${snapshot.data['description']}",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Hours:  ${snapshot.data['hours']}",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Recommended:  ${snapshot.data['course_require']}",
                      ),
                    ],
                  ),
                );
              });
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searchers for something
    var searchlist = query.isEmpty
        ? list
        : list.where((p) => p.toLowerCase().contains(query)).toList();
    return ListView.builder(
        itemCount: searchlist.length,
        itemBuilder: (context, i) {
          return ListTile(
            // leading: Icon(Icons.arrow_back_ios),
            title: Text(searchlist[i]),
            onTap: () {
              query = searchlist[i];
              showResults(context);
            },
          );
        });
  }
}



// SingleChildScrollView(
  //   controller: ModalScrollController.of(context),
  //   child: Container(),
  // ),


  // ListView.builder(
  //                   physics: const BouncingScrollPhysics(),
  //                   itemCount: 2,
  //                   itemBuilder: (BuildContext context, int i) {
  //                     return Column(
  //                       children: const [
  //                         ListTile(
  //                           title: Text('Simulation'),
  //                           subtitle: Text('Computer/Statistics'),
  //                         ),
  //                         SizedBox(height: 10),
  //                       ],
  //                     );
  //                   },
  //                 )