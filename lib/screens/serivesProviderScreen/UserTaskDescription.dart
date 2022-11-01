import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thebarber/provider/widgets_viewmodel.dart';

import '../../constant/Palette.dart';
import '../../constant/color_constant.dart';
import '../../constant/constant_font.dart';
import '../../constant/string_constant.dart';

class UserTaskDescription extends StatefulWidget {
  UserTaskDescription({
    Key? key,
    required this.data,
  }) : super(key: key);

  DocumentSnapshot data;

  @override
  State<UserTaskDescription> createState() => _UserTaskDescriptionState();
}

class _UserTaskDescriptionState extends State<UserTaskDescription> {
  var _bottomNavIndex = 0;
  late AnimationController _animationController;

  late Animation<double> animation;

  late CurvedAnimation curve;

  // DatabaseMethod databaseMethod = new DatabaseMethod();

  ScrollController _scrollController = ScrollController();

  Stream<QuerySnapshot>? chatMessageStream;

  @override
  void initState() {
    // getConversationMessage(widget.data!.id).then((value){
    //   setState((){
    //     chatMessageStream = value;
    //   });    });
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
          StringConstant.requestService,
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Service Name',
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                widget.data['beared'] == null
                                    ? ''
                                    : '\n${widget.data['beared']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.data['cure'] == null
                                    ? ''
                                    : '\n${widget.data['cure']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.data['facial'] == null
                                    ? ''
                                    : '\n${widget.data['facial']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.data['haircut'] == null
                                    ? ''
                                    : '\n${widget.data['haircut']}\n',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                widget.data['mask'] == null
                                    ? ''
                                    : '\n${widget.data['mask']}\n',
                                // widget.data['mask'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.data['skincare'] == null
                                    ? ''
                                    : '\n${widget.data['skincare']}\n',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.data['treatment'] == null
                                    ? ''
                                    : '\n${widget.data['treatment']}\n',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.data['trimming'] == null
                                    ? ''
                                    : '\n${widget.data['trimming']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    // SizedBox(width:50 ,),
                    // StreamBuilder<DocumentSnapshot>(
                    //     stream: FirebaseFirestore.instance
                    //         .collection('task')
                    //         .doc(widget.data.id)
                    //         .snapshots(),
                    //     builder: (context, snapshot) {
                    //       final data = snapshot.data;
                    //       return Column(
                    //         children: [
                    //           CircularPercentIndicator(
                    //             //circular progress indicator
                    //             radius: 25.0.r,
                    //             //radius for circle
                    //             lineWidth: 5.0.r,
                    //             //width of circle line
                    //             //  animation: true, //animate when it shows progress indicator first
                    //             percent: data!['progress'] / 100,
                    //             //vercentage value: 0.6 for 60% (60/100 = 0.6)
                    //             center: Text(
                    //               "${data['progress']}%",
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 12.0.sp),
                    //             ),
                    //             //center text, you can set Icon as well
                    //             //footer text
                    //             backgroundColor: Colors.grey,
                    //             //backround of progress bar
                    //             circularStrokeCap: CircularStrokeCap.round,
                    //             //corner shape of progress bar at start/end
                    //             progressColor: Colors.blue, //progress bar color
                    //           ),
                    //           SizedBox(
                    //             height: 5.h,
                    //           ),
                    //           Text(
                    //             data['priority'],
                    //             style: TextStyle(
                    //                 fontSize: 10.sp,
                    //                 color: Colors.grey.shade600),
                    //           ),
                    //           Text(
                    //             data['status'],
                    //             style: TextStyle(
                    //                 fontSize: 10.sp,
                    //                 color: Colors.grey.shade600),
                    //           ),
                    //           SizedBox(
                    //             height: 10,
                    //           ),
                    //           GestureDetector(
                    //             onTap: () {
                    //               Get.to(ShowStatusScreen(data: widget.data));
                    //             },
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                   color: Palette.mainColor,
                    //                   borderRadius: BorderRadius.circular(5)),
                    //               padding: EdgeInsets.all(4),
                    //               child: Text(
                    //                 'Show Status',
                    //                 style: TextStyle(color: Colors.white),
                    //               ),
                    //             ),
                    //           )
                    //         ],
                    //       );
                    //     }),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' Date',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${widget.data['servicetimedate']}',
                        // widget.data!['startDate'],
                        style: TextStyle(
                            fontSize: 12,
                            color: Palette().fontcolor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(right: 38.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'test',
                          // widget.data!['endDate'],
                          style: TextStyle(
                              fontSize: 12,
                              color: Palette().fontcolor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Container(
                          width: 100,
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
                              // print('serviceeeeeessssss');
                              // // if (_formKey.currentState!.validate()) {
                              // widgetProvider.setCircular(true);
                              // provider.managerSignIn(
                              //   context,
                              //   userModel: UserModel(
                              //       email: _userEmailController.text.trim(),
                              //       password:
                              //           _passwordController.text.trim()),
                              // );
                              // widgetProvider.setCircular(false);
                              // print(
                              //     "userName of admin is ${provider.userModel.userName}");
                              // }

                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => HomeBottom(0)));
                            },
                            child: Text(
                              StringConstant.accept,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: ConstantFont.montserratMedium,
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Container(
                          width: 100,
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
                              print('serviceeeeeessssss');
                              // if (_formKey.currentState!.validate()) {
                              // widgetProvider.setCircular(true);
                              // provider.managerSignIn(
                              //   context,
                              //   userModel: UserModel(
                              //       email: _userEmailController.text.trim(),
                              //       password:
                              //           _passwordController.text.trim()),
                              // );
                              // widgetProvider.setCircular(false);
                              // print(
                              //     "userName of admin is ${provider.userModel.userName}");
                              // }

                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => HomeBottom(0)));
                            },
                            child: Text(
                              StringConstant.cancal,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: ConstantFont.montserratMedium,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              )

