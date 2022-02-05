
import 'dart:convert';

GroupBuyingProductDetails groupBuyingProductDetailsResponseFromJson(String str) => GroupBuyingProductDetails.fromJson(json.decode(str));

class GroupBuyingProductDetails {
  bool _success;
  int _status;
  String _message;
  String _minMaxPrice;
  String _startTime;
  String _endTime;
  GroupProductInfo _groupProductInfo;
  List<Data> _data;

  GroupBuyingProductDetails(
      {bool success,
        int status,
        String message,
        String minMaxPrice,
        String startTime,
        String endTime,
        GroupProductInfo groupProductInfo,
        List<Data> data}) {
    this._success = success;
    this._status = status;
    this._message = message;
    this._minMaxPrice = minMaxPrice;
    this._startTime = startTime;
    this._endTime = endTime;
    this._groupProductInfo = groupProductInfo;
    this._data = data;
  }

  bool get success => _success;
  set success(bool success) => _success = success;
  int get status => _status;
  set status(int status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  String get minMaxPrice => _minMaxPrice;
  set minMaxPrice(String minMaxPrice) => _minMaxPrice = minMaxPrice;
  String get startTime => _startTime;
  set startTime(String startTime) => _startTime = startTime;
  String get endTime => _endTime;
  set endTime(String endTime) => _endTime = endTime;
  GroupProductInfo get groupProductInfo => _groupProductInfo;
  set groupProductInfo(GroupProductInfo groupProductInfo) =>
      _groupProductInfo = groupProductInfo;
  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;

  GroupBuyingProductDetails.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _status = json['status'];
    _message = json['message'];
    _minMaxPrice = json['min_max_price'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _groupProductInfo = json['groupProductInfo'] != null
        ? new GroupProductInfo.fromJson(json['groupProductInfo'])
        : null;
    if (json['data'] != null) {
      _data = new List<Data>();
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['status'] = this._status;
    data['message'] = this._message;
    data['min_max_price'] = this._minMaxPrice;
    data['start_time'] = this._startTime;
    data['end_time'] = this._endTime;
    if (this._groupProductInfo != null) {
      data['groupProductInfo'] = this._groupProductInfo.toJson();
    }
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupProductInfo {
  int _id;
  String _name;
  String _addedBy;
  int _userId;
  int _verificationStatus;
  int _categoryId;
  int _brandId;
  String _photos;
  String _thumbnailImg;
  String _videoProvider;
  Null _videoLink;
  String _tags;
  String _description;
  int _unitPrice;
  Null _purchasePrice;
  int _variantProduct;
  int _groupsellProduct;
  String _attributes;
  String _choiceOptions;
  String _colors;
  Null _variations;
  int _todaysDeal;
  int _published;
  String _stockVisibilityState;
  int _cashOnDelivery;
  int _featured;
  int _sellerFeatured;
  int _currentStock;
  String _unit;
  int _minQty;
  int _lowStockQuantity;
  int _discount;
  String _discountType;
  int _isStudentDiscount;
  int _studentDiscountPercent;
  String _universityIds;
  Null _tax;
  Null _taxType;
  int _vatPaidBy;
  String _shippingType;
  String _shippingCost;
  int _isQuantityMultiplied;
  Null _estShippingDays;
  int _numOfSale;
  String _metaTitle;
  String _metaDescription;
  String _metaImg;
  Null _pdf;
  String _slug;
  int _refundable;
  int _rating;
  Null _barcode;
  int _digital;
  Null _fileName;
  Null _filePath;
  int _qrRequestStatus;
  int _qrVerificationStatus;
  String _createdAt;
  String _updatedAt;

  GroupProductInfo(
      {int id,
        String name,
        String addedBy,
        int userId,
        int verificationStatus,
        int categoryId,
        int brandId,
        String photos,
        String thumbnailImg,
        String videoProvider,
        Null videoLink,
        String tags,
        String description,
        int unitPrice,
        Null purchasePrice,
        int variantProduct,
        int groupsellProduct,
        String attributes,
        String choiceOptions,
        String colors,
        Null variations,
        int todaysDeal,
        int published,
        String stockVisibilityState,
        int cashOnDelivery,
        int featured,
        int sellerFeatured,
        int currentStock,
        String unit,
        int minQty,
        int lowStockQuantity,
        int discount,
        String discountType,
        int isStudentDiscount,
        int studentDiscountPercent,
        String universityIds,
        Null tax,
        Null taxType,
        int vatPaidBy,
        String shippingType,
        String shippingCost,
        int isQuantityMultiplied,
        Null estShippingDays,
        int numOfSale,
        String metaTitle,
        String metaDescription,
        String metaImg,
        Null pdf,
        String slug,
        int refundable,
        int rating,
        Null barcode,
        int digital,
        Null fileName,
        Null filePath,
        int qrRequestStatus,
        int qrVerificationStatus,
        String createdAt,
        String updatedAt}) {
    this._id = id;
    this._name = name;
    this._addedBy = addedBy;
    this._userId = userId;
    this._verificationStatus = verificationStatus;
    this._categoryId = categoryId;
    this._brandId = brandId;
    this._photos = photos;
    this._thumbnailImg = thumbnailImg;
    this._videoProvider = videoProvider;
    this._videoLink = videoLink;
    this._tags = tags;
    this._description = description;
    this._unitPrice = unitPrice;
    this._purchasePrice = purchasePrice;
    this._variantProduct = variantProduct;
    this._groupsellProduct = groupsellProduct;
    this._attributes = attributes;
    this._choiceOptions = choiceOptions;
    this._colors = colors;
    this._variations = variations;
    this._todaysDeal = todaysDeal;
    this._published = published;
    this._stockVisibilityState = stockVisibilityState;
    this._cashOnDelivery = cashOnDelivery;
    this._featured = featured;
    this._sellerFeatured = sellerFeatured;
    this._currentStock = currentStock;
    this._unit = unit;
    this._minQty = minQty;
    this._lowStockQuantity = lowStockQuantity;
    this._discount = discount;
    this._discountType = discountType;
    this._isStudentDiscount = isStudentDiscount;
    this._studentDiscountPercent = studentDiscountPercent;
    this._universityIds = universityIds;
    this._tax = tax;
    this._taxType = taxType;
    this._vatPaidBy = vatPaidBy;
    this._shippingType = shippingType;
    this._shippingCost = shippingCost;
    this._isQuantityMultiplied = isQuantityMultiplied;
    this._estShippingDays = estShippingDays;
    this._numOfSale = numOfSale;
    this._metaTitle = metaTitle;
    this._metaDescription = metaDescription;
    this._metaImg = metaImg;
    this._pdf = pdf;
    this._slug = slug;
    this._refundable = refundable;
    this._rating = rating;
    this._barcode = barcode;
    this._digital = digital;
    this._fileName = fileName;
    this._filePath = filePath;
    this._qrRequestStatus = qrRequestStatus;
    this._qrVerificationStatus = qrVerificationStatus;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get addedBy => _addedBy;
  set addedBy(String addedBy) => _addedBy = addedBy;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  int get verificationStatus => _verificationStatus;
  set verificationStatus(int verificationStatus) =>
      _verificationStatus = verificationStatus;
  int get categoryId => _categoryId;
  set categoryId(int categoryId) => _categoryId = categoryId;
  int get brandId => _brandId;
  set brandId(int brandId) => _brandId = brandId;
  String get photos => _photos;
  set photos(String photos) => _photos = photos;
  String get thumbnailImg => _thumbnailImg;
  set thumbnailImg(String thumbnailImg) => _thumbnailImg = thumbnailImg;
  String get videoProvider => _videoProvider;
  set videoProvider(String videoProvider) => _videoProvider = videoProvider;
  Null get videoLink => _videoLink;
  set videoLink(Null videoLink) => _videoLink = videoLink;
  String get tags => _tags;
  set tags(String tags) => _tags = tags;
  String get description => _description;
  set description(String description) => _description = description;
  int get unitPrice => _unitPrice;
  set unitPrice(int unitPrice) => _unitPrice = unitPrice;
  Null get purchasePrice => _purchasePrice;
  set purchasePrice(Null purchasePrice) => _purchasePrice = purchasePrice;
  int get variantProduct => _variantProduct;
  set variantProduct(int variantProduct) => _variantProduct = variantProduct;
  int get groupsellProduct => _groupsellProduct;
  set groupsellProduct(int groupsellProduct) =>
      _groupsellProduct = groupsellProduct;
  String get attributes => _attributes;
  set attributes(String attributes) => _attributes = attributes;
  String get choiceOptions => _choiceOptions;
  set choiceOptions(String choiceOptions) => _choiceOptions = choiceOptions;
  String get colors => _colors;
  set colors(String colors) => _colors = colors;
  Null get variations => _variations;
  set variations(Null variations) => _variations = variations;
  int get todaysDeal => _todaysDeal;
  set todaysDeal(int todaysDeal) => _todaysDeal = todaysDeal;
  int get published => _published;
  set published(int published) => _published = published;
  String get stockVisibilityState => _stockVisibilityState;
  set stockVisibilityState(String stockVisibilityState) =>
      _stockVisibilityState = stockVisibilityState;
  int get cashOnDelivery => _cashOnDelivery;
  set cashOnDelivery(int cashOnDelivery) => _cashOnDelivery = cashOnDelivery;
  int get featured => _featured;
  set featured(int featured) => _featured = featured;
  int get sellerFeatured => _sellerFeatured;
  set sellerFeatured(int sellerFeatured) => _sellerFeatured = sellerFeatured;
  int get currentStock => _currentStock;
  set currentStock(int currentStock) => _currentStock = currentStock;
  String get unit => _unit;
  set unit(String unit) => _unit = unit;
  int get minQty => _minQty;
  set minQty(int minQty) => _minQty = minQty;
  int get lowStockQuantity => _lowStockQuantity;
  set lowStockQuantity(int lowStockQuantity) =>
      _lowStockQuantity = lowStockQuantity;
  int get discount => _discount;
  set discount(int discount) => _discount = discount;
  String get discountType => _discountType;
  set discountType(String discountType) => _discountType = discountType;
  int get isStudentDiscount => _isStudentDiscount;
  set isStudentDiscount(int isStudentDiscount) =>
      _isStudentDiscount = isStudentDiscount;
  int get studentDiscountPercent => _studentDiscountPercent;
  set studentDiscountPercent(int studentDiscountPercent) =>
      _studentDiscountPercent = studentDiscountPercent;
  String get universityIds => _universityIds;
  set universityIds(String universityIds) => _universityIds = universityIds;
  Null get tax => _tax;
  set tax(Null tax) => _tax = tax;
  Null get taxType => _taxType;
  set taxType(Null taxType) => _taxType = taxType;
  int get vatPaidBy => _vatPaidBy;
  set vatPaidBy(int vatPaidBy) => _vatPaidBy = vatPaidBy;
  String get shippingType => _shippingType;
  set shippingType(String shippingType) => _shippingType = shippingType;
  String get shippingCost => _shippingCost;
  set shippingCost(String shippingCost) => _shippingCost = shippingCost;
  int get isQuantityMultiplied => _isQuantityMultiplied;
  set isQuantityMultiplied(int isQuantityMultiplied) =>
      _isQuantityMultiplied = isQuantityMultiplied;
  Null get estShippingDays => _estShippingDays;
  set estShippingDays(Null estShippingDays) =>
      _estShippingDays = estShippingDays;
  int get numOfSale => _numOfSale;
  set numOfSale(int numOfSale) => _numOfSale = numOfSale;
  String get metaTitle => _metaTitle;
  set metaTitle(String metaTitle) => _metaTitle = metaTitle;
  String get metaDescription => _metaDescription;
  set metaDescription(String metaDescription) =>
      _metaDescription = metaDescription;
  String get metaImg => _metaImg;
  set metaImg(String metaImg) => _metaImg = metaImg;
  Null get pdf => _pdf;
  set pdf(Null pdf) => _pdf = pdf;
  String get slug => _slug;
  set slug(String slug) => _slug = slug;
  int get refundable => _refundable;
  set refundable(int refundable) => _refundable = refundable;
  int get rating => _rating;
  set rating(int rating) => _rating = rating;
  Null get barcode => _barcode;
  set barcode(Null barcode) => _barcode = barcode;
  int get digital => _digital;
  set digital(int digital) => _digital = digital;
  Null get fileName => _fileName;
  set fileName(Null fileName) => _fileName = fileName;
  Null get filePath => _filePath;
  set filePath(Null filePath) => _filePath = filePath;
  int get qrRequestStatus => _qrRequestStatus;
  set qrRequestStatus(int qrRequestStatus) =>
      _qrRequestStatus = qrRequestStatus;
  int get qrVerificationStatus => _qrVerificationStatus;
  set qrVerificationStatus(int qrVerificationStatus) =>
      _qrVerificationStatus = qrVerificationStatus;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  GroupProductInfo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _addedBy = json['added_by'];
    _userId = json['user_id'];
    _verificationStatus = json['verification_status'];
    _categoryId = json['category_id'];
    _brandId = json['brand_id'];
    _photos = json['photos'];
    _thumbnailImg = json['thumbnail_img'];
    _videoProvider = json['video_provider'];
    _videoLink = json['video_link'];
    _tags = json['tags'];
    _description = json['description'];
    _unitPrice = json['unit_price'];
    _purchasePrice = json['purchase_price'];
    _variantProduct = json['variant_product'];
    _groupsellProduct = json['groupsell_product'];
    _attributes = json['attributes'];
    _choiceOptions = json['choice_options'];
    _colors = json['colors'];
    _variations = json['variations'];
    _todaysDeal = json['todays_deal'];
    _published = json['published'];
    _stockVisibilityState = json['stock_visibility_state'];
    _cashOnDelivery = json['cash_on_delivery'];
    _featured = json['featured'];
    _sellerFeatured = json['seller_featured'];
    _currentStock = json['current_stock'];
    _unit = json['unit'];
    _minQty = json['min_qty'];
    _lowStockQuantity = json['low_stock_quantity'];
    _discount = json['discount'];
    _discountType = json['discount_type'];
    _isStudentDiscount = json['is_student_discount'];
    _studentDiscountPercent = json['student_discount_percent'];
    _universityIds = json['university_ids'];
    _tax = json['tax'];
    _taxType = json['tax_type'];
    _vatPaidBy = json['vat_paid_by'];
    _shippingType = json['shipping_type'];
    _shippingCost = json['shipping_cost'];
    _isQuantityMultiplied = json['is_quantity_multiplied'];
    _estShippingDays = json['est_shipping_days'];
    _numOfSale = json['num_of_sale'];
    _metaTitle = json['meta_title'];
    _metaDescription = json['meta_description'];
    _metaImg = json['meta_img'];
    _pdf = json['pdf'];
    _slug = json['slug'];
    _refundable = json['refundable'];
    _rating = json['rating'];
    _barcode = json['barcode'];
    _digital = json['digital'];
    _fileName = json['file_name'];
    _filePath = json['file_path'];
    _qrRequestStatus = json['qr_request_status'];
    _qrVerificationStatus = json['qr_verification_status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['added_by'] = this._addedBy;
    data['user_id'] = this._userId;
    data['verification_status'] = this._verificationStatus;
    data['category_id'] = this._categoryId;
    data['brand_id'] = this._brandId;
    data['photos'] = this._photos;
    data['thumbnail_img'] = this._thumbnailImg;
    data['video_provider'] = this._videoProvider;
    data['video_link'] = this._videoLink;
    data['tags'] = this._tags;
    data['description'] = this._description;
    data['unit_price'] = this._unitPrice;
    data['purchase_price'] = this._purchasePrice;
    data['variant_product'] = this._variantProduct;
    data['groupsell_product'] = this._groupsellProduct;
    data['attributes'] = this._attributes;
    data['choice_options'] = this._choiceOptions;
    data['colors'] = this._colors;
    data['variations'] = this._variations;
    data['todays_deal'] = this._todaysDeal;
    data['published'] = this._published;
    data['stock_visibility_state'] = this._stockVisibilityState;
    data['cash_on_delivery'] = this._cashOnDelivery;
    data['featured'] = this._featured;
    data['seller_featured'] = this._sellerFeatured;
    data['current_stock'] = this._currentStock;
    data['unit'] = this._unit;
    data['min_qty'] = this._minQty;
    data['low_stock_quantity'] = this._lowStockQuantity;
    data['discount'] = this._discount;
    data['discount_type'] = this._discountType;
    data['is_student_discount'] = this._isStudentDiscount;
    data['student_discount_percent'] = this._studentDiscountPercent;
    data['university_ids'] = this._universityIds;
    data['tax'] = this._tax;
    data['tax_type'] = this._taxType;
    data['vat_paid_by'] = this._vatPaidBy;
    data['shipping_type'] = this._shippingType;
    data['shipping_cost'] = this._shippingCost;
    data['is_quantity_multiplied'] = this._isQuantityMultiplied;
    data['est_shipping_days'] = this._estShippingDays;
    data['num_of_sale'] = this._numOfSale;
    data['meta_title'] = this._metaTitle;
    data['meta_description'] = this._metaDescription;
    data['meta_img'] = this._metaImg;
    data['pdf'] = this._pdf;
    data['slug'] = this._slug;
    data['refundable'] = this._refundable;
    data['rating'] = this._rating;
    data['barcode'] = this._barcode;
    data['digital'] = this._digital;
    data['file_name'] = this._fileName;
    data['file_path'] = this._filePath;
    data['qr_request_status'] = this._qrRequestStatus;
    data['qr_verification_status'] = this._qrVerificationStatus;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

class Data {
  int _id;
  String _name;
  String _paymentStatus;
  Null _productId;

  Data({int id, String name, String paymentStatus, Null productId}) {
    this._id = id;
    this._name = name;
    this._paymentStatus = paymentStatus;
    this._productId = productId;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get paymentStatus => _paymentStatus;
  set paymentStatus(String paymentStatus) => _paymentStatus = paymentStatus;
  Null get productId => _productId;
  set productId(Null productId) => _productId = productId;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _paymentStatus = json['payment_status'];
    _productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['payment_status'] = this._paymentStatus;
    data['product_id'] = this._productId;
    return data;
  }
}