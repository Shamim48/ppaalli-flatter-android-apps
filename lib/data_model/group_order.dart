import 'dart:convert';

GroupOrder groupOrderResponse(String str)=> GroupOrder.fromJson(json.decode(str));

class GroupOrder {
  List<GroupData> data;
  Links links;
  Meta meta;
  bool success;
  int status;
  String message;

  GroupOrder(
      {this.data,
        this.links,
        this.meta,
        this.success,
        this.status,
        this.message});

  GroupOrder.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GroupData>[];
      json['data'].forEach((v) {
        data.add(new GroupData.fromJson(v));
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

class GroupData {
  int id;
  int productId;
  int quantityRangeId;
  int productUnitPrice;
  int advancePaymentPrice;
  int timesloatId;
  String startTime;
  String endTime;
  int totalMemberJoin;
  int orderStatus;
  ProductInfo productInfo;

  GroupData(
      {this.id,
        this.productId,
        this.quantityRangeId,
        this.productUnitPrice,
        this.advancePaymentPrice,
        this.timesloatId,
        this.startTime,
        this.endTime,
        this.totalMemberJoin,
        this.orderStatus,
        this.productInfo});

  GroupData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    quantityRangeId = json['quantity_range_id'];
    productUnitPrice = json['product_unit_price'];
    advancePaymentPrice = json['advance_payment_price'];
    timesloatId = json['timesloat_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    totalMemberJoin = json['total_member_join'];
    orderStatus = json['order_status'];
    productInfo = json['productInfo'] != null
        ? new ProductInfo.fromJson(json['productInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['quantity_range_id'] = this.quantityRangeId;
    data['product_unit_price'] = this.productUnitPrice;
    data['advance_payment_price'] = this.advancePaymentPrice;
    data['timesloat_id'] = this.timesloatId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['total_member_join'] = this.totalMemberJoin;
    data['order_status'] = this.orderStatus;
    if (this.productInfo != null) {
      data['productInfo'] = this.productInfo.toJson();
    }
    return data;
  }
}

class ProductInfo {
  String name;
  String thumbnailImage;
  int rating;

  ProductInfo({this.name, this.thumbnailImage, this.rating});

  ProductInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    thumbnailImage = json['thumbnail_image'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['thumbnail_image'] = this.thumbnailImage;
    data['rating'] = this.rating;
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