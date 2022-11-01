import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearByScreen extends StatefulWidget {
  NearByScreen({Key? key}) : super(key: key);

  @override
  State<NearByScreen> createState() => _NearByScreenState();
}

class _NearByScreenState extends State<NearByScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(27.7089427, 85.3086209), zoom: 14)),
        Positioned(
            top: 40.h,
            left: 30.w,
            right: 30.w,
            child: Container(
              height: 45.h,
              color: Colors.white,
              child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search", border: OutlineInputBorder())),
            )),
        Positioned(
            bottom: 40.h,
            left: 0.w,
            right: 0.w,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left:5.0,right: 5),
                child: Row(
                  children: [
                    SizedBox(width: 10.w,),
                   MyContainerListView(title: "Creative Cuts", detail:"XYZ Street\n opposite of \n Oil Station", url: "assets/images/inner1.jpg"),
                     SizedBox(width: 10.w,),
                        MyContainerListView(title: "New Cuts", detail:"XYZ Street\n opposite of \n Oil Station", url: "assets/images/inner1.jpg"),

                     SizedBox(width: 10.w,),
                      MyContainerListView(title: " Modren Creative Cuts", detail:"XYZ Street\n opposite of \n Oil Station", url: "assets/images/inner1.jpg"),

                  ],
                ),
              ),
            ))
      ]),
    );
  }
}

class MyContainerListView extends StatelessWidget {
final String title;
final String detail;
final String url;

  const MyContainerListView({super.key, required this.title, required this.detail, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
    height: 140.h,
    width: 275.w,
    decoration:
        BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(20)),
    child: Row(children: [
      Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Container(
            
              decoration: (BoxDecoration( borderRadius: BorderRadius.circular(20))),
              child: Column(children: [
                SizedBox(height: 10.h,),
                Text(title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.h,),
              Text(detail),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.star,color: Colors.yellow,),
               Icon(Icons.star,color: Colors.yellow,),
                Icon(Icons.star,color: Colors.yellow,),
                Icon(Icons.star,color: Colors.yellow,),
                Icon(Icons.star,color: Colors.grey,),
              ],),
             
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
                  image: DecorationImage(image: AssetImage(url,),fit: BoxFit.cover)),
            ),
          )),
    ]),
    );
  }
}
