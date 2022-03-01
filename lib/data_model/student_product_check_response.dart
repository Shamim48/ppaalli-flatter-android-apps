
import 'dart:convert';

StudentProductCheckResponse studentProductCheckResponseFromJson(String str) => StudentProductCheckResponse.fromJson(json.decode(str));


class StudentProductCheckResponse {
  bool _success;
  int _status;
  String _message;
  List<StudentProductCheckData> _data;

  StudentProductCheckResponse(
      {bool success, int status, String message, List<StudentProductCheckData> data}) {
    this._success = success;
    this._status = status;
    this._message = message;
    this._data = data;
  }

  bool get success => _success;
  set success(bool success) => _success = success;
  int get status => _status;
  set status(int status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  List<StudentProductCheckData> get data => _data;
  set data(List<StudentProductCheckData> data) => _data = data;

  StudentProductCheckResponse.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = new List<StudentProductCheckData>();
      json['data'].forEach((v) {
        _data.add(new StudentProductCheckData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentProductCheckData {
  int _id;
  String _versityName;
  int _discountPercentage;
  int _status;

  StudentProductCheckData({int id, String versityName, int discountPercentage, int status}) {
    this._id = id;
    this._versityName = versityName;
    this._discountPercentage = discountPercentage;
    this._status = status;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get versityName => _versityName;
  set versityName(String versityName) => _versityName = versityName;
  int get discountPercentage => _discountPercentage;
  set discountPercentage(int discountPercentage) =>
      _discountPercentage = discountPercentage;
  int get status => _status;
  set status(int status) => _status = status;

  StudentProductCheckData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _versityName = json['versity_name'];
    _discountPercentage = json['discount_percentage'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['versity_name'] = this._versityName;
    data['discount_percentage'] = this._discountPercentage;
    data['status'] = this._status;
    return data;
  }
}