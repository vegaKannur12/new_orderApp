import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/areaPopup.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();

  static void dispose() {}
}

class _MainDashboardState extends State<MainDashboard> {
  DateTime date = DateTime.now();
  String? formattedDate;
  String? selected;
  List<String> s = [];
  AreaSelectionPopup popup = AreaSelectionPopup();
  String? sid;
  final _random = Random();

  sharedPref() async {
    print("helooo");
    final prefs = await SharedPreferences.getInstance();
    sid = prefs.getString('sid');
    print("sid ......$sid");
    print("formattedDate...$formattedDate");
    Future.delayed(Duration(milliseconds: 1000), () {
      Provider.of<Controller>(context, listen: false).getArea(sid!);
      Provider.of<Controller>(context, listen: false)
          .selectTotalPrice(sid!, s[0]);
      Provider.of<Controller>(context, listen: false)
          .selectOrderCount(sid!, s[0]);
      Provider.of<Controller>(context, listen: false)
          .selectCollectionPrice(sid!, s[0]);
      Provider.of<Controller>(context, listen: false)
          .collectionCountFun(sid!, s[0]);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init");
    formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    s = formattedDate!.split(" ");
  }

  @override
  void didChangeDependencies() {
    print("didchange");
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    sharedPref();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Consumer<Controller>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return SpinKitFadingCircle(
                color: P_Settings.wavecolor,
              );
            } else {
              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          // topLeft: Radius.circular(95),
                          // topRight: Radius.circular(95),
                          ),
                      color: Color.fromARGB(255, 255, 255, 255)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.08,
                          width: double.infinity,
                          // color: P_Settings.collection,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CircleAvatar(
                                      radius: 15,
                                      child: Icon(
                                        Icons.person,
                                        color: P_Settings.wavecolor,
                                      ),
                                      backgroundColor:
                                          Color.fromARGB(255, 214, 201, 200),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  Text("${value.cname}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: P_Settings.wavecolor)),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  Text("- ${value.sname}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: P_Settings.collection1)),
                                  // Spacer(),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        buildPopupDialog(context, size);
                                      },
                                      icon: Icon(
                                        Icons.place,
                                        color: Colors.red,
                                      )),
                                  Flexible(
                                    child: Text(value.areaSelecton == null
                                        ? ""
                                        : value.areaSelecton!),
                                  ),
                                  // Spacer(),
                                  
                                ],
                              ),
                              Divider(
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Todays",
                          style: TextStyle(
                              fontSize: 20,
                              color: P_Settings.wavecolor,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          child: Container(
                            height: size.height * 0.9,
                            color: Color.fromARGB(255, 255, 255, 255),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: P_Settings.dashbordcl3,
                                          ),
                                          height: size.height * 0.1,
                                          width: size.height * 0.2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Collection",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: P_Settings
                                                          .detailscolor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Text(
                                                  "${value.collectionCount.length != 0 && value.collectionCount[0]['S'] != null && value.collectionCount.isNotEmpty ? value.collectionCount[0]['S'] : "0"}",
                                                  style: TextStyle(
                                                      color: P_Settings
                                                          .detailscolor,
                                                      fontSize: 15),
                                                ),
                                                // Text(
                                                //   "\u{20B9}${value.sumPrice[0]['S']}",
                                                //   style: TextStyle(fontSize: 15),
                                                // )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: P_Settings.dashbordcl1,
                                          ),
                                          height: size.height * 0.1,
                                          width: size.height * 0.2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Orders",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: P_Settings
                                                          .detailscolor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Text(
                                                  "${value.orderCount.length != 0 && value.orderCount[0]['S'] != null && value.orderCount.isNotEmpty ? value.orderCount[0]['S'] : "0"}",
                                                  style: TextStyle(
                                                      color: P_Settings
                                                          .detailscolor,
                                                      fontSize: 15),
                                                ),
                                                // Text(
                                                //   "\u{20B9}${value.sumPrice[0]['S']}",
                                                //   style: TextStyle(fontSize: 15),
                                                // )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Flexible(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl2,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Sales",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: P_Settings
                                                            .detailscolor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl1,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Return",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: P_Settings
                                                            .detailscolor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        color: P_Settings
                                                            .detailscolor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  // Text(
                                                  //   "\u{20B9}${value.sumPrice[0]['S']}",
                                                  //   style: TextStyle(fontSize: 15),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   height: size.height * 0.01,
                                // ),
                                Flexible(
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl3,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Shop Visited",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: P_Settings
                                                            .detailscolor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl2,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: P_Settings
                                                            .detailscolor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        color: P_Settings
                                                            .detailscolor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  // Text(
                                                  //   "\u{20B9}${value.sumPrice[0]['S']}",
                                                  //   style: TextStyle(fontSize: 15),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      alignment: Alignment.center,
                                      height: size.height * 0.05,
                                      width: double.infinity,
                                      child: Text(
                                        "Today Collection",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: P_Settings.wavecolor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl1,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Collection",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: P_Settings
                                                            .detailscolor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Text(
                                                    "\u{20B9}${value.collectionsumPrice.length != 0 && value.collectionsumPrice[0]['S'] != null && value.collectionsumPrice.isNotEmpty ? value.collectionsumPrice[0]['S'] : "0"}",
                                                    style: TextStyle(
                                                        color: P_Settings
                                                            .detailscolor,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl3,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Orders",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: P_Settings
                                                            .detailscolor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Text(
                                                    "\u{20B9}${value.sumPrice.length != 0 && value.sumPrice[0]['s'] != null && value.sumPrice.isNotEmpty ? value.sumPrice[0]['s'] : "0"}",
                                                    style: TextStyle(
                                                        color: P_Settings
                                                            .detailscolor,
                                                        fontSize: 15),
                                                  ),
                                                  // Text(
                                                  //   "\u{20B9}${value.sumPrice[0]['S']}",
                                                  //   style: TextStyle(fontSize: 15),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: P_Settings.dashbordcl2,
                                              ),
                                              height: size.height * 0.1,
                                              width: size.height * 0.2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Sales",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: P_Settings
                                                              .detailscolor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl1,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Return",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: P_Settings
                                                            .detailscolor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        color: P_Settings
                                                            .detailscolor,
                                                        fontSize: 15),
                                                  ),
                                                  // Text(
                                                  //   "\u{20B9}${value.sumPrice[0]['S']}",
                                                  //   style: TextStyle(fontSize: 15),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: P_Settings.dashbordcl3,
                                              ),
                                              height: size.height * 0.1,
                                              width: size.height * 0.2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Shop Visited",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: P_Settings
                                                              .detailscolor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: P_Settings.dashbordcl2,
                                            ),
                                            height: size.height * 0.1,
                                            width: size.height * 0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: P_Settings
                                                            .detailscolor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        color: P_Settings
                                                            .extracolor,
                                                        fontSize: 18),
                                                  ),
                                                  // Text(
                                                  //   "\u{20B9}${value.sumPrice[0]['S']}",
                                                  //   style: TextStyle(fontSize: 15),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  //////////////////////////////////////////////////////////////////////

  buildPopupDialog(BuildContext context, Size size) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return new AlertDialog(
              content: Consumer<Controller>(builder: (context, value, child) {
                if (value.isLoading) {
                  return CircularProgressIndicator();
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.grey[200],
                        height: size.height * 0.04,
                        child: DropdownButton<String>(
                          value: selected,
                          hint: Text("Select"),
                          isExpanded: true,
                          autofocus: false,
                          underline: SizedBox(),
                          elevation: 0,
                          items: value.areDetails
                              .map((item) => DropdownMenuItem<String>(
                                  value: item["aid"].toString(),
                                  child: Container(
                                    width: size.width * 0.5,
                                    child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(item["aname"].toString())),
                                  )))
                              .toList(),
                          onChanged: (item) {
                            print("clicked");

                            if (item != null) {
                              setState(() {
                                selected = item;
                              });
                              print("se;ected---$item");
                            }
                          },
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Provider.of<Controller>(context, listen: false)
                                .areaSelection(selected!);
                            Navigator.pop(context);
                          },
                          child: Text("save"))
                    ],
                  );
                }
              }),
            );
          });
        });
  }
}
