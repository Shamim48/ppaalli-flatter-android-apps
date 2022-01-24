import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/screens/product_details.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/utill/color_resources.dart';
import 'package:active_ecommerce_flutter/utill/dimensions.dart';
import 'package:active_ecommerce_flutter/utill/images.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {

  int id;
  String image;
  String name;
  String main_price;

  ProductCard({Key key,this.id, this.image, this.name, this.main_price,}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    print((MediaQuery.of(context).size.width - 48 ) / 2);
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProductDetails(id: widget.id,);
          }));
        },
        child: Center(child: Column( mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: MyTheme.primary_Colour,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(color: MyTheme.primary_Colour.withOpacity(0.3), blurRadius: 5, spreadRadius: 1)]
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Image.asset(Images.profile, height: 80, width: MediaQuery.of(context).size.width/4, fit: BoxFit.scaleDown,),
                          SizedBox(height: 2),
                          Container(
                              height: 10,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: MyTheme.primary_Colour.withOpacity(0.2),
                                  boxShadow: [BoxShadow(color: MyTheme.primary_Colour.withOpacity(0.3), blurRadius: 10, spreadRadius: 1)]
                              ))
                        ],
                      ),
                    ),
                    Container(
                      padding:  EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                      decoration: BoxDecoration(
                          color: ColorResources.getPrimaryColor(context),
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
                          boxShadow: [BoxShadow(color: MyTheme.primary_Colour.withOpacity(0.3), blurRadius: 5, spreadRadius: 1)]
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(widget.name,
                            style: SFSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: ColorResources.getBackgroundColor(context)),
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: RatingBar(
                                rating: 4,
                                size: 16,
                              ),
                            ),
                            Text(
                              '\$${widget.main_price} - \$${widget.main_price}',
                              style: SFBold.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.getBackgroundColor(context)),  maxLines: 1, overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ]),
                    ),

                  ]),
                ),
                Positioned(
                  right: -8,
                  top: -8,
                  child: Row(
                    children: [
                      Text('1h.30m.12s', style: SFSemiBold.copyWith(color: ColorResources.getPrimaryColor(context), fontSize: Dimensions.FONT_SIZE_LARGE)),
                      SizedBox(width: 5,),
                      Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorResources.getPrimaryColor(context)
                          ),
                          child: Icon(Icons.person_add_alt_1, color: ColorResources.getBackgroundColor(context),))
                    ],
                  ),
                )
              ],
            ),
          ],
        )
        )
    );
/*
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetails(id: widget.id,);
        }));
      },
      child: Card(
         //clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          side: new BorderSide(color: MyTheme.light_grey, width: 1.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Container(
                  width: double.infinity,
                  //height: 158,
                  height: (( MediaQuery.of(context).size.width - 28 ) / 2) + 2,
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16), bottom: Radius.zero),
                    */
/*  child: FadeInImage.assetNetwork( //assetNetwork
                        placeholder: 'assets/placeholder.png',
                        image: AppConfig.BASE_PATH + widget.image,
                        fit: BoxFit.cover,
                      )*//*

                   // child: Image.asset(AppConfig.BASE_PATH + widget.image),
                    child: Image.asset(widget.image),
                  )),
              Container(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Text(
                        widget.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: MyTheme.font_grey,
                            fontSize: 14,
                            height: 1.2,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
                      child: Text(
                        widget.main_price,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: MyTheme.accent_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                   widget.has_discount ? Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Text(
                        widget.stroked_price,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          decoration:TextDecoration.lineThrough,
                            color: MyTheme.medium_grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                      ),
                    ):Container(),
                  ],
                ),
              ),
            ]),
      ),
    );
*/
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


