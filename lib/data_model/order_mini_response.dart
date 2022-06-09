import 'dart:convert';

OrderMiniResponse orderMiniResponseFromJson(String str) => OrderMiniResponse.fromJson(json.decode(str));

class OrderMiniResponse {
  List<Data> data;
  Links links;
  Meta meta;
  bool success;
  int status;

  OrderMiniResponse(
      {this.data, this.links, this.meta, this.success, this.status});

  OrderMiniResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    success = json['success'];
    status = json['status'];
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
    return data;
  }
}

class Data {
  int id;
  String code;
  int userId;
  String paymentType;
  String paymentStatus;
  String paymentStatusString;
  String deliveryStatus;
  String deliveryStatusString;
  String grandTotal;
  String date;
  List<Items> items;
  Links links;

  Data(
      {this.id,
        this.code,
        this.userId,
        this.paymentType,
        this.paymentStatus,
        this.paymentStatusString,
        this.deliveryStatus,
        this.deliveryStatusString,
        this.grandTotal,
        this.date,
        this.items,
        this.links});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    userId = json['user_id'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    paymentStatusString = json['payment_status_string'];
    deliveryStatus = json['delivery_status'];
    deliveryStatusString = json['delivery_status_string'];
    grandTotal = json['grand_total'];
    date = json['date'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['user_id'] = this.userId;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;
    data['payment_status_string'] = this.paymentStatusString;
    data['delivery_status'] = this.deliveryStatus;
    data['delivery_status_string'] = this.deliveryStatusString;
    data['grand_total'] = this.grandTotal;
    data['date'] = this.date;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class Items {
  int id;
  String productName;
  String thumbnailImage;
  int price;
  String formatPrice;
  dynamic tax;
  int shippingCost;
  int quantity;

  Items(
      {this.id,
        this.productName,
        this.thumbnailImage,
        this.price,
        this.formatPrice,
        this.tax,
        this.shippingCost,
        this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    thumbnailImage = json['thumbnail_image'];
    price = json['price'];
    formatPrice = json['format_price'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['thumbnail_image'] = this.thumbnailImage;
    data['price'] = this.price;
    data['format_price'] = this.formatPrice;
    data['tax'] = this.tax;
    data['shipping_cost'] = this.shippingCost;
    data['quantity'] = this.quantity;
    return data;
  }
}

class LinksDetails {
  String details;

  LinksDetails({this.details});

  LinksDetails.fromJson(Map<String, dynamic> json) {
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['details'] = this.details;
    return data;
  }
}

class Links {
  String first;
  String last;
  Null prev;
  String next;

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
