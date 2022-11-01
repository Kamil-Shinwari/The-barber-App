import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindSaloonScreen extends StatefulWidget {
  const FindSaloonScreen({super.key});

  @override
  State<FindSaloonScreen> createState() => _FindSaloonScreenState();
}

class _FindSaloonScreenState extends State<FindSaloonScreen> {
  Position? position;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _showMaterialDialog();
    getLocation();
    // LoadData();
     getDocs();
   
   
  }


  var addressa;
  double? lat;
  double? longi;
  // final List<Marker> _markers = <Marker>[];
  // final List<LatLng> _latlang = <LatLng>[
  //   LatLng(34.007262070394106, 71.5486452846636),
  //   LatLng(34.00368666835743, 71.54134967618405),
  //   LatLng(34.00027121844808, 71.54029825025607),
  // ];

  // CustomInfoWindowController _customInfoWindowController =
  // CustomInfoWindowController();
  getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition();
    setState(() {});
  }



  void CoordinatesToAddress(double lat,double lon) async {
    var address = await Geocoder2.getDataFromCoordinates(
        latitude: lat,
        longitude: lon,
        googleMapApiKey: "AIzaSyDUpkW2Cixeg33umfD87s9CYkzsSyC3jXI");

    setState(() {
      addressa = address.city + " " + address.country;
      log(addressa.toString());
    });
  }
  void getDocs() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("users").where("role",isEqualTo: "ServicesProvider").get();
  for (int i = 0; i < querySnapshot.docs.length; i++) {
    var a = querySnapshot.docs[i];
    lat=double.parse(a.get("lat"));
    longi=double.parse(a.get("lon"));
    CoordinatesToAddress(lat!,longi!);
  }
}
String query="";
TextEditingController searchc=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // _showMaterialDialog();
    return Scaffold(
      body: 
      Stack(children: [
        GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
              target: position == null
                  ? LatLng(34.00895968237819, 71.54737448996782)
                  : LatLng(position!.latitude, position!.longitude),
              zoom: 14),
          onMapCreated: (GoogleMapController controller) {
            // _customInfoWindowController.googleMapController = controller;
          },
          // markers: Set<Marker>.of(_markers),
        ),
        Positioned(
            top: 40.h,
            left: 30.w,
            right: 30.w,
            child: Container(
              height: 45.h,
              color: Colors.white,
              child: TextField(
                onTap: (){
                  // _showMaterialDialog();
                },
                controller:searchc ,
                onEditingComplete: () {
                  setState(() {
                    query=searchc.text;
                    log(query);
                  });
                },
                  decoration: InputDecoration(
                      hintText: "Search By City Name", border: OutlineInputBorder())),
            )),
        Positioned(
          bottom: 40.h,
          left: 0,
          right: 0,
          child:query==""?
          Container(
            width: 350,
            height: 160,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where("role", isEqualTo: "ServicesProvider")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data!.docs.map((document) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: MyContainerListView(
                            address: "Address: ${document["address"]}",
                            detail: "City : ${document["city"]}",
                            title: "Name : ${document["userName"]}",
                            url: "${document["imageUrl"]}",
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
          ):
           Container(
            width: 350,
            height: 160,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where("role", isEqualTo: "ServicesProvider")
                    .where("city",isEqualTo: query)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data!.docs.map((document) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: MyContainerListView(
                            address: "Address: ${document["address"]}",
                            detail: "City : ${document["city"]}",
                            title: "Name : ${document["userName"]}",
                            url: "${document["imageUrl"]}",
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
          ),
        ),
      ]),
    );
  }
}

class MyContainerListView extends StatelessWidget {
  final String title;
  final String detail;
  final String url;
  final String address;

  const MyContainerListView(
      {super.key,
      required this.title,
      required this.address,
      required this.detail,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      width: 275.w,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(20)),
      child: Row(children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration:
                    (BoxDecoration(borderRadius: BorderRadius.circular(20))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(detail),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(address)
                    ]),
              ),
            )),
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(
                          url,
                        ),
                        fit: BoxFit.cover)),
              ),
            )),
      ]),
    );
  }
}