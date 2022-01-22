import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/utill/images.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Congratulations extends StatefulWidget {
  const Congratulations({Key key}) : super(key: key);

  @override
  _CongratulationsState createState() => _CongratulationsState();
}

class _CongratulationsState extends State<Congratulations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(Images.logo, width: 250,),
              SizedBox(height: 40,),
              Container(
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    Image.asset(Images.congress, width: double.infinity,),
                    Positioned(
                      left: 50,
                      right: 50,
                      bottom: 0,
                      child: Center(
                        child: Image.asset(Images.complete, color: MyTheme.primary_Colour, height: 90, width: 90,),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Text("Congratulations", style:  LatoMedium.copyWith(color: MyTheme.primary_Colour, fontSize: 22),),
              SizedBox(height: 30,),
              Text("Complete Your", style:  LatoBold.copyWith(color: MyTheme.primary_Colour, fontSize: 22),),
              Text("Order", style:  LatoBold.copyWith(color: MyTheme.primary_Colour, fontSize: 22),),
              SizedBox(height: 50,),

              Container(
                height: 40,
                width: 200,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: MyTheme.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: MyTheme.dark_grey.withOpacity(0.3),
                          spreadRadius: 1.5,
                          blurRadius: 3
                      )
                    ]
                ),
                child: Center(child: Text("Brows Product", style: LatoHeavy.copyWith(color: MyTheme.primary_Colour, fontSize: 20),))
              ),





            ],
          ),
        ));
  }
}
