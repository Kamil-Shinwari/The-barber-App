import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thebarber/screens/customerside/bookingscreencustomer.dart';
import 'package:thebarber/screens/customerside/nearbyscreen.dart';

import '../../constant/color_constant.dart';
import '../../constant/constant_font.dart';
import '../../constant/string_constant.dart';
import '../serivesProviderScreen/createserices.dart';

class CustmerServicesListhair extends StatefulWidget {
  CustmerServicesListhair({Key? key}) : super(key: key);

  @override
  State<CustmerServicesListhair> createState() =>
      _CustmerServicesListhairState();
}

class _CustmerServicesListhairState extends State<CustmerServicesListhair> {
  @override
  Widget build(BuildContext context) {
    return
  Scaffold(
        body: Column(
      children: [
        Container(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("services")
                                .where('rolehair', isEqualTo: 'hair')
.snapshots(),
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
                    MaterialPageRoute(builder: (context) => NearByScreen()));
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
