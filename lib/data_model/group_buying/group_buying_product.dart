
import 'dart:convert';

GroupBuyingProductResponse groupProductResponseFromJson(String str) => GroupBuyingProductResponse.fromJson(json.decode(str));
CheckGroupBuying checkGroupBuyingResponseFromJson(String str) => CheckGroupBuying.fromJson(json.decode(str));

class GroupBuyingProductResponse {
  List<Data> _data;
  Links _links;
  Meta _meta;
  bool _success;
  int _status;

  GroupBuyingProductResponse(
      {List<Data> data, Links links, Meta meta, bool success, int status}) {
    this._data = data;
    this._links = links;
    this._meta = meta;
    this._success = success;
    this._status = status;
  }

  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;
  Links get links => _links;
  set links(Links links) => _links = links;
  Meta get meta => _meta;
  set meta(Meta meta) => _meta = meta;
  bool get success => _success;
  set success(bool success) => _success = success;
  int get status => _status;
  set status(int status) => _status = status;

  GroupBuyingProductResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = new List<Data>();
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
    _links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    _success = json['success'];
    _status = json['status'];
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
    return data;
  }
}

class Data {
  int _id;
  String _name;
  String _thumbnailImage;
  String _basePrice;
  int _rating;
  int _sales;
  GroupbuyingInfo _groupbuyingInfo;
  Links _links;

  Data(
      {int id,
        String name,
        String thumbnailImage,
        String basePrice,
        int rating,
        int sales,
        GroupbuyingInfo groupbuyingInfo,
        Links links}) {
    this._id = id;
    this._name = name;
    this._thumbnailImage = thumbnailImage;
    this._basePrice = basePrice;
    this._rating = rating;
    this._sales = sales;
    this._groupbuyingInfo = groupbuyingInfo;
    this._links = links;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get thumbnailImage => _thumbnailImage;
  set thumbnailImage(String thumbnailImage) => _thumbnailImage = thumbnailImage;
  String get basePrice => _basePrice;
  set basePrice(String basePrice) => _basePrice = basePrice;
  int get rating => _rating;
  set rating(int rating) => _rating = rating;
  int get sales => _sales;
  set sales(int sales) => _sales = sales;
  GroupbuyingInfo get groupbuyingInfo => _groupbuyingInfo;
  set groupbuyingInfo(GroupbuyingInfo groupbuyingInfo) =>
      _groupbuyingInfo = groupbuyingInfo;
  Links get links => _links;
  set links(Links links) => _links = links;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _thumbnailImage = json['thumbnail_image'];
    _basePrice = json['base_price'];
    _rating = json['rating'];
    _sales = json['sales'];
    _groupbuyingInfo = json['groupbuyingInfo'] != null
        ? new GroupbuyingInfo.fromJson(json['groupbuyingInfo'])
        : null;
    _links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['thumbnail_image'] = this._thumbnailImage;
    data['base_price'] = this._basePrice;
    data['rating'] = this._rating;
    data['sales'] = this._sales;
    if (this._groupbuyingInfo != null) {
      data['groupbuyingInfo'] = this._groupbuyingInfo.toJson();
    }
    if (this._links != null) {
      data['links'] = this._links.toJson();
    }
    return data;
  }
}

class GroupbuyingInfo {
  String _minMaxPrice;
  int _startTime;
  int _endTime;

  GroupbuyingInfo({String minMaxPrice, int startTime, int endTime}) {
    this._minMaxPrice = minMaxPrice;
    this._startTime = startTime;
    this._endTime = endTime;
  }

  String get minMaxPrice => _minMaxPrice;
  set minMaxPrice(String minMaxPrice) => _minMaxPrice = minMaxPrice;
  int get startTime => _startTime;
  set startTime(int startTime) => _startTime = startTime;
  int get endTime => _endTime;
  set endTime(int endTime) => _endTime = endTime;

  GroupbuyingInfo.fromJson(Map<String, dynamic> json) {
    _minMaxPrice = json['min_max_price'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_max_price'] = this._minMaxPrice;
    data['start_time'] = this._startTime;
    data['end_time'] = this._endTime;
    return data;
  }
}

class DetailsLinks {
  String _details;

  Links({String details}) {
    this._details = details;
  }

  String get details => _details;
  set details(String details) => _details = details;

  DetailsLinks.fromJson(Map<String, dynamic> json) {
    _details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['details'] = this._details;
    return data;
  }
}

class Links {
  String _first;
  String _last;
  Null _prev;
  String _next;

  Links({String first, String last, Null prev, String next}) {
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
  String get next => _next;
  set next(String next) => _next = next;

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


}

class CheckGroupBuying {
  bool _success;
  int _status;
  String _message;
  int _minPrice;
  int _maxPrice;
  String _minMaxPrice;
  String _startTime;
  String _endTime;

  CheckGroupBuying(
      {bool success,
        int status,
        String message,
        int minPrice,
        int maxPrice,
        String minMaxPrice,
        String startTime,
        String endTime}) {
    this._success = success;
    this._status = status;
    this._message = message;
    this._minPrice = minPrice;
    this._maxPrice = maxPrice;
    this._minMaxPrice = minMaxPrice;
    this._startTime = startTime;
    this._endTime = endTime;
  }

  bool get success => _success;
  set success(bool success) => _success = success;
  int get status => _status;
  set status(int status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  int get minPrice => _minPrice;
  set minPrice(int minPrice) => _minPrice = minPrice;
  int get maxPrice => _maxPrice;
  set maxPrice(int maxPrice) => _maxPrice = maxPrice;
  String get minMaxPrice => _minMaxPrice;
  set minMaxPrice(String minMaxPrice) => _minMaxPrice = minMaxPrice;
  String get startTime => _startTime;
  set startTime(String startTime) => _startTime = startTime;
  String get endTime => _endTime;
  set endTime(String endTime) => _endTime = endTime;

  CheckGroupBuying.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _status = json['status'];
    _message = json['message'];
    _minPrice = json['min_price'];
    _maxPrice = json['max_price'];
    _minMaxPrice = json['min_max_price'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['status'] = this._status;
    data['message'] = this._message;
    data['min_price'] = this._minPrice;
    data['max_price'] = this._maxPrice;
    data['min_max_price'] = this._minMaxPrice;
    data['start_time'] = this._startTime;
    data['end_time'] = this._endTime;
    return data;
  }
}