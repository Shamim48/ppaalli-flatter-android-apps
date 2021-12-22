
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintTxt;
  final TextInputType textInputType;
  final int maxLine;
  final FocusNode focusNode;
  final FocusNode nextNode;
  final TextInputAction textInputAction;
  final bool isPhoneNumber;
  final bool isEmail;
  final Function onSaved;
  final bool isAuth;
  final Color fillColor;

  CustomTextField(
      {this.controller,
        this.hintTxt,
        this.textInputType,
        this.maxLine,
        this.focusNode,
        this.nextNode,
        this.textInputAction,
        this.isEmail = false,
        this.isPhoneNumber = false,
        this.onSaved,
        this.isAuth = true,
        this.fillColor});


  @override
  Widget build(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyTheme.white,
        borderRadius: isPhoneNumber ? BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)) : BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 1.5) // changes position of shadow
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLine ?? 1,
        cursorColor: MyTheme.primary_Colour,
        maxLength: isPhoneNumber ? 15 : null,
        focusNode: focusNode,
        keyboardType: textInputType ?? TextInputType.text,
        //keyboardType: TextInputType.number,
        initialValue: null,
        textInputAction: textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(nextNode);
        },
        inputFormatters: [isPhoneNumber ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.singleLineFormatter],
        validator: (input) => isEmail?input.isValidEmail() ? null : 'Please Provide a Valid Email' : null,
        decoration: InputDecoration(
          hintText: hintTxt ?? '',
          filled: fillColor != null,
          fillColor: fillColor,
          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          isDense: true,
          counterText: '',
          // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorResources.getPrimaryColor(context))),
          hintStyle: LatoSemiBold.copyWith(color: MyTheme.dark_grey),
          errorStyle: TextStyle(height: 1.5),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
