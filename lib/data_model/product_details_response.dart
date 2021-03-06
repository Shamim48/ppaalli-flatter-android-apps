// To parse this JSON data, do
//
//     final productDetailsResponse = productDetailsResponseFromJson(jsonString);
// https://app.quicktype.io/
import 'dart:convert';

ProductDetailsResponse productDetailsResponseFromJson(String str) => ProductDetailsResponse.fromJson(json.decode(str));

String productDetailsResponseToJson(ProductDetailsResponse data) => json.encode(data.toJson());

class ProductDetailsResponse   {
  ProductDetailsResponse({
  this.data,
  this.success,
  this.status,});

  ProductDetailsResponse.fromJson(dynamic json) {
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

/*{
  List<Data> data;
  bool success;
  int status;

  ProductDetailsResponse({this.data, this.success, this.status});

  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int id;
  String name;
  String addedBy;
  int sellerId;
  int shopId;
  String shopName;
  String shopLogo;
  List<Photos> photos;
  String thumbnailImage;
  List<String> tags;
  String priceHighLow;
  List<ChoiceOptions> choiceOptions;
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
  String videoLink;
  Brand brand;
  String link;

  Data(
      {this.id,
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
        this.description,
        this.videoLink,
        this.brand,
        this.link});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    addedBy = json['added_by'];
    sellerId = json['seller_id'];
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    shopLogo = json['shop_logo'];
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    thumbnailImage = json['thumbnail_image'];
    if (json['tags'] != null) {
      tags = json['tags'].cast<String>();
    }
    priceHighLow = json['price_high_low'];
    if (json['choice_options'] != null) {
      choiceOptions = new List<ChoiceOptions>();
      json['choice_options'].forEach((v) {
        choiceOptions.add(new ChoiceOptions.fromJson(v));
      });
    }
    if (json['colors'] != null) {
      colors = json['colors'].cast<String>();
    }
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
    videoLink = json['video_link'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['added_by'] = this.addedBy;
    data['seller_id'] = this.sellerId;
    data['shop_id'] = this.shopId;
    data['shop_name'] = this.shopName;
    data['shop_logo'] = this.shopLogo;
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    data['thumbnail_image'] = this.thumbnailImage;
    data['tags'] = this.tags;
    data['price_high_low'] = this.priceHighLow;
    if (this.choiceOptions != null) {
      data['choice_options'] =
          this.choiceOptions.map((v) => v.toJson()).toList();
    }
    data['colors'] = this.colors;
    data['has_discount'] = this.hasDiscount;
    data['stroked_price'] = this.strokedPrice;
    data['main_price'] = this.mainPrice;
    data['calculable_price'] = this.calculablePrice;
    data['currency_symbol'] = this.currencySymbol;
    data['current_stock'] = this.currentStock;
    data['unit'] = this.unit;
    data['rating'] = this.rating;
    data['rating_count'] = this.ratingCount;
    data['earn_point'] = this.earnPoint;
    data['description'] = this.description;
    data['video_link'] = this.videoLink;
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    data['link'] = this.link;
    return data;
  }
}

class Photos {
  String variant;
  String path;

  Photos({this.variant, this.path});

  Photos.fromJson(Map<String, dynamic> json) {
    variant = json['variant'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant'] = this.variant;
    data['path'] = this.path;
    return data;
  }
}

class ChoiceOptions {
  String name;
  String title;
  List<String> options;

  ChoiceOptions({this.name, this.title, this.options});

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['options'] = this.options;
    return data;
  }
}

class Brand {
  int id;
  String name;
  String logo;

  Brand({this.id, this.name, this.logo});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}
*/

/*{

  ProductDetailsResponse({
    this.detailed_products,
    this.success,
    this.status,
  });

  List<DetailedProduct> detailed_products;
  bool success;
  int status;

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) => ProductDetailsResponse(
    detailed_products: List<DetailedProduct>.from(json["data"].map((x) => DetailedProduct.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(detailed_products.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class DetailedProduct {
  DetailedProduct({
    this.id,
    this.name,
    this.added_by,
    this.seller_id,
    this.shop_id,
    this.shop_name,
    this.shop_logo,
    this.photos,
    this.thumbnail_image,
    this.tags,
    this.price_high_low,
    this.choice_options,
    this.colors,
    this.has_discount,
    this.stroked_price,
    this.main_price,
    this.calculable_price,
    this.currency_symbol,
    this.current_stock,
    this.unit,
    this.rating,
    this.rating_count,
    this.earn_point,
    this.description,
    this.video_link,
    this.link,
    this.brand
  });

  int id;
  String name;
  String added_by;
  int seller_id;
  int shop_id;
  String shop_name;
  String shop_logo;
  List<Photo> photos;
  String thumbnail_image;
  List<String> tags;
  String price_high_low;
  List<ChoiceOption> choice_options;
  List<dynamic> colors;
  bool has_discount;
  String stroked_price;
  String main_price;
  var calculable_price;
  String currency_symbol;
  int current_stock;
  String unit;
  int rating;
  int rating_count;
  int earn_point;
  String description;
  String video_link;
  String link;
  Brand brand;

  factory DetailedProduct.fromJson(Map<String, dynamic> json) => DetailedProduct(
    id: json["id"],
    name: json["name"],
    added_by: json["added_by"],
    seller_id: json["seller_id"],
    shop_id: json["shop_id"],
    shop_name: json["shop_name"],
    shop_logo: json["shop_logo"],
    photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    thumbnail_image: json["thumbnail_image"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    price_high_low: json["price_high_low"],
    choice_options: List<ChoiceOption>.from(json["choice_options"].map((x) => ChoiceOption.fromJson(x))),
    colors: List<String>.from(json["colors"].map((x) => x)),
    has_discount: json["has_discount"],
    stroked_price: json["stroked_price"],
    main_price: json["main_price"],
    calculable_price: json["calculable_price"],
    currency_symbol: json["currency_symbol"],
    current_stock: json["current_stock"],
    unit: json["unit"],
    rating: json["rating"].toInt(),
    rating_count: json["rating_count"],
    earn_point: json["earn_point"].toInt(),
    description: json["description"] == null || json["description"] == "" ? "No Description is available" : json['description'],
    video_link: json["video_link"],
    link: json["link"],
    brand: Brand.fromJson(json["brand"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "added_by": added_by,
    "seller_id": seller_id,
    "shop_id": shop_id,
    "shop_name": shop_name,
    "shop_logo": shop_logo,
    "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    "thumbnail_image": thumbnail_image,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "price_high_low": price_high_low,
    "choice_options": List<dynamic>.from(choice_options.map((x) => x.toJson())),
    "colors": List<dynamic>.from(colors.map((x) => x)),
    "has_discount": has_discount,
    "stroked_price": stroked_price,
    "main_price": main_price,
    "calculable_price": calculable_price,
    "currency_symbol": currency_symbol,
    "current_stock": current_stock,
    "unit": unit,
    "rating": rating,
    "rating_count": rating_count,
    "earn_point": earn_point,
    "description": description,
    "video_link": video_link,
    "link": link,
    "brand": brand.toJson(),
  };
}

class Brand {
  Brand({
    this.id,
    this.name,
    this.logo,
  });

  int id;
  String name;
  String logo;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
  };
}

class Photo {
  Photo({
    this.variant,
    this.path,
  });

  String variant;
  String path;

  factory Photo.fromJson(Map<String, dynamic> json) =>
      Photo(
        variant: json["variant"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() =>
      {
        "variant": variant,
        "path": path,
      };
}

class ChoiceOption {
  ChoiceOption({
    this.name,
    this.title,
    this.options,
  });

  String name;
  String title;
  List<String> options;

  factory ChoiceOption.fromJson(Map<String, dynamic> json) => ChoiceOption(
    name: json["name"],
    title: json["title"],
    options: List<String>.from(json["options"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "title": title,
    "options": List<dynamic>.from(options.map((x) => x)),
  };
}
*/