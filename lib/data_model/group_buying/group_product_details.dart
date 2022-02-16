
import 'dart:convert';

GroupProductDetails groupProductDetailsResponseFromJson(String str) => GroupProductDetails.fromJson(json.decode(str));

class GroupProductDetails {
  bool _success;
  int _status;
  String _message;
  String _minMaxPrice;
  String _startTime;
  String _endTime;
  int _advancePayment;
  List<Data> _data;

  GroupProductDetails(
      {bool success,
        int status,
        String message,
        String minMaxPrice,
        String startTime,
        String endTime,
        int advancePayment,
        List<Data> data}) {
    this._success = success;
    this._status = status;
    this._message = message;
    this._minMaxPrice = minMaxPrice;
    this._startTime = startTime;
    this._endTime = endTime;
    this._advancePayment = advancePayment;
    this._data = data;
  }

  bool get success => _success;
  set success(bool success) => _success = success;
  int get status => _status;
  set status(int status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  String get minMaxPrice => _minMaxPrice;
  set minMaxPrice(String minMaxPrice) => _minMaxPrice = minMaxPrice;
  String get startTime => _startTime;
  set startTime(String startTime) => _startTime = startTime;
  String get endTime => _endTime;
  set endTime(String endTime) => _endTime = endTime;
  int get advancePayment => _advancePayment;
  set advancePayment(int advancePayment) => _advancePayment = advancePayment;
  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;

  GroupProductDetails.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _status = json['status'];
    _message = json['message'];
    _minMaxPrice = json['min_max_price'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _advancePayment = json['advance_payment'];
    if (json['data'] != null) {
      _data = new List<Data>();
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['status'] = this._status;
    data['message'] = this._message;
    data['min_max_price'] = this._minMaxPrice;
    data['start_time'] = this._startTime;
    data['end_time'] = this._endTime;
    data['advance_payment'] = this._advancePayment;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int _id;
  String _quantityRange;
  String _price;
  int _status;

  Data({int id, String quantityRange, String price, int status}) {
    this._id = id;
    this._quantityRange = quantityRange;
    this._price = price;
    this._status = status;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get quantityRange => _quantityRange;
  set quantityRange(String quantityRange) => _quantityRange = quantityRange;
  String get price => _price;
  set price(String price) => _price = price;
  int get status => _status;
  set status(int status) => _status = status;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _quantityRange = json['quantity_range'];
    _price = json['price'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['quantity_range'] = this._quantityRange;
    data['price'] = this._price;
    data['status'] = this._status;
    return data;
  }
}