import 'package:active_ecommerce_flutter/addon_config.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/repositories/auth_repository.dart';
import 'package:active_ecommerce_flutter/repositories/profile_repository.dart';
import 'package:active_ecommerce_flutter/repositories/wallet_repository.dart';
import 'package:active_ecommerce_flutter/screens/address.dart';
import 'package:active_ecommerce_flutter/screens/club_point.dart';
import 'package:active_ecommerce_flutter/screens/main.dart';
import 'package:active_ecommerce_flutter/screens/order_list.dart';
import 'package:active_ecommerce_flutter/screens/password_forget.dart';
import 'package:active_ecommerce_flutter/screens/profile_edit.dart';
import 'package:active_ecommerce_flutter/screens/refund_request.dart';
import 'package:active_ecommerce_flutter/screens/wishlist.dart';
import 'package:active_ecommerce_flutter/utill/dimensions.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  Profile({Key key, this.show_back_button = false}) : super(key: key);

  bool show_back_button;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ScrollController _mainScrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _cartCounter = 0;
  String _cartCounterString = "...";
  int _wishlistCounter = 0;
  String _wishlistCounterString = "...";
  int _orderCounter = 0;
  String _orderCounterString = "...";

  var _balanceDetails = null;

  bool isTabCkick=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (is_logged_in.$ == true) {
      fetchAll();
    }
  }

  fetchBalanceDetails() async {
    var balanceDetailsResponse =
    await WalletRepository().getBalance();

    _balanceDetails = balanceDetailsResponse;

    setState(() {});
  }

  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  Future<void> _onPageRefresh() async {
    reset();
    fetchAll();
  }

  onPopped(value) async {
    reset();
    fetchAll();
  }

  fetchAll() {
    fetchCounters();
    fetchBalanceDetails();
  }

  fetchCounters() async {
    var profileCountersResponse =
        await ProfileRepository().getProfileCountersResponse();

    _cartCounter = profileCountersResponse.cart_item_count;
    _wishlistCounter = profileCountersResponse.wishlist_item_count;
    _orderCounter = profileCountersResponse.order_count;

    _cartCounterString =
        counterText(_cartCounter.toString(), default_length: 2);
    _wishlistCounterString =
        counterText(_wishlistCounter.toString(), default_length: 2);
    _orderCounterString =
        counterText(_orderCounter.toString(), default_length: 2);
    setState(() {});
  }

  String counterText(String txt, {default_length = 3}) {
    var blank_zeros = default_length == 3 ? "000" : "00";
    var leading_zeros = "";
    if (txt != null) {
      if (default_length == 3 && txt.length == 1) {
        leading_zeros = "00";
      } else if (default_length == 3 && txt.length == 2) {
        leading_zeros = "0";
      } else if (default_length == 2 && txt.length == 1) {
        leading_zeros = "0";
      }
    }

    var newtxt = (txt == null || txt == "" || txt == null.toString())
        ? blank_zeros
        : txt;

    // print(txt + " " + default_length.toString());
    // print(newtxt);

    if (default_length > txt.length) {
      newtxt = leading_zeros + newtxt;
    }
    //print(newtxt);

    return newtxt;
  }

  reset() {
    _cartCounter = 0;
    _cartCounterString = "...";
    _wishlistCounter = 0;
    _wishlistCounterString = "...";
    _orderCounter = 0;
    _orderCounterString = "...";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            // drawer: MainDrawer(),
            backgroundColor: Colors.white,
            /* appBar: AppBar(
          leading: Icon(Icons.arrow_back,color: Colors.black,),
              backgroundColor: Colors.white,
        ),*/
            //buildAppBar(context),
            body: buildBody(context),
          ),
        ));
  }

  buildBody(context) {
    /* if (is_logged_in.$ == false) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                AppLocalizations.of(context).profile_screen_please_log_in,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {*/
    return RefreshIndicator(
      color: MyTheme.primaryColor,
      backgroundColor: Colors.white,
      onRefresh: _onPageRefresh,
      displacement: 10,
      child: CustomScrollView(
        controller: _mainScrollController,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              buildTopSection(),
              buildBalanceSection(),
              buildOrderSection(),
              buildVerticalMenu()

              /*buildCountersRow(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  height: 24,
                ),
              ),
              buildHorizontalMenu(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  height: 24,
                ),
              ),*/
            ]),
          )
        ],
      ),
    );
    // }
  }

  buildHorizontalMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return OrderList();
            }));
          },
          child: Column(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: MyTheme.light_grey,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.assignment_outlined,
                      color: Colors.green,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  AppLocalizations.of(context).profile_screen_orders,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyTheme.font_grey, fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProfileEdit();
            })).then((value) {
              onPopped(value);
            });
          },
          child: Column(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: MyTheme.light_grey,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.blueAccent,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  AppLocalizations.of(context).profile_screen_profile,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyTheme.font_grey, fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Address();
            }));
          },
          child: Column(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: MyTheme.light_grey,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.amber,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  AppLocalizations.of(context).profile_screen_address,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyTheme.font_grey, fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
        /*InkWell(
          onTap: () {
            ToastComponent.showDialog("Coming soon", context,
                gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
          },
          child: Column(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: MyTheme.light_grey,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Icon(Icons.message_outlined, color: Colors.redAccent),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Message",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyTheme.font_grey, fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),*/
      ],
    );
  }

  buildVerticalMenu() {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
      Container(height: 1,width: double.infinity, color: MyTheme.primary_Colour,),
      InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ProfileEdit();
              }));
            },
            child: Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0,top: 5,left: 30,right: 30),
                child: Row(
                  children: [
                    Image.asset("dummy_assets/icons/my_profile.png",color: MyTheme.primary_Colour, height: 30, width: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Update Profile",
                      //  AppLocalizations.of(context)
                           // .profile_screen_notification,
                        textAlign: TextAlign.center,
                        style: LatoSemiBold.copyWith(color: MyTheme.font_grey,fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(height: 1,width: double.infinity, color: MyTheme.primary_Colour,),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return OrderList(from_checkout: false,);
              }));
            },
            child: Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0,top: 5,left: 30,right: 30),
                child: Row(
                  children: [
                    Image.asset("dummy_assets/icons/order_history.png",color: MyTheme.primary_Colour, height: 30, width: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Order History",
                        //  AppLocalizations.of(context)
                        // .profile_screen_notification,
                        textAlign: TextAlign.center,
                        style: LatoSemiBold.copyWith(color: MyTheme.font_grey,fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(height: 1,width: double.infinity, color: MyTheme.primary_Colour,),
          InkWell(
            onTap: () {
              ToastComponent.showDialog(
                  AppLocalizations.of(context).common_coming_soon, context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            },
            child: Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0,top: 5,left: 30,right: 30),
                child: Row(
                  children: [
                    Image.asset("dummy_assets/icons/group_order.png",color: MyTheme.primary_Colour, height: 30, width: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Group Order Details",
                        //  AppLocalizations.of(context)
                        // .profile_screen_notification,
                        textAlign: TextAlign.center,
                        style: LatoSemiBold.copyWith(color: MyTheme.font_grey,fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(height: 1,width: double.infinity, color: MyTheme.primary_Colour,),
          InkWell(
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context){
               return Wishlist();
             }));
            },
            child: Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0,top: 5,left: 30,right: 30),
                child: Row(
                  children: [
                    Image.asset("dummy_assets/icons/wishlist.png",color: MyTheme.primary_Colour, height: 30, width: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Wishlist",
                        //  AppLocalizations.of(context)
                        // .profile_screen_notification,
                        textAlign: TextAlign.center,
                        style: LatoSemiBold.copyWith(color: MyTheme.font_grey,fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(height: 1,width: double.infinity, color: MyTheme.primary_Colour,),

          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return PasswordForget();
              }));
            },
            child: Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0,top: 5,left: 30,right: 30),
                child: Row(
                  children: [
                    Image.asset("dummy_assets/icons/change_pass.png",color: MyTheme.primary_Colour, height: 30, width: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Change password",
                        //  AppLocalizations.of(context)
                        // .profile_screen_notification,
                        textAlign: TextAlign.center,
                        style: LatoSemiBold.copyWith(color: MyTheme.font_grey,fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(height: 1,width: double.infinity, color: MyTheme.primary_Colour,),
          InkWell(
            onTap: () {
              ToastComponent.showDialog(
                  AppLocalizations.of(context).common_coming_soon, context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            },
            child: Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0,top: 5,left: 30,right: 30),
                child: Row(
                  children: [
                    Image.asset("dummy_assets/icons/help.png",color: MyTheme.primary_Colour, height: 30, width: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Help",
                        //  AppLocalizations.of(context)
                        // .profile_screen_notification,
                        textAlign: TextAlign.center,
                        style: LatoSemiBold.copyWith(color: MyTheme.font_grey,fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(height: 1,width: double.infinity, color: MyTheme.primary_Colour,),
          InkWell(
            onTap: () {
              ToastComponent.showDialog(
                  AppLocalizations.of(context).common_coming_soon, context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
            },
            child: Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0,top: 5,left: 30,right: 30),
                child: Row(
                  children: [
                    Image.asset("dummy_assets/icons/about.png",color: MyTheme.primary_Colour, height: 30, width: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("About",
                        //  AppLocalizations.of(context)
                        // .profile_screen_notification,
                        textAlign: TextAlign.center,
                        style: LatoSemiBold.copyWith(color: MyTheme.font_grey,fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(height: 1,width: double.infinity, color: MyTheme.primary_Colour,),
          InkWell(
            onTap: () {
              AuthRepository().getLogoutResponse();
              ToastComponent.showDialog(
                  "Log Out", context,
                  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Main();
              }));
              setState(() {
              });
            },
            child: Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0,top: 5,left: 30,right: 30),
                child: Row(
                  children: [
                    Image.asset("dummy_assets/icons/log_out.png",color: MyTheme.primary_Colour, height: 30, width: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Log out",
                        //  AppLocalizations.of(context)
                        // .profile_screen_notification,
                        textAlign: TextAlign.center,
                        style: LatoSemiBold.copyWith(color: MyTheme.font_grey,fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(height: 1,width: double.infinity, color: MyTheme.primary_Colour,),




/*          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return OrderList();
              }));
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.credit_card_rounded,
                          color: Colors.white,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      AppLocalizations.of(context)
                          .profile_screen_purchase_history,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: MyTheme.font_grey, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          ),*/
          AddonConfig.club_point_addon_installed
              ? InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Clubpoint();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: [
                        Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.monetization_on_outlined,
                                color: Colors.white,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            AppLocalizations.of(context)
                                .profile_screen_earning_points,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyTheme.font_grey, fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
          AddonConfig.refund_addon_installed
              ? InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RefundRequest();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: [
                        Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.pinkAccent,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.double_arrow,
                                color: Colors.white,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            AppLocalizations.of(context)
                                .profile_screen_refund_requests,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyTheme.font_grey, fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      );
  }

  buildCountersRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _cartCounterString,
                style: TextStyle(
                    fontSize: 16,
                    color: MyTheme.font_grey,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  AppLocalizations.of(context).profile_screen_in_your_cart,
                  style: TextStyle(
                    color: MyTheme.medium_grey,
                  ),
                )),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _wishlistCounterString,
                style: TextStyle(
                    fontSize: 16,
                    color: MyTheme.font_grey,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  AppLocalizations.of(context).profile_screen_in_wishlist,
                  style: TextStyle(
                    color: MyTheme.medium_grey,
                  ),
                )),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _orderCounterString,
                style: TextStyle(
                    fontSize: 16,
                    color: MyTheme.font_grey,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  AppLocalizations.of(context).profile_screen_in_ordered,
                  style: TextStyle(
                    color: MyTheme.medium_grey,
                  ),
                )),
          ],
        )
      ],
    );
  }

  buildTopSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(left: 10,top: 10),
        child: Icon(Icons.arrow_back,color: MyTheme.primary_Colour, size: 30,),),
        Center(child:
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "PROFILE",
            style: LatoHeavy.copyWith(
                color: MyTheme.primary_Colour,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
        ),),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 8.0, left: 50),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: MyTheme.primary_Colour,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      color: Color.fromRGBO(112, 112, 112, .3), width: 2),
                  //shape: BoxShape.rectangle,
                ),
                child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'dummy_assets/icons/profile.png',
                      image: AppConfig.BASE_PATH + "${avatar_original.$}",
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_DEFAULT  ),
                    child: Text(
                      "Shamim Ahmed",
                      // "${user_name.$}",
                      style: LatoHeavy.copyWith(
                          fontSize: 20,
                          color: MyTheme.font_grey,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  /*Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: user_name.$ != "" && user_name.$ != null
                      ? Text(
                    "${user_name.$}",
                    style: TextStyle(
                      color: MyTheme.medium_grey,
                    ),
                  )
                      : Text(
                    "${user_phone.$}",
                    style: TextStyle(
                      color: MyTheme.medium_grey,
                    ),
                  )),*/

                  Padding(
                    padding: EdgeInsets.only(
                        top: 5,
                        left: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Text(
                      "shamim@nextpage.com",
                      style: LatoRegular.copyWith(color: Colors.black),
                    ),
                  )
                ],
              ),
            )

         /*Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Container(
            height: 24,
            child: FlatButton(
              color: Colors.green,
              // 	rgb(50,205,50)
              shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(16.0),
                bottomLeft: const Radius.circular(16.0),
                topRight: const Radius.circular(16.0),
                bottomRight: const Radius.circular(16.0),
              )),
              child: Text(
                AppLocalizations.of(context).profile_screen_check_balance,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Wallet();
                }));
              },
            ),
          ),
        ),*/

          ],
        )
      ],
    );
  }

  buildBalanceSection(){
    return Padding(padding: EdgeInsets.fromLTRB(30,10,30,10),
    child: Row(
      children: [
        InkWell(
          onTap: (){
            setState(() {
              isTabCkick=!isTabCkick;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: isTabCkick ? MyTheme.white:  MyTheme.golden,
                    shape: BoxShape.circle,

                  ),
                  child: Center(
                    child: Text("\$",style: LatoSemiBold.copyWith(color: Colors.white),),
                  )
              ),
              SizedBox(width: 5,),
              Text( isTabCkick ? _balanceDetails.balance : "Check Balance"),
              Container(

                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: isTabCkick ? MyTheme.golden: MyTheme.golden.withOpacity(0.3),
                    shape: BoxShape.circle,

                  ),
                  child: Center(
                    child: Text("\$",style: LatoSemiBold.copyWith(color: Colors.white),),
                  )
              ),
            ],
          ),
        ),
        Expanded(child: Container()),
        Row(
          children: [

            Text("Is Student", style: LatoMedium.copyWith(fontWeight: FontWeight.bold),),
            SizedBox(width: 5,),
            Container(
                height: 18,
                width: 40,
                decoration: BoxDecoration(
                  color: MyTheme.golden,
                    boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 1, spreadRadius: .5)],
                    borderRadius: BorderRadius.circular(5)

                ),
                child: Center(
                  child: Text("\$",style: LatoSemiBold.copyWith(color: Colors.white),),
                )
            ),
          ],
        )

      ],
    ),
    );
  }

  buildOrderSection() {
    return Center(
      child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                              height: 35,
                              width: 150,
                              decoration: BoxDecoration(color: MyTheme.white,
                                  boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 2, spreadRadius: 1)],
                                  borderRadius: BorderRadius.circular(7)
                              ),
                                child: Row(
                                  children: [
                                    // Image.asset("assets/"),
                                    ClipRRect(
                                      borderRadius: BorderRadius.only( topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                      child: Container(
                                        height: double.infinity,
                                        width: 35,
                                        color: MyTheme.primary_Colour,
                                        // clipBehavior: Clip.antiAlias,
                                         child: Padding(
                                           padding: EdgeInsets.all(5),
                                           child: Image.asset("dummy_assets/icons/complete_order.png"),
                                         )

                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Text('Order Complete',style: LatoSemiBold.copyWith(color: Colors.black,fontSize: 12),)

                                  ],
                                )


                          ),
                          Positioned(
                              right: 3,
                              top: -15,
                              child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: MyTheme.primary_Colour,
                                    shape: BoxShape.circle,

                                  ),
                                  child: Center(
                                    child: Text("12",style: LatoSemiBold.copyWith(color: Colors.white),),
                                  )
                              ))
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                              height: 35,
                              width: 150,
                              decoration: BoxDecoration(color: MyTheme.white,
                                  boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 2, spreadRadius: 1)],
                                  borderRadius: BorderRadius.circular(5)
                              ),

                                child: Row(
                                  children: [
                                    // Image.asset("assets/"),
                                    ClipRRect(
                                      borderRadius: BorderRadius.only( topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                      child: Container(
                                          height: double.infinity,
                                          width: 35,
                                          color: MyTheme.primary_Colour,
                                          // clipBehavior: Clip.antiAlias,
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Image.asset("dummy_assets/icons/process_order.png"),
                                          )

                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Text('Order Process',style: LatoSemiBold.copyWith(color: Colors.black,fontSize: 12),)

                                  ],

                              )

                          ),
                          Positioned(
                              right: 3,
                              top: -15,
                              child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: MyTheme.primary_Colour,
                                    shape: BoxShape.circle,

                                  ),
                                  child: Center(
                                    child: Text("5",style: LatoSemiBold.copyWith(color: Colors.white),),
                                  )
                              ))
                        ],
                      )),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                              height: 35,
                              width: 150,
                              decoration: BoxDecoration(color: MyTheme.white,
                                  boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 2, spreadRadius: 1)],
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                children: [
                                  // Image.asset("assets/"),
                                  ClipRRect(
                                    borderRadius: BorderRadius.only( topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                    child: Container(
                                        height: double.infinity,
                                        width: 35,
                                        color: MyTheme.primary_Colour,
                                        // clipBehavior: Clip.antiAlias,
                                        child: Padding(
                                          padding: EdgeInsets.all(6),
                                          child: Image.asset("dummy_assets/icons/pending_order.png"),
                                        )

                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text('Order Pending',style: LatoSemiBold.copyWith(color: Colors.black,fontSize: 12),)

                                ],

                              )

                          ),
                          Positioned(
                              right: 3,
                              top: -15,
                              child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: MyTheme.primary_Colour,
                                    shape: BoxShape.circle,

                                  ),
                                  child: Center(
                                    child: Text("3",style: LatoSemiBold.copyWith(color: Colors.white),),
                                  )
                              ))
                        ],
                      )),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                              height: 35,
                              width: 150,
                              decoration: BoxDecoration(color: MyTheme.white,
                                  boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 2, spreadRadius: 1)],
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                children: [
                                  // Image.asset("assets/"),
                                  ClipRRect(
                                    borderRadius: BorderRadius.only( topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                    child: Container(
                                        height: double.infinity,
                                        width: 30,
                                        color: MyTheme.primary_Colour,
                                        // clipBehavior: Clip.antiAlias,
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Image.asset("dummy_assets/icons/cancel_order.png"),
                                        )

                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text('Order Cancel',style: LatoSemiBold.copyWith(color: Colors.black,fontSize: 12),)

                                ],

                              )

                          ),
                          Positioned(
                              right: 3,
                              top: -15,
                              child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: MyTheme.primary_Colour,
                                    shape: BoxShape.circle,

                                  ),
                                  child: Center(
                                    child: Text("4",style: LatoSemiBold.copyWith(color: Colors.white),),
                                  )
                              ))
                        ],
                      )),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                              height: 35,
                              width: 150,
                              decoration: BoxDecoration(color: MyTheme.white,
                                  boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 2, spreadRadius: 1)],
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                children: [
                                  // Image.asset("assets/"),
                                  ClipRRect(
                                    borderRadius: BorderRadius.only( topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                    child: Container(
                                        height: double.infinity,
                                        width: 35,
                                        color: MyTheme.primary_Colour,
                                        // clipBehavior: Clip.antiAlias,
                                        child: Padding(
                                          padding: EdgeInsets.all(6),
                                          child: Image.asset("dummy_assets/icons/group_buying.png"),
                                        )

                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text('Group Buying',style: LatoSemiBold.copyWith(color: Colors.black,fontSize: 12),)

                                ],

                              )

                          ),
                          Positioned(
                              right: 3,
                              top: -15,
                              child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: MyTheme.primary_Colour,
                                    shape: BoxShape.circle,

                                  ),
                                  child: Center(
                                    child: Text("7",style: LatoSemiBold.copyWith(color: Colors.white),),
                                  )
                              ))
                        ],
                      )),
                ],
              )


            ],

          )
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: GestureDetector(
        child: widget.show_back_button
            ? Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              )
            : Builder(
                builder: (context) => GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 0.0),
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
      ),
      title: Text(
        AppLocalizations.of(context).profile_screen_account,
        style: TextStyle(fontSize: 16, color: MyTheme.primaryColor),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
