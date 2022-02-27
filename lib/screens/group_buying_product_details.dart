import 'dart:async';
import 'dart:ui';

import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/data_model/group_buying/group_buying_product.dart';
import 'package:active_ecommerce_flutter/data_model/group_buying/group_product_details.dart';
import 'package:active_ecommerce_flutter/helpers/color_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/repositories/cart_repository.dart';
import 'package:active_ecommerce_flutter/repositories/chat_repository.dart';
import 'package:active_ecommerce_flutter/repositories/group_buying_repository.dart';
import 'package:active_ecommerce_flutter/repositories/product_repository.dart';
import 'package:active_ecommerce_flutter/repositories/wishlist_repository.dart';
import 'package:active_ecommerce_flutter/screens/brand_products.dart';
import 'package:active_ecommerce_flutter/screens/cart.dart';
import 'package:active_ecommerce_flutter/screens/chat.dart';
import 'package:active_ecommerce_flutter/screens/common_webview_screen.dart';
import 'package:active_ecommerce_flutter/screens/login.dart';
import 'package:active_ecommerce_flutter/screens/product_reviews.dart';
import 'package:active_ecommerce_flutter/screens/video_description_screen.dart';
import 'package:active_ecommerce_flutter/ui_elements/list_product_card.dart';
import 'package:active_ecommerce_flutter/ui_elements/mini_product_card.dart';
import 'package:active_ecommerce_flutter/utill/images.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:social_share/social_share.dart';
import 'package:toast/toast.dart';

import 'group_buying_product_details.dart';

class GroupBuyingProductDetails extends StatefulWidget {
  int id;

  GroupBuyingProductDetails({Key key, this.id}) : super(key: key);

  @override
  _GroupBuyingProductDetailsState createState() =>
      _GroupBuyingProductDetailsState();
}

class _GroupBuyingProductDetailsState extends State<GroupBuyingProductDetails> {
  bool isGroup = false;
  bool _showCopied = false;
  String _appbarPriceString = ". . .";
  int _currentImage = 0;
  ScrollController _mainScrollController = ScrollController();
  ScrollController _colorScrollController = ScrollController();
  ScrollController _sizeScrollController = ScrollController();
  ScrollController _variantScrollController = ScrollController();
  ScrollController _imageScrollController = ScrollController();
  TextEditingController sellerChatTitleController = TextEditingController();
  TextEditingController sellerChatMessageController = TextEditingController();

  //init values
  bool _isInWishList = false;
  var _productDetailsFetched = false;
  var _productDetails = null;
  var _productImageList = [];
  var _colorList = [];
  int _selectedColorIndex = 0;
  var _selectedChoices = [];
  var _choiceString = "";
  var _variant = "";
  var _totalPrice;
  var _singlePrice;
  var _singlePriceString;
  int _quantity = 1;
  int _stock = 0;
  var list = [1, 2, 3, 4];

  List<dynamic> _relatedProducts = [];
  bool _relatedProductInit = false;
  List<dynamic> _topProducts = [];
  bool _topProductInit = false;

  String wishlistImage = Images.heart_outline;

  CheckGroupBuying _checkGroupBuying;

  GroupProductDetails _groupProductDetails;

  @override
  void initState() {
    fetchAll();

    super.initState();
  }

  @override
  void dispose() {
    _mainScrollController.dispose();
    _variantScrollController.dispose();
    _imageScrollController.dispose();
    _colorScrollController.dispose();
    _sizeScrollController.dispose();
    super.dispose();
  }

  fetchAll() {
    print("product id : ${widget.id}");
    fetchProductDetails();
    fetchGroupProductDetails();
    checkGroupBuying();
    if (is_logged_in.$ == true) {
      fetchWishListCheckInfo();
    }

    // fetchRelatedProducts();
    fetchTopProducts();
  }

  fetchGroupProductDetails() async{
    var productDetailsRes= await GroupBuyingRepo().getGroupProductDetails(id: widget.id);
    _groupProductDetails=productDetailsRes;

    setState(() {

    });

  }

  fetchProductDetails() async {
    var productDetailsResponse =
        await ProductRepository().getProductDetails(id: widget.id);

    // var productDetailsResponse =_productImageList.ge;
    // if (productDetailsResponse.data.length > 0) {
    _productDetails = productDetailsResponse;
    print(
        'Product Details : ${productDetailsResponse.data[0].name.toString()}');
    sellerChatTitleController.text = productDetailsResponse.data[0].name;
    // }

    setProductDetailValues();

    setState(() {});
  }

  checkGroupBuying() async {
    var response = await GroupBuyingRepo().checkGroupProduct(widget.id);
    isGroup = response.success;
    _checkGroupBuying = response;
    print("Product type:");
    print(isGroup);
    setState(() {});
  }

  fetchRelatedProducts() async {
    var relatedProductResponse =
        await ProductRepository().getRelatedProducts(id: widget.id);
    _relatedProducts.addAll(relatedProductResponse.data);
    _relatedProductInit = true;

    setState(() {});
  }

  fetchTopProducts() async {
    var topProductResponse =
        await ProductRepository().getTopFromThisSellerProducts(id: widget.id);
    _topProducts.addAll(topProductResponse.data);
    _topProductInit = true;
  }

