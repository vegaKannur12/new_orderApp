import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/ADMIN_/adminModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'dart:math' as math;

class AdminDashboard extends StatefulWidget {
  // const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  DateTime date = DateTime.now();
  String? formattedDate;
  String? sid;
  String? heading;
  String? updateDate;
  Color parseColor(String color) {
    print("Colorrrrr...$color");
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }

  final rnd = math.Random();

  // List<String> listHeader = [
  //   'HEADER1',
  //   'HEADER2',
  //   'HEADER3',
  //   'HEADER4',
  //   'HEADER5',
  // ];
  List<String> listTitle = [
    'collection',
    'order',
    'sale',
    'shop visited',
  ];
  sharedPref() async {
    print("helooo");
    final prefs = await SharedPreferences.getInstance();
    sid = prefs.getString('sid');
    heading = prefs.getString('heading');
    updateDate = prefs.getString('updateDate');
    print("heading ......$heading");
    // Provider.of<Controller>(context, listen: false).todayOrder(s[0], context);
  }

  @override
  void initState() {
    formattedDate = DateFormat('yyyy-MM-dd').format(date);
    // s = formattedDate!.split(" ");
    // TODO: implement initState
    super.initState();
    sharedPref();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<Controller>(
        builder: (context, value, child) {
          return Column(
            children: [
              Container(
                height: size.height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      child: Icon(
                        Icons.person,
                        color: P_Settings.wavecolor,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text("${value.cname}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: P_Settings.wavecolor)),
                    // Text("  - Admin",
                    //     style: TextStyle(
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.bold,
                    //         color: P_Settings.collection1,
                    //         fontStyle: FontStyle.italic)),
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                    value.heading != null && value.updateDate != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text("${value.heading}",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: P_Settings.wavecolor)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("${value.updateDate}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: P_Settings.extracolor)),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                height: size.height * 0.03,
                                width: size.width * 0.02,
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              ////////////////////////////////////////////////////////////////////////
              SizedBox(
                height: size.height * 0.03,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: value.adminDashboardList.length,
                  itemBuilder: (context, index) {
                    return rowChild(value.adminDashboardList[index], size);
                  },
                ),
              )
              // SingleChildScrollView(
              //   child: Container(
              //     height: size.height * 0.75,
              //     child: getSizewidget(value.adminDashboardList),
              //   ),
              // ),
            ],
          );
        },
      ),
    )
        //
        );
  }


  Widget rowChild(Today list, Size size) {
    print("listtt$list");
    return Column(
      children: [
        Text(list.group.toString(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: P_Settings.wavecolor)),
        SizedBox(
          height: size.height * 0.02,
        ),
        GridView.builder(
            shrinkWrap: true,
            itemCount: list.data!.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: list.tileCount == 1 ? 1 : 2,
                childAspectRatio: list.tileCount == 1?3:1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemBuilder: (contxt, indx) {
              return Container(
                child: Card(
                  color: P_Settings.roundedButtonColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(list.data![indx].caption.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(list.data![indx].cvalue.toString(),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
