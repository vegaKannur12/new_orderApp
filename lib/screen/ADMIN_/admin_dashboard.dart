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

  final json = [
    {
      "heading": "helloo",
      "data": [
        {"caption": "sales", "value": "10"},
        {"caption": "sales", "value": "10"},
        {"caption": "sales", "value": "10"},
      ]
    },
    {
      "heading": "helloo",
      "data": [
        {"caption": "sales", "value": "10"}
      ]
    }
  ];

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
                    // CircleAvatar(
                    //   radius: 15,
                    //   child: Icon(
                    //     Icons.person,
                    //     color: P_Settings.wavecolor,
                    //   ),
                    // ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    // Text("${value.cname}",
                    //     style: TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.bold,
                    //         color: P_Settings.wavecolor)),
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
                        ? Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text("${value.heading}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: P_Settings.wavecolor)),
                                  Flexible(
                                    child: Text(" : ${value.updateDate}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: P_Settings.extracolor)),
                                  ),
                                ],
                              ),
                            ),
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
              // SizedBox(
              //   height: size.height * 0.03,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                child: Divider(thickness: 2),
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

  Widget gridHeader(
    List listHeader,
  ) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: listHeader.length,
      itemBuilder: (context, index) {
        return StickyHeader(
          header: Container(
            height: 50.0,
            color: Colors.white,
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              listHeader[index],
              style: TextStyle(
                  color: P_Settings.wavecolor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listTitle.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: (contxt, indx) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(4.0),
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  // color: Colors.grey[400],
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, top: 6.0, bottom: 2.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: size.height * 0.08,
                              width: size.width * 0.12,
                              child: Image.asset("asset/3.png"),
                            ),
                            Text(
                              listTitle[indx],
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "5",
                              style:
                                  TextStyle(fontSize: 23, color: Colors.white),
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
        );
      },
      shrinkWrap: true,
    );
  }

  Widget rowChild(Today list, Size size) {
    print("listtt$list");
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(list.group.toString(),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: P_Settings.wavecolor)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: list.data!.length,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: list.tileCount == 1 ? 1 : 2,
                  childAspectRatio: list.tileCount == 1 ? 3.2 : 1.1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: (contxt, indx) {
                return Container(
                  child: Card(
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
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
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
