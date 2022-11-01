import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thebarber/screens/serivesProviderScreen/UserTaskDescription.dart';
import 'package:thebarber/screens/serivesProviderScreen/bookinnglist.dart';

import '../../constant/color_constant.dart';
import '../../constant/constant_font.dart';
import '../../constant/string_constant.dart';

class ServicesBookedScreen extends StatefulWidget {
  ServicesBookedScreen({Key? key}) : super(key: key);

  @override
  State<ServicesBookedScreen> createState() => _ServicesBookedScreenState();
}

class _ServicesBookedScreenState extends State<ServicesBookedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                StringConstant.bookService,
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
            body: StreamBuilder<QuerySnapshot>(
              // <2> Pass `Stream<QuerySnapshot>` to stream
              stream: FirebaseFirestore.instance
                  .collection('bookservices')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;

                  return ListView(
                      children: documents
                          .map((doc) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserTaskDescription(
                                                  data: doc,
                                                )));
                                  },
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https://4.imimg.com/data4/YM/AY/GLADMIN-17254102/1-500x500.jpg'),
                                                  fit: BoxFit.cover)),
                                          height: 90,
                                        )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 10),
                                          child: Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              height: 90,
                                              child: Column(children: [
                                                Text(
                                                  'New Order \n ${doc.get('beared')}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  'Date \n ${doc.get('servicetimedate')}  ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ]),
                                            ),
                                          ),
                                        )
                                      ]),
                                    ),
                                  ),
                                ),
                              ))
                          .toList());
                } else {
                  return Text("It's Error!");
                }
              },
            )));
  }
}
