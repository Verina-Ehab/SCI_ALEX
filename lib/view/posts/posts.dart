import 'package:flutter/material.dart';
import 'package:sci_alex/reusable_components/background.dart';
import 'package:sci_alex/reusable_components/colors.dart';
import 'package:sci_alex/controller/database_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  var listOfPosts =
      DatabaseHelper().getPosts("http://192.168.1.11:8000/api/post/index");
  // final Uri _url = Uri.parse('https://flutter.dev');
  // void _launchUrl(Uri url) async {
  //   if (!await launchUrl(url)) throw 'Could not launch $url';
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkBlue,
        child: const Icon(Icons.logout),
        onPressed: () {
          DatabaseHelper().logout(context);
        },
      ),
      body: Stack(
        children: [
          const BackgroundImg(),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      boxShadow: [
                        BoxShadow(
                            color: shadowTextFieldBlue,
                            spreadRadius: 0,
                            blurRadius: 100,
                            offset: Offset(0, 2))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width: ((size.width) - 120) / 2,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: textFieldBlue,
                        ),
                        child: InkWell(
                            child: const Text(
                              "Website",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            onTap: () async {
                              launchUrl(
                                Uri.parse(
                                    'https://sci.alexu.edu.eg/index.php/ar/'),
                              );
                            }),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width: ((size.width) - 120) / 2,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: textFieldBlue,
                        ),
                        child: InkWell(
                            child: const Text(
                              "Facebook",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            onTap: () async {
                              launchUrl(Uri.parse(
                                  'https://m.facebook.com/208344759184679/'));
                            }
                            // () async {
                            //   const url =
                            //       'https://m.facebook.com/208344759184679/';
                            //   if (await canLaunchUrlString(url)) {
                            //     await launchUrlString(url);
                            //   } else {
                            //     throw 'Could not launch $url';
                            //   }
                            // }
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Expanded(
                  child: FutureBuilder(
                      future: listOfPosts,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data.length,
                              separatorBuilder: (BuildContext context, int i) {
                                return const SizedBox(height: 20);
                              },
                              itemBuilder: (BuildContext context, int i) {
                                return Card(
                                  child: Container(
                                    decoration: const BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: textFieldBlue,
                                          spreadRadius: 0,
                                          blurRadius: 10,
                                          offset: Offset(0, 0))
                                    ]),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              snapshot.data[i].title,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          subtitle: Text(
                                            snapshot.data[i].createdAt,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 17, bottom: 17, right: 15),
                                          alignment: Alignment.topLeft,
                                          child: Text(snapshot.data[i].content,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
