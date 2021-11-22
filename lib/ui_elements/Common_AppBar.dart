/*
import 'package:flutter/material.dart';

import '../my_theme.dart';

class Common_AppBar extends StatefulWidget {
  const Common_AppBar({Key? key}) : super(key: key);

  @override
  _Common_AppBarState createState() => _Common_AppBarState();
}

class _Common_AppBarState extends State<Common_AppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState.openDrawer();
        },
        child: widget.show_back_button
            ? Builder(
          builder: (context) => IconButton(
              icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
              onPressed: () {
                if(!widget.go_back){
                  return;
                }
                return Navigator.of(context).pop();
              }),
        )
            : Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 18.0, horizontal: 0.0),
            child: Container(
              child: Image.asset(
                'assets/hamburger.png',
                height: 16,
                //color: MyTheme.dark_grey,
                color: MyTheme.primary_Colour,
              ),
            ),
          ),
        ),
      ),
      title: Container(
        height: kToolbarHeight +
            statusBarHeight -
            (MediaQuery.of(context).viewPadding.top > 40 ? 16.0 : 16.0),
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
            ToastComponent.showDialog(AppLocalizations.of(context).common_coming_soon, context,
                gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
          },
          child: Visibility(
            visible: true,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
              child: Image.asset(
                'assets/bell.png',
                height: 20,
                color: MyTheme.primary_Colour,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


*/
