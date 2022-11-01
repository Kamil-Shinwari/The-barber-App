import 'dart:developer';

import 'package:date_time_field/date_time_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thebarber/models/bookservicesmodel.dart';

import '../../Widgets/widgets.dart';
import '../../provider/users_managers_viewmodel.dart';
import '../../provider/widgets_viewmodel.dart';

class BookingScreenCustomer extends StatefulWidget {
  BookingScreenCustomer({Key? key}) : super(key: key);

  @override
  State<BookingScreenCustomer> createState() => _BookingScreenCustomerState();
}

class _BookingScreenCustomerState extends State<BookingScreenCustomer> {
  String? haircut,
      beared,
      trimming,
      skincare,
      facial,
      treatment,
      mask,
      cure,
      other = "";
  bool checkHaircut = false;
  bool checkbeared = false;
  bool checktrimming = false;
  bool checkskincare = false;
  bool checkfacial = false;
  bool checktreatment = false;
  bool checkmask = false;
  bool checkcure = false;
  bool checkother = false;
  DateTime? _fromDate;
  late DateEditingController dobController;

  bool loading = false;
  DateTime? dob;
  String? time;
  String? date;

  @override
  void initState() {
    super.initState();
    dobController = DateEditingController(
      date: DateTime(2020, 1, 1),
      initialDate: DateTime(2020, 9, 1),
      firstDate: DateTime(2019, 3, 4),
      lastDate: DateTime(2022, 4, 4),
      format: DateFormat('yyyy/MM/dd'),
    );
    dobController.addListener(() => {dob = dobController.date  });
  }

  @override
  void dispose() {
    dobController.dispose();
    super.dispose();
  }
  
