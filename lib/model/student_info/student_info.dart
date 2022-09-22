
class Info {
  final int id;
  final String studentName;
  final String level;
  final double cgpa;
  final int hours;
  final String major;
  final String minor;


  Info(
 {
    required this.id,
    required this.studentName,
    required this.level,
    required this.cgpa,
    required this.hours,
    required this.major,
    required this.minor,
  });

  factory Info.fromJson(Map<String, dynamic> parsedJson) {
    return Info(
      id: parsedJson['user_id'] as int,
      studentName: parsedJson['student_name'],
      level: parsedJson['level'] ,
      cgpa: (parsedJson['cgpa']).toDouble() ,
      hours: parsedJson['hours'],
      major: parsedJson['major'],
      minor: parsedJson['minor'],
    );
  }


}
