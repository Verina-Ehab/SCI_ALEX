import 'package:flutter/material.dart';
import 'package:sci_alex/reusable_components/alert.dart';
import 'package:sci_alex/reusable_components/background.dart';
import 'package:sci_alex/reusable_components/colors.dart';
import 'package:sci_alex/controller/database_helper.dart';
// import 'package:sci_alex/view/home/home_navigation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../reusable_components/alert.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool visable = true;
  // var mytoken;

  var userIDController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var token = DatabaseHelper().readLoginData();

  //whenComplete == when loginData complete do this!

  _onPressed() {
    setState(() {
      if (formKey.currentState!.validate()) {
        myLoading(context);
        DatabaseHelper().loginData("http://192.168.1.11:8000/api/login",
            userIDController.text, passwordController.text, context);

        // DatabaseHelper()
        //     .loginData("http://192.168.1.11:8000/api/login",
        //         "$userIDController", passwordController.text)
        //     .whenComplete(() {
        //   //whenComplete == when loginData complete do this!
        //   if (DatabaseHelper().status) {
        //     myLoading(context);
        //     Navigator.pushReplacement(context,
        //         MaterialPageRoute(builder: (context) => (const Home())));
        //   } else {
        //     myDialog(context, "Erorr!", "Check your ID or password", '');
        //   }
        // });
      }
    });
  }

  // readLoginData() async{
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'token';
  //   final value = prefs.get(key) ?? 0;
  //   print('My Token: $value');
  //   if(value != "0"){
  //     Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) =>
  //                   (const Home())));
  //   }
  // }}

  // logedIn() async{
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.get('api-Token');
  //   if(token != ''){
  //     Navigator.push(context,
  //               MaterialPageRoute(builder: (context) => (const Home())));
  //   }
  // }

  @override
  void initState() {
    // logedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        const BackgroundImg(),
        SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.2,
                ),
                const Text(
                  "LOG IN",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: darkBlue),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset("images/scilogo.png"),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        //userID textFormField
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: shadowTextFieldBlue,
                                spreadRadius: 5,
                                blurRadius: 40,
                                offset: Offset(0, 0)),
                          ]),
                          child: TextFormField(
                            style: const TextStyle(color: darkBlue),
                            controller: userIDController,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'ID must not be empty';
                              }
                              return null;
                            },
                            cursorColor: darkBlue,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.all(15),
                                fillColor: textFieldBlue,
                                prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(
                                      Icons.account_circle,
                                      color: darkBlue,
                                    )),
                                labelText: "ID",
                                labelStyle: TextStyle(
                                    color: darkBlue,
                                    fontWeight: FontWeight.w500),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        color: darkBlue))),
                          ),
                        ),
                        const SizedBox(height: 10),

                        //===================================================Password textFormField
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: shadowTextFieldBlue,
                                spreadRadius: 5,
                                blurRadius: 40,
                                offset: Offset(5, 10))
                          ]),
                          child: TextFormField(
                            style: const TextStyle(color: darkBlue),
                            controller: passwordController,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Password must not be empty';
                              }
                              return null;
                            },
                            cursorColor: darkBlue,
                            obscureText: visable,
                            decoration: InputDecoration(
                                filled: true,
                                contentPadding: const EdgeInsets.all(15),
                                fillColor: textFieldBlue,
                                prefixIcon: const Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(
                                      Icons.lock,
                                      color: darkBlue,
                                    )),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      visable = !visable;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Icon(
                                      visable
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: darkBlue,
                                    ),
                                  ),
                                ),
                                labelText: "Password",
                                labelStyle: const TextStyle(
                                    color: darkBlue,
                                    fontWeight: FontWeight.w500),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40))),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        color: darkBlue))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  // splashColor: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 55, vertical: 12),
                    child: const Text(
                      "LOG IN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    decoration: const BoxDecoration(
                        color: darkBlue,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                  ),
                  onTap: () {
                    _onPressed();
                    // if (formKey.currentState!.validate()) {
                    //   myLoading(context);
                    //   Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => (const Home())));
                    // }
                  },
                ),
                SizedBox(
                  height: size.height * 0.2,
                ),
              ]),
        )
      ]),
    );
  }
}





  // login() async {
  //   var formdata = formKey.currentState;
  //   if (formdata!.validate()) {
  //     formdata.save();

  //     myLoading(context);
  //     var data = {
  //       "userID": userIDController.text,
  //       "password": passwordController.text,
  //       "token": mytoken
  //     };
  //     var url = "http://10.0.2.2:8080/mobtech/login.php";
  //     var response = await http.post(Uri.parse(url), body: data);
  //     var responsebody = jsonDecode(response.body);
  //     print(responsebody);
  //     if (responsebody['status'] == "success") {
  //       savePref(responsebody['password'], responsebody['email']);
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => (const Home())));
  //     } else {
  //       print("login faild");
  //       Navigator.of(context).pop();
  //       myDialog(context, "Erorr!", "Invalid ID or Password");
  //     }
  //   } else {
  //     print("not valid");
  //   }
  //   ;
  // }
