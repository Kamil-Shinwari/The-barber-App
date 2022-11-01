import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thebarber/screens/customerside/categoryscreen.dart';
import 'package:thebarber/screens/customerside/homemainscreen.dart';
import 'package:thebarber/screens/serivesProviderScreen/Loginscreensevice.dart';
import 'package:thebarber/screens/serivesProviderScreen/homebottom.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(snapshot.data?.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final userDoc = snapshot.data!;
                  if (userDoc['role'] == 'customer') {
                    return CategoryScreen();
                  } else {
                    return HomeBottom(0);
                  }
                } else {
                  return Material(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          }
          return LoginScreenServies();
        });
  }
}
