import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/repositories/wishlist_repository.dart';
import 'package:active_ecommerce_flutter/screens/product_details.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:toast/toast.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  ScrollController _mainScrollController = ScrollController();

  //init
  bool _wishlistInit = true;
  List<dynamic> _wishlistItems = [];

  @override
  void initState() {
    if (is_logged_in.$ == true) {
      fetchWishlistItems();
    }

    super.initState();
  }

  @override
  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  fetchWishlistItems() async {
    var wishlistResponse = await WishListRepository().getUserWishlist();
    _wishlistItems.addAll(wishlistResponse.wishlist_items);
    _wishlistInit = false;
    setState(() {});
  }

  reset() {
    _wishlistInit = true;
    _wishlistItems.clear();
    setState(() {});
  }

  Future<void> _onPageRefresh() async {
    reset();
    fetchWishlistItems();
  }

  Future<void> _onPressRemove(index) async {
    var wishlist_id = _wishlistItems[index].id;
    _wishlistItems.removeAt(index);
    setState(() {});

    var wishlistDeleteResponse =
        await WishListRepository().delete(wishlist_id: wishlist_id);

    if (wishlistDeleteResponse.result == true) {
      ToastComponent.showDialog(wishlistDeleteResponse.message, context,
          gravity: Toast.TOP, duration: Toast.LENGTH_SHORT);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(context),
          body: RefreshIndicator(
            color: MyTheme.primaryColor,
            backgroundColor: Colors.white,
            onRefresh: _onPageRefresh,
            child: CustomScrollView(
              controller: _mainScrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  buildWishlist(),
                ])),
              ],
            ),
          )),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
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
      title: Text(
        "Wishlist",
        style: LatoHeavy.copyWith(
            fontSize: 20,
            color: MyTheme.primaryColor,
            fontWeight: FontWeight.w900),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  buildWishlist() {
    if (is_logged_in.$ == false) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context).wishlist_screen_login_warning,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else if (_wishlistInit == true && _wishlistItems.length == 0) {
      return SingleChildScrollView(
        child: ShimmerHelper().buildListShimmer(item_count: 10),
      );
    } else if (_wishlistItems.length > 0) {
      return SingleChildScrollView(
        child: ListView.builder(
          itemCount: _wishlistItems.length,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: buildWishListItem(index),
            );
          },
        ),
      );
    } else {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                  AppLocalizations.of(context).common_no_item_is_available,
                  style: TextStyle(color: MyTheme.font_grey))));
    }
  }

  buildWishListItem(index) {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProductDetails(
              id: _wishlistItems[index].product.id,
            );
          }));
        },
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: IconButton(
                iconSize: 28,
                onPressed: () {
                  onPressDelete(index);
                },
                icon: Icon(
                  Icons.delete_forever_outlined,
                  color: MyTheme.primary_Colour,
                  size: 28,
                ),
              ),
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: MyTheme.dark_grey.withOpacity(.1), width: 1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4.0,
                shadowColor: MyTheme.dark_grey,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[


                      /*SizedBox(
                height: 28,
                width: 20,
                child:
              ),*/
                      Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyTheme.white,
                              boxShadow: [
                                BoxShadow(
                                    color: MyTheme.dark_grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                )

                              ]),
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/placeholder.png',
                                image: AppConfig.BASE_PATH +
                                    _wishlistItems[index].product.thumbnail_image,
                                fit: BoxFit.fitWidth,
                              ))),

                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _wishlistItems[index].product.name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: LatoHeavy.copyWith(color: MyTheme.black, fontWeight: FontWeight.w900, fontSize: 18),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        _wishlistItems[index]
                                            .product
                                            .base_price
                                            .toString(),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: LatoBold.copyWith(fontSize: 18, fontWeight: FontWeight.w900, color: MyTheme.primary_Colour),
                                      ),
                                    ),


                                    Padding(
                                      padding:
                                      EdgeInsets.only(left: 5),
                                      child: RatingBarIndicator(
                                        rating: _wishlistItems[index].product.rating.toDouble(),
                                        itemBuilder:
                                            (context, index) => Icon(
                                          Icons.star,
                                          color: MyTheme.white,
                                        ),
                                        itemCount: 5,
                                        itemSize: 19.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Spacer(),

                      /*Container(
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: MyTheme.white,
    boxShadow: [
    BoxShadow(
    color: MyTheme.dark_grey.withOpacity(0.3),
    spreadRadius: 1,
    blurRadius: 1,
    //offset: Offset(1,0)
    )
    ]
    ),
    child:         Padding(
    padding: const EdgeInsets.all(6.0),
    child: Column(
    children: [
    SizedBox(
    width: 28,
    height: 28,
    child: FlatButton(
    padding: EdgeInsets.all(0),
    child: Icon(
    Icons.add,
    color: MyTheme.primary_Colour,
    size: 18,
    ),
    shape: CircleBorder(
    side: new BorderSide(color: MyTheme.light_grey, width: 1.0),
    ),
    color: Colors.white,
    onPressed: () {
    onQuantityIncrease(seller_index, item_index);
    },
    ),
    ),
    Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
    child: Text(
    _shopList[seller_index]
              .cart_items[item_index]
              .quantity
              .toString(),
    style: TextStyle(color: MyTheme.primary_Colour, fontSize: 16),
    ),
    ),
    SizedBox(
    width: 28,
    height: 28,
    child: FlatButton(
    padding: EdgeInsets.all(0),
    child: Icon(
    Icons.remove,
    color: MyTheme.primary_Colour,
    size: 18,
    ),
    height: 30,
    shape: CircleBorder(
    side: new BorderSide(color: MyTheme.light_grey, width: 1.0),
    ),
    color: Colors.white,
    onPressed: () {
    onQuantityDecrease(seller_index, item_index);
    },
    ),
    )
    ],
    ),
    ),
    ),
*/
                    ]),
              ),
            ),
          ],
        )