  // String date= DateFormat('hh:mm:ss').format(DateTime.now());


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => WidgetsViewModel()),
          ChangeNotifierProvider(create: (context) => UserManagerViewModel()),
        ],
        child: Consumer2<WidgetsViewModel, UserManagerViewModel>(
            builder: (context, widgetProvider, userProvider, child) => Scaffold(
                  backgroundColor: Color(0xff282828),
                  body: SingleChildScrollView(
                    child: Column(children: [
                      Center(
                        child: Image.network(
                          "https://dcassetcdn.com/design_img/559626/200490/200490_3733364_559626_image.png",
                          width: 150.w,
                          height: 150.h,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Creative Cuts",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: screenSize.width,
                        height: 580.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8.0.h, left: 8.w),
                                child: Text(
                                  "Services",
                                  style: TextStyle(
                                      color: Color(0xff282828),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GFCheckbox(
                                      activeBgColor: Colors.green,
                                      type: GFCheckboxType.circle,
                                      value: checkHaircut,
                                      onChanged: (bool? value) {
                                        checkHaircut = value!;
                                        setState(() {
                                          if (checkHaircut == false) {
                                            haircut = '';
                                          } else {
                                            haircut = 'Hair Cut';
                                          }
                                        });
                                      },
                                    ),
                                    Text("Hair Cut"),
                                    GFCheckbox(
                                        activeBgColor: Colors.green,
                                        type: GFCheckboxType.circle,
                                        value: checkbeared,
                                        onChanged: (bool? value) {
                                          checkbeared = value!;
                                          setState(() {
                                            if (checkbeared == false) {
                                              beared = '';
                                            } else {
                                              beared = 'Beared';
                                            }
                                          });
                                        }),
                                    Text("Beared"),
                                    GFCheckbox(
                                        activeBgColor: Colors.green,
                                        type: GFCheckboxType.circle,
                                        value: checktrimming,
                                        onChanged: (bool? value) {
                                          checktrimming = value!;
                                          setState(() {
                                            if (checktrimming == false) {
                                              trimming = '';
                                            } else {
                                              trimming = 'trimming';
                                            }
                                          });
                                        }),
                                    Text("Trimming"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 9.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.w, right: 8.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GFCheckbox(
                                        activeBgColor: Colors.green,
                                        type: GFCheckboxType.circle,
                                        value: checkskincare,
                                        onChanged: (bool? value) {
                                          checkskincare = value!;
                                          setState(() {
                                            if (checkskincare == false) {
                                              skincare = '';
                                            } else {
                                              skincare = 'Skin Care';
                                            }
                                          });
                                        }),
                                    Text("Skin Care"),
                                    GFCheckbox(
                                        activeBgColor: Colors.green,
                                        type: GFCheckboxType.circle,
                                        value: checkfacial,
                                        onChanged: (bool? value) {
                                          checkfacial = value!;
                                          setState(() {
                                            if (checkfacial == false) {
                                              facial = '';
                                            } else {
                                              facial = 'Facial';
                                            }
                                          });
                                        }),
                                    Text("Facial"),
                                    GFCheckbox(
                                        activeBgColor: Colors.green,
                                        type: GFCheckboxType.circle,
                                        value: checktreatment,
                                        onChanged: (bool? value) {
                                          checktreatment = value!;
                                          setState(() {
                                            if (checktreatment == false) {
                                              treatment = '';
                                            } else {
                                              treatment = 'Treatment';
                                            }
                                          });
                                        }),
                                    Text("Treatment"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 9.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GFCheckbox(
                                        activeBgColor: Colors.green,
                                        type: GFCheckboxType.circle,
                                        value: checkmask,
                                        onChanged: (bool? value) {
                                          checkmask = value!;
                                          setState(() {
                                            if (checkmask == false) {
                                              mask = '';
                                            } else {
                                              mask = 'Mask';
                                            }
                                          });
                                        }),
                                    Text("Mask"),
                                    GFCheckbox(
                                        activeBgColor: Colors.blue,
                                        type: GFCheckboxType.circle,
                                        value: checkcure,
                                        onChanged: (bool? value) {
                                          checkcure = value!;
                                          setState(() {
                                            if (checkcure == false) {
                                              cure = '';
                                            } else {
                                              cure = 'Cure';
                                            }
                                          });
                                        }),
                                    Text("Cure"),
                                    GFCheckbox(
                                        activeBgColor: Colors.red,
                                        type: GFCheckboxType.circle,
                                        value: checkother,
                                        onChanged: (bool? value) {
                                          checkother = value!;
                                          setState(() {
                                            if (checkother == false) {
                                              other = '';
                                            } else {
                                              other = 'Other';
                                            }
                                          });
                                        }),
                                    Text("Other"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                width: 350.w,
                                  height: 170.h,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                         Padding(
                                           padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 10),
                                           child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text(
                                                  "Get Appointment",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.sp),
                                                ),
                                                Column(
                                                  children: [
                                                    Icon(Icons.notifications,color: Colors.white,size: 30,),
                                                    Text("Set Notification",                                                  style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.sp),),
                                                          
                                                  ],
                                                )
                                             ],
                                           ),
                                            
                                         ),
                                           Padding(
                                           padding:  EdgeInsets.only(left:20.0.w,right: 170.w),
                                           child: Container(
                                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
                                             child: DateTimePicker(
                                              decoration: InputDecoration(
                                                labelText: "select date",
                                                contentPadding: EdgeInsets.only(left: 10),
                                                border: InputBorder.none),
                                              type: DateTimePickerType.date,
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2100),
                                              // dateMask: "dd-mm-yyyy",
                                              onChanged: (val){
                                                 date=val;
                                                
                                                setState(() {
                                                  log("date  :$date");
                                                });
                                              },
                                             
                                             ),
                                           ),
                                         ),  
                                         
                                          SizedBox(height: 10,),
                                         Padding(
                                           padding:  EdgeInsets.only(left:20.0.w,right: 170.w),
                                           child: Container(
                                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
                                             child: DateTimePicker(

                                              decoration: InputDecoration(
                                                labelText: "select time",
                                                
                                                contentPadding: EdgeInsets.only(left: 10),
                                                border: InputBorder.none),
                                              type: DateTimePickerType.time,
                                              // use24HourFormat: false,
                                             
                                            onChanged: (val){
                                              time=val;
                                              log(time.toString());
                                             
                                              setState(() {
                                                
                                              });
                                            },
                                             ),
                                           ),
                                         ),
                                      ]),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 8.0.w),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      height: 80.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/inner1.jpg"))),
                                    )),
                                    SizedBox(
                                      width: 8.0.w,
                                    ),
                                    Expanded(
                                        child: Container(
                                      height: 80.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/inner2.jpg"))),
                                    )),
                                    SizedBox(
                                      width: 8.0.w,
                                    ),
                                    Expanded(
                                        child: Container(
                                      height: 80.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/inner3.jpg"))),
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              // Padding(
                              //   padding:  EdgeInsets.symmetric(horizontal:10.0.w),
                              //   child: Text("Contacts", style: TextStyle(
                              //         fontSize: 18, fontWeight: FontWeight.bold),),
                              // ),
                              // SizedBox(height:20.h,),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //   Container(height: 50.h,width: 50.w,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black),child: Icon(Icons.facebook_outlined,color: Colors.white,size: 45,),),
                              //    Container(height: 50.h,width: 50.w,decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(image: AssetImage("images/instag.png",),fit: BoxFit.cover)),),
                              //    Container(height: 50.h,width: 50.w,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black,image: DecorationImage(image: AssetImage("images/whatsapp.jpg")))),
                              //    Container(height: 50.h,width: 50.w,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black),),
                              // ],)

                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      print("aaaaaaaaaaaaaaaaaaaa${haircut}");
                                      print("bbbbbbbbbbbbbbbbbbb${beared}");
                                      print("cccccccccccccccccccc${trimming}");
                                      print("dddddddddddddddddddd${skincare}");
                                      print("eeeeeeeeeeeeeeeeeeee${facial}");
                                      print("ffffffffffffffffffff${treatment}");
                                      print("gggggggggggggggggggg${mask}");
                                      print("hhhhhhhhhhhhhhhhhhhh${cure}");
                                      print("iiiiiiiiiiiiiiiiiiiii${other}");
                                     

                                      //  if (_formKey.currentState!.validate()) {
                                      widgetProvider.setCircular(true);
                                      // await widgetProvider.uploadImage(context);
                                      // await userProvider
                                      //     .getUser(widgetProvider.selectUser);
                                      // print(
                                      //     "this is user image provided ${userProvider.userImage}");

                                      userProvider.bookservicesTask(
                                          taskModell: BookServicesModel(
                                              haircutm: haircut,
                                              bearedm: beared,
                                              trimmingm: trimming,
                                              skincarem: skincare,
                                              facialm: facial,
                                              treatmentm: treatment,
                                              maskm: mask,
                                              curem: cure,
                                              othersm: other,
                                              servicetimedatem:
                                                  dob.toString(),
                                                  status:  'Panding'
                                                  ));
                                      // print('sender Token $senderToken');
                                      // makePostRequest("Dijilla", "you received a new task",
                                      //     senderToken!);
                                      widgetProvider.setCircular(false);
                                      CustomWidgets().successAwesomeDialog(
                                          context, "Task created Successfully");
                                    },
                                    child: Container(
                                      width: screenSize.width * 0.7,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black,
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Book Now",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ]),
                  ),
                )));
  }
}
