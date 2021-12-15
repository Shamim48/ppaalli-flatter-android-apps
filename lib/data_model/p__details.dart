/// data : [{"id":49,"name":"cap all","added_by":"admin","seller_id":1,"shop_id":0,"shop_name":"In House Product","shop_logo":"uploads/all/Fxj7NEzIY1TyRernpzwI4m3rZkSkcFx6accqMjVa.png","photos":["uploads/all/PxPDkvWU8MYwN8iPY9JA16BWtqRp4LGDMGbTLZ8s.jpg"],"thumbnail_image":"uploads/all/PxPDkvWU8MYwN8iPY9JA16BWtqRp4LGDMGbTLZ8s.jpg","tags":["cap"],"price_high_low":"320,0$","choice_options":[{"name":"1","title":"Size","options":["32","34","36"]}],"colors":["#0000FF","#00008B","#FF0000"],"has_discount":true,"stroked_price":"400,0$","main_price":"320,0$","calculable_price":320,"currency_symbol":"$","current_stock":0,"unit":"pcs","rating":5,"rating_count":1,"earn_point":0,"description":"<p>cap all<br></p>"}]
/// success : true
/// status : 200

class P_Details {
  P_Details({
      this.data, 
      this.success, 
      this.status,});

  P_Details.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
  }
  List<Data> data;
  bool success;
  int status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    map['success'] = success;
    map['status'] = status;
    return map;
  }

}

/// id : 49
/// name : "cap all"
/// added_by : "admin"
/// seller_id : 1
/// shop_id : 0
/// shop_name : "In House Product"
/// shop_logo : "uploads/all/Fxj7NEzIY1TyRernpzwI4m3rZkSkcFx6accqMjVa.png"
/// photos : ["uploads/all/PxPDkvWU8MYwN8iPY9JA16BWtqRp4LGDMGbTLZ8s.jpg"]
/// thumbnail_image : "uploads/all/PxPDkvWU8MYwN8iPY9JA16BWtqRp4LGDMGbTLZ8s.jpg"
/// tags : ["cap"]
/// price_high_low : "320,0$"
/// choice_options : [{"name":"1","title":"Size","options":["32","34","36"]}]
/// colors : ["#0000FF","#00008B","#FF0000"]
/// has_discount : true
/// stroked_price : "400,0$"
/// main_price : "320,0$"
/// calculable_price : 320
/// currency_symbol : "$"
/// current_stock : 0
/// unit : "pcs"
/// rating : 5
/// rating_count : 1
/// earn_point : 0
/// description : "<p>cap all<br></p>"

class Data {
  Data({
      this.id, 
      this.name, 
      this.addedBy, 
      this.sellerId, 
      this.shopId, 
      this.shopName, 
      this.shopLogo, 
      this.photos, 
      this.thumbnailImage, 
      this.tags, 
      this.priceHighLow, 
      this.choiceOptions, 
      this.colors, 
      this.hasDiscount, 
      this.strokedPrice, 
      this.mainPrice, 
      this.calculablePrice, 
      this.currencySymbol, 
      this.currentStock, 
      this.unit, 
      this.rating, 
      this.ratingCount, 
      this.earnPoint, 
      this.description,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    addedBy = json['added_by'];
    sellerId = json['seller_id'];
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    shopLogo = json['shop_logo'];
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    thumbnailImage = json['thumbnail_image'];
    tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    priceHighLow = json['price_high_low'];
    if (json['choice_options'] != null) {
      choiceOptions = [];
      json['choice_options'].forEach((v) {
        choiceOptions.add(Choice_options.fromJson(v));
      });
    }
    colors = json['colors'] != null ? json['colors'].cast<String>() : [];
    hasDiscount = json['has_discount'];
    strokedPrice = json['stroked_price'];
    mainPrice = json['main_price'];
    calculablePrice = json['calculable_price'];
    currencySymbol = json['currency_symbol'];
    currentStock = json['current_stock'];
    unit = json['unit'];
    rating = json['rating'];
    ratingCount = json['rating_count'];
    earnPoint = json['earn_point'];
    description = json['description'];
  }
  int id;
  String name;
  String addedBy;
  int sellerId;
  int shopId;
  String shopName;
  String shopLogo;
  List<String> photos;
  String thumbnailImage;
  List<String> tags;
  String priceHighLow;
  List<Choice_options> choiceOptions;
  List<String> colors;
  bool hasDiscount;
  String strokedPrice;
  String mainPrice;
  int calculablePrice;
  String currencySymbol;
  int currentStock;
  String unit;
  int rating;
  int ratingCount;
  int earnPoint;
  String description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['added_by'] = addedBy;
    map['seller_id'] = sellerId;
    map['shop_id'] = shopId;
    map['shop_name'] = shopName;
    map['shop_logo'] = shopLogo;
    map['photos'] = photos;
    map['thumbnail_image'] = thumbnailImage;
    map['tags'] = tags;
    map['price_high_low'] = priceHighLow;
    if (choiceOptions != null) {
      map['choice_options'] = choiceOptions.map((v) => v.toJson()).toList();
    }
    map['colors'] = colors;
    map['has_discount'] = hasDiscount;
    map['stroked_price'] = strokedPrice;
    map['main_price'] = mainPrice;
    map['calculable_price'] = calculablePrice;
    map['currency_symbol'] = currencySymbol;
    map['current_stock'] = currentStock;
    map['unit'] = unit;
    map['rating'] = rating;
    map['rating_count'] = ratingCount;
    map['earn_point'] = earnPoint;
    map['description'] = description;
    return map;
  }

}

/// name : "1"
/// title : "Size"
/// options : ["32","34","36"]

class Choice_options {
  Choice_options({
      this.name, 
      this.title, 
      this.options,});

  Choice_options.fromJson(dynamic json) {
    name = json['name'];
    title = json['title'];
    options = json['options'] != null ? json['options'].cast<String>() : [];
  }
  String name;
  String title;
  List<String> options;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['title'] = title;
    map['options'] = options;
    return map;
  }

}