// To parse this JSON data, do
//
//     final addressResponse = addressResponseFromJson(jsonString);

import 'dart:convert';

AddressResponse addressResponseFromJson(String str) => AddressResponse.fromJson(json.decode(str));

String addressResponseToJson(AddressResponse data) => json.encode(data.toJson());

class AddressResponse {
  List<AddressData> data;
  bool success;
  int status;

  AddressResponse({this.data, this.success, this.status});

  AddressResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<AddressData>();
      json['data'].forEach((v) {
        data.add(new AddressData.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class AddressData {
  int id;
  int userId;
  String address;
  String country;
  String city;
  String postalCode;
  String phone;
  int setDefault;

  AddressData(
      {this.id,
        this.userId,
        this.address,
        this.country,
        this.city,
        this.postalCode,
        this.phone,
        this.setDefault});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    setDefault = json['set_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['phone'] = this.phone;
    data['set_default'] = this.setDefault;
    return data;
  }
}