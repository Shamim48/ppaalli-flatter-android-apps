import 'dart:convert';

import 'package:active_ecommerce_flutter/addon_config.dart';
import 'package:active_ecommerce_flutter/custom/intl_phone_input.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/helpers/auth_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/other_config.dart';
import 'package:active_ecommerce_flutter/repositories/auth_repository.dart';
import 'package:active_ecommerce_flutter/repositories/profile_repository.dart';
import 'package:active_ecommerce_flutter/screens/main.dart';
import 'package:active_ecommerce_flutter/screens/password_forget.dart';
import 'package:active_ecommerce_flutter/screens/registration.dart';
import 'package:active_ecommerce_flutter/screens/student_reg.dart';
import 'package:active_ecommerce_flutter/social_config.dart';
import 'package:active_ecommerce_flutter/utill/images.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _login_by = "email"; //phone or email
  String initialCountry = 'US';
  PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");
  String _phone = "";

  //controllers
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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

  onPressedLogin() async {
    var email = _emailController.text.toString();
    var password = _passwordController.text.toString();

    if (_login_by == 'email' && email == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).login_screen_email_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    } else if (_login_by == 'phone' && _phone == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).login_screen_phone_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    } else if (password == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context).login_screen_password_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }

    var loginResponse = await AuthRepository()
        .getLoginResponse(_login_by == 'email' ? email : _phone, password);

    if (loginResponse.result == false) {
      ToastComponent.showDialog(loginResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      ToastComponent.showDialog(loginResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      AuthHelper().setUserData(loginResponse);

      // push notification starts
      if (OtherConfig.USE_PUSH_NOTIFICATION) {
        final FirebaseMessaging _fcm = FirebaseMessaging.instance;

        await _fcm.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );

        String fcmToken = await _fcm.getToken();

        if (fcmToken != null) {
          print("--fcm token--");
          print(fcmToken);
          if (is_logged_in.$ == true) {
            // update device token
            var deviceTokenUpdateResponse = await ProfileRepository()
                .getDeviceTokenUpdateResponse(fcmToken);
          }
        }
      }

      //push norification ends

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Main();
      }));
    }
  }

/*
  onPressedFacebookLogin() async {
    final facebookLogin = FacebookLogin();
    final facebookLoginResult = await facebookLogin.logIn(['email']);

    */
/*print(facebookLoginResult.accessToken);
    print(facebookLoginResult.accessToken.token);
    print(facebookLoginResult.accessToken.expires);
    print(facebookLoginResult.accessToken.permissions);
    print(facebookLoginResult.accessToken.userId);
    print(facebookLoginResult.accessToken.isValid());

    print(facebookLoginResult.errorMessage);
    print(facebookLoginResult.status);*//*


    final token = facebookLoginResult.accessToken.token;

    /// for profile details also use the below code
    Uri url = Uri.parse(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
    final graphResponse = await http.get(url);
    final profile = json.decode(graphResponse.body);
    //print(profile);
    */
