import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:thebarber/screens/customerside/loginscreen.dart';
import 'package:thebarber/screens/serivesProviderScreen/Loginscreensevice.dart';

import '../../constant/color_constant.dart';
import '../../constant/constant_font.dart';
import '../../constant/dymmyimages.dart';
import '../../constant/string_constant.dart';

class HomeMainScreen extends StatefulWidget {
  HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              decoration: BoxDecoration(color: whiteColor.withOpacity(0.0)),
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginScreenServies()));
                  },
                  child: Text(
                    StringConstant.providerlogin,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: ConstantFont.montserratMedium,
                    ),
                  ),
                )),
          ],
        )
      ]),
    );
  }
}