  setProductDetailValues() {
    if (_productDetails != null) {
      _appbarPriceString = _productDetails.data[0].priceHighLow;
      _singlePrice = _productDetails.data[0].calculablePrice;
      _singlePriceString = _productDetails.data[0].mainPrice;
      calculateTotalPrice();
      _stock = _productDetails.data[0].currentStock;
      _productDetails.data[0].photos.forEach((photo) {
        _productImageList.add(photo);
      });

      _productDetails.data[0].choiceOptions.forEach((choiceOpiton) {
        _selectedChoices.add(choiceOpiton.options[0]);
      });
      _productDetails.data[0].colors.forEach((color) {
        _colorList.add(color);
      });

      setChoiceString();
      if (_productDetails.data[0].colors.length > 0 ||
          _productDetails.data[0].choice_options.length > 0) {
        fetchAndSetVariantWiseInfo(change_appbar_string: true);
      }
      _productDetailsFetched = true;

      setState(() {});
    }
  }

  setChoiceString() {
    _choiceString = _selectedChoices.join(",").toString();
    //print(_choiceString);
    setState(() {});
  }

  fetchWishListCheckInfo() async {
    var wishListCheckResponse =
        await WishListRepository().isProductInUserWishList(
      product_id: widget.id,
    );

    //print("p&u:" + widget.id.toString() + " | " + _user_id.toString());
    _isInWishList = wishListCheckResponse.is_in_wishlist;
    setState(() {});
  }

  addToWishList() async {
    var wishListCheckResponse =
        await WishListRepository().add(product_id: widget.id);

    //print("p&u:" + widget.id.toString() + " | " + _user_id.toString());
    _isInWishList = wishListCheckResponse.is_in_wishlist;
    setState(() {});
  }

  removeFromWishList() async {
    var wishListCheckResponse =
        await WishListRepository().remove(product_id: widget.id);

    //print("p&u:" + widget.id.toString() + " | " + _user_id.toString());
    _isInWishList = wishListCheckResponse.is_in_wishlist;
    setState(() {});
  }

  onWishTap() {
    if (is_logged_in.$ == false) {
      ToastComponent.showDialog(
          AppLocalizations.of(context).common_login_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }

    if (_isInWishList) {
      _isInWishList = false;
      setState(() {});
      removeFromWishList();
    } else {
      _isInWishList = true;
      setState(() {});
      addToWishList();
    }
  }

  fetchAndSetVariantWiseInfo({bool change_appbar_string = true}) async {
    var color_string = _colorList.length > 0
        ? _colorList[_selectedColorIndex].toString().replaceAll("#", "")
        : "";

    /*print("color string: "+color_string);
    return;*/

    var variantResponse = await ProductRepository().getVariantWiseInfo(
        id: widget.id, color: color_string, variants: _choiceString);

    /*print("vr"+variantResponse.toJson().toString());
    return;*/

    _singlePrice = variantResponse.price;
    _stock = variantResponse.stock;
    if (_quantity > _stock) {
      _quantity = _stock;
      setState(() {});
    }

    _variant = variantResponse.variant;
    setState(() {});

    calculateTotalPrice();
    _singlePriceString = variantResponse.price_string;

    if (change_appbar_string) {
      _appbarPriceString = "${variantResponse.variant} ${_singlePriceString}";
    }

    int pindex = 0;
    _productDetails.photos.forEach((photo) {
      if (photo.variant == _variant && variantResponse.image != "") {
        _currentImage = pindex;
      }

      pindex++;
    });

    setState(() {});
  }

  reset() {
    restProductDetailValues();
    _productImageList.clear();
    _colorList.clear();
    _selectedChoices.clear();
    _relatedProducts.clear();
    _topProducts.clear();
    _choiceString = "";
    _variant = "";
    _selectedColorIndex = 0;
    _quantity = 1;
    _productDetailsFetched = false;
    _isInWishList = false;
    sellerChatTitleController.clear();
    setState(() {});
  }

  restProductDetailValues() {
    _appbarPriceString = " . . .";
    _productDetails = null;
    _productImageList.clear();
    _currentImage = 0;
    setState(() {});
  }

  Future<void> _onPageRefresh() async {
    reset();
    fetchAll();
  }

  calculateTotalPrice() {
    _totalPrice = _singlePrice * _quantity;
    setState(() {});
  }

  _onVariantChange(_choice_options_index, value) {
    _selectedChoices[_choice_options_index] = value;
    setChoiceString();
    setState(() {});
    fetchAndSetVariantWiseInfo();
  }

  _onColorChange(index) {
    _selectedColorIndex = index;
    setState(() {});
    fetchAndSetVariantWiseInfo();
  }

  onPressAddToCart({context, snackbar}) {
    addToCart(mode: "add_to_cart", context: context, snackbar: snackbar);
  }

  onPressBuyNow(context) {
    addToCart(mode: "buy_now", context: context);
  }

  addToCart({mode, context = null, snackbar = null}) async {
    if (is_logged_in.$ == false) {
      ToastComponent.showDialog(
          AppLocalizations.of(context).common_login_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
      }));

      return;
    }

    /*productCartList.add(_productDetails.data[0]);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Cart(has_bottomnav: true,);
      }));*/

    print(widget.id);
    print(_variant);
    print(user_id.$);
    print(_quantity);

    var cartAddResponse = await CartRepository()
        .getGroupCartAddResponse(id:widget.id, user_id: user_id.$, quantity: _quantity);

