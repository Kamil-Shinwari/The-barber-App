import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:thebarber/screens/customerside/bookingscreencustomer.dart';
import 'package:thebarber/screens/customerside/homemainscreen.dart';
import 'package:thebarber/screens/customerside/loginscreen.dart';
import 'package:thebarber/screens/serivesProviderScreen/Loginscreensevice.dart';

import 'constant/appconstant.dart';
import 'constant/preferenceutils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // LocalNotificationService.initialize();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // setuplocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: ScreenUtilInit(
        designSize: Size(360,690),
        builder: (context, child) => 
         MaterialApp(
          debugShowCheckedModeBanner: false,
          home: new BookingScreenCustomer(),
          // routes: <String, WidgetBuilder>{
          //   '/HomeScreen': (BuildContext context) => new HomeScreen(1),
          // },
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//   startTime() async {
//     // var _duration = new Duration(seconds: 3);
//     // return new Timer(_duration, navigationPage);

// }

  void navigationPage() {
    // var isLogin=PreferenceUtils.getlogin(AppConstant.isLoggedIn);
    //   isLogin==true?Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => new HomeScreen(0))):
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreenServies()));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreenServies()));
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        body: new Container(
          padding: EdgeInsets.only(bottom: 50),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('assets/images/splash.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }


}
