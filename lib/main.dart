import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sci_alex/controller/loading.dart';
import 'package:sci_alex/view/SplashScreen/splash_screen.dart';

// import 'package:sci_alex/view/courses_registration/courses_registration.dart';
// import 'package:sci_alex/view/academic_book/academic_book.dart';
// import 'package:sci_alex/trash/view/courses_registration.dart';
// import 'package:sci_alex/view/help/help.dart';
// import 'package:sci_alex/view/home/homeNavigation.dart';
// import 'package:sci_alex/view/open_courses/open_courses.dart';
// import 'package:sci_alex/view/payment/payment.dart';

void main() async {
  // =========================================================
  // WidgetsFlutterBinding.ensureInitialized();
  // shpref = await SharedPreferences.getInstance();
  // G_use_id_val = shpref!.getString(G_use_id)!;
  // List data= await getData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingControl>(
            create: (context) => LoadingControl())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
