import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:thebarber/screens/customerside/categoryscreen.dart';
import 'package:thebarber/screens/customerside/registerScreen.dart';
import 'package:thebarber/screens/serivesProviderScreen/createserices.dart';
import 'package:thebarber/screens/serivesProviderScreen/homebottom.dart';
import '../../constant/appconstant.dart';
import '../../constant/color_constant.dart';
import '../../constant/constant_font.dart';
import '../../constant/dymmyimages.dart';
import '../../constant/preferenceutils.dart';
import '../../constant/string_constant.dart';
import 'package:email_validator/email_validator.dart';

import 'forgotpassword.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => new _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  FocusNode? myFocusNode;
  String? _email, _password = "";
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      opacity: 1.0,
      color: Colors.transparent.withOpacity(0.2),
      progressIndicator: SpinKitFadingCircle(color: pinkColor),
      child: Form(
        key: _formKey,
        child: SafeArea(
          child: Scaffold(
            body: Stack(children: <Widget>[
              Container(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: whiteColor.withOpacity(0.0)),
                  ),
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(DummyImage.loginBG),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListView(
                children: [
                  Container(
                    child: Container(
                      margin: const EdgeInsets.only(top: 150.0, left: 100.0),
                      alignment: FractionalOffset.topLeft,
                      child: Text(
                        "The",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: ConstantFont.montserratRegular),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 0.0, left: 100.0),
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      "BARBER.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          fontFamily: ConstantFont.montserratBlack),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    alignment: FractionalOffset.topCenter,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (email) => EmailValidator.validate(email!)
                          ? null
                          : "Invalid email address",
                      onSaved: (email) => _email = email,
                      // onFieldSubmitted: (_) {
                      //   fieldFocusChange(
                      //       context, _emailFocusNode, _passwordFocusNode);
                      // },
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: whiteColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: ConstantFont.montserratMedium),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: whiteF1.withOpacity(0.2),
                        hintText: 'Email id',
                        hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: greyColor,
                            fontFamily: ConstantFont.montserratMedium),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent.withOpacity(0.50)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent.withOpacity(0.50)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    alignment: FractionalOffset.topCenter,
                    child: TextFormField(
                      obscureText: _obscureText,
                      focusNode: _passwordFocusNode,
                      validator: (password) {
                        Pattern pattern =
                            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                        RegExp regex = new RegExp(pattern as String);
                        if (!regex.hasMatch(password!))
                          return 'Invalid password';
                        else
                          return null;
                      },
                      onSaved: (password) => _password = password,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: whiteColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: ConstantFont.montserratMedium),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: whiteF1.withOpacity(0.2),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: greyColor,
                            fontFamily: ConstantFont.montserratMedium),
                        contentPadding:
                            EdgeInsets.only(left: 14.0, bottom: 5.0, top: 14.0),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent.withOpacity(0.50)),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent.withOpacity(0.50)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent.withOpacity(0.50)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: new Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: whiteColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10, right: 15.0),
                      alignment: FractionalOffset.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()),
                              (context) => false);
                        },
                        child: Text(
                          StringConstant.ForgotPassword,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: ConstantFont.montserratMedium),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      alignment: FractionalOffset.center,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width * .90,
                        height: 45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        color: pinkColor,
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                          //   widgetProvider.setCircular(true);
                          //   print(widgetProvider.circular);
                          //   provider.managerSignIn(context);
                          //   widgetProvider.setCircular(false);
                          //   print(
                          //       "userName of admin is ${provider.userModel.userName}");
                          // }

                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => CategoryScreen()));
                        },
                        child: Text(
                          StringConstant.login,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: ConstantFont.montserratMedium,
                          ),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            alignment: FractionalOffset.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    StringConstant.donHaveAnAccount,
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        fontFamily:
                                            ConstantFont.montserratMedium),
                                  ),
                                  new Text(
                                    StringConstant.signUp,
                                    style: TextStyle(
                                        color: pinkColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily:
                                            ConstantFont.montserratBold),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    PreferenceUtils.init();
    initPlatformState();

    WidgetsFlutterBinding.ensureInitialized();

    if (mounted) {
      setState(() {
        PreferenceUtils.init();
      });
    }
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
    OneSignal.shared.promptLocationPermission();
    var status = await OneSignal.shared.getDeviceState();
    var pushtoken = status!.userId!;
    PreferenceUtils.setString(AppConstant.fcmtoken, pushtoken);
  }
}
