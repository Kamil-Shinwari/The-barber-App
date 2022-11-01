import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebarber/models/user_model.dart';
import 'package:thebarber/screens/serivesProviderScreen/homebottom.dart';

import '../../constant/color_constant.dart';
import '../../constant/constant_font.dart';
import '../../constant/dymmyimages.dart';
import '../../constant/string_constant.dart';
import '../../provider/manager_signin_viewmodel.dart';
import '../../provider/widgets_viewmodel.dart';
import '../customerside/forgotpassword.dart';
import '../customerside/registerScreen.dart';

class LoginScreenServies extends StatefulWidget {
  LoginScreenServies({Key? key}) : super(key: key);

  @override
  State<LoginScreenServies> createState() => _LoginScreenServiesState();
}

class _LoginScreenServiesState extends State<LoginScreenServies> {
  FocusNode? myFocusNode;
  String? _email, _password = "";
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => WidgetsViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => ManagerSignInViewModel(),
          ),
        ],
        child: Consumer2<WidgetsViewModel, ManagerSignInViewModel>(
            builder: (context, widgetProvider, provider, child) => SafeArea(
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
                            margin:
                                const EdgeInsets.only(top: 150.0, left: 100.0),
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
                            // validator: (email) =>
                            //     EmailValidator.validate(email!)
                            //         ? null
                            //         : "Invalid email address",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            controller: _userEmailController,
                            onChanged: (value) {
                              provider.userModel.email = value;
                            },
                            // onSaved: (email) => _email = email,
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
                                    color:
                                        Colors.transparent.withOpacity(0.50)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Colors.transparent.withOpacity(0.50)),
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
                            // obscureText: _obscureText,
                            // focusNode: _passwordFocusNode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            controller: _passwordController,
                            onChanged: (value) {
                              provider.userModel.password = value;
                            },
                            // onSaved: (password) => _password = password,
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
                              contentPadding: EdgeInsets.only(
                                  left: 14.0, bottom: 5.0, top: 14.0),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Colors.transparent.withOpacity(0.50)),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Colors.transparent.withOpacity(0.50)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Colors.transparent.withOpacity(0.50)),
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
                                print('serviceeeeeessssss');
                                // if (_formKey.currentState!.validate()) {
                                widgetProvider.setCircular(true);
                                provider.managerSignIn(
                                  context,
                                  userModel: UserModel(
                                      email: _userEmailController.text.trim(),
                                      password:
                                          _passwordController.text.trim()),
                                );
                                widgetProvider.setCircular(false);
                                print(
                                    "userName of admin is ${provider.userModel.userName}");
                                // }

                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => HomeBottom(0)));
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
                                            builder: (context) =>
                                                RegisterScreen()),
                                      );
                                    },
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text(
                                          StringConstant.donHaveAnAccount,
                                          style: TextStyle(
                                              color: whiteColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: ConstantFont
                                                  .montserratMedium),
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
                ))));
  }
}
