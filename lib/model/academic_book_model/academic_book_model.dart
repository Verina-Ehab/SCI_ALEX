class AcademicBookModel {
  String? semesterName;
  List<Courses>? courses;

  AcademicBookModel({this.semesterName, this.courses});

  AcademicBookModel.fromJson(Map<String, dynamic> json) {
    semesterName = json['semester_name'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['semester_name'] = semesterName;
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  int? id;
  int? studentId;
  int? courseId;
  String? courseName;
  String? grade;
  String? gradeNum;
  String? createdAt;
  String? updatedAt;

  Courses(
      {this.id,
      this.studentId,
      this.courseId,
      this.courseName,
      this.grade,
      this.gradeNum,
      this.createdAt,
      this.updatedAt});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    courseId = json['course_id'];
    courseName = json['course_name'];
    grade = json['grade'];
    gradeNum = json['grade_num'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['student_id'] = studentId;
    data['course_id'] = courseId;
    data['course_name'] = courseName;
    data['grade'] = grade;
    data['grade_num'] = gradeNum;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
