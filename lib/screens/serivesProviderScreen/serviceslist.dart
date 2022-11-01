import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebarber/provider/user_signup_viewmodel.dart';
import 'package:thebarber/provider/widgets_viewmodel.dart';
import 'package:thebarber/screens/serivesProviderScreen/createserices.dart';

import '../../constant/color_constant.dart';
import '../../constant/constant_font.dart';
import '../../constant/string_constant.dart';

class ServicesListScreen extends StatefulWidget {
  ServicesListScreen({Key? key}) : super(key: key);

  @override
  State<ServicesListScreen> createState() => _ServicesListScreenState();
}

class _ServicesListScreenState extends State<ServicesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            StringConstant.listServies,
            style: TextStyle(
                color: blackColor,
                fontFamily: ConstantFont.montserratBold,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 15),
              child: GestureDetector(
                onTap: (() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreateServices()));
                }),
                child: Text(
                  'Add New',
                  style: TextStyle(
                      color: blackColor,
                      fontFamily: ConstantFont.montserratBold,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
          centerTitle: true,
          backgroundColor: whiteColor,
          elevation: 0.0,
        ),
        body: StreamBuilder<QuerySnapshot>(
          // <2> Pass `Stream<QuerySnapshot>` to stream
          stream: FirebaseFirestore.instance.collection('services').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // <3> Retrieve `List<DocumentSnapshot>` from snapshot
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ListView(
                  children: documents
                      .map((doc) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(width: 1)),
                              child: Card(
                                // child: ListTile(
                                //   title: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Text("Service Name: ${doc['serviceName']}"),
                                //         Text("Price : ${doc['price']}"),
                                //     ],
                                //   ),

                                //   subtitle: Text("Contact : ${doc['phone']}"),

                                // ),
                                child: Row(children: [
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(doc["image"]),
                                            fit: BoxFit.cover)),
                                    height: 90,
                                  )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      height: 90,
                                      child: Column(children: [
                                        Text(
                                          doc["servicesName"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          doc["servicesTime"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ]),
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          ))
                      .toList());
            } else {
              return Text("It's Error!");
            }
          },
        ));
  }
}
