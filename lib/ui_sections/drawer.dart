import 'package:active_ecommerce_flutter/helpers/auth_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/login.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({
    Key key,
  }) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  onTapLogout(context) async {
    AuthHelper().clearUserData();

    /*
    var logoutResponse = await AuthRepository()
            .getLogoutResponse();


    if(logoutResponse.result == true){
         ToastComponent.showDialog(logoutResponse.message, context,
                   gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
         }
         */
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Login();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                /*    is_logged_in.$ == true
                    ? ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            AppConfig.BASE_PATH + "${avatar_original.$}",
                          ),
                        ),
                        title: Text("${user_name.$}"),
                        subtitle:
                            user_name.$ != "" && user_name.$ != null
                                ? Text("${user_name.$}")
                                : Text("${user_phone.$}"))
                    : Text(AppLocalizations.of(context).main_drawer_not_logged_in,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),*/
                Divider(),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(180),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Fashion',
                      style: LatoBold.copyWith(color: Colors.black,  fontSize: 16),

                      //TextStyle(color: Colors.black,  fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(180),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Beauty & Health',
                      style: LatoBold.copyWith(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(180),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Dress',
                      style: LatoBold.copyWith(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(180),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Clock',
                      style: LatoBold.copyWith(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(180),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Shoes',
                      style: LatoBold.copyWith(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(180),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Headphone',
                      style: LatoBold.copyWith(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(180),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'New Shoes',
                      style: LatoBold.copyWith(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(180),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'T-shirt',
                      style: LatoBold.copyWith(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(180),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Vegetable',
                      style: LatoBold.copyWith(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),


                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(180),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'New Shoes',
                      style: LatoBold.copyWith(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                /*ListTile(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    leading: Container(height: 10,width: 10,
                      decoration: BoxDecoration(
                        color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(180),
                      ),),
                    // Image.asset("assets/language.png",
                    //                         height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context).main_drawer_change_language,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return ChangeLanguage();
                          }));
                    }),
                ListTile(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/home.png",
                        height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context).main_drawer_home,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Main();
                          }));
                    }),
                is_logged_in.$ == true
                    ? ListTile(
                    visualDensity:
                    VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/profile.png",
                        height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context).main_drawer_profile,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Profile(show_back_button: true);
                          }));
                    })
                    : Container(),
                is_logged_in.$ == true
                    ? ListTile(
                    visualDensity:
                    VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/order.png",
                        height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context).main_drawer_orders,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return OrderList(from_checkout: false);
                          }));
                    })
                    : Container(),
                is_logged_in.$ == true
                    ? ListTile(
                    visualDensity:
                    VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/heart.png",
                        height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context).main_drawer_my_wishlist,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Wishlist();
                          }));
                    })
                    : Container(),
                (is_logged_in.$ == true)
                    ? ListTile(
                    visualDensity:
                    VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/chat.png",
                        height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context).main_drawer_messages,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return MessengerList();
                          }));
                    })
                    : Container(),
                is_logged_in.$ == true
                    ? ListTile(
                    visualDensity:
                    VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/wallet.png",
                        height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context).main_drawer_wallet,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Wallet();
                          }));
                    })
                    : Container(),
                Divider(height: 24),
                is_logged_in.$ == false
                    ? ListTile(
                    visualDensity:
                    VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/login.png",
                        height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context).main_drawer_login,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Login();
                          }));
                    })
                    : Container(),
                is_logged_in.$ == true
                    ? ListTile(
                    visualDensity:
                    VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/logout.png",
                        height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context).main_drawer_logout,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      onTapLogout(context);
                    })
                    : Container(),*/
              ],
            ),
          )),
        ),
      ),
    );
  }
}
