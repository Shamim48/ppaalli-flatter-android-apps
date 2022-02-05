
import 'dart:convert';

GroupOrderMessage groupMessageResponseFromJson(String str) => GroupOrderMessage.fromJson(json.decode(str));

class GroupOrderMessage {
  bool success;
  int status;
  String message;
  List<GroupMessageData> data;

  GroupOrderMessage({this.success, this.status, this.message, this.data});

  GroupOrderMessage.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GroupMessageData>[];
      json['data'].forEach((v) {
        data.add(new GroupMessageData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupMessageData {
  int id;
  int senderUserId;
  String name;
  String message;
  String createdAt;

  GroupMessageData({this.id, this.senderUserId, this.name, this.message, this.createdAt});

  GroupMessageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderUserId = json['sender_user_id'];
    name = json['name'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_user_id'] = this.senderUserId;
    data['name'] = this.name;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    return data;
  }
}