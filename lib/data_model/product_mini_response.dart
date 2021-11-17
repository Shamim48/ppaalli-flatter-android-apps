// To parse this JSON data, do
//
//     final productMiniResponse = productMiniResponseFromJson(jsonString);
//https://app.quicktype.io/
import 'dart:convert';

ProductMiniResponse productMiniResponseFromJson(String str) => ProductMiniResponse.fromJson(json.decode(str));

String productMiniResponseToJson(ProductMiniResponse data) => json.encode(data.toJson());

var productList_=[
  Product(id: 1,name: 'Product Name',thumbnail_image: "dummy_assets/p1.jpeg",main_price: '1000',stroked_price: '800',has_discount: false,rating: 5,sales: 5),
  Product(id: 1,name: 'Blue T-Shirt',thumbnail_image: "dummy_assets/p2.jpeg",main_price: '800',stroked_price: '800',has_discount: false,rating: 5,sales: 5),
  Product(id: 1,name: 'Shirt',thumbnail_image: 'dummy_assets/p3.jpeg',main_price: '700',stroked_price: '800',has_discount: false,rating: 5,sales: 5),
  Product(id: 1,name: 'Sleeve',thumbnail_image: 'dummy_assets/p4.jpeg',main_price: '800',stroked_price: '800',has_discount: false,rating: 5,sales: 5),
  Product(id: 1,name: 'Textured ',thumbnail_image: 'dummy_assets/p5.jpeg',main_price: '500',stroked_price: '800',has_discount: false,rating: 5,sales: 5),
  Product(id: 1,name: ' Short Sleeve',thumbnail_image: 'dummy_assets/p6.jpeg',main_price: '900',stroked_price: '800',has_discount: false,rating: 5,sales: 5),
  Product(id: 1,name: ' Short ',thumbnail_image: 'dummy_assets/p7.jpeg',main_price: '300',stroked_price: '800',has_discount: false,rating: 5,sales: 5),
  Product(id: 1,name: 'Textured ',thumbnail_image: 'assets/splash_screen_logo.png',main_price: '1000',stroked_price: '800',has_discount: false,rating: 5,sales: 5),
  Product(id: 1,name: ' Sleeve',thumbnail_image: 'assets/splash_screen_logo.png',main_price: '1000',stroked_price: '800',has_discount: false,rating: 5,sales: 5),
  Product(id: 1,name: 'Textured ',thumbnail_image: 'assets/splash_screen_logo.png',main_price: '1000',stroked_price: '800',has_discount: false,rating: 5,sales: 5),
  Product(id: 1,name: 'Short Sleeve',thumbnail_image: 'assets/splash_screen_logo.png',main_price: '1000',stroked_price: '800',has_discount: false,rating: 5,sales: 5),
  Product(id: 1,name: 'Textured',thumbnail_image: 'assets/splash_screen_logo.png',main_price: '1000',stroked_price: '800',has_discount: false,rating: 5,sales: 5),
  Product(id: 1,name: 'Money Bag',thumbnail_image: 'assets/splash_screen_logo.png',main_price: '1000',stroked_price: '800',has_discount: false,rating: 5,sales: 5),
  Product(id: 1,name: 'Textured ',thumbnail_image: 'assets/splash_screen_logo.png',main_price: '1000',stroked_price: '800',has_discount: false,rating: 5,sales: 5),
];

class ProductMiniResponse {
  ProductMiniResponse({
    this.products,
    this.meta,
    this.success,
    this.status,
  });

  List<Product> products;
  bool success;
  int status;
  Meta meta;

  factory ProductMiniResponse.fromJson(Map<String, dynamic> json) => ProductMiniResponse(
    products: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(products.map((x) => x.toJson())),
    "meta": meta == null ? null : meta.toJson(),
    "success": success,
    "status": status,
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.thumbnail_image,
    this.main_price,
    this.stroked_price,
    this.has_discount,
    this.rating,
    this.sales,
    this.links,
  });

  int id;
  String name;
  String thumbnail_image;
  String main_price;
  String stroked_price;
  bool has_discount;
  int rating;
  int sales;
  Links links;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    thumbnail_image: json["thumbnail_image"],
    main_price: json["main_price"],
    stroked_price: json["stroked_price"],
    has_discount: json["has_discount"],
    rating: json["rating"].toInt(),
    sales: json["sales"],
    links: Links.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail_image": thumbnail_image,
    "main_price": main_price,
    "stroked_price": stroked_price,
    "has_discount": has_discount,
    "rating": rating,
    "sales": sales,
    "links": links.toJson(),
  };
}

class Links {
  Links({
    this.details,
  });

  String details;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "details": details,
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}
