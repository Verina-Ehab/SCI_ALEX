// import 'package:meta/meta.dart';

class Doctor {
  final String id;
  final String name; 
  final String bio; 

  final String? telephone;
  final String? email;

  const Doctor({
    required this.name,
    required this.id,    
    required this.bio,

     this.telephone,
     this.email,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        name: json['name'],
        id: json['name'],
        bio: json['code'],
        telephone: json['name'],
        email: json['code'],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Doctor &&
          runtimeType == other.runtimeType &&
          name == other.name 
          // &&
          // code == other.code
          ;

  @override
  int get hashCode => name.hashCode
  //  ^ 
  // code.hashCode
  ;

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': name,
        'urlImage': bio,
        'title': telephone,
        'finalExam': email,
      };

}
