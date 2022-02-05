// To parse this JSON data, do
//
//     final conversationResponse = conversationResponseFromJson(jsonString);

import 'dart:convert';

ConversationResponse conversationResponseFromJson(String str) => ConversationResponse.fromJson(json.decode(str));

String conversationResponseToJson(ConversationResponse data) => json.encode(data.toJson());

class ConversationResponse {
  List<Data> data;
  Links links;
  Meta meta;
  bool success;
  int status;
  String message;

  ConversationResponse(
      {this.data,
        this.links,
        this.meta,
        this.success,
        this.status,
        this.message});

  ConversationResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    success = json['success'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int id;
  int senderId;
  String senderName;
  int receiverId;
  String receiverName;
  String title;
  String lastMessage;
  String createdAt;

  Data(
      {this.id,
        this.senderId,
        this.senderName,
        this.receiverId,
        this.receiverName,
        this.title,
        this.lastMessage,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    senderName = json['sender_name'];
    receiverId = json['receiver_id'];
    receiverName = json['receiver_name'];
    title = json['title'];
    lastMessage = json['last_message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['sender_name'] = this.senderName;
    data['receiver_id'] = this.receiverId;
    data['receiver_name'] = this.receiverName;
    data['title'] = this.title;
    data['last_message'] = this.lastMessage;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Links {
  String first;
  String last;
  int prev;
  int next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  Meta(
      {this.currentPage,
        this.from,
        this.lastPage,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

/*
class ConversationResponse {
  List<SellerConversationData> _data;
  Links _links;
  Meta _meta;
  bool _success;
  int _status;
  String _message;

  ConversationResponse(
      {List<SellerConversationData> data,
        Links links,
        Meta meta,
        bool success,
        int status,
        String message}) {
    this._data = data;
    this._links = links;
    this._meta = meta;
    this._success = success;
    this._status = status;
    this._message = message;
  }

  List<SellerConversationData> get data => _data;
  set data(List<SellerConversationData> data) => _data = data;
  Links get links => _links;
  set links(Links links) => _links = links;
  Meta get meta => _meta;
  set meta(Meta meta) => _meta = meta;
  bool get success => _success;
  set success(bool success) => _success = success;
  int get status => _status;
  set status(int status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;

  ConversationResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = new List<SellerConversationData>();
      json['data'].forEach((v) {
        _data.add(new SellerConversationData.fromJson(v));
      });
    }
    _links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    _success = json['success'];
    _status = json['status'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    if (this._links != null) {
      data['links'] = this._links.toJson();
    }
    if (this._meta != null) {
      data['meta'] = this._meta.toJson();
    }
    data['success'] = this._success;
    data['status'] = this._status;
    data['message'] = this._message;
    return data;
  }
}

class SellerConversationData {
  int _id;
  int _senderId;
  String _senderName;
  int _receiverId;
  String _receiverName;
  String _title;
  String _lastMessage;
  String _createdAt;

  SellerConversationData(
      {int id,
        int senderId,
        String senderName,
        int receiverId,
        String receiverName,
        String title,
        String lastMessage,
        String createdAt}) {
    this._id = id;
    this._senderId = senderId;
    this._senderName = senderName;
    this._receiverId = receiverId;
    this._receiverName = receiverName;
    this._title = title;
    this._lastMessage = lastMessage;
    this._createdAt = createdAt;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get senderId => _senderId;
  set senderId(int senderId) => _senderId = senderId;
  String get senderName => _senderName;
  set senderName(String senderName) => _senderName = senderName;
  int get receiverId => _receiverId;
  set receiverId(int receiverId) => _receiverId = receiverId;
  String get receiverName => _receiverName;
  set receiverName(String receiverName) => _receiverName = receiverName;
  String get title => _title;
  set title(String title) => _title = title;
  String get lastMessage => _lastMessage;
  set lastMessage(String lastMessage) => _lastMessage = lastMessage;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;

  SellerConversationData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _senderId = json['sender_id'];
    _senderName = json['sender_name'];
    _receiverId = json['receiver_id'];
    _receiverName = json['receiver_name'];
    _title = json['title'];
    _lastMessage = json['last_message'];
    _createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['sender_id'] = this._senderId;
    data['sender_name'] = this._senderName;
    data['receiver_id'] = this._receiverId;
    data['receiver_name'] = this._receiverName;
    data['title'] = this._title;
    data['last_message'] = this._lastMessage;
    data['created_at'] = this._createdAt;
    return data;
  }
}

class Links {
  String _first;
  String _last;
  Null _prev;
  Null _next;

  Links({String first, String last, Null prev, Null next}) {
    this._first = first;
    this._last = last;
    this._prev = prev;
    this._next = next;
  }

  String get first => _first;
  set first(String first) => _first = first;
  String get last => _last;
  set last(String last) => _last = last;
  Null get prev => _prev;
  set prev(Null prev) => _prev = prev;
  Null get next => _next;
  set next(Null next) => _next = next;

  Links.fromJson(Map<String, dynamic> json) {
    _first = json['first'];
    _last = json['last'];
    _prev = json['prev'];
    _next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this._first;
    data['last'] = this._last;
    data['prev'] = this._prev;
    data['next'] = this._next;
    return data;
  }
}

class Meta {
  int _currentPage;
  int _from;
  int _lastPage;
  String _path;
  int _perPage;
  int _to;
  int _total;

  Meta(
      {int currentPage,
        int from,
        int lastPage,
        String path,
        int perPage,
        int to,
        int total}) {
    this._currentPage = currentPage;
    this._from = from;
    this._lastPage = lastPage;
    this._path = path;
    this._perPage = perPage;
    this._to = to;
    this._total = total;
  }

  int get currentPage => _currentPage;
  set currentPage(int currentPage) => _currentPage = currentPage;
  int get from => _from;
  set from(int from) => _from = from;
  int get lastPage => _lastPage;
  set lastPage(int lastPage) => _lastPage = lastPage;
  String get path => _path;
  set path(String path) => _path = path;
  int get perPage => _perPage;
  set perPage(int perPage) => _perPage = perPage;
  int get to => _to;
  set to(int to) => _to = to;
  int get total => _total;
  set total(int total) => _total = total;

  Meta.fromJson(Map<String, dynamic> json) {
    _currentPage = json['current_page'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _path = json['path'];
    _perPage = json['per_page'];
    _to = json['to'];
    _total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this._currentPage;
    data['from'] = this._from;
    data['last_page'] = this._lastPage;
    data['path'] = this._path;
    data['per_page'] = this._perPage;
    data['to'] = this._to;
    data['total'] = this._total;
    return data;
  }
}*/
