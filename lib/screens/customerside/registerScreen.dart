import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../constant/Palette.dart';
import '../../constant/color_constant.dart';
import '../../constant/constant_font.dart';
import '../../constant/preferenceutils.dart';
import '../../constant/string_constant.dart';
import '../../constant/toast_message.dart';
import '../../models/user_model.dart';
import '../../provider/user_signup_viewmodel.dart';
import '../../provider/widgets_viewmodel.dart';
import 'homemainscreen.dart';
import 'loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => new _RegisterScreen();
}

File? _imageFile;
File? get imageFile => _imageFile;
XFile? image;
ImagePicker _picker = ImagePicker();

class _RegisterScreen extends State<RegisterScreen> {
  String? _selectedCountryCode = ' +91';
  List<String> _countryCodes = [' +91', ' +23', ' +8'];
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _cityFocusNode = FocusNode();

  String? _city, _username, _email, _password, _phoneno = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscureText = true;
  String _userManager = "User";

  String get userManager => _userManager;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("servies Provider"), value: "User"),
      DropdownMenuItem(child: Text("Customer"), value: "Manager"),
    ];
    return menuItems;
  }

  final User currentUser = FirebaseAuth.instance.currentUser!;

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userphoneController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var countryDropDown = Container(
      margin: EdgeInsets.only(right: 10),
      decoration: new BoxDecoration(
        border: Border(
          right: BorderSide(width: 0.5, color: greyColor),
        ),
      ),
      height: 45.0,
      //width: 300.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            value: _selectedCountryCode,
            items: _countryCodes.map((String value) {
              return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(
                    value,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: ConstantFont.montserratMedium),
                  ));
            }).toList(),
            onChanged: (dynamic value) {
              setState(() {
                _selectedCountryCode = value;
              });
            },
          ),
        ),
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WidgetsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserSignUpViewModel(),
        ),
      ],
      child: Consumer2<WidgetsViewModel, UserSignUpViewModel>(
          builder: (context, widgetProvider, signUpProvider, child) =>
              ModalProgressHUD(
                inAsyncCall: _loading,
                opacity: 1.0,
                color: Colors.transparent.withOpacity(0.2),
                progressIndicator: SpinKitFadingCircle(color: pinkColor),
                child: SafeArea(
                  child: Scaffold(
                      key: _scaffoldKey,
                      backgroundColor: whiteColor,
                      body: Scaffold(
                        resizeToAvoidBottomInset: true,
                        backgroundColor: whiteColor,
                        appBar: AppBar(
                          leading: IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_left,
                              color: blackColor,
                              size: 30,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          title: Text(
                            StringConstant.createNewAccount,
                            style: TextStyle(
                                color: blackColor,
                                fontFamily: ConstantFont.montserratBold,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          centerTitle: true,
                          backgroundColor: whiteColor,
                          elevation: 0.0,
                        ),
                        body: Form(
                          key: _formKey,
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // showDialog(
                                            //     context: context,
                                            //     builder: (BuildContext context) {
                                            //       return AlertDialog(
                                            //         backgroundColor: Palette.primary,
                                            //         shape: RoundedRectangleBorder(
                                            //           borderRadius:
                                            //               BorderRadius.circular(35.0),
                                            //         ),
                                            //         title: Text(
                                            //           'Choose Option',
                                            //           style: TextStyle(
                                            //             fontWeight: FontWeight.w600,
                                            //           ),
                                            //         ),
                                            //         content: SingleChildScrollView(
                                            //           child: ListBody(
                                            //             children: [
                                            //               InkWell(
                                            //                 onTap: () {
                                            //                   widgetProvider
                                            //                       .selectCameraImage();
                                            //                 },
                                            //                 // splashColor: Palette.facebookColor,
                                            //                 child: Row(
                                            //                   children: [
                                            //                     Padding(
                                            //                       padding:
                                            //                           const EdgeInsets
                                            //                               .all(8.0),
                                            //                       child: Icon(
                                            //                         Icons.camera,
                                            //                       ),
                                            //                     ),
                                            //                     Text(
                                            //                       'Camera',
                                            //                       style: TextStyle(
                                            //                           fontSize: 18,
                                            //                           fontWeight:
                                            //                               FontWeight
                                            //                                   .bold),
                                            //                     )
                                            //                   ],
                                            //                 ),
                                            //               ),
                                            //               InkWell(
                                            //                 onTap: () {
                                            //                   widgetProvider
                                            //                       .selectGalleryImage();
                                            //                 },
                                            //                 // splashColor: Palette.facebookColor,
                                            //                 child: Row(
                                            //                   children: [
                                            //                     Padding(
                                            //                       padding:
                                            //                           const EdgeInsets
                                            //                               .all(8.0),
                                            //                       child: Icon(
                                            //                         Icons.image,
                                            //                       ),
                                            //                     ),
                                            //                     Text(
                                            //                       'Gallery',
                                            //                       style: TextStyle(
                                            //                           fontSize: 18,
                                            //                           fontWeight:
                                            //                               FontWeight
                                            //                                   .bold),
                                            //                     )
                                            //                   ],
                                            //                 ),
                                            //               ),
                                            //               InkWell(
                                            //                 onTap: () {},
                                            //                 // splashColor: Palette.facebookColor,
                                            //                 child: Row(
                                            //                   children: [
                                            //                     Padding(
                                            //                       padding:
                                            //                           const EdgeInsets
                                            //                               .all(8.0),
                                            //                       child: Icon(
                                            //                         Icons.remove_circle,
                                            //                       ),
                                            //                     ),
                                            //                     Text(
                                            //                       'Remove',
                                            //                       style: TextStyle(
                                            //                           fontSize: 18,
                                            //                           color: Colors.red,
                                            //                           fontWeight:
                                            //                               FontWeight
                                            //                                   .bold),
                                            //                     )
                                            //                   ],
                                            //                 ),
                                            //               ),
                                            //             ],
                                            //           ),
                                            //         ),
                                            //       );
                                            //     });
                                            widgetProvider.selectGalleryImage();
                                            // selectGalleryImage();
                                          },
                                          child: Container(
                                            height: size.height * .3,
                                            width: size.width,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    right: 0,
                                                    child: CircleAvatar(
                                                      radius: 80,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: CircleAvatar(
                                                        radius: 75,
                                                        backgroundColor: Colors
                                                            .grey.shade400,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              blackColor,
                                                          radius: 72,
                                                          backgroundImage: widgetProvider
                                                                      .imageFile ==
                                                                  null
                                                              ? null
                                                              : FileImage(
                                                                  widgetProvider
                                                                      .imageFile!),
                                                          child: widgetProvider
                                                                      .imageFile ==
                                                                  null
                                                              ? Icon(
                                                                  Icons.person,
                                                                  size: 100,
                                                                  color: Colors
                                                                      .white70,
                                                                )
                                                              : null,
                                                        ),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 50.0, left: 35.0),
                                            alignment: FractionalOffset.topLeft,
                                            child: Text(
                                              StringConstant.name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: grey99,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: ConstantFont
                                                      .montserratMedium),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 45,
                                          alignment: FractionalOffset.topLeft,
                                          margin: const EdgeInsets.only(
                                              top: 5.0,
                                              left: 20.0,
                                              right: 20.0,
                                              bottom: 15),
                                          child: TextFormField(
                                            autofocus: true,
                                            keyboardType: TextInputType.name,
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (name) {
                                              Pattern pattern =
                                                  r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                              RegExp regex =
                                                  new RegExp(pattern as String);
                                              if (!regex.hasMatch(name!))
                                                return 'Invalid username';
                                              else
                                                return null;
                                            },
                                            onSaved: (name) => _username = name,
                                            onFieldSubmitted: (_) {
                                              fieldFocusChange(
                                                  context,
                                                  _usernameFocusNode,
                                                  _emailFocusNode);
                                            },
                                            controller: _userNameController,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: blackColor,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: ConstantFont
                                                    .montserratMedium),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: whiteF1,
                                              hintText: 'Enter your full name',
                                              hintStyle: TextStyle(
                                                  fontSize: 16.0,
                                                  color: blackColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: ConstantFont
                                                      .montserratMedium),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 14.0,
                                                      bottom: 8.0,
                                                      top: 8.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: whiteF1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: whiteF1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 5.0, left: 35.0),
                                          alignment: FractionalOffset.topLeft,
                                          child: Text(
                                            StringConstant.emailId,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: grey99,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: ConstantFont
                                                    .montserratMedium),
                                          ),
                                        ),
                                        Container(
                                          height: 45,
                                          alignment: FractionalOffset.topLeft,
                                          margin: const EdgeInsets.only(
                                              top: 5.0,
                                              left: 20.0,
                                              right: 20.0,
                                              bottom: 15),
                                          child: TextFormField(
                                            autofocus: true,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: _emailFocusNode,
                                            validator: (email) =>
                                                EmailValidator.validate(email!)
                                                    ? null
                                                    : "Invalid email address",
                                            onSaved: (email) => _email = email,
                                            onFieldSubmitted: (_) {
                                              fieldFocusChange(
                                                  context,
                                                  _emailFocusNode,
                                                  _phoneFocusNode);
                                            },
                                            controller: _emailController,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: blackColor,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: ConstantFont
                                                    .montserratMedium),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: whiteF1,
                                              hintText: 'Enter your email id',
                                              hintStyle: TextStyle(
                                                  fontSize: 16.0,
                                                  color: blackColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: ConstantFont
                                                      .montserratMedium),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 14.0,
                                                      bottom: 8.0,
                                                      top: 8.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: whiteF1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: whiteF1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 10.0, left: 35.0),
                                            alignment: FractionalOffset.topLeft,
                                            child: Text(
                                              StringConstant.cityname,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: grey99,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: ConstantFont
                                                      .montserratMedium),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 45,
                                          alignment: FractionalOffset.topLeft,
                                          margin: const EdgeInsets.only(
                                              top: 5.0,
                                              left: 20.0,
                                              right: 20.0,
                                              bottom: 15),
                                          child: TextFormField(
                                            autofocus: true,
                                            keyboardType: TextInputType.name,
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (name) {
                                              Pattern pattern =
                                                  r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                              RegExp regex =
                                                  new RegExp(pattern as String);
                                              if (!regex.hasMatch(name!))
                                                return 'Invalid username';
                                              else
                                                return null;
                                            },
                                            onSaved: (name) => _city = name,
                                            onFieldSubmitted: (_) {
                                              fieldFocusChange(
                                                  context,
                                                  _cityFocusNode,
                                                  _phoneFocusNode);
                                            },
                                            controller: _cityController,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: blackColor,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: ConstantFont
                                                    .montserratMedium),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: whiteF1,
                                              hintText: 'Enter your City',
                                              hintStyle: TextStyle(
                                                  fontSize: 16.0,
                                                  color: blackColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: ConstantFont
                                                      .montserratMedium),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 14.0,
                                                      bottom: 8.0,
                                                      top: 8.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: whiteF1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: whiteF1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 5.0, left: 35.0),
                                          alignment:
                                              FractionalOffset.centerLeft,
                                          child: Text(
                                            StringConstant.phoneNumber,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: grey99,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: ConstantFont
                                                    .montserratMedium),
                                          ),
                                        ),
                                        Container(
                                            alignment:
                                                FractionalOffset.centerLeft,
                                            height: 45,
                                            margin: const EdgeInsets.only(
                                                top: 5.0,
                                                left: 20.0,
                                                right: 20.0,
                                                bottom: 15),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                focusNode: _phoneFocusNode,
                                                textAlign: TextAlign.left,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                validator: (phone) {
                                                  Pattern pattern =
                                                      r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                                  RegExp regex = new RegExp(
                                                      pattern as String);
                                                  if (!regex.hasMatch(phone!))
                                                    return 'Invalid Phone number';
                                                  else
                                                    return null;
                                                },
                                                controller:
                                                    _userphoneController,
                                                onSaved: (phone) =>
                                                    _phoneno = phone,
                                                onFieldSubmitted: (_) {
                                                  fieldFocusChange(
                                                      context,
                                                      _phoneFocusNode,
                                                      _passwordFocusNode);
                                                },
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: blackColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: ConstantFont
                                                        .montserratMedium),
                                                decoration: InputDecoration(
                                                  prefixIcon: countryDropDown,
                                                  filled: true,
                                                  fillColor: whiteF1,
                                                  hintText: '  Phone Number ',
                                                  hintStyle: TextStyle(
                                                      fontSize: 16.0,
                                                      color: blackColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: ConstantFont
                                                          .montserratMedium),
                                                  contentPadding:
                                                      EdgeInsets.all(15),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: whiteF1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: whiteF1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 15, 15),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .075,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: pinkColor),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  color: pinkColor,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Container(
                                                    width: size.width * .65,
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                        iconEnabledColor:
                                                            pinkColor,
                                                        iconDisabledColor:
                                                            pinkColor,
                                                        isExpanded: true,
                                                        value: widgetProvider
                                                            .userManager,
                                                        items: widgetProvider
                                                            .dropdownItems,
                                                        onChanged: (value) {
                                                          widgetProvider
                                                              .setUserManager(value
                                                                  .toString());
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 15, 15),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .075,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: pinkColor),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  color: pinkColor,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Container(
                                                    width: size.width * .65,
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                        iconEnabledColor:
                                                            pinkColor,
                                                        iconDisabledColor:
                                                            pinkColor,
                                                        isExpanded: true,
                                                        value: widgetProvider
                                                            .userhair,
                                                        items: widgetProvider
                                                            .dropdownItemsHair,
                                                        onChanged: (value) {
                                                          widgetProvider
                                                              .setUserHair(value
                                                                  .toString());
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 5.0, left: 35.0),
                                          alignment:
                                              FractionalOffset.centerLeft,
                                          child: Text(
                                            StringConstant.password,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: grey99,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: ConstantFont
                                                    .montserratMedium),
                                          ),
                                        ),
                                        Container(
                                          alignment:
                                              FractionalOffset.centerLeft,
                                          height: 45,
                                          margin: const EdgeInsets.only(
                                              top: 5.0,
                                              left: 20.0,
                                              right: 20.0,
                                              bottom: 15),
                                          child: TextFormField(
                                            controller: _passwordController,
                                            obscureText: _obscureText,
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: _passwordFocusNode,
                                            validator: (password) {
                                              Pattern pattern =
                                                  r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                              RegExp regex =
                                                  new RegExp(pattern as String);
                                              if (!regex.hasMatch(password!))
                                                return 'Invalid password';
                                              else
                                                return null;
                                            },
                                            onSaved: (password) =>
                                                _password = password,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: blackColor,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: ConstantFont
                                                    .montserratMedium),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: whiteF1,
                                              hintText: 'Enter your Password',
                                              hintStyle: TextStyle(
                                                  fontSize: 16.0,
                                                  color: blackColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: ConstantFont
                                                      .montserratMedium),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 14.0,
                                                      bottom: 8.0,
                                                      top: 8.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: whiteF1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: whiteF1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _obscureText =
                                                        !_obscureText;
                                                  });
                                                },
                                                child: new Icon(
                                                  _obscureText
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: blackColor,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: MaterialButton(
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8.0)),
                                            height: 45,
                                            color: pinkColor,
                                            onPressed: () async {
                                              // if (_formKey.currentState!
                                              //     .validate()) {
                                              widgetProvider.setCircular(true);
                                              await widgetProvider
                                                  .uploadImage(context);
                                              // ignore: use_build_context_synchronously
                                              signUpProvider.userSignUp(context,
                                                  userModel: UserModel(
                                                    role: widgetProvider
                                                        .userManager,
                                                    email: _emailController.text
                                                        .trim(),
                                                    imageUrl: widgetProvider
                                                        .imageUrlDownload,
                                                    password:
                                                        _passwordController.text
                                                            .trim(),
                                                    phoneNo:
                                                        _userphoneController
                                                            .text
                                                            .trim(),
                                                    userName:
                                                        _userNameController.text
                                                            .trim(),
                                                    fcmToken: 'dsds',
                                                    city: _cityController.text
                                                        .trim(),
                                                    rolehair:
                                                        widgetProvider.userhair,
                                                    uID: currentUser.uid,
                                                  ));
                                              print('singuoppppppp');
                                              widgetProvider.setCircular(false);
                                              // }
                                              print(
                                                  'onpresssssssssssssssssssssssssss');
                                            },
                                            child: Text(
                                              StringConstant.createNewAccount,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: whiteColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: ConstantFont
                                                    .montserratMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 10.0),
                                                  alignment: FractionalOffset
                                                      .bottomCenter,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomeMainScreen()),
                                                      );
                                                    },
                                                    child: new Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        new Text(
                                                          StringConstant
                                                              .alreadyHaveAnAccount,
                                                          style: TextStyle(
                                                              color: blackColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  ConstantFont
                                                                      .montserratMedium),
                                                        ),
                                                        new Text(
                                                          StringConstant
                                                              .loginDot,
                                                          style: TextStyle(
                                                              color: pinkColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  ConstantFont
                                                                      .montserratBold),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        new Container(
                                          child: SizedBox(
                                            height: 100,
                                          ),
                                        ),
                                        new Container(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            StringConstant
                                                .byClickingCreateNewAccountYouAgreeToTheFollowingTermsCondition,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: blackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: ConstantFont
                                                    .montserratMedium),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              )),
    );
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    setState(() {
      PreferenceUtils.init();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void selectGalleryImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    _imageFile = File(image!.path);
  }
}
