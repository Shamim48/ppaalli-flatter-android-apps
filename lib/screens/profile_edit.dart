import 'package:active_ecommerce_flutter/screens/profile.dart';
import 'package:active_ecommerce_flutter/ui_elements/common_ui_element.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'package:active_ecommerce_flutter/custom/input_decorations.dart';
import 'package:active_ecommerce_flutter/repositories/profile_repository.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:active_ecommerce_flutter/helpers/file_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  ScrollController _mainScrollController = ScrollController();

  TextEditingController _nameController =
      TextEditingController(text: "${user_name.$}");
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  //for image uploading
  final ImagePicker _picker = ImagePicker();
  XFile _file;

  chooseAndUploadImage(context) async {
    var status = await Permission.photos.request();

    if (status.isDenied) {
      // We didn't ask for permission yet.
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text(AppLocalizations.of(context).common_photo_permission),
                content: Text(
                    AppLocalizations.of(context).common_app_needs_permission),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(AppLocalizations.of(context).common_deny),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    child: Text(AppLocalizations.of(context).common_settings),
                    onPressed: () => openAppSettings(),
                  ),
                ],
              ));
    } else if (status.isRestricted) {
      ToastComponent.showDialog(
          AppLocalizations.of(context).common_give_photo_permission,
          context,
          gravity: Toast.CENTER,
          duration: Toast.LENGTH_LONG);
    } else if (status.isGranted) {
      //file = await ImagePicker.pickImage(source: ImageSource.camera);
      _file = await _picker.pickImage(source: ImageSource.gallery);

      if (_file == null) {
        ToastComponent.showDialog(AppLocalizations.of(context).common_no_file_chosen, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        return;
      }

      //return;
      String base64Image = FileHelper.getBase64FormateFile(_file.path);
      String fileName = _file.path.split("/").last;

      var profileImageUpdateResponse =
          await ProfileRepository().getProfileImageUpdateResponse(
        base64Image,
        fileName,
      );

      if (profileImageUpdateResponse.result == false) {
        ToastComponent.showDialog(profileImageUpdateResponse.message, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
        return;
      } else {
        ToastComponent.showDialog(profileImageUpdateResponse.message, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

        avatar_original.$ = profileImageUpdateResponse.path;
        setState(() {});
      }
    }
  }

  Future<void> _onPageRefresh() async {}

  onPressUpdate() async {
    var name = _nameController.text.toString();
    var password = _passwordController.text.toString();
    var password_confirm = _passwordConfirmController.text.toString();

    var change_password = password != "" ||
        password_confirm !=
            ""; // if both fields are empty we will not change user's password

    if (name == "") {
      ToastComponent.showDialog(AppLocalizations.of(context).profile_edit_screen_name_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }
    if (change_password && password == "") {
      ToastComponent.showDialog(AppLocalizations.of(context).profile_edit_screen_password_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }
    if (change_password && password_confirm == "") {
      ToastComponent.showDialog(AppLocalizations.of(context).profile_edit_screen_password_confirm_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }
    if (change_password && password.length < 6) {
      ToastComponent.showDialog(
          AppLocalizations.of(context).password_otp_screen_password_length_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }
    if (change_password && password != password_confirm) {
      ToastComponent.showDialog(AppLocalizations.of(context).profile_edit_screen_password_match_warning, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      return;
    }

    var profileUpdateResponse =
        await ProfileRepository().getProfileUpdateResponse(
      name,
      change_password ? password : "",
    );

    if (profileUpdateResponse.result == false) {
      ToastComponent.showDialog(profileUpdateResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      ToastComponent.showDialog(profileUpdateResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Profile()), (route) => false);

      user_name.$ = name;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: buildBody(context),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
backgroundColor: Colors.white,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back, color: MyTheme.primary_Colour, size: 30,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        AppLocalizations.of(context).profile_edit_screen_edit_profile,
        style: LatoHeavy.copyWith(fontSize: 20, color: MyTheme.primaryColor),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  buildBody(context) {
    if (is_logged_in.$ == false) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                AppLocalizations.of(context).profile_edit_screen_login_warning,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      return RefreshIndicator(
        color: MyTheme.primaryColor,
        backgroundColor: Colors.white,
        onRefresh: _onPageRefresh,
        displacement: 10,
        child: CustomScrollView(
          controller: _mainScrollController,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                buildTopSection(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    height: 24,
                  ),
                ),
                buildProfileForm(context)
              ]),
            )
          ],
        ),
      );
    }
  }

  buildTopSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      color: MyTheme.primary_Colour, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: MyTheme.primary_Colour.withOpacity(0.3),
                      blurRadius: 7,
                      spreadRadius: 7,
                    )
                  ]
                  //shape: BoxShape.rectangle,
                ),
                child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/placeholder.png',
                      image: AppConfig.BASE_PATH + "${avatar_original.$}",
                      fit: BoxFit.fill,
                    )),
              ),
              Positioned(
                right: 1,
                bottom: 60,
                top: 5,
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Icon(
                      Icons.edit,
                      color: MyTheme.white,
                      size: 20,
                    ),
                    shape: CircleBorder(
                      side:
                          new BorderSide(color: MyTheme.white, width: 2.0),
                    ),
                    color: MyTheme.primary_Colour,
                    onPressed: () {
                      chooseAndUploadImage(context);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  buildProfileForm(context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                AppLocalizations.of(context).profile_edit_screen_basic_information,
                style: LatoBold.copyWith(
                    color: MyTheme.grey_153,
                    fontWeight: FontWeight.w800,
                    fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                AppLocalizations.of(context).profile_edit_screen_name,
                style: labelTextFieldStyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                height: 42,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: textFieldContainerDecoration(),
                child: TextField(
                  controller: _nameController,
                  autofocus: false,
                  decoration: textFieldDecoration(hindText: "User Name"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                AppLocalizations.of(context).profile_edit_screen_password,
                style: labelTextFieldStyle(),
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: textFieldContainerDecoration(),
                    child: TextField(
                      controller: _passwordController,
                      autofocus: false,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: textFieldDecoration(hindText: "• • • • • • • •")
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).profile_edit_screen_password_length_recommendation,
                    style: LatoRegular.copyWith(
                        color: MyTheme.primary_Colour,
                        fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                  AppLocalizations.of(context).profile_edit_screen_retype_password,
                style: labelTextFieldStyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                height: 42,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: textFieldContainerDecoration(),
                child: TextField(
                  controller: _passwordConfirmController,
                  autofocus: false,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: textFieldDecoration(hindText: "• • • • • • • •")
                ),
              ),
            ),
            Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: MyTheme.textfield_grey, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30.0))),
                    child: FlatButton(
                      minWidth: MediaQuery.of(context).size.width,
                      //height: 50,
                      color: MyTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30.0))),
                      child: Text(
                        AppLocalizations.of(context).profile_edit_screen_btn_update_profile,
                        style: LatoBold.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        onPressUpdate();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
