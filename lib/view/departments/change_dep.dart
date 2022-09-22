import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sci_alex/controller/database_helper.dart';
import 'package:sci_alex/reusable_components/alert.dart';
import 'package:sci_alex/reusable_components/background.dart';
import 'package:sci_alex/reusable_components/colors.dart';
// import 'package:sci_alex/view/home/homeNavigation.dart';
// import 'package:sci_alex/view/login/login.dart';
// import 'package:bulleted_list/bulleted_list.dart';

class Departments extends StatefulWidget {
  const Departments({Key? key}) : super(key: key);

  @override
  State<Departments> createState() => _DepartmentsState();
}

class _DepartmentsState extends State<Departments> {
  int lang = 1;
  // List newOrder=[];
  List<String> departments = [
    "cs",
    "stat",
    "phy",
    "chem",
    "Oceanography",
    "math",
    "bio"
  ]; // List<Department> departments = [];

  sendRequest() {
    //  DatabaseHelper().sendRghpat("http://127.0.0.1:8000/api/raghpat/store",departments);
    myDialog(context, "", "Your request sent successfuly", 'Done!');
  }

  Future<dynamic> bottomSheetMajor(BuildContext context) {
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
                  // padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            'Registration start from',
                            style: TextStyle(
                                fontSize: 18,
                                color: darkBlue,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '30/12/2022  to  30/1/2023',
                            style: TextStyle(
                                fontSize: 18,
                                color: darkBlue,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 45),
                          const Text(
                            "Reorder departments as desired,",
                            style: TextStyle(
                                fontSize: 16,
                                color: darkBlue,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "just drag & drop",
                            style: TextStyle(
                                fontSize: 16,
                                color: darkBlue,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 110.0),
                            height: 300,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60)),
                                boxShadow: [
                                  BoxShadow(
                                      color: shadowTextFieldBlue,
                                      spreadRadius: 0,
                                      blurRadius: 100,
                                      offset: Offset(0, 2))
                                ]),
                            child: ReorderableListView.builder(
                              // prototypeItem: const Card(
                              //   child: Padding(
                              //     padding: EdgeInsets.all(15.0),
                              //     child: Text(
                              //       "Order Ascending",
                              //       style: TextStyle(
                              //           fontSize: 16, color: Colors.black),
                              //     ),
                              //   ),
                              // ),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              physics: const AlwaysScrollableScrollPhysics(),
                              // header: Column(
                              //   children: const [
                              //     Text(
                              //       "Reorder departments as desired,",
                              //       style: TextStyle(
                              //           fontSize: 16,
                              //           color: Colors.white,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //     Text(
                              //       "just drag & drop",
                              //       style: TextStyle(
                              //           fontSize: 16,
                              //           color: Colors.white,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //   ],
                              // ),
                              itemCount: departments.length,
                              onReorder: (oldIndex, newIndex) => setState(() {
                                final index = newIndex > oldIndex
                                    ? newIndex - 1
                                    : newIndex;

                                final department =
                                    departments.removeAt(oldIndex);
                                departments.insert(index, department);
                                // newOrder.add(departments[index]);
                                // print(newOrder);
                                // print(departments);
                              }),
                              itemBuilder: (context, index) {
                                final department = departments[index];
                                // setState(() {
                                //   newOrder.add(departments[index]);

                                // });
                                // print(newOrder);

                                return buildDepartment(index, department);
                              },
                            ),
                          ),
                          const SizedBox(height: 50),
                          CupertinoButton(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: darkBlue,
                              child: const Text(
                                "Submit",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                final idsString = departments
                                    .map((i) => i.toString())
                                    .join("*");
                                DatabaseHelper().postMajorMinor(
                                    "http://192.168.1.11:8000/api/registration/create",
                                    idsString);
                              }
                              // sendRequest()
                              ),
                          const SizedBox(height: 15),
                        ],
                      );
                    },
                  ),
                )));
  }

  Widget buildDepartment(int index, String s /*Department department*/) => Row(
        key: ValueKey(s),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              s,
              style: TextStyle(fontSize: 16, color: Colors.grey[300]),
            ),
          ),
        ],
      );

  Future<dynamic> bottomSheetChange(BuildContext context) {
    // Size size= MediaQuery.of(context).size;
    final items = ['cs/stat', 'stat/cs', 'chem/phy', 'phy/chem', 'math/cs'];
    var selectedValue;

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
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int i) {
                      return Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 25),
                            const Text(
                              'Registration start from',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: darkBlue,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              '30/12/2022  to  30/1/2023',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: darkBlue,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 45),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 70.0),
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: shadowTextFieldBlue,
                                        spreadRadius: 10,
                                        blurRadius: 100,
                                        offset: Offset(0, 2))
                                  ]),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    // decoration: InputDecoration(
                                    //   contentPadding: EdgeInsets.zero,
                                    //   border: OutlineInputBorder(
                                    //       borderRadius:
                                    //           BorderRadius.circular(15)),
                                    // ),
                                    hint: const Center(
                                        child: Text(
                                      "Select a department",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconDisabledColor: textFieldBlue,
                                    iconEnabledColor: darkBlue,
                                    iconSize: 30,
                                    // dropdownDecoration: BoxDecoration(),
                                    isExpanded: true,
                                    // value: selectedValue,
                                    items: items
                                        .map((e) => DropdownMenuItem(
                                            child: Text(e), value: e))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        selectedValue = val;
                                      });
                                    }),
                              ),
                            ),
                            const SizedBox(height: 170),
                            CupertinoButton(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: darkBlue,
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Fluttertoast.showToast(
                                      msg: "Can not send your request",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: shadowTextFieldBlue,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }),
                            const SizedBox(height: 15),
                          ],
                        ),
                      );
                    },
                  ),
                )));
  }

  Future<dynamic> bottomSheetSpecial(BuildContext context) {
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
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: [
                          const SizedBox(height: 25),
                          const Text(
                            'Registration start from',
                            style: TextStyle(
                                fontSize: 18,
                                color: darkBlue,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '30/12/2022  to  30/1/2023',
                            style: TextStyle(
                                fontSize: 18,
                                color: darkBlue,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 170),
                          const Text(
                            'Just press to',
                            style: TextStyle(
                              fontSize: 14,
                              color: darkBlue,
                            ),
                          ),
                          CupertinoButton(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: darkBlue,
                              child: const Text(
                                "Send your request",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Fluttertoast.showToast(
                                    msg: "Can not send your request",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: shadowTextFieldBlue,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }),
                        ],
                      );
                    },
                  ),
                )));
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        const BackgroundImg(),
        Padding(
            padding: const EdgeInsets.only(
              left: 70, /*top: 15, bottom: 15*/
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                // padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    boxShadow: [
                      BoxShadow(
                          color: shadowTextFieldBlue,
                          spreadRadius: 0,
                          blurRadius: 100,
                          offset: Offset(0, 2))
                    ]),

                //============================================body of the page
                child: Column(
                  children: [
                    MyItem(
                        leading: Icons.dns_outlined,
                        title: 'Major & Minor Request',
                        subtitle: '30/8/2022',
                        onTap: () => bottomSheetMajor(context)),
                    const MyDivider(),
                    MyItem(
                        leading: Icons.change_circle_outlined,
                        title: 'Change Department Request',
                        subtitle: '1/4/2023',
                        onTap: () => bottomSheetChange(context)),
                    const MyDivider(),
                    MyItem(
                        leading: Icons.auto_awesome,
                        title: 'Special Request',
                        subtitle: "1/4/2023",
                        onTap: () => bottomSheetSpecial(context)
                        // trailing: RichText(text: const TextSpan(children: [ TextSpan(text: "Press to send your request:)")])),
                        ),
                    const MyDivider(),
                    // MyItem(
                    //   leading: Icons.logout,
                    //   title: 'Log Out',
                    // ),
                    // const MyDivider(),
                  ],
                ),
              ),
            )),
      ]),
    ));
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.white,
      height: 5.0,
    );
  }
}

class MyItem extends StatelessWidget {
  final String title;
  final IconData leading;
  String subtitle = '';
  Function()? onTap;
  Widget? trailing;

  MyItem({
    Key? key,
    required this.title,
    required this.leading,
    this.subtitle = '',
    this.onTap,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: ListTile(
          trailing: trailing,
          leading: Icon(
            leading,
            color: Colors.white,
            size: 30,
          ),
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ));
  }

  Widget myBottomSheet() => Column(
        mainAxisSize: MainAxisSize.min,
        children: const [],
      );
}



                    // Stack(
                    //   children: [
                    //     Positioned(bottom: 60, right: 15,
                    //       child: FloatingActionButton(
                    //         onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));},
                    //         child: const Icon(Icons.logout),
                    //         backgroundColor: darkBlue,
                    //       ),
                    //     ),
                    //   ],
                    // ),