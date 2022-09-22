import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sci_alex/reusable_components/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:sci_alex/reusable_components/utils.dart';

myLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // shape: ,
          contentTextStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          backgroundColor: textFieldBlue,
          content: Row(
            children: [
              CircularProgressIndicator(
                color: Colors.white.withOpacity(0.7),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("Loading ... "),
            ],
          ),
        );
      });
}

myDialog(context, String mytitle, String mycontent, String afterPop) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titleTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          contentTextStyle: const TextStyle(color: Colors.white),
          backgroundColor: dialogColor,
          title: Text(mytitle),
          content: Text(
            mycontent,
          ),
          actions: <Widget>[
            CupertinoButton(
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Utils.showSnackBar(context, afterPop);
                Fluttertoast.showToast(
                    msg: afterPop,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: shadowTextFieldBlue,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
            ),
          ],
        );
      });
}

// myToast(String myMSG, BuildContext context) {
//   return Toast.show(
//     myMSG,
//     duration: Toast.lengthShort,
//     gravity: Toast.bottom,
//   );
// }

showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(content: Text(text));

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}
