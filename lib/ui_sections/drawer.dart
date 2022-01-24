import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/helpers/auth_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/repositories/category_repository.dart';
import 'package:active_ecommerce_flutter/screens/filter.dart';
import 'package:active_ecommerce_flutter/screens/login.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({
    Key key,
  }) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  var _categoryList = [];
  bool _isCategoryInitial = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  fetchCategories() async {
    var categoryResponse = await CategoryRepository().getCategory();
    _categoryList.addAll(categoryResponse.categories);
    _isCategoryInitial = false;
    setState(() {});
  }

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
          child:
              buildCategory() /*Padding(
          padding: EdgeInsets.all(10),
          child: buildCategory(),
        )*/
          ),
    );
  }

  buildCategory() {
    if (_isCategoryInitial && _categoryList.length == 0) {
      //snapshot.hasError
      print("category list error");
      return Container(
        height: 10, // 01923531404
      );
    } else if (_categoryList.length > 0) {
      return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _categoryList.length,
          //  itemExtent: 0,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Filter(
                        link: _categoryList[index].links.products,
                      );
                    }));
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only( left: 8.0, top: 10),
                  child: Container(
                   /* decoration: BoxDecoration(
                        color: MyTheme.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: MyTheme.dark_grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2)
                        ]),*/
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: MyTheme.primary_Colour.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(35),
                                border: Border.all(color: MyTheme.dark_grey.withOpacity(0.5), width: 1.5)
                                //shape: BoxShape.rectangle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/placeholder.png',
                                  image: AppConfig.BASE_PATH +
                                      _categoryList[index].banner,
                                  //AppConfig.BASE_PATH + _list[index].shop_logo,
                                  fit: BoxFit.contain,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              )
                              /*ClipRRect(
                //  borderRadius: BorderRadius.circular(35),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    image: Images.complete,//AppConfig.BASE_PATH + _list[index].shop_logo,
                    fit: BoxFit.contain,
                    height: double.infinity,
                    width: double.infinity,
                  )),*/
                              ),
                          Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _categoryList[index].name,
                              // _list[index].shop_name,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: LatoBold.copyWith(
                                  fontSize: 15,
                                  height: 1.6,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ]),
                  ),
                )

                /* Padding(padding: EdgeInsets.all(10),
                child: Text(_categoryList[index].name, style: LatoHeavy,),
              )*/
                );
          });
    } else {
      return SingleChildScrollView(
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: MyTheme.shimmer_base,
                    highlightColor: MyTheme.shimmer_highlighted,
                    child: Container(
                      height: 60,
                      width: 60,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                        child: Shimmer.fromColors(
                          baseColor: MyTheme.shimmer_base,
                          highlightColor: MyTheme.shimmer_highlighted,
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width * .7,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Shimmer.fromColors(
                          baseColor: MyTheme.shimmer_base,
                          highlightColor: MyTheme.shimmer_highlighted,
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width * .5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}
