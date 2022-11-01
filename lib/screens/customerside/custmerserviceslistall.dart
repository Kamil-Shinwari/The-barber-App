import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/color_constant.dart';
import '../../constant/constant_font.dart';
import '../../constant/string_constant.dart';
import '../serivesProviderScreen/FindSaloonScreen.dart';
import '../serivesProviderScreen/createserices.dart';
import 'bookingscreencustomer.dart';
import 'nearbyscreen.dart';

class CustmerServicesListAll extends StatefulWidget {
  CustmerServicesListAll({Key? key}) : super(key: key);

  @override
  State<CustmerServicesListAll> createState() => _CustmerServicesListAllState();
}

class _CustmerServicesListAllState extends State<CustmerServicesListAll> {
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
        body: Column(
      children: [
        Container(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("services").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BookingScreenCustomer()));
                      },
                      child: GridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5),
                        itemBuilder: (context, index) {
                          return Container(
                              height: 250.h,
                              width: 250.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(snapshot
                                          .data!.docs[index]
                                          .get("image")),
                                      fit: BoxFit.cover)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Name : ${snapshot.data!.docs[index].get("servicesName")}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "Price : ${snapshot.data!.docs[index].get("servicePrice")}",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ]));
                        },
                      ),
                    ),
                  ],
                );
              }
            },
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
                    MaterialPageRoute(builder: (context) => FindSaloonScreen()));
              },
              child: Text(
                StringConstant.findnear,
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
    ));
  }
}

class MyVerticalScrolView extends StatelessWidget {
  final String url;
  final String logoUrl;
  final String title;

  const MyVerticalScrolView(
      {super.key,
      required this.url,
      required this.logoUrl,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 170.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:
                  DecorationImage(image: AssetImage(url), fit: BoxFit.cover)),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 130.w,
            height: 110.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [Colors.black12, Colors.white10],
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(
                    "$logoUrl",
                    width: 80.w,
                    height: 60.h,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "$title",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: Colors.white),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.grey,
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ]),
    );
  }
}
