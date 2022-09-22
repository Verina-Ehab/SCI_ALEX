import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sci_alex/trash/model/course.dart';

// import 'package:bulleted_list/bulleted_list.dart';
// import 'package:toast/toast.dart';

class Utils {
  static showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static List<T> modelBuilder<M, T>(
      List<M> models, T Function(int index, M model) builder) {
    return models
        .asMap()
        .map<int, T>((index, model) => MapEntry(index, builder(index, model)))
        .values
        .toList();
  }

  static Future loadCourses(String path) async {
    final data = await rootBundle
        .loadString('assets/course_kind_registration2.json' /*path*/);
    final coursesJson = json.decode(data);

    return coursesJson.keys.map<Course>((code) {
      final json = coursesJson[code];
      final newJson = json..addAll({'code': code.toLowerCase()});

      return Course.fromJson(newJson);
    }).toList()
      ..sort(Utils.ascendingSort);
  }

  static int ascendingSort(Course c1, Course c2) => c1.name.compareTo(c2.name);
}
