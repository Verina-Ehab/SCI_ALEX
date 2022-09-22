// import 'package:meta/meta.dart';

class Student {
  final String id;
  final String studId;
  final String name;
  final String cgpa;
  final String hours;

  final String? major;
  final String? minor;

  const Student({
    required this.name,
    required this.studId,
    required this.id,
    required this.cgpa,
    required this.hours,
    this.major,
    this.minor,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        name: json['name'],
        id: json['code'],
        studId: json['name'],
        cgpa: json['code'],
        hours: json['name'],
        major: json['code'],
        minor: json['name'],
      );

//======================================================================================
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Student &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          studId == other.studId;

  @override
  int get hashCode => name.hashCode ^ studId.hashCode;
}
