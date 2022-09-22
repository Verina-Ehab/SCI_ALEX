// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:sci_alex/constants/config.dart';
// import 'package:sci_alex/view/home/homeNavigation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' ;
// import 'dart:async';

// Future<bool> loginUsers (
//   String useEmail, String usePwd, BuildContext context) async {
//   String url= path_api +
//    "users/login.php?use_email=" + 
//    useEmail + 
//    "&use_pwd=" + 
//    usePwd + 
//    "&token=" +
//    token;

//    Response response= await get(url);
//    if(json.decode(response.body)["code"]=="200")
//    {
//      Map arr= json.decode(response.body)["message"];
//      SharedPreferences shpref = await SharedPreferences.getInstance();
//      shpref.setString(G_use_id, arr["use_id"]);
//      shpref.setString(G_use_email, arr["use_email"]);
//      shpref.setString(G_use_pwd, arr["use_pwd"]);
//      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Home()));

//      print("success");
//      return true;
//    }
//    else
//    {
//      print("Fail");
//      return false;
//    }
// }