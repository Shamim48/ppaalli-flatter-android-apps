import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/data_model/group_buying/group_order_details_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/repositories/chat_repository.dart';
import 'package:active_ecommerce_flutter/repositories/group_buying_repository.dart';
import 'package:active_ecommerce_flutter/repositories/order_repository.dart';
import 'package:active_ecommerce_flutter/screens/chat.dart';
import 'package:active_ecommerce_flutter/ui_elements/AppBar_Common.dart';
import 'package:active_ecommerce_flutter/utill/images.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';

import '../app_config.dart';
import '../my_theme.dart';

class GroupOrderDetails extends StatefulWidget {
  int id;
   GroupOrderDetails({Key key, this.id}) : super(key: key);

  @override
  _GroupOrderDetailsState createState() => _GroupOrderDetailsState();
}

class _GroupOrderDetailsState extends State<GroupOrderDetails> {
  GroupOrderDetailsResponse _groupOrderDetails=null;

  ScrollController _mainScrollController = ScrollController();
  TextEditingController sellerChatTitleController = TextEditingController();
  TextEditingController sellerChatMessageController = TextEditingController();


  @override
  void initState() {
    fetchAll();

    super.initState();
  }

  @override
  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }
  Future<void> _onPageRefresh() async {
    reset();
    fetchAll();
  }

  reset() {

    setState(() {});
  }

  onPopped(value) async {
    reset();
    fetchAll();
  }
  fetchAll() {
    print("Order id : ${widget.id}");
    fetchGroupProductDetails();

  }

  fetchGroupProductDetails() async{
    var productDetailsRes= await OrderRepository().getGroupOrderDetails( widget.id);
    _groupOrderDetails=productDetailsRes;
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        // bottomNavigationBar: buildBottomAppBar(context, _addedToCartSnackbar),
          backgroundColor: Colors.white,
          appBar: buildAppBarWithBackAndTitle( context, "Group Order Details"),
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
                          child: _groupOrderDetails != null
                              ? Text(
                            _groupOrderDetails.groupProductInfo.name,
                            style: LatoBold.copyWith(
                                fontSize: 20,
                                color: MyTheme.black,
                                fontWeight: FontWeight.w800),
                            maxLines: 2,
                          )//01722952715
                              : ShimmerHelper().buildBasicShimmer(
                            height: 30.0,
                          )),
                    ])),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20.0,
                        25.0,
                        16.0,
                        0.0,
                      ),
                      child: _groupOrderDetails != null
                          ? buildProductImageSection()
                          : ShimmerHelper().buildBasicShimmer(
                        height: 50.0,
                      ), //buildProductImagePart(),

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
                          10.0,
                          16.0,
                          10.0,
                        ),
                        child: _groupOrderDetails != null
                            ? priceAndTimeRow(context)
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
                        child: _groupOrderDetails != null
                            ? groupMemberRow(context)
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
                          16.0,
                          16.0,
                          0.0,
                        ),
                        child: _groupOrderDetails != null
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

  buildProductImageSection() {
    return Center(
        child: Container(
            height: 200,
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
                              _groupOrderDetails.groupProductInfo.thumbnailImage);
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
                                _groupOrderDetails.groupProductInfo.thumbnailImage,
                            fit: BoxFit.scaleDown,
                          ),
                        )),
                  ),
                  left: 10,
                  right: 10,
                  top: 10,
                  bottom: 30,
                ),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: RatingBar(
                      itemSize: 14.0,
                      ignoreGestures: true,
                      initialRating:
                      double.parse(_groupOrderDetails.groupProductInfo.rating.toString()),
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
                  ),
                  left: 15,
                  right: 5,
                  bottom: 10,
                ),
              ],
            )),
    );
  }

  Row buildSellerRow(BuildContext context) {
    //print("sl:" + AppConfig.BASE_PATH + _productDetails.shop_logo);
    return Row(
      children: [
        Container(

            height: 50,
            decoration: BoxDecoration(
                color: MyTheme.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 2,
                      color: MyTheme.dark_grey.withOpacity(0.3)
                  )
                ]
            ),

            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )
                    ),
                    child: Icon(Icons.message, size: 30, color: MyTheme.white)),

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
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                    child: Text("Message\n  Seller",
                        style: LatoBold.copyWith(color: MyTheme.black)),
                  ),
                ),
              ],
            )),
        Spacer(),
        Container(
          height: 50,
            decoration: BoxDecoration(
              color: MyTheme.white,
                borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 2,
                color: MyTheme.dark_grey.withOpacity(0.3)
              )
            ]
            ),

            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(Images.group, height: 30, width: 30,),
                    )),
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
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                    child: Text("   Chat \nMember",
                        style: LatoBold.copyWith(color: MyTheme.black)),
                  ),
                ),
              ],
            )),

      ],
    );
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
        product_id: widget.id, message: message);

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

  groupMemberRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          /*Container(
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
          ),*/
          Table(
            border: TableBorder.all(width: 1, color: MyTheme.primary_Colour),
            columnWidths: {
              0: FlexColumnWidth(5),
              1: FlexColumnWidth(5),
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
                    color: Colors.amber,
                    padding: EdgeInsets.all(8),
                    child: Center(
                        child: Text(
                          "Member ",
                          style: LatoHeavy.copyWith(
                              color: MyTheme.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 18

                          ),
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: MyTheme.red_div,
                      ),
                  child: Center(
                      child: Text(
                        "Payment Status",
                        style: LatoHeavy.copyWith(
                            color: MyTheme.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 18
                        ),
                      )),
                ),
              ]),
              for (var groupMember in _groupOrderDetails.data)

                TableRow(children: [


                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Center(
                          child: Text(
                            groupMember.name,
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
                          groupMember.paymentStatus,
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

  priceAndTimeRow(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)
                    )
                ),

                padding: EdgeInsets.all(8),
                child: Center(
                    child: Text(
                      "${_groupOrderDetails.minMaxPrice}",
                      style: LatoHeavy.copyWith(
                          color: MyTheme.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        shadows:[ Shadow(
                          offset: Offset(2,2),
                          color: MyTheme.dark_grey.withOpacity(0.3)
                        )]
                      ),

                    )),
              ),
            ),
          Expanded(
            child: Container(
              height: 50,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: MyTheme.red_div,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  )
              ),
              child: Center(
                  child: Text(
                    "01.15.35",
                    style: LatoHeavy.copyWith(
                        color: MyTheme.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

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

  buildRatingRow() {
    return Row(
      children: [
        RatingBar(
          itemSize: 14.0,
          ignoreGestures: true,
          initialRating:
          double.parse(_groupOrderDetails.groupProductInfo.rating.toString()),
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
      ],
    );
  }







}