              // Container(
              //   height: size.height.h * .23.h,
              //   child: Stack(
              //     children: [
              //       Text(
              //         'comments',
              //         style: TextStyle(
              //             fontSize: 20,
              //             color: Colors.black,
              //             fontWeight: FontWeight.w700),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(top: 30),
              //         child: Divider(
              //           height: 1,
              //           color: Colors.grey.shade400,
              //           thickness: 2,
              //           indent: 20,
              //           endIndent: 20,
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(bottom: 50, top: 40),
              //         child: StreamBuilder<QuerySnapshot>(
              //             stream: chatMessageStream,
              //             builder: (context, snapshot) {
              //               return snapshot.hasData
              //                   ? ListView.builder(
              //                 controller: _scrollController,
              //                   itemCount: snapshot.data!.docs.length,
              //                   itemBuilder: (context, index) {
              //                     print("your messages are ${snapshot.data!.docs[index]["message"]}");
              //                     return MessageTile(context,
              //                       message: snapshot.data!.docs[index]["message"],
              //                       isSendByMe: snapshot.data!.docs[index]["sendby"] == widget.data!['userName'],
              //                       // isImage: snapshot.data!.docs[index]["type"] == 'img',
              //                     );
              //                   })
              //                   : CircularProgressIndicator();
              //             }
              //         )
              //       ),
              //       Align(
              //         alignment: Alignment.bottomCenter,
              //         widthFactor: double.infinity,
              //         // heightFactor: double.infinity,
              //         child: Row(
              //           crossAxisAlignment: CrossAxisAlignment.end,
              //           children: [
              //             Expanded(
              //               flex: 4,
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   // shape: BoxShape.rectangle,
              //                   color: Colors.grey.shade200,
              //                   border: Border.all(color: Colors.grey.shade400),
              //                   borderRadius: BorderRadius.circular(8),
              //                 ),
              //                 child: TextField(
              //                   textAlign: TextAlign.start,
              //                   controller: controller,
              //                   keyboardType: TextInputType.text,
              //                   decoration: InputDecoration(
              //                     hintText: 'type here....',
              //                     hintStyle: TextStyle(
              //                         fontSize: 16, color: Palette().fontcolor),
              //                     border: OutlineInputBorder(
              //                       borderSide: BorderSide(
              //                           // width: 0,
              //                           // style: BorderStyle.none,
              //                           // color: Colors.grey.shade400
              //                           ),
              //                     ),
              //                     filled: true,
              //                     contentPadding: EdgeInsets.all(16),
              //                     // suffixIcon: Icon(Icons.camera_alt,color: Colors.grey.shade500,)
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Expanded(
              //               flex: 1,
              //               child: Padding(
              //                 padding: const EdgeInsets.only(left: 10),
              //                 child: GestureDetector(
              //                   onTap: () async {
              //                     if(controller.text.isNotEmpty)
              //                       {
              //                         FirebaseFirestore.instance.collection('task').doc(widget.data!.id).collection('comments').add(
              //                             {"message": controller.text,
              //                               "sendby": widget.data!['userName'],
              //                               "time": DateTime.now().microsecondsSinceEpoch});
              //                         setState((){
              //                           controller.clear();
              //                           _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
              //                         });
              //                       }
              //                   },
              //                   child: Container(
              //                       // width: 50,
              //                       height: 50,
              //                       decoration: BoxDecoration(
              //                         shape: BoxShape.rectangle,
              //                         color: Palette().maincolor,
              //                         // border: Border.all(color: Colors.grey.shade600),
              //                         borderRadius: BorderRadius.circular(10.0),
              //                       ),
              //                       child: Icon(Icons.send,
              //                           color: Colors.white, size: 30)),
              //                 ),
              //               ),
              //             ),
              //             // Expanded(
              //             //   child: Padding(
              //             //     padding: const EdgeInsets.only(left: 10),
              //             //     child: Container(
              //             //       // width: 50,
              //             //         height: 50,
              //             //         decoration: BoxDecoration(
              //             //             shape: BoxShape.rectangle,
              //             //             color: Colors.grey.shade200,
              //             //             // border: Border.all(color: Colors.grey.shade600),
              //             //             borderRadius: BorderRadius.circular(8),
              //             //             border: Border.all(color: Colors.grey.shade600)
              //             //
              //             //         ),
              //             //         child:Icon(Icons.attachment_sharp,color: Colors.grey.shade500,size: 30)
              //             //     ),
              //             //   ),
              //             // ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
