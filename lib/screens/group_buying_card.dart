import 'package:active_ecommerce_flutter/utill/color_resources.dart';
import 'package:active_ecommerce_flutter/utill/dimensions.dart';
import 'package:active_ecommerce_flutter/utill/images.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/material.dart';



class Group_Buying_Card extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
        child: Center(child: Column( mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 5, spreadRadius: 1)]
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
                                  color: Colors.grey[200],
                                  boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 10, spreadRadius: 1)]
                              ))
                        ],
                      ),
                    ),
                    Container(
                      padding:  EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                      decoration: BoxDecoration(
                          color: ColorResources.getPrimaryColor(context),
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
                          boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 5, spreadRadius: 1)]
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Name',
                            style: SFSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: ColorResources.getBackgroundColor(context)),
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: RatingBar_(
                                rating: 4.5,
                                size: 16,
                              ),
                            ),
                            Text(
                              '\$${6000} - \$${3000}',
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
    )
    );
  }
}

 class RatingBar_ extends StatelessWidget {
  final double rating;
  final double size;

  RatingBar_({@required this.rating, this.size = 18});

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

