import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/repositories/cart_repository.dart';
import 'package:active_ecommerce_flutter/screens/cart.dart';
import 'package:active_ecommerce_flutter/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/screens/product_details.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/utill/images.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:toast/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupBuyingProductCard extends StatefulWidget {

  int id;
  String image;
  String name;
  String main_price;
  int rating;
  int startTime;
  int endTime;

  GroupBuyingProductCard({Key key,this.id, this.image, this.name, this.main_price,this.rating=0, this.startTime, this.endTime}) : super(key: key);

  @override
  _GroupBuyingProductCardState createState() => _GroupBuyingProductCardState();

}

class _GroupBuyingProductCardState extends State<GroupBuyingProductCard> {
  SnackBar _addedToCartSnackbar;
  String wishlistImage=Images.heart_outline;

  CountdownTimerController _timerController ;

  DateTime end ; // YYYY-mm-dd
  DateTime now = DateTime.now();
  int diff ;
  int endTime ;

  DateTime convertTimeStampToDateTime(int timeStamp) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return dateToTimeStamp;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(endTime!=0){
      end = convertTimeStampToDateTime(1646376303);
      diff = end.difference(now).inMilliseconds;
      endTime = diff + now.millisecondsSinceEpoch;
      void onEnd() {}
      _timerController=CountdownTimerController(endTime: endTime, onEnd: onEnd);
    }


  }

  @override
  Widget build(BuildContext context) {
    print((MediaQuery.of(context).size.width - 48 ) / 2);

    _addedToCartSnackbar = SnackBar(
      content: Text(
        AppLocalizations.of(context)
            .product_details_screen_snackbar_added_to_cart,
        style: TextStyle(color: MyTheme.font_grey),
      ),
      backgroundColor: MyTheme.soft_accent_color,
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: AppLocalizations.of(context)
            .product_details_screen_snackbar_show_cart,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Cart(has_bottomnav: false,);
          })).then((value) {

          });
        },
        textColor: MyTheme.primaryColor,
        disabledTextColor: Colors.grey,
      ),
    );

    return CountdownTimer(
      controller: _timerController,
      widgetBuilder: (_ , CurrentRemainingTime time){
        return InkWell(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return ProductDetails(
                    id: widget.id,
                    fromGroupBuying: true,
                  );
                }));
          },
          child: Card(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3)
            ),
            child: Container(
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Container(
                    margin: EdgeInsets.all(5),
                    child: Stack(
                      children: [
                        FadeInImage.assetNetwork(
                          placeholder:
                          'assets/placeholder.png',
                          image: AppConfig.BASE_PATH +
                              widget.image,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                        ),




                         Positioned(child: widget.startTime!=0 ?  Container(

                            padding: EdgeInsets.only(top: 3, bottom: 3, left: 5, right: 15),
                            decoration: BoxDecoration(
                                color: MyTheme.primary_Colour.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(30)
                            ),
                            child: Text("${time.hours}h.${time.min}m.${time.sec}s",style:  LatoHeavy.copyWith(color: MyTheme.white, fontWeight: FontWeight.w900),))
                         : Container(),
                        top: 6,
                        right: 15,
                      ),

/*${time.days.toString()}d*/
                        Positioned(child: widget.startTime!=0 ? Container(
                          width: 30,
                          height: 30,
                          padding: EdgeInsets.all(4.5),
                          decoration: BoxDecoration(
                              color: MyTheme.primary_Colour,
                              shape: BoxShape.circle
                          ),

                          child: Image.asset(Images.timer_light, color: Colors.white,),
                        )
                        : Container(),
                          top: 1,
                          right: 1,
                        ),


                      ],
                    ),

                  ),),
                  Container(

                    decoration: BoxDecoration(
                      color: MyTheme.primary_Colour,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3), bottomRight: Radius.circular(3)),
                    ),
                    height: 96,
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(1),
                          child: Text(widget.name, style: LatoBold.copyWith(overflow: TextOverflow.ellipsis, color: MyTheme.white ), maxLines: 1,),
                        ),
                        Padding(padding: EdgeInsets.all(1),
                          child: Row(
                            children: [
                              /*  RatingBar(
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),*/

                              Expanded(
                                child: Padding(
                                  padding:
                                  EdgeInsets.only(left: 5),
                                  child: RatingBarIndicator(
                                    rating: widget.rating.toDouble(),
                                    itemBuilder:
                                        (context, index) => Icon(
                                      Icons.star,
                                      color: MyTheme.white,
                                    ),
                                    itemCount: 5,
                                    itemSize: 12.0,
                                    direction: Axis.horizontal,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    5, 2, 5, 5),
                                child: Text(
                                  widget.main_price,
                                  style: LatoMedium.copyWith(color: MyTheme.white),
                                ),
                              )
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: FlatButton(onPressed: (){
                                onPressAddToCart(context, _addedToCartSnackbar,widget.id);

                              },
                                minWidth: MediaQuery.of(context).size.width,
                                color: MyTheme.black,
                                textColor: MyTheme.white,
                                child: Center(
                                  child: Text("Add to cart", style: LatoBold.copyWith(),),
                                ),

                              ),
                            )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ),
        );
      }
    );

  }

  onPressAddToCart(context, snackbar, int id) {
    addToCart(mode: "add_to_cart", context: context, snackbar: snackbar, id: id);
  }

  addToCart({mode, context = null, snackbar = null, int id}) async {
    if (is_logged_in.$ == false) {
      ToastComponent.showDialog(
          "You are not log in!", context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return Login();
      }));

      return;
    }

    /*productCartList.add(_productDetails.data[0]);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Cart(has_bottomnav: true,);
      }));*/

    print(id);
    // print(_variant);
    print(user_id.$);
    // print(_quantity);

    var cartAddResponse = await CartRepository()
        .getCartAddResponseWithoutVariant(id, /*_variant,*/ user_id.$,1);

    if (cartAddResponse.result == false) {
      ToastComponent.showDialog(cartAddResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    } else {
      if (mode == "add_to_cart") {
        if (snackbar != null && context != null) {
          Scaffold.of(context).showSnackBar(snackbar);
        }
      } else if (mode == 'buy_now') {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Cart(has_bottomnav: false,);
        })).then((value) {

        });
      }
    }
  }

  onWishTap(int id) {
    if (is_logged_in.$ == false) {
      ToastComponent.showDialog(
          AppLocalizations.of(context).common_login_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }

    /* if (_isInWishList) {
      _isInWishList = false;
      setState(() {});
      removeFromWishList(id);
    } else {
      _isInWishList = true;
      setState(() {});
      addToWishList(id);
    }
    */
  }
  String timeText(String txt, {default_length = 3}) {
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
  Row buildTimerRowRow(CurrentRemainingTime time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          timeText(time.days.toString()+"d", default_length: 3),
          style: TextStyle(
              color: MyTheme.primaryColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: Text(
            ":",
            style: TextStyle(
                color: MyTheme.primaryColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          timeText(time.hours.toString()+"h", default_length: 2),
          style: TextStyle(
              color: MyTheme.primaryColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: Text(
            ":",
            style: TextStyle(
                color: MyTheme.primaryColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          timeText(time.min.toString()+"m", default_length: 2),
          style: TextStyle(
              color: MyTheme.primaryColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: Text(
            ":",
            style: TextStyle(
                color: MyTheme.primaryColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          timeText(time.sec.toString()+"s", default_length: 2),
          style: TextStyle(
              color: MyTheme.primaryColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }



}

class RatingBar extends StatelessWidget {
  final double rating;
  final double size;

  RatingBar({@required this.rating, this.size = 18});

  @override
  Widget build(BuildContext context) {
    List<Widget> _starList = [];

    int realNumber = rating.floor();
    int partNumber = ((rating - realNumber) * 10).ceil();

    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        _starList.add(Icon(Icons.star, color: Colors.white, size: size));
      } else if (i == realNumber) {
        _starList.add(SizedBox(
          height: size,
          width: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(Icons.star, color: Colors.white, size: size),
              ClipRect(
                clipper: _Clipper(part: partNumber),
                child: Icon(Icons.star, color: Colors.grey, size: size),
              )
            ],
          ),
        ));
      } else {
        _starList.add(Icon(Icons.star, color: Colors.grey, size: size));
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _starList,
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;

  _Clipper({@required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      (size.width / 10) * part,
      0.0,
      size.width,
      size.height,
    );
  }
  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}


