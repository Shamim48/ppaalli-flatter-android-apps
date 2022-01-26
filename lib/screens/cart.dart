import 'package:active_ecommerce_flutter/data_model/cart_response.dart';
import 'package:active_ecommerce_flutter/data_model/product_mini_response.dart';
import 'package:active_ecommerce_flutter/screens/shipping_info.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/ui_sections/drawer.dart';
import 'package:flutter/widgets.dart';
import 'package:active_ecommerce_flutter/repositories/cart_repository.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Cart extends StatefulWidget {
  Cart({Key key, this.has_bottomnav}) : super(key: key);
  final bool has_bottomnav;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _mainScrollController = ScrollController();
  var _shopList = [];
  bool _isInitial = true;
  var _cartTotal = 0.00;
  var _cartTotalString = ". . .";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /*print("user data");
    print(is_logged_in.$);
    print(access_token.value);
    print(user_id.$);
    print(user_name.$);*/
    fetchData();

    if (is_logged_in.$ == true) {
      fetchData();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _mainScrollController.dispose();
  }

  fetchData() async {
  var cartResponseList =
        await CartRepository().getCartResponseList(user_id.$);

    if (cartResponseList != null && cartResponseList.length > 0) {
      _shopList = cartResponseList;
    }
 // _shopList=cartList;
    _isInitial = false;
    getSetCartTotal();
    setState(() {

    });
  }

  getSetCartTotal() {
    _cartTotal = 0.00;
    if (_shopList.length > 0) {
      _shopList.forEach((shop) {
        if (shop.cart_items.length > 0) {
          shop.cart_items.forEach((cart_item) {
            _cartTotal +=
                (cart_item.price + cart_item.tax) * cart_item.quantity;
            _cartTotalString = "${cart_item.currency_symbol}${_cartTotal}";
          });
        }
      });
    }

    setState(() {});
  }

  partialTotalString(index) {
    var partialTotal = 0.00;
    var partialTotalString = "";
    if (_shopList[index].cart_items.length > 0) {
      _shopList[index].cart_items.forEach((cart_item) {
        partialTotal += (cart_item.price + cart_item.tax) * cart_item.quantity;
        partialTotalString = "${cart_item.currency_symbol}${partialTotal}";
      });
    }
    return partialTotalString;
  }

  onQuantityIncrease(seller_index, item_index) {
    if (_shopList[seller_index].cart_items[item_index].quantity <
        _shopList[seller_index].cart_items[item_index].upper_limit) {
      _shopList[seller_index].cart_items[item_index].quantity++;
      getSetCartTotal();
      setState(() {});
    } else {
      ToastComponent.showDialog(
          "${AppLocalizations.of(context).cart_screen_cannot_order_more_than} ${_shopList[seller_index].cart_items[item_index].upper_limit} ${AppLocalizations.of(context).cart_screen_items_of_this}",
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
    }
  }

  onQuantityDecrease(seller_index, item_index) {
    if (_shopList[seller_index].cart_items[item_index].quantity >
        _shopList[seller_index].cart_items[item_index].lower_limit) {
      _shopList[seller_index].cart_items[item_index].quantity--;
      getSetCartTotal();
      setState(() {});
    } else {
      ToastComponent.showDialog(
          "${AppLocalizations.of(context).cart_screen_cannot_order_more_than} ${_shopList[seller_index].cart_items[item_index].lower_limit} ${AppLocalizations.of(context).cart_screen_items_of_this}",
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
    }
  }

  onPressDelete(cart_id) {
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
                  style: LatoBold.copyWith(color: MyTheme.font_grey, fontSize: 14),
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
                    confirmDelete(cart_id);
                  },
                ),
              ],
            ));
  }

  confirmDelete(cart_id) async {
    var cartDeleteResponse =
        await CartRepository().getCartDeleteResponse(cart_id);

    if (cartDeleteResponse.result == true) {
      ToastComponent.showDialog(cartDeleteResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

      reset();
      fetchData();
    } else {
      ToastComponent.showDialog(cartDeleteResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    }
  }

  onPressUpdate() {
    process(mode: "update");
  }

  onPressProceedToShipping() {
    process(mode: "proceed_to_shipping");
  }

  process({mode}) async {
    var cart_ids = [];
    var cart_quantities = [];
    if (_shopList.length > 0) {
      _shopList.forEach((shop) {
        if (shop.cart_items.length > 0) {
          shop.cart_items.forEach((cart_item) {
            cart_ids.add(cart_item.id);
            cart_quantities.add(cart_item.quantity);
          });
        }
      });
    }

    if (cart_ids.length == 0) {
      ToastComponent.showDialog(AppLocalizations.of(context).cart_screen_cart_empty, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }

    var cart_ids_string = cart_ids.join(',').toString();
    var cart_quantities_string = cart_quantities.join(',').toString();

    print(cart_ids_string);
    print(cart_quantities_string);

    var cartProcessResponse = await CartRepository()
        .getCartProcessResponse(cart_ids_string, cart_quantities_string);

    if (cartProcessResponse.result == false) {
      ToastComponent.showDialog(cartProcessResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      ToastComponent.showDialog(cartProcessResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

      if (mode == "update") {
        reset();
        fetchData();
      } else if (mode == "proceed_to_shipping") {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ShippingInfo(

          );
        })).then((value) {
          onPopped(value);
        });
      }
    }
  }

  reset() {
    _shopList = [];
    _isInitial = true;
    _cartTotal = 0.00;
    _cartTotalString = ". . .";

    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fetchData();
  }

  onPopped(value) async {
    reset();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.has_bottomnav);
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          key: _scaffoldKey,
          drawer: MainDrawer(),
          backgroundColor: Colors.white,
          appBar: buildAppBar(context),
          body: Stack(
            children: [
              RefreshIndicator(
                color: MyTheme.primaryColor,
                backgroundColor: Colors.white,
                onRefresh: _onRefresh,
                displacement: 0,
                child: CustomScrollView(
                  controller: _mainScrollController,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildCartSellerList(),
                        ),
                        Container(
                          height: widget.has_bottomnav ? 140 : 10,
                        )
                      ]),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: buildBottomContainer(),
              )
            ],
          )),
    );
  }

  Container buildBottomContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        /*border: Border(
                  top: BorderSide(color: MyTheme.light_grey,width: 1.0),
                )*/
      ),

      height: widget.has_bottomnav ? 230 : 230,
      //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: MyTheme.white,
              boxShadow:[ BoxShadow(
                color: MyTheme.dark_grey.withOpacity(0.3),
                spreadRadius: 1.5,
                blurRadius: 3
              )]
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                          child: Text(
                            "Sub Total",
                            style:
                            LatoMedium,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("$_cartTotalString",
                              style: LatoMedium),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                          child: Text(
                            "Shipping Charge",
                            style:
                            LatoMedium,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("$_cartTotalString",
                              style: LatoMedium),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                          child: Text(
                            AppLocalizations.of(context).cart_screen_total_amount,
                            style:
                            LatoHeavy,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("$_cartTotalString",
                              style: LatoHeavy),
                        ),
                      ],
                    ),
                  ],
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(25)),
                    child: FlatButton(
                      minWidth: MediaQuery.of(context).size.width,
                      //height: 50,

                      child: Text(
                        "Continue",
                        style: LatoHeavy.copyWith(color: MyTheme.white),
                      ),
                      onPressed: () {
                        onPressUpdate();
                      },
                    ),
                  ),
                ),
                SizedBox(width: 60,),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(25),
                    ),
                    child: FlatButton(
                      minWidth: MediaQuery.of(context).size.width,
                      //height: 50,
                      child: Text(
                        "Checkout",
                        style: LatoHeavy.copyWith(color: MyTheme.white),
                      ),
                      onPressed: () {
                        onPressProceedToShipping();
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: widget.has_bottomnav ? 50 : 10 ,)
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
backgroundColor: Colors.white,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState.openDrawer();
        },
        child: Builder(
          builder: (context) => Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 0.0),
            child: Container(
              child: Image.asset(
                'assets/hamburger.png',
                height: 16,
                color: MyTheme.dark_grey,
              ),
            ),
          ),
        ),
      ),
      title: Text(
        AppLocalizations.of(context).cart_screen_shopping_cart,
        style: LatoHeavy.copyWith(color: MyTheme.primary_Colour, fontSize: 22),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }



  buildCartSellerList() {
    if (is_logged_in.$ == false) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                AppLocalizations.of(context).cart_screen_please_log_in,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else if (_isInitial && _shopList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildListShimmer(item_count: 5, item_height: 100.0));
    } else if (_shopList.length > 0) {
      return SingleChildScrollView(
        child: ListView.builder(
          itemCount: _shopList.length,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return buildCartSellerItemList(index);
          },
        ),
      );
    } else if (!_isInitial && _shopList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                AppLocalizations.of(context).cart_screen_cart_empty,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    }
  }

  SingleChildScrollView buildCartSellerItemList(seller_index) {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: _shopList[seller_index].cart_items.length,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: buildCartSellerItemCard(seller_index, index),
          );
        },
      ),
    );
  }

  buildCartSellerItemCard(seller_index, item_index) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: IconButton(
            onPressed: () {
              onPressDelete(_shopList[seller_index]
                  .cart_items[item_index]
                  .id);
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
              side: BorderSide(color: MyTheme.dark_grey.withOpacity(.2), width: 1.5),
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 3.0,
            shadowColor: MyTheme.dark_grey.withOpacity(.4),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[

              /*SizedBox(
                height: 28,
                width: 20,
                child:
              ),*/
              Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(left: 10, right: 5),
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(10),
                    color: MyTheme.white,
                    boxShadow: [
                      BoxShadow(
                        color: MyTheme.dark_grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, .5)

                      )
                    ]
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image: AppConfig.BASE_PATH +
                            _shopList[seller_index]
                                .cart_items[item_index]
                                .product_thumbnail_image,
                        fit: BoxFit.fitWidth,
                      ))),

              Expanded(child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _shopList[seller_index]
                                .cart_items[item_index]
                                .product_name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: LatoHeavy,
                          ),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 8.0),
                                child: Text("Price:  ", style: LatoMedium,),),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  _shopList[seller_index]
                                      .cart_items[item_index]
                                      .currency_symbol +
                                      (_shopList[seller_index]
                                          .cart_items[item_index]
                                          .price *
                                          _shopList[seller_index]
                                              .cart_items[item_index]
                                              .quantity)
                                          .toString(),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: LatoMedium,
                                ),
                              ),

                            ],
                          ),
                          /*Row(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 8.0),
                                child: Text("Color:  ", style: LatoMedium,),),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("Black",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: LatoMedium,
                                ),
                              ),

                            ],
                          ),*/
                         /* Row(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 8.0),
                                child: Text("Advance:", style: LatoMedium,),),


                            ],
                          ),*/

                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text("\$20(10%)"+" Advanced",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: LatoMedium,
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),),

              //Spacer(),

              Container(
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

            ]),
          ),
        ),
      ],
    );
  }
}
