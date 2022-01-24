import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/screens/filter.dart';
import 'package:active_ecommerce_flutter/utill/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../my_theme.dart';

AppBar buildCommonAppBar(double statusBarHeight, BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: GestureDetector(
      onTap: () {

      },
      child: Builder(
        builder: (context) => IconButton(
            icon: Icon(Icons.arrow_back, color: MyTheme.primary_Colour),
            onPressed: () {
              return Navigator.of(context).pop();
            }),
      )
    ),
    title: Container(
      height: 60,
     /* kToolbarHeight +
          statusBarHeight -
          (MediaQuery.of(context).viewPadding.top > 40 ? 16.0 : 16.0),*/
      //MediaQuery.of(context).viewPadding.top is the statusbar height, with a notch phone it results almost 50, without a notch it shows 24.0.For safety we have checked if its greater than thirty
      child: Container(
        child: Padding(
            padding: app_language_rtl.$ ? const EdgeInsets.only(top: 14.0, bottom: 14, left: 12) : const EdgeInsets.only(top: 14.0, bottom: 14, right: 12),
            // when notification bell will be shown , the right padding will cease to exist.
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return Filter();
                      }));
                },
                child: buildHomeSearchBox(context))),
      ),
    ),
    elevation: 0.0,
    // titleSpacing: 0,
    actions: <Widget>[
      InkWell(
        onTap: () {
         // ToastComponent.showDialog(AppLocalizations.of(context).common_coming_soon, context,
            //  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        },
        child: Visibility(
          visible: true,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
            child: Image.asset(
              Images.chat,
              height: 20,
              color: MyTheme.primary_Colour,
            ),
          ),
        ),
      ),
      InkWell(
        onTap: () {
         // ToastComponent.showDialog(AppLocalizations.of(context).common_coming_soon, context,
            //  gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        },
        child: Visibility(
          visible: true,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
            child: Image.asset(
              'dummy_assets/icons/notifications.png',
              height: 20,
              color: MyTheme.primary_Colour,
            ),
          ),
        ),
      ),

    ],
  );
}

buildHomeSearchBox(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: MyTheme.primary_Colour,
    ),
    padding: EdgeInsets.only(left: 10,right: 0),
    child: TextField(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Filter();
        }));
      },
      autofocus: false,
      decoration: InputDecoration(

          hintText: "Search..",
          hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.white),
          fillColor: MyTheme.primary_Colour,
          border: InputBorder.none,
          /*  enabledBorder: OutlineInputBorder(
              // borderSide: BorderSide(color: MyTheme.primary_Colour, width: 0.5),
              borderRadius: const BorderRadius.all(
                const Radius.circular(16.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyTheme.primary_Colour, width: 1.0),
              borderRadius: const BorderRadius.all(
                const Radius.circular(16.0),
              ),
            ),*/
          suffixIcon: Stack(
            children: [
              Positioned(
                // padding: const EdgeInsets.all(5.0),
                  right: -1,
                  top: 4,
                  bottom: 4,
                  child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.search,
                          color: MyTheme.primary_Colour,
                          size: 20,
                        ),
                      )
                  )
              ),
            ],
          ),
          contentPadding: EdgeInsets.all(0.0)),
    ),
  );
}


class Appbar_Common{

}