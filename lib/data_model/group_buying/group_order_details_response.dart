
import 'dart:convert';

GroupOrderDetailsResponse groupOrderDetailsResponseFromJson(String str) => GroupOrderDetailsResponse.fromJson(json.decode(str));

class GroupOrderDetailsResponse {
  bool _success;
  int _status;
  String _message;
  String _minMaxPrice;
  int _startTime;
  int _endTime;
  GroupProductInfo _groupProductInfo;
  List<Data> _data;

  GroupOrderDetailsResponse(
      {bool success,
        int status,
        String message,
        String minMaxPrice,
        int startTime,
        int endTime,
        GroupProductInfo groupProductInfo,
        List<Data> data}) {
    this._success = success;
    this._status = status;
    this._message = message;
    this._minMaxPrice = minMaxPrice;
    this._startTime = startTime;
    this._endTime = endTime;
    this._groupProductInfo = groupProductInfo;
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
  int get startTime => _startTime;
  set startTime(int startTime) => _startTime = startTime;
  int get endTime => _endTime;
  set endTime(int endTime) => _endTime = endTime;
  GroupProductInfo get groupProductInfo => _groupProductInfo;
  set groupProductInfo(GroupProductInfo groupProductInfo) =>
      _groupProductInfo = groupProductInfo;
  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;

  GroupOrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _status = json['status'];
    _message = json['message'];
    _minMaxPrice = json['min_max_price'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _groupProductInfo = json['groupProductInfo'] != null
        ? new GroupProductInfo.fromJson(json['groupProductInfo'])
        : null;
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
    if (this._groupProductInfo != null) {
      data['groupProductInfo'] = this._groupProductInfo.toJson();
    }
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupProductInfo {
  String _name;
  String _thumbnailImage;
  int _rating;

  GroupProductInfo({String name, String thumbnailImage, int rating}) {
    this._name = name;
    this._thumbnailImage = thumbnailImage;
    this._rating = rating;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get thumbnailImage => _thumbnailImage;
  set thumbnailImage(String thumbnailImage) => _thumbnailImage = thumbnailImage;
  int get rating => _rating;
  set rating(int rating) => _rating = rating;

  GroupProductInfo.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _thumbnailImage = json['thumbnail_image'];
    _rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['thumbnail_image'] = this._thumbnailImage;
    data['rating'] = this._rating;
    return data;
  }
}

class Data {
  int _id;
  String _name;
  String _paymentStatus;
  Null _productId;

  Data({int id, String name, String paymentStatus, Null productId}) {
    this._id = id;
    this._name = name;
    this._paymentStatus = paymentStatus;
    this._productId = productId;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get paymentStatus => _paymentStatus;
  set paymentStatus(String paymentStatus) => _paymentStatus = paymentStatus;
  Null get productId => _productId;
  set productId(Null productId) => _productId = productId;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _paymentStatus = json['payment_status'];
    _productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['payment_status'] = this._paymentStatus;
    data['product_id'] = this._productId;
    return data;
  }
}