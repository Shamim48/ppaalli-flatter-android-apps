
import 'dart:convert';

StudentCheck studentCheckResponseFromJson(String str) => StudentCheck.fromJson(json.decode(str));


class StudentCheck {
  bool success;
  int status;
  String message;

  StudentCheck({this.success, this.status, this.message});

  StudentCheck.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
