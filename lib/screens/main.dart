import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/cart.dart';
import 'package:active_ecommerce_flutter/screens/category_list.dart';
import 'package:active_ecommerce_flutter/screens/home.dart';
import 'package:active_ecommerce_flutter/screens/profile.dart';
import 'package:active_ecommerce_flutter/screens/filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Main extends StatefulWidget {

  Main({Key key, go_back = true})
      : super(key: key);

  bool go_back;


  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {


  int _currentIndex = 0;
  var _children = [
    Home(),
    CategoryList(
      is_base_category: true,
    ),
    Home(),
    Cart(has_bottomnav: true),
    Profile()
  ];

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  void initState() {
    // TODO: implement initState
    //re appear statusbar in case it was not there in the previous page
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()
    async {
      return widget.go_back;
    },
    child: Directionality(
    textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
    child: Scaffold(
    extendBody: true,
    body: _children[_currentIndex],
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    //specify the location of the FAB
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.transparent,

      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Filter(
            selected_filter: "sellers",
          );
        }));
      },
    child: new Image.asset("assets/shop.png",
      height: 100,
      width: 100,
    ),
      /*IconButton(
    icon:
    tooltip: 'Action',
   ),*/
    ),
    bottomNavigationBar: Container(

      decoration: BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        color: MyTheme.primary_Colour,

      /*  boxShadow: [
        BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
      ],*/
    ),
    child: ClipRRect(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)) ,
    child: BottomNavigationBar(
      backgroundColor: MyTheme.primary_Colour,
    type: BottomNavigationBarType.fixed,
    onTap: onTapped,
    currentIndex: _currentIndex,
    fixedColor: Theme.of(context).accentColor,
    unselectedItemColor: MyTheme.grey_153,
    items: <BottomNavigationBarItem>[
    BottomNavigationBarItem(
    icon: Image.asset(
    "assets/home.png",
    color: _currentIndex == 0
    ? MyTheme.white
        : MyTheme.white,
    /*  color: _currentIndex == 0
                            ? Theme.of(context).accentColor
                            : Color.fromRGBO(153, 153, 153, 1),
                        */
    height: 20,
    ),
    title: Text("",
    style: TextStyle(fontSize: 12,color: MyTheme.white),
    ),
    ),
    BottomNavigationBarItem(
    icon: Image.asset(
    "assets/categories.png",
    color: _currentIndex == 1
    ? MyTheme.white
        : MyTheme.white,
    height: 20,
    ),
      title: Text("",
        style: TextStyle(fontSize: 12,color: MyTheme.white),
      ),
/*    title: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
    AppLocalizations.of(context).main_screen_bottom_navigation_categories,
    style: TextStyle(fontSize: 12,color: MyTheme.white),
    ),
    )*/
    ),

    BottomNavigationBarItem(
    icon: Icon(
    Icons.circle,
    color: Colors.transparent,
    ),
    title: Text(""),
    ),
    BottomNavigationBarItem(
    icon: Image.asset(
    "assets/cart.png",
    color: _currentIndex == 3
    ? MyTheme.white
        : MyTheme.white,
    height: 20,
    ),
      title: Text("",
        style: TextStyle(fontSize: 12,color: MyTheme.white),
      ),
    ),
    BottomNavigationBarItem(
    icon: Image.asset(
    "assets/profile.png",
    color: _currentIndex == 4
    ? MyTheme.white
        : MyTheme.white,
    height: 20,
    ),
      title: Text("",
        style: TextStyle(fontSize: 12,color: MyTheme.white),
      ),
    ),
    ],


    ),
    ),

    ),
    ),
    ),
    );
  }
}
