import 'dart:convert';

StudentProductResponse studentProductMiniResponseFromJson(String str) => StudentProductResponse.fromJson(json.decode(str));


class StudentProductResponse {
  List<Data> _data;
  DetailsLinks _links;
  Meta _meta;
  bool _success;
  int _status;

  StudentProductResponse(
      {List<Data> data, DetailsLinks links, Meta meta, bool success, int status}) {
    this._data = data;
    this._links = links;
    this._meta = meta;
    this._success = success;
    this._status = status;
  }

  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;
  DetailsLinks get links => _links;
  set links(DetailsLinks links) => _links = links;
  Meta get meta => _meta;
  set meta(Meta meta) => _meta = meta;
  bool get success => _success;
  set success(bool success) => _success = success;
  int get status => _status;
  set status(int status) => _status = status;

  StudentProductResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = new List<Data>();
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
    _links = json['links'] != null ? new DetailsLinks.fromJson(json['links']) : null;
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
  dynamic _rating;
  int _sales;
  List<VersityInfo> _versityInfo;
  DetailsLinks _links;

  Data(
      {int id,
        String name,
        String thumbnailImage,
        String basePrice,
        dynamic rating,
        int sales,
        List<VersityInfo> versityInfo,
        DetailsLinks links}) {
    this._id = id;
    this._name = name;
    this._thumbnailImage = thumbnailImage;
    this._basePrice = basePrice;
    this._rating = rating;
    this._sales = sales;
    this._versityInfo = versityInfo;
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
  dynamic get rating => _rating;
  set rating(dynamic rating) => _rating = rating;
  int get sales => _sales;
  set sales(int sales) => _sales = sales;
  List<VersityInfo> get versityInfo => _versityInfo;
  set versityInfo(List<VersityInfo> versityInfo) => _versityInfo = versityInfo;
  DetailsLinks get links => _links;
  set links(DetailsLinks links) => _links = links;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _thumbnailImage = json['thumbnail_image'];
    _basePrice = json['base_price'];
    _rating = json['rating'];
    _sales = json['sales'];
    if (json['versityInfo'] != null) {
      _versityInfo = new List<VersityInfo>();
      json['versityInfo'].forEach((v) {
        _versityInfo.add(new VersityInfo.fromJson(v));
      });
    }
    _links = json['links'] != null ? new DetailsLinks.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['thumbnail_image'] = this._thumbnailImage;
    data['base_price'] = this._basePrice;
    data['rating'] = this._rating;
    data['sales'] = this._sales;
    if (this._versityInfo != null) {
      data['versityInfo'] = this._versityInfo.map((v) => v.toJson()).toList();
    }
    if (this._links != null) {
      data['links'] = this._links.toJson();
    }
    return data;
  }
}

class VersityInfo {
  int _id;
  String _versityName;
  int _discountPercentage;
  int _status;

  VersityInfo(
      {int id, String versityName, int discountPercentage, int status}) {
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

  VersityInfo.fromJson(Map<String, dynamic> json) {
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

class DetailsLinks {
  String _details;

  DetailsLinks({String details}) {
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
  String _prev;
  String _next;

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
}