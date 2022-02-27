import 'package:active_ecommerce_flutter/data_model/university.dart';
import 'package:active_ecommerce_flutter/screens/login.dart';
import 'package:active_ecommerce_flutter/utill/custom_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/utill/images.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:active_ecommerce_flutter/custom/intl_phone_input.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:active_ecommerce_flutter/addon_config.dart';
import 'package:active_ecommerce_flutter/screens/otp.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:active_ecommerce_flutter/repositories/auth_repository.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StudentReg extends StatefulWidget {
  const StudentReg({Key key}) : super(key: key);

  @override
  _StudentRegState createState() => _StudentRegState();
}

class _StudentRegState extends State<StudentReg> {
  String _register_by = "email"; //phone or email
  String initialCountry = 'US';
  PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");

  String _phone = "";

  //controllers
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _studentIdController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  bool _isUniversityInitial=true;

  List<UniversityData> _universityList=[];

  int universityIndex=0;

  String day;
  String month ;
  String year;

  @override
  void initState() {
    //on Splash Screen hide statusbar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
    fetchUniversity();
  }


  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  fetchUniversity() async {
    var universityResponse = await AuthRepository().getUniversityResponse();
    _universityList.addAll(universityResponse.data);
    _isUniversityInitial = false;
    setState(() {});
  }

