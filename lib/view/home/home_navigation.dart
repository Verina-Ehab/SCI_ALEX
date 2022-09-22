import 'package:flutter/material.dart';
import 'package:sci_alex/controller/database_helper.dart';
import 'package:sci_alex/reusable_components/colors.dart';
import 'package:sci_alex/view/academic_book/academic_book.dart';
import 'package:sci_alex/view/courses_registration/courses_registration.dart';
import 'package:sci_alex/view/help/help.dart';
import 'package:sci_alex/view/open_courses/open_courses.dart';
import 'package:sci_alex/view/departments/change_dep.dart';
import 'package:sci_alex/view/home/circular_progres_drawer.dart';
import 'package:sci_alex/view/posts/posts.dart';
import 'package:sci_alex/view/recommendations/recommendations.dart';

// import 'package:sci_alex/reusable_components/background.dart';
// import 'package:get/get.dart';
// import 'package:sci_alex/view/login/login.dart';
// import 'package:sci_alex/trash/view/courses_registration.dart';
// import 'package:sci_alex/reusable_components/config.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static var currentSelectedIndex;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int currentSelectedIndex = 0;
  bool isCollapsed = false;
  double maxWidth = 310.0;
  double minWidth = 60.0;
  List<Widget> screens = [
    const Posts(),
    const AcademicBook(),
    const CoursesRegisteration(),
    const OpenCoursesReq(),
    const Departments(),
    const Recommendations(),
    const Help(),
  ];

  var studentInfo = DatabaseHelper()
      .getStudentInfo("http://192.168.1.11:8000/api/profile/show");
  late Animation<double> widthAnimation;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth) //######
        .animate(_animationController);
  }

  Widget getWidget(context, widget) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // const BackgroundImg(),
            screens[currentSelectedIndex],
            Material(
              elevation: 12.0,
              child: Container(
                width: widthAnimation.value,
                color: drawerBackgroundColor,
                child: Column(
                  children: <Widget>[
                    isCollapsed
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOutBack,
                              width: 70,
                              height: 270,
                              child: const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.person,
                                  size: 45,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : AnimatedContainer(
                            curve: Curves.easeInOutBack,
                            duration: const Duration(milliseconds: 500),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                  width: 305,
                                  height: 270,
                                  child: FutureBuilder(
                                      future: studentInfo,
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          return SingleChildScrollView(
                                            // scrollDirection:,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: ListTile(
                                                    leading: const Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                      size: 45,
                                                    ),
                                                    title: RichText(
                                                        text: TextSpan(
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500),
                                                            children: [
                                                          TextSpan(
                                                              text: snapshot
                                                                  .data
                                                                  .studentName)
                                                        ])),
                                                    subtitle: Text(
                                                        '${snapshot.data.major}/${snapshot.data.minor}',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12)),
                                                  ),
                                                ),
                                                Text(
                                                    "${snapshot.data.level} level",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                circularProgressDrawer(
                                                    snapshot.data.cgpa,
                                                    snapshot.data.hours),
                                              ],
                                            ),
                                          );
                                        }
                                        return const Center(
                                            child: Icon(
                                          Icons.person,
                                          size: 45,
                                          color: Colors.white,
                                        ));
                                      })),
                            ),
                          ),
                    const Divider(
                      color: Colors.grey,
                      height: 20.0,
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, counter) {
                          return const Divider(
                            height: 10.0,
                          );
                        },
                        itemBuilder: (context, counter) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: CollapsingListTile(
                                onTap: () {
                                  setState(() {
                                    currentSelectedIndex = counter;
                                    // Get.to(navigationItem[counter].page);
                                  });
                                },
                                isSelected: currentSelectedIndex == counter,
                                title: navigationItem[counter].title,
                                icon: navigationItem[counter].icon,
                                animationController: _animationController),
                          );
                        },
                        itemCount: navigationItem.length,
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            isCollapsed = !isCollapsed;
                            isCollapsed
                                ? _animationController.forward()
                                : _animationController.reverse();
                          });
                        },
                        child: AnimatedIcon(
                          icon: AnimatedIcons.close_menu,
                          progress: _animationController,
                          color: Colors.white,
                          size: 35.0,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }
}

myCircularProgressIndicatorDrawer() {}

// ignore: must_be_immutable
class CollapsingListTile extends StatefulWidget {
  CollapsingListTile(
      {Key? key,
      required this.title,
      required this.icon,
      required this.animationController,
      required this.isSelected,
      required this.onTap,
      this.widget})
      : super(key: key);

  final AnimationController animationController;
  final IconData icon;
  final bool isSelected;
  final Function() onTap;
  Color selectedColor = textFieldBlue;
  final String title;
  final Widget? widget;

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  //###############################################################
  double maxWidth = 220.0;

  double minWidth = 70.0;
  late Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
    widthAnimation = Tween<double>(begin: (maxWidth + 70), end: minWidth)
        .animate(widget.animationController);
    sizedBoxAnimation =
        Tween<double>(begin: 8, end: 0.0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon,
              color: Colors.white,
              // color: widget.isSelected ? selectedColor : Colors.white30, //=========================
              size: 32.0,
            ),
            SizedBox(
              width: sizedBoxAnimation.value,
            ),
            (widthAnimation.value >= 220)
                ? Text(
                    widget.title,
                    style: widget.isSelected
                        ? listTileSelectedStyle
                        : listTileDefaultStyle,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class NavigationItem {
  // Widget page;

  NavigationItem({
    required this.title,
    required this.icon,
    // required this.page,
  });

  IconData icon;
  String title;
}

List<NavigationItem> navigationItem = [
  NavigationItem(
    title: 'Home',
    icon: Icons.home, /*page: const Profile()*/
  ),
  NavigationItem(
    title: 'Academic Book',
    icon: Icons.assignment_turned_in, /*page: const AcademicBook()*/
  ),
  NavigationItem(
    title: 'Courses Registration',
    icon: Icons.app_registration_rounded, /*page: const Profile()*/
  ),
  NavigationItem(
    title: 'Open Courses',
    icon: Icons.lock_open, /*Icons.file_open_outlined page: const Profile()*/
  ),
  NavigationItem(
    title: 'Departments',
    icon: Icons.person_pin_circle_outlined, /*page: const Profile()*/
  ),
  NavigationItem(
    title: 'Recommendations',
    icon: Icons.recommend, /*page: const Profile()*/
  ),
  NavigationItem(
    title: 'Help',
    icon: Icons.help, /*page: const Profile()*/
  ),
];

TextStyle listTileDefaultStyle = const TextStyle(
    color: Colors.white70, fontSize: 16.0, fontWeight: FontWeight.w600);
TextStyle listTileSelectedStyle = const TextStyle(
    color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600);

Color selectedColor = Colors.white;
Color drawerBackgroundColor = darkBlue;