    if (cartAddResponse.result == false) {
      ToastComponent.showDialog(cartAddResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Cart(has_bottomnav: false);
      })).then((value) {
        onPopped(value);
      });
    }
  }

  onPopped(value) async {
    reset();
    fetchAll();
  }

  onCopyTap(setState) {
    setState(() {
      _showCopied = true;
    });
    Timer timer = Timer(Duration(seconds: 3), () {
      setState(() {
        _showCopied = false;
      });
    });
  }

  onPressShare(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 10),
              contentPadding: EdgeInsets.only(
                  top: 36.0, left: 36.0, right: 36.0, bottom: 2.0),
              content: Container(
                width: 400,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: FlatButton(
                          minWidth: 75,
                          height: 26,
                          color: Color.fromRGBO(253, 253, 253, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side:
                                  BorderSide(color: Colors.black, width: 1.0)),
                          child: Text(
                            AppLocalizations.of(context)
                                .product_details_screen_copy_product_link,
                            style: TextStyle(
                              color: MyTheme.medium_grey,
                            ),
                          ),
                          onPressed: () {
                            onCopyTap(setState);
                            SocialShare.copyToClipboard(_productDetails.link);
                          },
                        ),
                      ),
                      _showCopied
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                AppLocalizations.of(context).common_copied,
                                style: TextStyle(
                                    color: MyTheme.medium_grey, fontSize: 12),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: FlatButton(
                          minWidth: 75,
                          height: 26,
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side:
                                  BorderSide(color: Colors.black, width: 1.0)),
                          child: Text(
                            AppLocalizations.of(context)
                                .product_details_screen_share_options,
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            SocialShare.shareOptions(_productDetails.link);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: app_language_rtl.$
                          ? EdgeInsets.only(left: 8.0)
                          : EdgeInsets.only(right: 8.0),
                      child: FlatButton(
                        minWidth: 75,
                        height: 30,
                        color: Color.fromRGBO(253, 253, 253, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                                color: MyTheme.font_grey, width: 1.0)),
                        child: Text(
                          "CLOSE",
                          style: TextStyle(
                            color: MyTheme.font_grey,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                    ),
                  ],
                )
              ],
            );
          });
        });
  }

  onTapSellerChat() {
    return showDialog(
        context: context,
        builder: (_) => Directionality(
              textDirection:
                  app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
              child: AlertDialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 10),
                contentPadding: EdgeInsets.only(
                    top: 36.0, left: 36.0, right: 36.0, bottom: 2.0),
                content: Container(
                  width: 400,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                              AppLocalizations.of(context)
                                  .product_details_screen_seller_chat_title,
                              style: TextStyle(
                                  color: MyTheme.font_grey, fontSize: 12)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Container(
                            height: 40,
                            child: TextField(
                              controller: sellerChatTitleController,
                              autofocus: false,
                              decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)
                                      .product_details_screen_seller_chat_enter_title,
                                  hintStyle: TextStyle(
                                      fontSize: 12.0,
                                      color: MyTheme.textfield_grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: MyTheme.textfield_grey,
                                        width: 0.5),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(8.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: MyTheme.textfield_grey,
                                        width: 1.0),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(8.0),
                                    ),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8.0)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                              "${AppLocalizations.of(context).product_details_screen_seller_chat_messasge} *",
                              style: TextStyle(
                                  color: MyTheme.font_grey, fontSize: 12)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Container(
                            height: 55,
                            child: TextField(
                              controller: sellerChatMessageController,
                              autofocus: false,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)
                                      .product_details_screen_seller_chat_enter_messasge,
                                  hintStyle: TextStyle(
                                      fontSize: 12.0,
                                      color: MyTheme.textfield_grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: MyTheme.textfield_grey,
                                        width: 0.5),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(8.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: MyTheme.textfield_grey,
                                        width: 1.0),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(8.0),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      right: 16.0,
                                      left: 8.0,
                                      top: 16.0,
                                      bottom: 16.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: FlatButton(
                          minWidth: 75,
                          height: 30,
                          color: Color.fromRGBO(253, 253, 253, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                  color: MyTheme.light_grey, width: 1.0)),
                          child: Text(
                            AppLocalizations.of(context)
                                .common_close_in_all_capital,
                            style: TextStyle(
                              color: MyTheme.font_grey,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: FlatButton(
                          minWidth: 75,
                          height: 30,
                          color: MyTheme.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                  color: MyTheme.light_grey, width: 1.0)),
                          child: Text(
                            AppLocalizations.of(context)
                                .common_send_in_all_capital,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            onPressSendMessage();
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ));
  }

  onPressSendMessage() async {
    var title = sellerChatTitleController.text.toString();
    var message = sellerChatMessageController.text.toString();

    if (title == "" || message == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context)
              .product_details_screen_seller_chat_title_message_empty_warning,
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
      return;
    }

    var conversationCreateResponse = await ChatRepository()
        .getCreateConversationResponse(
            product_id: widget.id, title: title, message: message);

    if (conversationCreateResponse.result == false) {
      ToastComponent.showDialog(
          AppLocalizations.of(context)
              .product_details_screen_seller_chat_creation_unable_warning,
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
      return;
    }

    Navigator.of(context, rootNavigator: true).pop();
    sellerChatTitleController.clear();
    sellerChatMessageController.clear();
    setState(() {});

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Chat(
        conversation_id: conversationCreateResponse.conversation_id,
        messenger_name: conversationCreateResponse.shop_name,
        messenger_title: conversationCreateResponse.title,
        messenger_image: conversationCreateResponse.shop_logo,
      );
      ;
    })).then((value) {
      onPopped(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    SnackBar _addedToCartSnackbar = SnackBar(
      content: Text(
        AppLocalizations.of(context)
            .product_details_screen_snackbar_added_to_cart,
        style: TextStyle(color: MyTheme.font_grey),
      ),
      backgroundColor: MyTheme.soft_accent_color,
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: AppLocalizations.of(context)
            .product_details_screen_snackbar_show_cart,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Cart(has_bottomnav: false);
          })).then((value) {
            onPopped(value);
          });
        },
        textColor: MyTheme.primaryColor,
        disabledTextColor: Colors.grey,
      ),
    );

    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
         // bottomNavigationBar: buildBottomAppBar(context, _addedToCartSnackbar),
          backgroundColor: Colors.white,
          appBar: buildAppBar(statusBarHeight, context),
          body: RefreshIndicator(
            color: MyTheme.primaryColor,
            backgroundColor: Colors.white,
            onRefresh: _onPageRefresh,
            child: CustomScrollView(
              controller: _mainScrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16.0,
                        8.0,
                        16.0,
                        0.0,
                      ),
                      child: _productDetails != null
                          ? Text(
                              _productDetails.data[0].name,
                              style: LatoBold.copyWith(
                                  fontSize: 20,
                                  color: MyTheme.black,
                                  fontWeight: FontWeight.w800),
                              maxLines: 2,
                            )
                          : ShimmerHelper().buildBasicShimmer(
                              height: 30.0,
                            )),
                ])),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16.0,
                        25.0,
                        16.0,
                        0.0,
                      ),
                      child: //buildProductImagePart(),
                          buildProductImageSection(),
                    ),
                    Divider(
                      height: 24.0,
                    ),
                  ]),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16.0,
                      16.0,
                      16.0,
                     0.0,
                    ),
                    child: _productDetails != null
                        ? buildSellerRow(context)
                        : ShimmerHelper().buildBasicShimmer(
                            height: 50.0,
                          ),
                  ),
                ])),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16.0,
                      10.0,
                      16.0,
                      10.0,
                    ),
                    child: _productDetails != null
                        ? priceRangeRow(context)
                        : ShimmerHelper().buildBasicShimmer(
                            height: 50.0,
                          ),
                  ),
                ])),

                 SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16.0,
                      0.0,
                      16.0,
                      0.0,
                    ),
                    child: _productDetails != null
                        ? cartAndCheckoutRow(context)
                        : ShimmerHelper().buildBasicShimmer(
                            height: 30.0,
                          ),
                  ),
                ])),
  SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16.0,
                        0.0,
                        16.0,
                        0.0,
                      ),
                      child: Container(
                              height: 30.0,
                            ),
                    ),
                  ])),


              ],
            ),
          )),
    );
  }

  Row buildSellerRow(BuildContext context) {
    //print("sl:" + AppConfig.BASE_PATH + _productDetails.shop_logo);
    return Row(
      children: [
        Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: MyTheme.primary_Colour,
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                Icon(Icons.message, size: 16, color: MyTheme.white),
                InkWell(
                  onTap: () {
                    if (is_logged_in == false) {
                      ToastComponent.showDialog("You need to log in", context,
                          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                      return;
                    }

                    onTapSellerChat();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text("Message Seller",
                        style: LatoBold.copyWith(color: MyTheme.white)),
                  ),
                ),
              ],
            )),
        Spacer(),
        IconButton(
          icon: Image.asset(
            _isInWishList ? Images.heart : Images.heart_outline,
            color: Colors.redAccent,
          ),
          onPressed: () {
            onWishTap();
            setState(() {
              wishlistImage = Images.heart;
            });
          },
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
          icon: Icon(
            Icons.share,
            color: MyTheme.primary_Colour,
          ),
          onPressed: () {
            onPressShare(context);
          },
        )
      ],
    );
  }

  Row buildDiscountRow(BuildContext context) {
    //print("sl:" + AppConfig.BASE_PATH + _productDetails.shop_logo);
    return Row(
      children: [
        Expanded(
            child: Column(
          children: [
            Text(
              "Discount Remaining",
              style: LatoMedium.copyWith(
                color: Colors.grey,
              ),
            ),
            Center(
                child: Text(
              "00:00:00",
              style: LatoHeavy.copyWith(color: Colors.grey),
            )),
          ],
        )),
        // Spacer(),

        Row(
          children: [
            Container(
              width: 100,
              height: 70,
              decoration: BoxDecoration(
                  color: MyTheme.golden,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: MyTheme.dark_grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 3,
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _singlePriceString != null ? _singlePriceString : "0.0",
                    style:
                        LatoHeavy.copyWith(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "Individual",
                    style:
                        LatoHeavy.copyWith(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GroupBuyingProductDetails();
                }));
              },
              child: Container(
                width: 120,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    border: Border.all(color: Colors.redAccent, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: MyTheme.dark_grey.withOpacity(0.3),
                        blurRadius: 4,
                        spreadRadius: 3,
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "৳${_checkGroupBuying.minPrice}-৳${_checkGroupBuying.maxPrice}",
                      style: LatoHeavy.copyWith(
                        color: Colors.redAccent,
                      ),
                    ),
                    Text(
                      "Discount",
                      style: LatoHeavy.copyWith(
                          color: Colors.redAccent, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Row buildTotalPriceRow() {
    return Row(
      children: [
        Padding(
          padding: app_language_rtl.$
              ? EdgeInsets.only(left: 8.0)
              : EdgeInsets.only(right: 8.0),
          child: Container(
            width: 75,
            child: Text(
              AppLocalizations.of(context).product_details_screen_total_price,
              style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
            ),
          ),
        ),
        /* Text(
          _productDetails.data[0].currencySymbol + _totalPrice.toString(),
          style: TextStyle(
              color: MyTheme.accent_color,
              fontSize: 18.0,
              fontWeight: FontWeight.w600),
        )*/
      ],
    );
  }

  Column buildQuantityRow() {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).product_details_screen_quantity,
          style: LatoHeavy,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 26,
          width: 100,
          decoration: BoxDecoration(
              border:
                  Border.all(color: Color.fromRGBO(222, 222, 222, 1), width: 1),
              borderRadius: BorderRadius.circular(36.0),
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              buildQuantityDownButton(),
              Container(
                  width: 26,
                  child: Center(
                      child: Text(
                    _quantity.toString(),
                    style: TextStyle(fontSize: 18, color: MyTheme.dark_grey),
                  ))),
              buildQuantityUpButton()
            ],
          ),
        ),
        /*     Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Text(
            "(${_stock} ${AppLocalizations.of(context).product_details_screen_available})",
            style: TextStyle(
                color: Color.fromRGBO(152, 152, 153, 1), fontSize: 12),
          ),
        ),*/
      ],
    );
  }

  Padding buildVariantShimmers() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16.0,
        0.0,
        8.0,
        0.0,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: app_language_rtl.$
                      ? EdgeInsets.only(left: 8.0)
                      : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                ),
                Padding(
                  padding: app_language_rtl.$
                      ? EdgeInsets.only(left: 8.0)
                      : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                ),
                Padding(
                  padding: app_language_rtl.$
                      ? EdgeInsets.only(left: 8.0)
                      : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                ),
                Padding(
                  padding: app_language_rtl.$
                      ? EdgeInsets.only(left: 8.0)
                      : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: app_language_rtl.$
                      ? EdgeInsets.only(left: 8.0)
                      : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                ),
                Padding(
                  padding: app_language_rtl.$
                      ? EdgeInsets.only(left: 8.0)
                      : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                ),
                Padding(
                  padding: app_language_rtl.$
                      ? EdgeInsets.only(left: 8.0)
                      : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                ),
                Padding(
                  padding: app_language_rtl.$
                      ? EdgeInsets.only(left: 8.0)
                      : EdgeInsets.only(right: 8.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 30.0, width: 60),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildChoiceOptionList() {
    /* return Column(
      children: [
        Center(
          child: Padding(
            padding: app_language_rtl.$ ? EdgeInsets.only(left: 8.0,bottom: 15) : EdgeInsets.only(right: 8.0, bottom: 15),
            child: Container(
              width: 75,
              child: Text(
                "Size",
                style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
              ),
            ),
          ),
        ),
        Container(
          height: 220,
          width: 40,
          child: Scrollbar(
            controller: _colorScrollController,
            isAlwaysShown: false,
            child: ListView.builder(
              itemCount: _productDetails.data[0].choiceOptions.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: buildChoiceOpiton(_productDetails.data[0].choiceOptions, index),
                );
              },
            )
          ),
        )
      ],
    );
*/
    return Center(
      child: ListView.builder(
        itemCount: _productDetails.data[0].choiceOptions.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child:
                buildChoiceOpiton(_productDetails.data[0].choiceOptions, index),
          );
        },
      ),
    );
  }

  buildChoiceOpiton(choice_options, choice_options_index) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          height: 220,
          width: 50,
          child: ListView.builder(
            itemCount: choice_options[choice_options_index].options.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return buildChoiceItem(
                  choice_options[choice_options_index].options[index],
                  choice_options_index,
                  index);
              /*Padding(
              padding: const EdgeInsets.only(bottom: 1.0,left: 1),
              child:
            );*/
            },
          ),
          /*Scrollbar(
          controller: _variantScrollController,
          isAlwaysShown: false,

        ),*/
        )

        /* Row(
        children: [
          Padding(
            padding: app_language_rtl.$ ? EdgeInsets.only(left: 8.0) : EdgeInsets.only(right: 8.0),
            child: Container(
              width: 75,
              child: Text(
                choice_options[choice_options_index].title,
                style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
              ),
            ),
          ),

        ],
      ),*/
        );
  }

  buildChoiceItem(option, choice_options_index, index) {
    return Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: InkWell(
          onTap: () {
            _onVariantChange(choice_options_index, option);
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: _selectedChoices[choice_options_index] == option
                      ? MyTheme.primary_Colour
                      : Color.fromRGBO(224, 224, 225, 1),
                  width: 2),
            ),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Center(
                child: Text(
                  option,
                  style: TextStyle(
                      color: _selectedChoices[choice_options_index] == option
                          ? Colors.black
                          : Color.fromRGBO(224, 224, 225, 1),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ));
  }

  buildColorColumn() {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: app_language_rtl.$
                ? EdgeInsets.only(left: 8.0, bottom: 15)
                : EdgeInsets.only(right: 8.0, bottom: 15),
            child: Container(
              width: 75,
              child: Text(
                AppLocalizations.of(context).product_details_screen_color,
                style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
              ),
            ),
          ),
        ),
        Container(
          height: 170,
          width: 40,
          child: Scrollbar(
            controller: _colorScrollController,
            isAlwaysShown: false,
            child: ListView.builder(
              itemCount: _colorList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: buildColorItem(index),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  buildColorItem(index) {
    return Padding(
      padding: app_language_rtl.$
          ? EdgeInsets.only(left: 8.0)
          : EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          _onColorChange(index);
        },
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(
                  color: _selectedColorIndex == index
                      ? Colors.purple
                      : Colors.white,
                  width: 1),
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(222, 222, 222, 1), width: 1),
                  borderRadius: BorderRadius.circular(16.0),
                  color: ColorHelper.getColorFromColorCode(_colorList[index])),
              child: _selectedColorIndex == index
                  ? buildColorCheckerContainer()
                  : Container(),
            ),
          ),
        ),
      ),
    );
  }

  buildColorCheckerContainer() {
    return Padding(
        padding: const EdgeInsets.all(3),
        child: /*Icon(FontAwesome.check, color: Colors.white, size: 16),*/
            Image.asset(
          "assets/white_tick.png",
          width: 16,
          height: 16,
        ));
  }

  Row buildClubPointRow() {
    return Row(
      children: [
        Padding(
          padding: app_language_rtl.$
              ? EdgeInsets.only(left: 8.0)
              : EdgeInsets.only(right: 8.0),
          child: Container(
            width: 75,
            child: Text(
              AppLocalizations.of(context).product_details_screen_club_point,
              style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: MyTheme.golden, width: 1),
              borderRadius: BorderRadius.circular(16.0),
              color: Color.fromRGBO(253, 235, 212, 1)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
            child: Text(
              _productDetails.data[0].earnPoint.toString(),
              style: TextStyle(color: MyTheme.golden, fontSize: 12.0),
            ),
          ),
        )
      ],
    );
  }

  Column buildMainPriceRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context).product_details_screen_total_price,
            style: LatoHeavy),
        SizedBox(
          height: 10,
        ),
        /* _productDetails.data[0].hasDiscount
            ? Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text(_productDetails.data[0].strokedPrice,
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Color.fromRGBO(224, 224, 225, 1),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600)),
              )
            : Container(),*/
        Text(_singlePriceString, style: LatoHeavy)
      ],
    );
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: MyTheme.primary_Colour,
            size: 25,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Container(
        height: kToolbarHeight +
            statusBarHeight -
            (MediaQuery.of(context).viewPadding.top > 40 ? 32.0 : 16.0),
        //MediaQuery.of(context).viewPadding.top is the statusbar height, with a notch phone it results almost 50, without a notch it shows 24.0.For safety we have checked if its greater than thirty
        child: Container(
            width: 300,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 22.0),
                child: Text(
                  "Product Details",
                  style: LatoHeavy.copyWith(
                      fontSize: 20,
                      color: MyTheme.primary_Colour,
                      fontWeight: FontWeight.w900),
                ),
              ),
            )),
      ),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: IconButton(
            icon: Icon(Icons.share_outlined, color: MyTheme.primary_Colour),
            onPressed: () {
              onPressShare(context);
            },
          ),
        ),
      ],
    );
  }

  buildBottomAppBar(BuildContext context, _addedToCartSnackbar) {
    return Builder(builder: (BuildContext context) {
      return BottomAppBar(
        child: Container(
          color: Colors.transparent,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                minWidth: MediaQuery.of(context).size.width / 2 - .5,
                height: 50,
                color: MyTheme.primary_Colour,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Text(
                  AppLocalizations.of(context)
                      .product_details_screen_button_add_to_cart,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  onPressAddToCart(context: context, snackbar:  _addedToCartSnackbar);
                },
              ),
              SizedBox(
                width: 1,
              ),
              FlatButton(
                minWidth: MediaQuery.of(context).size.width / 2 - .5,
                height: 50,
                color: MyTheme.golden,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Text(
                  AppLocalizations.of(context)
                      .product_details_screen_button_buy_now,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  onPressBuyNow(context);
                },
              )
            ],
          ),
        ),
      );
    });
  }

  buildRatingAndPriceRow() {
    return Row(
      children: [
        Text(
          _productDetails.data[0].mainPrice,
          style: LatoHeavy.copyWith(
              color: MyTheme.black, fontWeight: FontWeight.w800),
        ),
        Spacer(),
        RatingBar(
          itemSize: 14.0,
          ignoreGestures: true,
          initialRating:
              double.parse(_productDetails.data[0].rating.toString()),
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          ratingWidget: RatingWidget(
            full: Icon(FontAwesome.star, color: MyTheme.primary_Colour),
            empty: Icon(FontAwesome.star,
                color: MyTheme.dark_grey.withOpacity(0.7)),
          ),
          itemPadding: EdgeInsets.only(right: 1.0),
          onRatingUpdate: (rating) {
            //print(rating);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            "(" + _productDetails.data[0].ratingCount.toString() + ")",
            style: TextStyle(color: MyTheme.dark_grey, fontSize: 14),
          ),
        ),
      ],
    );
  }

  discountBuyingTimeRow() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: MyTheme.primary_Colour,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          children: [
            Text(
              "Discount Buying\nTime Remaining",
              style: LatoMedium.copyWith(
                  color: MyTheme.white, fontWeight: FontWeight.w700),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, top: 8, right: 4),
              child: Text(
                "01.02.50",
                style: LatoMedium.copyWith(
                    color: MyTheme.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  timeIconRow() {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          color: MyTheme.primary_Colour,
          shape: BoxShape.circle,
          border: Border.all(width: 1.5, color: MyTheme.white)),
      child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Image.asset(
            Images.profile_Home,
            height: 30,
            width: 30,
          )),
    );
  }

  buildBrandRow() {
    return _productDetails.data[0].brand.id > 0
        ? InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BrandProducts(
                  id: _productDetails.data[0].brand.id,
                  brand_name: _productDetails.data[0].brand.name,
                );
              }));
            },
            child: Row(
              children: [
                Padding(
                  padding: app_language_rtl.$
                      ? EdgeInsets.only(left: 8.0)
                      : EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: 75,
                    child: Text(
                      AppLocalizations.of(context).product_details_screen_brand,
                      style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    _productDetails.data[0].brand.name,
                    style: TextStyle(
                        color: Color.fromRGBO(152, 152, 153, 1), fontSize: 16),
                  ),
                ),
                Spacer(),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: Color.fromRGBO(112, 112, 112, .3), width: 1),
                    //shape: BoxShape.rectangle,
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image: AppConfig.BASE_PATH +
                            _productDetails.data[0].brand.logo,
                        fit: BoxFit.contain,
                      )),
                ),
              ],
            ),
          )
        : Container();
  }

  ExpandableNotifier buildExpandableDescription() {
    return ExpandableNotifier(
        child: ScrollOnExpand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /*Expandable(
            collapsed: Container(
                height: 50, child: Html(data: _productDetails.data[0].description)),
            expanded: Container(child: Html(data: _productDetails.data[0].description)),
          ),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Builder(
                builder: (context) {
                  var controller = ExpandableController.of(context);
                  return FlatButton(
                    child: Text(
                      !controller.expanded
                          ? AppLocalizations.of(context).common_view_more
                          : AppLocalizations.of(context).common_show_less,
                      style: TextStyle(color: MyTheme.font_grey, fontSize: 11),
                    ),
                    onPressed: () {
                      controller.toggle();
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ));
  }

  buildTopSellingProductList() {
    if (_topProductInit == false && _topProducts.length == 0) {
      return Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                height: 75.0,
              )),
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                height: 75.0,
              )),
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                height: 75.0,
              )),
        ],
      );
    } else if (_topProducts.length > 0) {
      return SingleChildScrollView(
        child: ListView.builder(
          itemCount: _topProducts.length,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: ListProductCard(
                id: _topProducts[index].id,
                image: _topProducts[index].thumbnailImage,
                name: _topProducts[index].name,
                main_price: _topProducts[index].basePrice,
                rating: _topProducts[index].rating,
              ),
            );
          },
        ),
      );
    } else {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                  AppLocalizations.of(context)
                      .product_details_screen_no_top_selling_product,
                  style: TextStyle(color: MyTheme.font_grey))));
    }
  }

  buildProductsMayLikeList() {
    if (_relatedProductInit == false && _relatedProducts.length == 0) {
      return Row(
        children: [
          Padding(
              padding: app_language_rtl.$
                  ? EdgeInsets.only(left: 8.0)
                  : EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
          Padding(
              padding: app_language_rtl.$
                  ? EdgeInsets.only(left: 8.0)
                  : EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
          Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
        ],
      );
    } else if (_relatedProducts.length > 0) {
      return SingleChildScrollView(
        child: SizedBox(
          height: 175,
          child: ListView.builder(
            itemCount: _relatedProducts.length,
            scrollDirection: Axis.horizontal,
            itemExtent: 120,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: MiniProductCard(
                  id: _relatedProducts[index].id,
                  image: _relatedProducts[index].thumbnailImage,
                  name: _relatedProducts[index].name,
                  main_price: _relatedProducts[index].basePrice,
                  rating: _relatedProducts[index].rating,
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context)
                .product_details_screen_no_related_product,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    }
  }

  buildQuantityUpButton() => SizedBox(
        width: 26,
        child: IconButton(
            icon: Icon(FontAwesome.plus, size: 12, color: MyTheme.dark_grey),
            onPressed: () {
              if (_quantity < _stock) {
                _quantity++;
                setState(() {});
                calculateTotalPrice();
              }
            }),
      );

  buildQuantityDownButton() => SizedBox(
      width: 26,
      child: IconButton(
          icon: Icon(FontAwesome.minus, size: 12, color: MyTheme.dark_grey),
          onPressed: () {
            if (_quantity > 1) {
              _quantity--;
              setState(() {});
              calculateTotalPrice();
            }
          }));

  openPhotoDialog(BuildContext context, path) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
                child: Stack(
              children: [
                PhotoView(
                  enableRotation: true,
                  heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
                  imageProvider: NetworkImage(path),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: ShapeDecoration(
                      color: MyTheme.medium_grey_50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                        ),
                      ),
                    ),
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: Icon(Icons.clear, color: MyTheme.white),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    ),
                  ),
                ),
              ],
            )),
          );
        },
      );

  buildProductImagePart() {
    if (_productImageList.length == 0) {
      return Center(
        child: Text("No Image Found"),
      );
    } else {
      return Container(
        height: 250,
        width: double.infinity,
        color: Colors.green,
      );
    }
  }

  buildProductImageSection() {
    if (_productImageList.length == 0) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 40,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ShimmerHelper()
                      .buildBasicShimmer(height: 40.0, width: 40.0),
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                height: 190.0,
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
          width: double.infinity,
          height: 240,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 50,
                    child: _productDetails != null
                        ? (_colorList.length > 0
                            ? buildColorColumn()
                            : Container())
                        : ShimmerHelper().buildBasicShimmer(
                            height: 30.0,
                          ),
                  ),
                ),
                //SizedBox(width: 10,),

                Container(
                    height: 240,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.5),
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Stack(
                      children: [
                        Positioned(
                          child: Image.asset(
                            Images.product_background_shape,
                            height: 100,
                            width: 100,
                          ),
                          left: 50,
                          right: 50,
                          top: 40,
                          bottom: 60,
                        ),
                        Positioned(
                          child: Container(
                            color: Colors.white.withOpacity(.5),
                          ),
                          left: 50,
                          right: 50,
                          top: 40,
                          bottom: 60,
                        ),
                        Positioned(
                          child: InkWell(
                            onTap: () {
                              openPhotoDialog(
                                  context,
                                  AppConfig.BASE_PATH +
                                      _productImageList[_currentImage]);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/placeholder_rectangle.png',
                                    image: AppConfig.BASE_PATH +
                                        _productImageList[_currentImage],
                                    fit: BoxFit.scaleDown,
                                  ),
                                )),
                          ),
                          left: 10,
                          right: 10,
                          top: 10,
                          bottom: 70,
                        ),
                        Positioned(
                          child: Padding(
                            padding: EdgeInsets.only(left: 0, right: 0),
                            child: buildRatingAndPriceRow(),
                          ),
                          left: 5,
                          right: 5,
                          bottom: 50,
                        ),
                        Positioned(
                          child: Padding(
                            padding: EdgeInsets.only(left: 0, right: 0),
                            child: discountBuyingTimeRow(),
                          ),
                          left: 0,
                          right: 0,
                          bottom: 0,
                        ),
                        Positioned(
                          child: Padding(
                            padding: EdgeInsets.only(left: 0, right: 0),
                            child: timeIconRow(),
                          ),
                          right: 0,
                          bottom: 30,
                        ),
                      ],
                    )),

                Center(
                  child: SizedBox(
                    height: 200,
                    width: 30,
                    child: _productDetails != null
                        ? buildChoiceOptionList()
                        : buildVariantShimmers(),
                  ),
                )
              ],
            ),
          ));
    }
  }

  Container buildDescription() {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: MyTheme.grey_153,
            spreadRadius: .5,
            blurRadius: .5,
            offset: Offset(.5, .5), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              "Description",
              style: LatoBold,
            ),
          ),
          Icon(
            Icons.fifteen_mp_outlined,
            color: MyTheme.primary_Colour,
          )
        ],
      ),
    );
  }

  priceRangeRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            height: 35,
            decoration: BoxDecoration(
                color: MyTheme.red_div,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Center(
              child: Text(
                "Invite Friends And Family",
                style: LatoHeavy.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                        color: Colors.black45.withOpacity(0.3),
                        offset: Offset(3, 3),
                        blurRadius: 5,
                      ),
                    ],
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
          Table(
            border: TableBorder.all(width: 1, color: MyTheme.primary_Colour),
            columnWidths: {
              0: FlexColumnWidth(6),
              1: FlexColumnWidth(4),
            },
            children: [
              TableRow(children: [
                /*Container(
                  width: 20,
                  padding: EdgeInsets.all(8),
                  child: Center(
                      child: Text(
                    "#",
                    style: LatoBold.copyWith(
                      color: MyTheme.black,
                    ),
                  )),
                ),*/
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Center(
                        child: Text(
                      "Group Sell",
                      style: LatoHeavy.copyWith(
                        color: MyTheme.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 18

                      ),
                    )),
                  ),
                ),
                Container(
                  width: 70,
                  padding: EdgeInsets.all(8),
                  child: Center(
                      child: Text(
                    "Price",
                    style: LatoHeavy.copyWith(
                      color: MyTheme.black,
                      fontWeight: FontWeight.w900,
                        fontSize: 18
                    ),
                  )),
                ),
              ]),
              for (var groupProduct in _groupProductDetails.data)
                TableRow(children: [
                  /*Container(
                    width: 20,
                    padding: EdgeInsets.all(6),
                    child: Center(
                        child: Container(
                          height: 25,
                          width: 25,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MyTheme.red_div,
                          ),

                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                          ),
                        )),
                  ),*/
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Center(
                          child: Text(
                        groupProduct.quantityRange,
                        style: LatoBold.copyWith(
                          color: MyTheme.black,
                        ),
                      )),
                    ),
                  ),
                  Container(
                    width: 70,
                    padding: EdgeInsets.all(8),
                    child: Center(
                        child: Text(
                      groupProduct.price,
                      style: LatoBold.copyWith(
                        color: MyTheme.black,
                      ),
                    )),
                  ),
                ]),
            ],
          )
        ],
      ),
    );
  }

  cartAndCheckoutRow(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                height: 30,
              ),
              InkWell(
                onTap: (){

                  onPressAddToCart(context: context);
                },
                child: Container(
                    height: 40,
                    width: 150,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: MyTheme.dark_grey.withOpacity(0.3),
                              spreadRadius: 1.5,
                              blurRadius: 3
                          )
                        ]
                    ),
                    child: Center(child: Text("Add to cart", style: LatoHeavy.copyWith(color: MyTheme.white, fontSize: 18),))
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 30,
                child: Text("Require ${_groupProductDetails.advancePayment}% amount to join"),
              ),
              InkWell(
                onTap: (){

                },
                child: Container(
                    height: 40,
                    width: 150,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: MyTheme.dark_grey.withOpacity(0.3),
                              spreadRadius: 1.5,
                              blurRadius: 3
                          )
                        ]
                    ),
                    child: Center(child: Text("Confirm", style: LatoHeavy.copyWith(color: MyTheme.white, fontSize: 18),))
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }
}
