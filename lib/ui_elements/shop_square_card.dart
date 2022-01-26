import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/screens/seller_details.dart';

class ShopSquareCard extends StatefulWidget {
  int id;
  String image;
  String name;

  ShopSquareCard({Key key,this.id, this.image, this.name}) : super(key: key);

  @override
  _ShopSquareCardState createState() => _ShopSquareCardState();
}

class _ShopSquareCardState extends State<ShopSquareCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SellerDetails(id: widget.id,);
        }));
      },
      child: Container(
        /*shape: RoundedRectangleBorder(
          side: new BorderSide(color: MyTheme.light_grey, width: 1.0),
          borderRadius: BorderRadius.circular(16.0),
        ),*/
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  width: 130,
                  height: 130,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: MyTheme.white,
                    boxShadow: [
                      BoxShadow(
                        color: MyTheme.dark_grey.withOpacity(0.3),
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(2,2)
                      )
                    ]
                  ),

                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image: AppConfig.BASE_PATH + widget.image,
                        fit: BoxFit.scaleDown,
                      ))),
              Container(
                height: 40,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Text(
                    widget.name,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: LatoBold.copyWith(
                        color: MyTheme.font_grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
