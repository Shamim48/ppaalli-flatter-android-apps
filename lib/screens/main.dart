import 'dart:ui';

import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/cart.dart';
import 'package:active_ecommerce_flutter/screens/group_buying_product.dart';
import 'package:active_ecommerce_flutter/screens/home.dart';
import 'package:active_ecommerce_flutter/screens/product_details.dart';
import 'package:active_ecommerce_flutter/screens/profile.dart';
import 'package:active_ecommerce_flutter/utill/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:toast/toast.dart';

class Main extends StatefulWidget {
  Main({Key key, go_back = true}) : super(key: key);
  bool go_back;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;

  String result = "";
  Future _scanQR() async {
    try {
      var cameraStatus= await Permission.camera.status;
      if(cameraStatus.isGranted){
        String cameraScanResult = await scanner.scan();
        setState(() {
          result = cameraScanResult;
          if(result!=""){

            try {
              var resultList=result.split("/");
              String slug = resultList[resultList.length-1];
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    result="";
                    return ProductDetails(fromScan: true, slug: slug);
                    print('Profle tab Click');
                  }));
            }catch(e){
              ToastComponent.showDialog("This is not Match", context, gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
              return AlertDialog(
                title: const Text('Sorry'),
                content: const Text('This QR code is invalid !'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Close'),
                    child: const Text('Close'),
                  ),
                ],
              );

            }

          }// setting string result with cameraScanResult
        });
      }else{
        var permissionRequest= await Permission.camera.request();

        if(permissionRequest.isGranted){
          String cameraScanResult = await scanner.scan();
          setState(() {
            result = cameraScanResult;
            if(result!=""){

              try {
                var resultList=result.split("/");
                String slug = resultList[resultList.length-1];
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      result="";
                      return ProductDetails(fromScan: true, slug: slug);
                      print('Profle tab Click');
                    }));
              }catch(e){
                ToastComponent.showDialog("This is not Match", context, gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                return AlertDialog(
                  title: const Text('Sorry'),
                  content: const Text('This QR code is invalid !'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Close'),
                      child: const Text('Close'),
                    ),
                  ],
                );

              }

            }// setting string result with cameraScanResult
          });
        }
      }

    } on PlatformException catch (e) {
      print(e);
    }
  }

  var _children = [
   // Cart(has_bottomnav: true),

    Home(),
    /*CategoryList(
      is_base_category: true,
    ),*/
    GroupBuyingProduct(),
    Cart(has_bottomnav: true),
    Profile(),
    // MyWidget()
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
      onWillPop: () async {
        return widget.go_back;
      },
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          extendBody: true,
          body: _children[_currentIndex],
          /*floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          //specify the location of the FAB
          floatingActionButton: Stack(
            children: [
              Positioned(
                bottom: 7,
                left: 10,
                right: 10,
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Filter(
                        selected_filter: "sellers",
                      );
                    }));
                  },
                  child: new Image.asset(
                    "assets/shop.png",
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ],
          ),*/
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: MyTheme.primary_Colour,
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 5),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: BottomNavigationBar(
                backgroundColor: MyTheme.primary_Colour,
                type: BottomNavigationBarType.fixed,
               // onTap: onTapped,
                fixedColor: Theme.of(context).accentColor,
                unselectedItemColor: MyTheme.grey_153,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: GestureDetector(
                      onTap: () {
                        onTapped(0);
                        /*Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Home();
                          print('Profle tab Click');
                        }));*/
                      },
                      child: Image.asset(
                        "assets/home.png",
                        color: _currentIndex == 0
                            ? MyTheme.white
                            : MyTheme.light_grey,
                        /*  color: _currentIndex == 0
                            ? Theme.of(context).accentColor
                            : Color.fromRGBO(153, 153, 153, 1),
                        */
                        height: 25,
                      ),
                    ),
                    title: Text(
                      "",
                      style: TextStyle(fontSize: 12, color: MyTheme.white),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: GestureDetector(
                      onTap: () {
                        onTapped(1);
                        /*Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategoryList();
                          print('Profle tab Click');
                        }));*/
                      },
                      child: Image.asset(
                        "assets/group.png",
                        color: _currentIndex == 1
                            ? MyTheme.white
                            : MyTheme.light_grey,
                        height: 25,
                      ),
                    ),
                    title: Text(
                      "",
                      style: TextStyle(fontSize: 12, color: MyTheme.white),
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
                    icon: GestureDetector(
                      onTap: () {
                        _scanQR();

                       // onTapped(2);
                      /*  Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Cart(has_bottomnav: true,);
                          print('Profle tab Click');
                        }));*/
                      },
                      child: Image.asset(
                        Images.qrCodeBold,
                        color:  MyTheme.light_grey,
                        height: 25,
                      ),
                    ),
                    title: Text(
                      "",
                      style: TextStyle(fontSize: 12, color: MyTheme.white),
                    ),
                  ),

                  BottomNavigationBarItem(
                    icon: GestureDetector(
                      onTap: () {
                        onTapped(2);
                      /*  Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Cart(has_bottomnav: true,);
                          print('Profle tab Click');
                        }));*/
                      },
                      child: Image.asset(
                        "assets/cart.png",
                        color: _currentIndex == 2
                            ? MyTheme.white
                            : MyTheme.light_grey,
                        height: 25,
                      ),
                    ),
                    title: Text(
                      "",
                      style: TextStyle(fontSize: 12, color: MyTheme.white),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: GestureDetector(
                      onTap: () {
                        onTapped(3);
                        /*Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Profile();
                          print('Profle tab Click');
                        }));*/
                      },
                      child: Image.asset(
                        "assets/profile.png",
                        color: _currentIndex == 3
                            ? MyTheme.white
                            : MyTheme.light_grey,
                        height: 25,
                      ),
                    ),
                    title: Text(
                      "",
                      style: TextStyle(fontSize: 12, color: MyTheme.white),
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
