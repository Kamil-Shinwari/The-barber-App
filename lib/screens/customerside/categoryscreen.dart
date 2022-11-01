import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thebarber/screens/customerside/custmerservicelisthair.dart';
import 'package:thebarber/screens/customerside/custmerserviceslistBeared.dart';
import 'package:thebarber/screens/customerside/custmerserviceslistTrimming.dart';

import 'custmerserviceslistall.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late final _tabcontroller = TabController(length: 4, vsync: this);
  int selected = 0;
  List<String> labelsList = ['All', 'HairCut', 'Beared', 'Trimming'];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: labelsList.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 30.0.w, right: 30.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 40.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu),
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/inner1.jpg"),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Recommended",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MyHorizentalScrollViewContainer(
                        url: "assets/images/hair.jpg",
                        logoUrl:
                            "https://dcassetcdn.com/design_img/559626/200490/200490_3733364_559626_image.png",
                        title: "Creative Cuts"),
                    SizedBox(
                      width: 10.w,
                    ),
                    MyHorizentalScrollViewContainer(
                        url: "assets/images/hair.jpg",
                        logoUrl:
                            "https://dcassetcdn.com/design_img/559626/200490/200490_3733364_559626_image.png",
                        title: "Creative Cuts"),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10.h,
              ),
              SingleChildScrollView(
                // scrollDirection: Axis.horizontal,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: TabBar(
                      controller: _tabcontroller,
                      unselectedLabelColor: const Color(0xffacb3bf),
                      indicatorColor: Color(0xFFffac81),
                      labelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3.0,
                      indicatorPadding: EdgeInsets.all(10),
                      isScrollable: true,
                      tabs: [
                        // Tab(child: Text("All",style: TextStyle(color: Colors.black,fontSize: 12),),),
                        Tab(
                            child: Container(
                          child: Text(
                            "All",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp),
                          ),
                        )),
                        Tab(
                            child: Container(
                          child: Text(
                            "Hair",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp),
                          ),
                        )),
                        Tab(
                            child: Container(
                          child: Text(
                            "Beared",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp),
                          ),
                        )),
                        Tab(
                            child: Container(
                          child: Text(
                            "Trimming",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp),
                          ),
                        )),
                      ]),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height ,
                child: TabBarView(controller: _tabcontroller, children: [
                  CustmerServicesListAll(),
                  CustmerServicesListhair(),
                  CustmerServicesListBeared(),
                  CustmerServicesListTrimming(),
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class MyHorizentalScrollViewContainer extends StatelessWidget {
  final String url;
  final String logoUrl;
  final String title;

  const MyHorizentalScrollViewContainer(
      {super.key,
      required this.url,
      required this.logoUrl,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 140.h,
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
