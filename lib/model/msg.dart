class MSG {
  final String msg;

  MSG({
    required this.msg,
  });

  factory MSG.fromJson(Map<String, dynamic> parsedJson) {
    return MSG(msg: parsedJson['msg']);
  }
}



// class MSG {
//   bool? status;
//   String? errNum;
//   String? msg;
//   Conflict? conflict;

//   MSG({this.status, this.errNum, this.msg, this.conflict});

//   MSG.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     errNum = json['errNum'];
//     msg = json['msg'];
//     conflict = json['conflict'] != null
//         ? new Conflict.fromJson(json['conflict'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['errNum'] = this.errNum;
//     data['msg'] = this.msg;
//     if (this.conflict != null) {
//       data['conflict'] = this.conflict!.toJson();
//     }
//     return data;
//   }
// }

// class Conflict {
//   String? lecture;

//   Conflict({this.lecture});

//   Conflict.fromJson(Map<String, dynamic> json) {
//     lecture = json['lecture'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['lecture'] = this.lecture;
//     return data;
//   }
// }