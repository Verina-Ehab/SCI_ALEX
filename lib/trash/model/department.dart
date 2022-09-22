// import 'package:meta/meta.dart';

class Department {
  final String id;
  final String name;

  const Department({
    required this.name,
    required this.id,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        name: json['name'],
        id: json['id'],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Department &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id;

  @override
  int get hashCode => name.hashCode ^ id.hashCode;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
