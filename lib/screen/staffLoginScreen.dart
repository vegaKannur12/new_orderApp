import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/screen/dashboard.dart';
import 'package:provider/provider.dart';

import '../components/waveclipper.dart';
import 'downloadedPage.dart';

class StaffLogin extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ValueNotifier<bool> visible = ValueNotifier(false);
  // final _formKey = GlobalKey<FormState>();
  toggle() {
    visible.value = !visible.value;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: P_Settings.wavecolor,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         exit(0);
        //       },
        //       icon: Icon(Icons.close))
        // ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: LayoutBuilder(
            builder: (context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Container(
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: P_Settings.wavecolor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.30,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    radius: 40,
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(30),
                              child: Column(
                                children: <Widget>[
                                  customTextField(
                                      "Username", controller1, "staff"),

                                  customTextField(
                                      "Password", controller2, "password"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: P_Settings.wavecolor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20), // <-- Radius
                                        ),
                                      ),
                                      onPressed: () async {
                                        // toggle();
                                        if (_formKey.currentState!.validate()) {
                                          String result = await OrderAppDB
                                              .instance
                                              .selectStaff(controller1.text,
                                                  controller2.text);
                                          if (result == "success") {
                                            visible.value = false;
                                            print("visible===${visible.value}");
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Dashboard()),
                                            );
                                          } else {
                                            visible.value = true;
                                            print("visible===${visible.value}");
                                          }
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'LOGIN',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, top: 25),
                                    child: Container(
                                      height: size.height * 0.07,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),

                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DownloadedPage()),
                                              );
                                            },
                                            color: P_Settings.wavecolor,
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.download,
                                              size: 24,
                                            ),
                                            padding: EdgeInsets.all(16),
                                            shape: CircleBorder(),
                                          ),
                                          //////////////////////////////
                                          MaterialButton(
                                            onPressed: () {
                                              exit(0);
                                            },
                                            color: P_Settings.wavecolor,
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.close,
                                              size: 24,
                                            ),
                                            padding: EdgeInsets.all(16),
                                            shape: CircleBorder(),
                                          ),

                                          MaterialButton(
                                            onPressed: () {},
                                            color: P_Settings.wavecolor,
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.refresh,
                                              size: 24,
                                            ),
                                            padding: EdgeInsets.all(16),
                                            shape: CircleBorder(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  ValueListenableBuilder(
                                      valueListenable: visible,
                                      builder: (BuildContext context, bool v,
                                          Widget? child) {
                                        print("value===${visible.value}");
                                        return Visibility(
                                          visible: v,
                                          child: Text(
                                            "Incorrect Username or Password!!!",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        );
                                      })
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

/////////////////////////////////////////////////////////////////////////
  Widget customTextField(
      String hinttext, TextEditingController controllerValue, String type) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          obscureText: type == "password" ? true : false,
          controller: controllerValue,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 3,
                ),
              ),
              hintText: hinttext.toString()),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Please Enter ${hinttext}';
            }
            return null;
          },
        ),
      ),
    );
  }
}

//Costom CLipper class with Path
