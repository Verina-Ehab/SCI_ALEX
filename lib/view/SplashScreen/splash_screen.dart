import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sci_alex/reusable_components/colors.dart';
import 'package:sci_alex/view/home/home_navigation.dart';
import 'package:sci_alex/view/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:get/get.dart';
// import 'package:animations/animations.dart';
// import 'package:sci_alex/reusable_components/config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;

  // getPref()async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var email =preferences.getString("email") ;
  //   var pwd =preferences.getString("pwd") ;
  //   if (email != null && pwd != null) {
  //     setState(() {
  //       isSignIn= true;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

// #####################################################################################################

    Timer(const Duration(seconds: 4), () {
      setState(() async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.get('api-Token');
        if (token != '') {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => (const Home())));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => (const Login())));
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: darkBlue,
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _height / _fontSize),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: Text(
                  'SCI ALEX',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: animation1.value,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _width / _containerSize,
                  width: _width / _containerSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                        0), //#########################################################
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.asset('images/scilogo.png', fit: BoxFit.fill)
                  // child: const Text(
                  //   'APP LOGO'
                  // ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTransition1 extends PageRouteBuilder {
  final Widget page;

  PageTransition1(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
