import 'package:flutter/cupertino.dart';
import 'package:sci_alex/reusable_components/colors.dart';
// import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({
    Key? key,
    required this.text,
    required this.onPress,
    this.width,
  }) : super(key: key);

  final String text;
  double? width;
  Function() onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: CupertinoButton(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: textFieldBlue,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: onPress,
      ),
    );
  }
}
