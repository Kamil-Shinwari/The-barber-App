import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebarber/provider/manager_signin_viewmodel.dart';

import '../../provider/user_signup_viewmodel.dart';

class ProfileProvider extends StatefulWidget {
  ProfileProvider({Key? key}) : super(key: key);

  @override
  State<ProfileProvider> createState() => _ProfileProviderState();
}

class _ProfileProviderState extends State<ProfileProvider> {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ManagerSignInViewModel(),
        child: Consumer<ManagerSignInViewModel>(
            builder: (context, provider, child) {
          return SafeArea(
            child: provider.userModel.userName == null
                ?
                // Center(child: CircularProgressIndicator())
                const Center(
                    child: CircularProgressIndicator(),
                  )
                // CircularProgressIndicator()
                : Scaffold(
                    body: Container(
                    color: Colors.white,
                    child: ListView(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 20.0, bottom: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 25.0,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                            Container(
                              color: Color(0xffFFFFFF),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  'Parsonal Information',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                _status
                                                    ? _getEditIcon()
                                                    : Container(),
                                              ],
                                            )
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children:[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                            const    Text(
                                                  'Name',
                                                  style:  TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                provider.userModel.userName!,
                                                style:const TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  'Email',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                                child: Text(
                                              provider.userModel.email!,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  'Phone Num',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                provider.userModel.phoneNo!,
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  'City',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                provider.userModel.city!,
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
          );
        }));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
