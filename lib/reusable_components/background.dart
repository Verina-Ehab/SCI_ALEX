import 'package:flutter/material.dart';

class BackgroundImg extends StatefulWidget {
  const BackgroundImg({ Key? key }) : super(key: key);

  @override
  State<BackgroundImg> createState() => _BackgroundImgState();
}

class _BackgroundImgState extends State<BackgroundImg> {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Stack(children: [
      Positioned(
          top: -500,
          left: -120,
          child: Opacity(
            opacity: 0.2,
            child: Image.asset(
              "images/background1.png",
              width: size.width * 2,
              height: size.height * 2,
            ),
          )),
      Positioned(
          top: size.height * 1 / 3,
          left: -170,
          child: Opacity(
            opacity: 0.4,
            child: Image.asset(
              "images/background2.png",
              width: size.width,
              height: size.height,
            ),
          )),
    ],);
  }
}