/*      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: new BorderSide(color: MyTheme.light_grey, width: 1.0),
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0.0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(16), right: Radius.zero),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/placeholder.png',
                              image: AppConfig.BASE_PATH +
                                  _wishlistItems[index].product.thumbnail_image,
                              fit: BoxFit.cover,
                            ))),
                    Container(
                      width: 240,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 3, 8, 0),
                            child: Text(
                              _wishlistItems[index].product.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: LatoBold.copyWith(
                                  color: MyTheme.font_grey,
                                  fontSize: 18,
                                  height: 1.6,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 3, 8, 5),
                            child: Text(
                              _wishlistItems[index].product.base_price,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: LatoBold.copyWith(
                                  color: MyTheme.primary_Colour,
                                  fontSize: 16,
                                  height: 1.6,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),

                          Padding(
                              padding:
                              EdgeInsets.only(left: 5),
                              child: RatingBarIndicator(
                                rating: _wishlistItems[index].product.rating.toDouble(),
                                itemBuilder:
                                    (context, index) => Icon(
                                  Icons.star,
                                  color: MyTheme.white,
                                ),
                                itemCount: 5,
                                itemSize: 15.0,
                                direction: Axis.horizontal,
                              ),
                            ),

                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          app_language_rtl.$
              ? Positioned(
                  bottom: 8,
                  left: 12,
                  child: IconButton(
                    icon: Icon(Icons.delete_forever_outlined,
                        color: MyTheme.medium_grey),
                    onPressed: () {
                      _onPressRemove(index);
                    },
                  ),
                )
              : Positioned(
                  bottom: 8,
                  top: 8,
                  right: 12,
                  child: IconButton(
                    icon: Icon(Icons.delete_forever_outlined,
                        color: MyTheme.primary_Colour),
                    onPressed: () {
                      onPressDelete(index);
                    },
                  ),
                ),
        ],
      ),*/
        );
  }

  onPressDelete(index) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.only(
                  top: 16.0, left: 2.0, right: 2.0, bottom: 2.0),
              content: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  AppLocalizations.of(context).cart_screen_sure_remove_item,
                  maxLines: 3,
                  style:
                      LatoBold.copyWith(color: MyTheme.font_grey, fontSize: 14),
                ),
              ),
              actions: [
                FlatButton(
                  color: Colors.deepOrangeAccent,
                  child: Text(
                    AppLocalizations.of(context).cart_screen_cancel,
                    style: LatoMedium.copyWith(color: MyTheme.white),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
                FlatButton(
                  color: MyTheme.primary_Colour,
                  child: Text(
                    AppLocalizations.of(context).cart_screen_confirm,
                    style: LatoMedium.copyWith(color: MyTheme.white),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    _onPressRemove(index);
                  },
                ),
              ],
            ));
  }
}
