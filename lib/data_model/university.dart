import 'dart:convert';

University universityResponseFromJson(String str) => University.fromJson(json.decode(str));


class University {
  List<UniversityData> _data;
  bool _success;
  int _status;

  University({List<UniversityData> data, bool success, int status}) {
    this._data = data;
    this._success = success;
    this._status = status;
  }

  List<UniversityData> get data => _data;
  set data(List<UniversityData> data) => _data = data;
  bool get success => _success;
  set success(bool success) => _success = success;
  int get status => _status;
  set status(int status) => _status = status;

  University.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = new List<UniversityData>();
      json['data'].forEach((v) {
        _data.add(new UniversityData.fromJson(v));
      });
    }
    _success = json['success'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    data['success'] = this._success;
    data['status'] = this._status;
    return data;
  }
}

class UniversityData {
  int _id;
  String _name;
  String _address;

  UniversityData({int id, String name, String address}) {
    this._id = id;
    this._name = name;
    this._address = address;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get address => _address;
  set address(String address) => _address = address;

  UniversityData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['address'] = this._address;
    return data;
  }
}