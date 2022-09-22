// import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

SharedPreferences? shpref;
const String token = "";

const String pathApi = "";
// final String path_images="";

String gUseIdVal = "";

const String gUseId = "";
const String gUseEmail = "";
const String gUsePwd = "";

Future<bool> checkConnection() async {
  try {
    final result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      // print("connect");
      return true;
    } else {
      // print("not connect");
      return false;
    }
  } on SocketException catch (_) {
    // print("connect");
    return true;
  }
}
