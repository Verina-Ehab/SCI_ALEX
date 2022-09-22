import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Dialog extends StatelessWidget {
  String title;
  String content;
  String textButton;
  String afterPop;

  Dialog({
    Key? key,
    required this.title,
    required this.content,
    required this.textButton,
    required this.afterPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Toast.show(afterPop,
                  duration: Toast.lengthShort, gravity: Toast.bottom);
            },
            child: Text(textButton))
      ],
    );
  }
}
