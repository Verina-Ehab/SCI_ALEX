class CoursesList{

  final Map<String,dynamic> cs;
  final Map<String,dynamic> stat;
  final Map<String,dynamic> freeChoice;
  final Map<String,dynamic> univRequire;


  CoursesList({required this.cs,required this.stat,required this.freeChoice,required this.univRequire,});
  
  factory CoursesList.fromJson(Map<String, dynamic> jsonData) {
    return CoursesList(
      cs: jsonData['cs'],
      stat: jsonData['stat'],
      freeChoice: jsonData['free_choice'],
      univRequire: jsonData['univ_require'],
    );
  }
}