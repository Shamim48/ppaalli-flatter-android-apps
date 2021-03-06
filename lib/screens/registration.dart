import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/utill/images.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:active_ecommerce_flutter/custom/input_decorations.dart';
import 'package:active_ecommerce_flutter/custom/intl_phone_input.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:active_ecommerce_flutter/addon_config.dart';
import 'package:active_ecommerce_flutter/screens/otp.dart';
import 'package:active_ecommerce_flutter/screens/login.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:active_ecommerce_flutter/repositories/auth_repository.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String _register_by = "email"; //phone or email
  String initialCountry = 'US';
  PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");

  String _phone = "";

  //controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  @override
  void initState() {
    //on Splash Screen hide statusbar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  onPressSignUp() async {
    var name = _nameController.text.toString();
    var email = _emailController.text.toString();
    var password = _passwordController.text.toString();
    var password_confirm = _passwordConfirmController.text.toString();

    if (name == "") {
      ToastComponent.showDialog(AppLocalizations.of(context).registration_screen_name_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    } else if (_register_by == 'email' && email == "") {
      ToastComponent.showDialog(AppLocalizations.of(context).registration_screen_email_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    } else if (_register_by == 'phone' && _phone == "") {
      ToastComponent.showDialog(AppLocalizations.of(context).registration_screen_phone_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    } else if (password == "") {
      ToastComponent.showDialog(AppLocalizations.of(context).registration_screen_password_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    } else if (password_confirm == "") {
      ToastComponent.showDialog(AppLocalizations.of(context).registration_screen_password_confirm_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    } else if (password.length < 6) {
      ToastComponent.showDialog(
          AppLocalizations.of(context).registration_screen_password_length_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    } else if (password != password_confirm) {
      ToastComponent.showDialog(AppLocalizations.of(context).registration_screen_password_match_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }

    var signupResponse = await AuthRepository().getSignupResponse(
        name,
        _register_by == 'email' ? email : _phone,
        password,
        password_confirm,
        _register_by);

    if (signupResponse.result == false) {
      ToastComponent.showDialog(signupResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      ToastComponent.showDialog(signupResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Otp(
          verify_by: _register_by,
          user_id: signupResponse.user_id,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            /*Container(
              width: _screen_width * (3 / 4),
              child: Image.asset(
                  "assets/splash_login_registration_background_image.png"),
            ),*/
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 15),
                    child: Container(
                      width: 120,
                      height: 40,
                      child:
                          Image.asset(Images.logo),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "REGISTER",
                      style: LatoHeavy.copyWith(fontSize: 20),
                    ),
                  ),
                  Container(
                    width: _screen_width * (3 / 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            AppLocalizations.of(context).registration_screen_name,
                            style: LatoBold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            height: 42,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                                color: MyTheme.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: MyTheme.dark_grey.withOpacity(0.3),
                                      spreadRadius: 1.5,
                                      blurRadius: 3
                                  )
                                ]
                            ),
                            child: TextField(
                              controller: _nameController,
                              autofocus: false,
                              /*decoration: InputDecorations.buildInputDecoration_1(
                                  hint_text: "Type Your name"),*/
                                decoration: new InputDecoration.collapsed(
                                  hintText:
                                  "Type your name", hintStyle: TextStyle(color: MyTheme.grey_153)
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            _register_by == "email" ? AppLocalizations.of(context).registration_screen_email : AppLocalizations.of(context).registration_screen_phone,
                            style: LatoBold,
                          ),
                        ),
                        if (_register_by == "email")
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 42,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: MyTheme.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: MyTheme.dark_grey.withOpacity(0.3),
                                            spreadRadius: 1.5,
                                            blurRadius: 3
                                        )
                                      ]
                                  ),
                                  child: TextField(
                                    controller: _emailController,
                                    autofocus: false,
                                    decoration:
                                        InputDecoration.collapsed(
                                            hintText: "Type your email", hintStyle: TextStyle(color: MyTheme.grey_153, fontSize: 14)),
                                  ),
                                ),
                                AddonConfig.otp_addon_installed
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _register_by = "phone";
                                          });
                                        },
                                        child: Text(
                                          AppLocalizations.of(context).registration_screen_or_register_with_phone,
                                          style: TextStyle(
                                              color: MyTheme.black,
                                              fontStyle: FontStyle.italic,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 42,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: MyTheme.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: MyTheme.dark_grey.withOpacity(0.3),
                                            spreadRadius: 1.5,
                                            blurRadius: 3
                                        )
                                      ]
                                  ),
                                  child: CustomInternationalPhoneNumberInput(
                                    onInputChanged: (PhoneNumber number) {
                                      print(number.phoneNumber);
                                      setState(() {
                                        _phone = number.phoneNumber;
                                      });
                                    },
                                    onInputValidated: (bool value) {
                                      print(value);
                                    },
                                    selectorConfig: SelectorConfig(
                                      selectorType: PhoneInputSelectorType.DIALOG,
                                    ),
                                    ignoreBlank: false,
                                    autoValidateMode: AutovalidateMode.disabled,
                                    selectorTextStyle:
                                        TextStyle(color: MyTheme.font_grey),
                                    initialValue: phoneCode,
                                    textFieldController: _phoneNumberController,
                                    formatInput: true,
                                    keyboardType: TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                    inputDecoration: InputDecoration.collapsed(
                                            hintText: "01710 333 558", hintStyle: TextStyle(color: MyTheme.grey_153,fontSize: 14)),
                                    onSaved: (PhoneNumber number) {
                                      //print('On Saved: $number');
                                    },
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _register_by = "email";
                                    });
                                  },
                                  child: Text(
                                    AppLocalizations.of(context).registration_screen_or_register_with_email,
                                    style: TextStyle(
                                        color: MyTheme.primaryColor,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline),
                                  ),
                                )
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            "Password",
                            style: LatoBold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 42,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: MyTheme.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: MyTheme.dark_grey.withOpacity(0.3),
                                          spreadRadius: 1.5,
                                          blurRadius: 3
                                      )
                                    ]
                                ),
                                child: TextField(
                                  controller: _passwordController,
                                  autofocus: false,
                                  obscureText: true,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration:
                                      InputDecoration.collapsed(
                                          hintText: "??? ??? ??? ??? ??? ??? ??? ???", hintStyle: TextStyle(color: MyTheme.grey_153, fontSize: 14)),
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context).registration_screen_password_length_recommendation,
                                style: LatoRegular.copyWith(
                                    color: MyTheme.primary_Colour,
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            AppLocalizations.of(context).registration_screen_retype_password,
                            style: LatoBold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            height: 42,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                                color: MyTheme.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: MyTheme.dark_grey.withOpacity(0.3),
                                      spreadRadius: 1.5,
                                      blurRadius: 3
                                  )
                                ]
                            ),
                            child: TextField(
                              controller: _passwordConfirmController,
                              autofocus: false,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration.collapsed(
                                  hintText: "??? ??? ??? ??? ??? ??? ??? ???", hintStyle: LatoRegular.copyWith(color: MyTheme.grey_153, fontSize: 14)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Center(
                            child: Container(

                              height: 40,
                              width: 180,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: MyTheme.dark_grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    // changes position of shadow
                                  ),
                                ],
                              ),

                              child: FlatButton(
                                minWidth: MediaQuery.of(context).size.width,
                                //height: 50,
                                color: MyTheme.primary_Colour,
                                shape: RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0))),
                                child: Text(
                                  "Create Account",
                                  style: LatoHeavy.copyWith(color: MyTheme.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  onPressSignUp();
                                },
                              ),
                            ),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                              child: Text(
                                AppLocalizations.of(context).registration_screen_already_have_account,
                            style: LatoBold,
                          )),
                        ),

                       Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                              child: InkWell(
                                child: Text(
                                  AppLocalizations.of(context).registration_screen_log_in,
                                  style: LatoBold.copyWith(color: MyTheme.primary_Colour, fontSize: 20),
                                ),
                              )),
                        ),


                       /* Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyTheme.textfield_grey, width: 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0))),
                            child: FlatButton(
                              minWidth: MediaQuery.of(context).size.width,
                              //height: 50,
                              color: MyTheme.golden,
                              shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0))),
                              child: Text(
                                AppLocalizations.of(context).registration_screen_log_in,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Login();
                                }));
                              },
                            ),
                          ),
                        )*/
                      ],
                    ),
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
