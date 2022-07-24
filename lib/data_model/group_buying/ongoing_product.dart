import 'dart:convert';

OnGoingGroupProduct onGoingProductResponseFromJson(String str) => OnGoingGroupProduct.
fromJson(json.decode(str));

class OnGoingGroupProduct {
  List<OnGoingData> _data;
  Links _links;
  Meta _meta;
  bool _success;
  int _status;
  String _message;

  OnGoingGroupProduct(
      {List<OnGoingData> data,
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

  List<OnGoingData> get data => _data;
  set data(List<OnGoingData> data) => _data = data;
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

  OnGoingGroupProduct.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = new List<OnGoingData>();
      json['data'].forEach((v) {
        _data.add(new OnGoingData.fromJson(v));
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

class OnGoingData {
  int _id;
  int _productId;
  int _quantityRangeId;
  String _productUnitPrice;
  String _advancePaymentPrice;
  int _timesloatId;
  int _startTime;
  int _endTime;
  int _totalMemberJoin;
  int _orderStatus;
  ProductInfo _productInfo;

  OnGoingData(
      {int id,
        int productId,
        int quantityRangeId,
        String productUnitPrice,
        String advancePaymentPrice,
        int timesloatId,
        int startTime,
        int endTime,
        int totalMemberJoin,
        int orderStatus,
        ProductInfo productInfo}) {
    this._id = id;
    this._productId = productId;
    this._quantityRangeId = quantityRangeId;
    this._productUnitPrice = productUnitPrice;
    this._advancePaymentPrice = advancePaymentPrice;
    this._timesloatId = timesloatId;
    this._startTime = startTime;
    this._endTime = endTime;
    this._totalMemberJoin = totalMemberJoin;
    this._orderStatus = orderStatus;
    this._productInfo = productInfo;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get productId => _productId;
  set productId(int productId) => _productId = productId;
  int get quantityRangeId => _quantityRangeId;
  set quantityRangeId(int quantityRangeId) =>
      _quantityRangeId = quantityRangeId;
  String get productUnitPrice => _productUnitPrice;
  set productUnitPrice(String productUnitPrice) =>
      _productUnitPrice = productUnitPrice;
  String get advancePaymentPrice => _advancePaymentPrice;
  set advancePaymentPrice(String advancePaymentPrice) =>
      _advancePaymentPrice = advancePaymentPrice;
  int get timesloatId => _timesloatId;
  set timesloatId(int timesloatId) => _timesloatId = timesloatId;
  int get startTime => _startTime;
  set startTime(int startTime) => _startTime = startTime;
  int get endTime => _endTime;
  set endTime(int endTime) => _endTime = endTime;
  int get totalMemberJoin => _totalMemberJoin;
  set totalMemberJoin(int totalMemberJoin) =>
      _totalMemberJoin = totalMemberJoin;
  int get orderStatus => _orderStatus;
  set orderStatus(int orderStatus) => _orderStatus = orderStatus;
  ProductInfo get productInfo => _productInfo;
  set productInfo(ProductInfo productInfo) => _productInfo = productInfo;

  OnGoingData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productId = json['product_id'];
    _quantityRangeId = json['quantity_range_id'];
    _productUnitPrice = json['product_unit_price'];
    _advancePaymentPrice = json['advance_payment_price'];
    _timesloatId = json['timesloat_id'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _totalMemberJoin = json['total_member_join'];
    _orderStatus = json['order_status'];
    _productInfo = json['productInfo'] != null
        ? new ProductInfo.fromJson(json['productInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['product_id'] = this._productId;
    data['quantity_range_id'] = this._quantityRangeId;
    data['product_unit_price'] = this._productUnitPrice;
    data['advance_payment_price'] = this._advancePaymentPrice;
    data['timesloat_id'] = this._timesloatId;
    data['start_time'] = this._startTime;
    data['end_time'] = this._endTime;
    data['total_member_join'] = this._totalMemberJoin;
    data['order_status'] = this._orderStatus;
    if (this._productInfo != null) {
      data['productInfo'] = this._productInfo.toJson();
    }
    return data;
  }
}

class ProductInfo {
  String _name;
  String _thumbnailImage;
  int _rating;

  ProductInfo({String name, String thumbnailImage, int rating}) {
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

  ProductInfo.fromJson(Map<String, dynamic> json) {
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