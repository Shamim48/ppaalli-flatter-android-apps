import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/screens/product_details.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MiniProductCard extends StatefulWidget {
  int id;
  String image;
  String name;
  String main_price;
  String stroked_price;
  int rating;

  MiniProductCard({Key key, this.id, this.image, this.name, this.main_price,this.stroked_price, this.rating})
      : super(key: key);

  @override
  _MiniProductCardState createState() => _MiniProductCardState();
}

class _MiniProductCardState extends State<MiniProductCard> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return ProductDetails(
                    id: widget.id,
                  );
                }));
          },
          child: Container(
            // clipBehavior: Clip.antiAlias,
              height: 120,
              width: 130,
              decoration: BoxDecoration(
                // color: MyTheme.primary_Colour,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: MyTheme.primary_Colour.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 130,
                        height: 80,
                        color: MyTheme.white,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.png',
                            image: AppConfig.BASE_PATH +
                                widget.image,
                            fit: BoxFit.scaleDown,
                            height: 60,
                            width: 130,
                          ),
                        )),

                    /*ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                    bottom: Radius.zero),
                                )),*/
                    Flexible(
                        child: Container(
                            width: 130,
                            height: 40,
                            color: MyTheme.primary_Colour,
                            child: Column(
                              children: [
                                Flexible(
                                    child: Text(
                                      widget.name,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: MyTheme.white),
                                    )),
                                Row(
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
                                          rating:widget.rating.toDouble(),
                                          itemBuilder:
                                              (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.white,
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
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: MyTheme.white),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )))
                  ],
                ),
              ))),
    );

/*
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetails(id: widget.id);
        }));
      },
      child: Card(
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
                  height: (MediaQuery.of(context).size.width - 36) / 3.5,
                  child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16), bottom: Radius.zero),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image: AppConfig.BASE_PATH + widget.image,
                        fit: BoxFit.cover,
                      ))),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                child: Text(
                  widget.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: MyTheme.font_grey,
                      fontSize: 11,
                      height: 1.2,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  widget.main_price,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: MyTheme.primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600),
                ),
              ),
             */
/* widget.has_discount ? Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  widget.stroked_price,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      decoration:TextDecoration.lineThrough,
                      color: MyTheme.medium_grey,
                      fontSize: 9,
                      fontWeight: FontWeight.w600),
                ),
              ):Container(),*//*

            ]),
      ),
    );
*/
  }
}