/*from profile you will get the below params
    {
     "name": "Iiro Krankka",
     "first_name": "Iiro",
     "last_name": "Krankka",
     "email": "iiro.krankka\u0040gmail.com",
     "id": "<user id here>"
    }*//*


    var loginResponse = await AuthRepository().getSocialLoginResponse(
        profile['name'], profile['email'], profile['id'].toString());

    if (loginResponse.result == false) {
      ToastComponent.showDialog(loginResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      ToastComponent.showDialog(loginResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      AuthHelper().setUserData(loginResponse);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Main();
      }));
    }
  }
*/

  onPressedGoogleLogin() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        // you can add extras if you require
      ],
    );

    _googleSignIn.signIn().then((GoogleSignInAccount acc) async {
      GoogleSignInAuthentication auth = await acc.authentication;
      print(acc.id);
      print(acc.email);
      print(acc.displayName);
      print(acc.photoUrl);

      acc.authentication.then((GoogleSignInAuthentication auth) async {
        print(auth.idToken);
        print(auth.accessToken);

        //---------------------------------------------------
        var loginResponse = await AuthRepository().getSocialLoginResponse(
            acc.displayName, acc.email, auth.accessToken);

        if (loginResponse.result == false) {
          ToastComponent.showDialog(loginResponse.message, context,
              gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        } else {
          ToastComponent.showDialog(loginResponse.message, context,
              gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
          AuthHelper().setUserData(loginResponse);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Main();
          }));
        }

        //-----------------------------------
      });
    });
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
          /*  Container(
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
                    padding: const EdgeInsets.only(top: 40.0,),
                    child: Container(
                      width: 120,
                      height: 40,
                      child: Image.asset(Images.logo),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Text(
                      "${AppLocalizations.of(context).login_screen_log_in} ",
                      style: LatoHeavy.copyWith(fontSize: 22),
                    ),
                  ),
                  Container(
                    width: _screen_width * (3 / 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Text(
                            _login_by == "email"
                                ? "Email/Phone"
                                : AppLocalizations.of(context)
                                    .login_screen_phone,
                            style: LatoBold,
                          ),
                        ),
                        if (_login_by == "email")
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 45,
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

                                    decoration: new InputDecoration.collapsed(
                                      hintText:
                                      "Type your Email / Phone",hintStyle: TextStyle(color: MyTheme.grey_153, fontSize: 14)
                                    )
                                        /*InputDecorations.buildInputDecoration_1(
                                            hint_text:
                                                "Type your Email / Phone"),*/
                                  ),
                                ),
                                AddonConfig.otp_addon_installed
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _login_by = "phone";
                                          });
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .login_screen_or_login_with_phone,
                                          style: TextStyle(
                                              color: MyTheme.primaryColor,
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
                                  height: 36,
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
                                      selectorType:
                                          PhoneInputSelectorType.DIALOG,
                                    ),
                                    ignoreBlank: false,
                                    autoValidateMode: AutovalidateMode.disabled,
                                    selectorTextStyle:
                                        TextStyle(color: MyTheme.font_grey),
                                    textStyle:
                                        TextStyle(color: MyTheme.font_grey),
                                    initialValue: phoneCode,
                                    textFieldController: _phoneNumberController,
                                    formatInput: true,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    inputDecoration: InputDecoration.collapsed(
                                            hintText: "01710 333 558", hintStyle: TextStyle(color: MyTheme.grey_153, fontSize: 14)),
                                    onSaved: (PhoneNumber number) {
                                      print('On Saved: $number');
                                    },
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _login_by = "email";
                                    });
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .login_screen_or_login_with_email,
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
                          padding: const EdgeInsets.only(bottom: 15.0,top: 5),
                          child: Text(
                            "Password",
                            style: LatoBold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 45,
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                alignment: Alignment.centerLeft,
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
                                    decoration: new InputDecoration.collapsed(
                                      hintText:
                                      "Type your password ", hintStyle: TextStyle(color: MyTheme.grey_153, fontSize: 14)

                                    )
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return PasswordForget();
                                  }));
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .login_screen_forgot_password,
                                  style: TextStyle(
                                      color: MyTheme.primary_Colour,
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Center(
                            child: Container(
                              height: 35,
                              width: 100,
                              alignment: Alignment.center,

                              decoration: BoxDecoration(
                                color: MyTheme.primary_Colour,
                                /*border: Border.all(
                                    color: MyTheme.textfield_grey, width: 1),*/
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: MyTheme.dark_grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    // changes position of shadow
                                  ),
                                ],
                              ),
                              child: FlatButton(
                                minWidth: MediaQuery.of(context).size.width,
                                //height: 50,
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800),
                                ),
                                onPressed: () {
                                  onPressedLogin();
                                },
                              ),
                            ),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                              child: Text(
                            "Don't Have an account?",
                            style: LatoMedium,
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Create A ",
                                style: LatoBold,
                              ),
                              Text(
                                " New Account ",
                                style: LatoBold.copyWith(
                                    color: MyTheme.primary_Colour),
                              ),
                            ],
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Student ",
                                style: LatoBold,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return StudentReg();
                                  }));
                                },
                                child: Text(
                                  " Registration ",
                                  style: LatoBold.copyWith(
                                      color: MyTheme.primary_Colour),
                                ),
                              )
                            ],
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
                              color: MyTheme.primary_Colour,
                              shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0))),
                              child: Text(
                                AppLocalizations.of(context).login_screen_sign_up,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              onPressed: () {

                              },
                            ),
                          ),
                        ),*/
                        Visibility(
                          visible: SocialConfig.allow_google_login ||
                              SocialConfig.allow_facebook_login,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Center(
                                child: Text(
                              AppLocalizations.of(context)
                                  .login_screen_login_with,
                              style: TextStyle(
                                  color: MyTheme.medium_grey, fontSize: 14),
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Center(
                            child: Container(
                              width: 120,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Visibility(
                                    visible: SocialConfig.allow_google_login,
                                    child: InkWell(
                                      onTap: () {
                                        onPressedGoogleLogin();
                                      },
                                      child: Container(
                                        width: 28,
                                        child: Image.asset(
                                            "assets/google_logo.png"),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: SocialConfig.allow_facebook_login,
                                    child: InkWell(
                                      onTap: () {
                                       // onPressedFacebookLogin();
                                      },
                                      child: Container(
                                        width: 28,
                                        child: Image.asset(
                                            "assets/facebook_logo.png"),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: false,
                                    child: InkWell(
                                      onTap: () {
                                        // onPressedTwitterLogin();
                                      },
                                      child: Container(
                                        width: 28,
                                        child: Image.asset(
                                            "assets/twitter_logo.png"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
