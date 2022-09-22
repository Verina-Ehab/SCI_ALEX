import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:sci_alex/model/posts/post.dart';
import 'package:sci_alex/model/posts/posts_list.dart';
import 'package:sci_alex/model/search/search_course.dart';
import 'package:sci_alex/model/student_info/student_info.dart';
import 'package:sci_alex/reusable_components/alert.dart';
import 'package:sci_alex/view/home/home_navigation.dart';
import 'package:sci_alex/view/login/login.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../reusable_components/colors.dart';

//"headers" for security
//loginData
//readLoginData
//deleteData
//addCourse
//editData
//postData
//logout
//getData
//getPosts
//getStudentInfo
//_saveLoginData

class DatabaseHelper {
  // String serverUrl = 'http://127.0.0.1:8000/api';
  // var status= true;
  var token = '';

  Future<void> loginData(
      String url, String userId, String password, BuildContext context) async {
    Map data = {
      "id": userId,
      "password": password,
    };
    Response response = await post(
      Uri.parse(url),
      body: data,
    );
    var responsebody = jsonDecode(response.body); /*.toString()*/

    if (responsebody['status'] == true) {
      _saveLoginData(responsebody['api-Token']);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => (const Home())));
    } else {
      Navigator.of(context).pop();
      myDialog(context, "Warning!", "Invalid ID or password",
          '${responsebody['msg']}');
      // status= false;

    }

    //convert response body to json
    //if status==true then there is an error
    //if error return it
    //else return token of the user
  }

  Future<String> readLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final myToken = prefs.get('api-Token') ?? '';
    // print('My Token: $myToken');
    return "$myToken";
  }

  void deleteData(String url, List? data, int id) async {
    final token = readLoginData();

    var response = await delete(Uri.parse(url),
            headers: {'auth.token': '$token'}, body: data)
        .then((response) {
      // print('Response Status: ${response.statusCode}');
      // print('Response body: ${response.body}');
    });
  }

  postCoursesRegistration(
      String url, String iDsString, BuildContext context, String codes) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('api-Token');
    var data = {'id': iDsString};

    var response = await post(Uri.parse(url),
        body: data, headers: {'auth.token': '$token'});

    // var responsebody=  MSG.fromJson(json.encode(response.body));
    var responsebody = json.decode(response.body);
    // MSG msg = MSG.fromJson(json.decode(json.encode(response.body)));
    String msg = responsebody['msg'];
    myDialog(context, "Selected Courses", codes, msg);
  }

  postMajorMinor(
    String url,
    String iDsString,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('api-Token');
    var data = {'id': iDsString};

    var response = await post(Uri.parse(url),
        body: data, headers: {'auth.token': '$token'});

    var responsebody = json.decode(response.body);
    String msg = responsebody['msg'];
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: shadowTextFieldBlue,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  postOpenCourse(String url, String iDString) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('api-Token');
    var data = {'course_id': iDString};

    var response = await post(Uri.parse(url),
        body: data, headers: {'auth.token': '$token'});

    var responsebody = json.decode(response.body);
    String msg = responsebody['msg'];
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: shadowTextFieldBlue,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<dynamic> getCoursesRegistration(
    String url,
    /*BuildContext context*/
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('api-Token');

    Response response =
        await get(Uri.parse(url), headers: {'auth.token': '$token'});
    try {
      var responsebody = jsonDecode(response.body);
      return responsebody['courses'];
    } catch (e) {
      // print(e);
    }

    // return responsebody['courses'];
  }

  Future<dynamic> getOpenCourses(
    String url,
    /*BuildContext context*/
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('api-Token');

    Response response =
        await get(Uri.parse(url), headers: {'auth.token': '$token'});
    try {
      var responsebody = jsonDecode(response.body);
      return responsebody['courses'];
    } catch (e) {
      // print(e);
    }

    // return responsebody['courses'];
  }

  Future<dynamic> sendRghpat(String url, List departments) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('api-Token');

    Map data = {
      "rghpat": departments,
    };

    Response response = await post(Uri.parse(url),
        body: data, headers: {'auth.token': '$token'});
    //   try{var responsebody = jsonDecode(response.body);
    //   return responsebody['courses'];
    //   }catch(e){
    // print(e);
// }

    // return responsebody['courses'];
  }

  void editData(String url, String userId, String password, int id) async {
    // var myUrl = "$url$id";
    final token = readLoginData();

    Map data = {
      "id": userId,
      "password": password,
    };
    var response = await post(Uri.parse(url),
        body: data, headers: {'auth.token': '$token'});
  }

  void postData(String url, List data, BuildContext context) async {
    // var url="http://jsonplaceholder.typicode.com/posts";
    var response =
        await post(Uri.parse(url), body: data, headers: {'auth.token': token})
            .then((response) {
      // print('Response Status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      myDialog(context, '${response.statusCode}', response.body, "Done");
    });
  }

  logout(context) async {
    // shpref?.remove(userID);
    // prefs?.remove(password);
    // prefs?.remove(token);
    final prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    prefs.setString('api-Token', '');

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  Future getData(String url) async {
    // var myUrl = url;
    final token = readLoginData();

    Response response =
        await get(Uri.parse(url), headers: {'auth.token': '$token'});
    //"headers" for security

    var responsebody = jsonDecode(response.body);
    return responsebody;
    // print(responsebody);
  }

  Future<List<Post>> getPosts(
    String url,
  ) async {
    // final token = readLoginData();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('api-Token');

    Response response =
        await get(Uri.parse(url), headers: {'auth.token': '$token'});
    var responsebody = jsonDecode(response.body);

    // if (responsebody['status'] == true) {
    PostsList posts = PostsList.fromJson(responsebody);
    List<Post> postsList = posts.posts.map((e) => Post.fromJson(e)).toList();
    // print("++++++++++++++++++++++++++++++++++++++++++++++++++$postsList");
    return postsList;
    // } else {
    // myDialog(
    // context, "Error!", "Something goes wrong!, try again later.", "");
    // }
  }

  Future<SearchCourse> getCouseInfo(String url, String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('api-Token');
    var data = int.parse(id);

    Response response = await post(Uri.parse(url),
        body: data, headers: {'auth.token': '$token'});
    var responsebody = jsonDecode(response.body);

    // if (responsebody['status'] == true) {
    SearchCourse course = SearchCourse.fromJson(responsebody['course']);
    // print("++++++++++++++++++++++++++++++++++++++++++++++++");
    // print(responsebody);
    // print(responsebody['course']);
    // print(course);

    return course;
  }

  Future<dynamic> getAcademicBook(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('api-Token');

    Response response =
        await get(Uri.parse(url), headers: {'auth.token': '$token'});
    var responsebody = jsonDecode(response.body);

    // PostsList posts = PostsList.fromJson(responsebody);
    // List<Post> postsList = posts.posts.map((e) => Post.fromJson(e)).toList();

    // print("+++++++++++++++++++++++++++++++++++++++");
    // print(responsebody);
    // print(responsebody["allcourses"]);
    return responsebody["allcourses"];
    // List<CoursesListBook> coursesListBook = responsebody["allcourses"].courses.map((e) => CourseBook.fromJson(e)).toList();
    // print(coursesListBook);

    // return AcademicBookModel.fromJson(jsonDecode(response.body));

    // CoursesListBook posts = CoursesListBook.fromJson(responsebody['allcourses']);
    // List<CourseBook> coursesListBook = posts.courses.map((e) => CourseBook.fromJson(e)).toList();
    // return coursesListBook;

    // return responsebody['semester'];
    // CoursesList posts = CoursesList.fromJson(responsebody);
    // List<Course> postsList = posts.courses.map((e) => Course.fromJson(e)).toList();
    // print('++++++++++++++++++++++++++++++++++++');
    // print(responsebody['courses'][1]['id']);
    // print('++++++++++++++++++++++++++++++++++++');
    // print(postsList);
  }

  Future<dynamic> getStudentInfo(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get('api-Token');

    Response response =
        await get(Uri.parse(url), headers: {'auth.token': '$token'});
    var responsebody = jsonDecode(response.body);

    Info info = Info.fromJson(responsebody['student']);
    // print("+++++++++++++++++++++++++++++++++++++++++++++");
    // print(info);
    // print(responsebody['student']);
    // print(responsebody['student']['major']);

    prefs.setString('hours', responsebody['student']['hours']);
    prefs.setString('cgpa', responsebody['student']['cgpa']);
    prefs.setString('name', responsebody['student']['student_name']);
    prefs.setString('level', responsebody['student']['level']);
    prefs.setString('major',
        "${responsebody['student']['major']}/${responsebody['student']['minor']}");

    return info;
  }

  _saveLoginData(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('api-Token', token);
    // prefs.setBool('logedIn', true);
  }
}
