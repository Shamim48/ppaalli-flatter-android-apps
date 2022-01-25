import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/screens/product_details.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListProductCard extends StatefulWidget {
  int id;
  String image;
  String name;
  String main_price;
  int rating;

  ListProductCard({Key key, this.id, this.image, this.name, this.main_price,this.rating,})
      : super(key: key);

  @override
  _ListProductCardState createState() => _ListProductCardState();
}

class _ListProductCardState extends State<ListProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetails(
            id: widget.id,
          );
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: new BorderSide(color: MyTheme.light_grey, width: 1.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Container(
              width: 100,
              height: 100,
              child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(16), right: Radius.zero),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    image: AppConfig.BASE_PATH + widget.image,
                    fit: BoxFit.cover,
                  ))),
          Container(
            width: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Text(
                    widget.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: LatoBold.copyWith(
                        color: MyTheme.font_grey,
                        fontSize: 18,
                        height: 1.6,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Text(
                    widget.main_price,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: LatoBold.copyWith(
                        color: MyTheme.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: RatingBar(
                    itemSize: 16.0,
                    ignoreGestures: true,
                    initialRating:
                    double.parse(widget.rating.toString()),
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                      full: Icon(FontAwesome.star, color: Colors.amber),
                      empty:
                      Icon(FontAwesome.star, color: Color.fromRGBO(224, 224, 225, 1)),
                    ),
                    itemPadding: EdgeInsets.only(right: 1.0),
                    onRatingUpdate: (rating) {
                      //print(rating);
                    },
                  ),
                ),

               /* widget.has_discount?Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Text(
                    widget.stroked_price,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        decoration:TextDecoration.lineThrough,
                        color: MyTheme.medium_grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ):Container(),*/
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
