
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../my_theme.dart';

TextStyle labelTextFieldStyle(){
  return LatoMedium.copyWith(
      color: MyTheme.black, fontWeight: FontWeight.w800);
}

TextStyle hindTextFieldStyle(){
  return LatoRegular.copyWith(color: MyTheme.grey_153, fontSize: 14);
}

textFieldDecoration({String hindText}){
  return InputDecoration.collapsed(
      hintText: hindText, hintStyle: LatoRegular.copyWith(color: MyTheme.grey_153, fontSize: 14));
}

textFieldContainerDecoration(){
  return BoxDecoration(
      color: MyTheme.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
            color: MyTheme.dark_grey.withOpacity(0.3),
            spreadRadius: 1.5,
            blurRadius: 3
        )
      ]
  );
}

class CommonUi{

}