  onPressSignUp() async {
    var firstName = _firstNameController.text.toString();
    var lasName = _lastNameController.text.toString();
    var phone = _phoneController.text.toString();
    var studentId = _studentIdController.text.toString();
    var email = _emailController.text.toString();
    var password = _passwordController.text.toString();
    var password_confirm = _passwordConfirmController.text.toString();

    if (firstName == "") {
      ToastComponent.showDialog(AppLocalizations.of(context).registration_screen_name_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    } else if (email == "") {
      ToastComponent.showDialog(AppLocalizations.of(context).registration_screen_email_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }else if (phone == "") {
      ToastComponent.showDialog(AppLocalizations.of(context).registration_screen_phone_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }else if (studentId == "") {
      ToastComponent.showDialog("Please Enter Student ID.", context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }else if (password == "") {
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

    var signupResponse = await AuthRepository().getStudentSignupResponse(

        firstName:firstName,
        lastName: lasName,
        email: email,
        phone: phone,
        studentId: studentId,
        universityId: _universityList[universityIndex].id,
        register_by: 'email' ,
        dateOfBirth: "${day}-${month}-${year}",
        password : password,
        );

    if (signupResponse.result == false) {
      ToastComponent.showDialog(signupResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      ToastComponent.showDialog(signupResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
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
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          "STUDENT REGISTER",
                          style: LatoHeavy.copyWith(fontSize: 18),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Select Student Program",
                          style: LatoHeavy.copyWith(fontSize: 18),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "Please ensure you Enter valid credentials.\n This information will be sent to \n Share ID for verification.",
                          style: LatoMedium.copyWith(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),


                      Container(
                        width: _screen_width * (3 / 3.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width/2.5,
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 4.0),
                                          child: Text(
                                            "First Name",
                                            style: LatoBold,
                                            textAlign: TextAlign.start,
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
                                                controller: _firstNameController,
                                                autofocus: false,

                                                decoration: new InputDecoration.collapsed(
                                                    hintText:
                                                    "Type your first name", hintStyle: TextStyle(color: MyTheme.grey_153)
                                                )
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/2.5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 4.0),
                                          child: Text(
                                            "Last Name",
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
                                                controller: _lastNameController,
                                                autofocus: false,

                                                decoration: new InputDecoration.collapsed(
                                                    hintText:
                                                    "Type your last name", hintStyle: TextStyle(color: MyTheme.grey_153)
                                                )
                                            ),

                                          ),
                                        ),
                                      ],
                                    ),
                                  )

                                ],
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
                                "Phone",
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
                                      controller: _phoneController,
                                      autofocus: false,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      decoration:
                                      InputDecoration.collapsed(
                                          hintText: "Type your phone number", hintStyle: TextStyle(color: MyTheme.grey_153, fontSize: 14)),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                "Select University",
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
                                    child: _isUniversityInitial ? Container() :  DropdownButton<UniversityData>(
                                      underline: SizedBox(),
                                      isExpanded: true,
                                      hint: Text('Select University', style: SFRegular),
                                      value:  _universityList[universityIndex],
                                      items: _universityList.map((UniversityData universityData) {
                                        return DropdownMenuItem<UniversityData>(
                                          value: universityData,
                                          child: Text(universityData.name, style: SFRegular, overflow: TextOverflow.ellipsis),
                                        );
                                      }).toList(),
                                      onChanged: (UniversityData universityData) {
                                        int index = _universityList.indexOf(universityData);
                                        setState(() {
                                          universityIndex=index;
                                        });

                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                "Student ID",
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
                                      controller: _studentIdController,
                                      autofocus: false,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      decoration:
                                      InputDecoration.collapsed(
                                          hintText: "Type Your student Id", hintStyle: TextStyle(color: MyTheme.grey_153, fontSize: 14)),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 4.0),
                                        child: Text(
                                          "Day",
                                          style: LatoBold,
                                        ),
                                      ),
                                      Container(
                                        height: 38,
                                        width: MediaQuery.of(context).size.width/4,
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
                                        child: DropdownButton<String>(
                                          underline: SizedBox(),
                                          isExpanded: true,
                                          hint: Text('Select Day', style: SFRegular),
                                          value:  day,
                                          items: dayList.map((String day) {
                                            return DropdownMenuItem<String>(
                                              value: day,
                                              child: Text(day, style: SFRegular, overflow: TextOverflow.ellipsis),
                                            );
                                          }).toList(),
                                          onChanged: (String dayValue) {
                                            setState(() {
                                              day=dayValue;
                                            });

                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 4.0),
                                        child: Text(
                                          "Month",
                                          style: LatoBold,
                                        ),
                                      ),
                                      Container(
                                        height: 38,
                                        width: MediaQuery.of(context).size.width/4,
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
                                        child: DropdownButton<String>(
                                          underline: SizedBox(),
                                          isExpanded: true,
                                          hint: Text('Select Month', style: SFRegular),
                                          value:  month,
                                          items: monthList.map((String month) {
                                            return DropdownMenuItem<String>(
                                              value: month,
                                              child: Text(month, style: SFRegular, overflow: TextOverflow.ellipsis),
                                            );
                                          }).toList(),
                                          onChanged: (String monthValue) {
                                            setState(() {
                                              month=monthValue;
                                            });

                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 4.0),
                                        child: Text(
                                          "Year",
                                          style: LatoBold,
                                        ),
                                      ),
                                      Container(
                                        height: 38,
                                        width: MediaQuery.of(context).size.width/4,
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
                                        child: DropdownButton<String>(
                                          underline: SizedBox(),
                                          isExpanded: true,
                                          hint: Text('Select Year', style: SFRegular),
                                          value:  year,
                                          items: yearList.map((String year) {
                                            return DropdownMenuItem<String>(
                                              value: year,
                                              child: Text(year, style: SFRegular, overflow: TextOverflow.ellipsis),
                                            );
                                          }).toList(),
                                          onChanged: (String yearValue) {
                                            setState(() {
                                              year=yearValue;
                                            });

                                          },
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),


                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width/2.5,
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

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
                                                      hintText: "• • • • • • • •", hintStyle: TextStyle(color: MyTheme.grey_153, fontSize: 14)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/2.5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                                  hintText: "• • • • • • • •", hintStyle: LatoRegular.copyWith(color: MyTheme.grey_153, fontSize: 14)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0, top: 20),
                              child: Text(
                                "By clicking bellow,I agree to the Ppaalli Select \n Student program terms and condition and that  \n Group may share this info with share ID , Inc for \n Verification Service",
                                style: LatoRegular,
                                textAlign: TextAlign.center,
                              ),
                            ),


                            Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Center(
                                  child: Container(

                                    height: 40,
                                    width: 250,
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
                                        "Verify And Continue",
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
