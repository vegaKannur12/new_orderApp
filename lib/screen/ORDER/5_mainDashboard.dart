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
                              SizedBox(height: size.height*0.02,),
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
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(value.areaSelecton == null
                                        ? ""
                                        : value.areaSelecton!),
                                  ),
                                  // Spacer(),
                                ],
                              ),
                              // Divider(
                              //   thickness: 1,
                              // ),
                            ],
                          ),
                        ),
                        Text(
                          "Todays",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(height: size.height*01,),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Orders",
                                  "${value.orderCount.length != 0 && value.orderCount[0]['S'] != null && value.orderCount.isNotEmpty ? value.orderCount[0]['S'] : "0"}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Collection",
                                  "${value.collectionCount.length != 0 && value.collectionCount[0]['S'] != null && value.collectionCount.isNotEmpty ? value.collectionCount[0]['S'] : "0"}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Sales", ""),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Return", ""),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Shops visited", ""),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "No shop visited", ""),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Todays Collection",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Orders",
                                  "\u{20B9}${value.sumPrice.length != 0 && value.sumPrice[0]['s'] != null && value.sumPrice.isNotEmpty ? value.sumPrice[0]['s'] : "0"}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Collection",
                                  "\u{20B9}${value.collectionsumPrice.length != 0 && value.collectionsumPrice[0]['S'] != null && value.collectionsumPrice.isNotEmpty ? value.collectionsumPrice[0]['S'] : "0"}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Sales", ""),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Return", ""),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Shops visited", ""),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "No shop visited", ""),
                            ),
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     height: size.height * 0.7,
                        //     child: GridView.builder(
                        //         gridDelegate:
                        //             const SliverGridDelegateWithFixedCrossAxisCount(
                        //                 crossAxisCount: 2, mainAxisExtent: 150),
                        //         itemCount: card.length,
                        //         itemBuilder: (BuildContext context, int index) {
                        //           return customcard();
                        //         }),
                        //   ),
                        // )
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       top: 20, left: 10, right: 10),
                        //   child: Container(
                        //     height: size.height * 0.9,
                        //     color: Color.fromARGB(255, 255, 255, 255),
                        //     child: Column(
                        //       children: [
                        //         Row(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Flexible(
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(10.0),
                        //                 child: Container(
                        //                   decoration: BoxDecoration(
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(20)),
                        //                     color: P_Settings.dashbordcl3,
                        //                   ),
                        //                   height: size.height * 0.1,
                        //                   width: size.height * 0.2,
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.all(8.0),
                        //                     child: Column(
                        //                       children: [
                        //                         Text(
                        //                           "Collection",
                        //                           style: TextStyle(
                        //                               fontSize: 18,
                        //                               color: P_Settings
                        //                                   .detailscolor,
                        //                               fontWeight:
                        //                                   FontWeight.bold),
                        //                         ),
                        //                         SizedBox(
                        //                           height: size.height * 0.01,
                        //                         ),
                        //                         Text(
                        //                           "${value.collectionCount.length != 0 && value.collectionCount[0]['S'] != null && value.collectionCount.isNotEmpty ? value.collectionCount[0]['S'] : "0"}",
                        //                           style: TextStyle(
                        //                               color: P_Settings
                        //                                   .detailscolor,
                        //                               fontSize: 15),
                        //                         ),
                        //                         // Text(
                        //                         //   "\u{20B9}${value.sumPrice[0]['S']}",
                        //                         //   style: TextStyle(fontSize: 15),
                        //                         // )
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             Flexible(
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(10.0),
                        //                 child: Container(
                        //                   decoration: BoxDecoration(
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(20)),
                        //                     color: P_Settings.dashbordcl1,
                        //                   ),
                        //                   height: size.height * 0.1,
                        //                   width: size.height * 0.2,
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.all(8.0),
                        //                     child: Column(
                        //                       children: [
                        //                         Text(
                        //                           "Orders",
                        //                           style: TextStyle(
                        //                               fontSize: 18,
                        //                               color: P_Settings
                        //                                   .detailscolor,
                        //                               fontWeight:
                        //                                   FontWeight.bold),
                        //                         ),
                        //                         SizedBox(
                        //                           height: size.height * 0.01,
                        //                         ),
                        //                         Text(
                        //                           "${value.orderCount.length != 0 && value.orderCount[0]['S'] != null && value.orderCount.isNotEmpty ? value.orderCount[0]['S'] : "0"}",
                        //                           style: TextStyle(
                        //                               color: P_Settings
                        //                                   .detailscolor,
                        //                               fontSize: 15),
                        //                         ),
                        //                         // Text(
                        //                         //   "\u{20B9}${value.sumPrice[0]['S']}",
                        //                         //   style: TextStyle(fontSize: 15),
                        //                         // )
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         SizedBox(
                        //           height: size.height * 0.01,
                        //         ),
                        //         Flexible(
                        //           child: Row(
                        //             children: [
                        //               Flexible(
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(10.0),
                        //                   child: Container(
                        //                     decoration: BoxDecoration(
                        //                       borderRadius: BorderRadius.all(
                        //                           Radius.circular(20)),
                        //                       color: P_Settings.dashbordcl2,
                        //                     ),
                        //                     height: size.height * 0.1,
                        //                     width: size.height * 0.2,
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: Column(
                        //                         children: [
                        //                           Text(
                        //                             "Sales",
                        //                             style: TextStyle(
                        //                                 fontSize: 18,
                        //                                 color: P_Settings
                        //                                     .detailscolor,
                        //                                 fontWeight:
                        //                                     FontWeight.bold),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //               Flexible(
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(10.0),
                        //                   child: Container(
                        //                     decoration: BoxDecoration(
                        //                       borderRadius: BorderRadius.all(
                        //                           Radius.circular(20)),
                        //                       color: P_Settings.dashbordcl1,
                        //                     ),
                        //                     height: size.height * 0.1,
                        //                     width: size.height * 0.2,
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: Column(
                        //                         children: [
                        //                           Text(
                        //                             "Return",
                        //                             style: TextStyle(
                        //                                 fontSize: 18,
                        //                                 color: P_Settings
                        //                                     .detailscolor,
                        //                                 fontWeight:
                        //                                     FontWeight.bold),
                        //                           ),
                        //                           SizedBox(
                        //                             height: size.height * 0.01,
                        //                           ),
                        //                           Text(
                        //                             "",
                        //                             style: TextStyle(
                        //                                 color: P_Settings
                        //                                     .detailscolor,
                        //                                 fontSize: 15,
                        //                                 fontWeight:
                        //                                     FontWeight.bold),
                        //                           ),
                        //                           // Text(
                        //                           //   "\u{20B9}${value.sumPrice[0]['S']}",
                        //                           //   style: TextStyle(fontSize: 15),
                        //                           // )
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // SizedBox(
                        //         //   height: size.height * 0.01,
                        //         // ),
                        //         Flexible(
                        //           child: Row(
                        //             // mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Flexible(
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(10.0),
                        //                   child: Container(
                        //                     decoration: BoxDecoration(
                        //                       borderRadius: BorderRadius.all(
                        //                           Radius.circular(20)),
                        //                       color: P_Settings.dashbordcl3,
                        //                     ),
                        //                     height: size.height * 0.1,
                        //                     width: size.height * 0.2,
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: Column(
                        //                         children: [
                        //                           Text(
                        //                             "Shop Visited",
                        //                             style: TextStyle(
                        //                                 fontSize: 18,
                        //                                 color: P_Settings
                        //                                     .detailscolor,
                        //                                 fontWeight:
                        //                                     FontWeight.bold),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //               Flexible(
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(10.0),
                        //                   child: Container(
                        //                     decoration: BoxDecoration(
                        //                       borderRadius: BorderRadius.all(
                        //                           Radius.circular(20)),
                        //                       color: P_Settings.dashbordcl2,
                        //                     ),
                        //                     height: size.height * 0.1,
                        //                     width: size.height * 0.2,
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: Column(
                        //                         children: [
                        //                           Text(
                        //                             "",
                        //                             style: TextStyle(
                        //                                 fontSize: 18,
                        //                                 color: P_Settings
                        //                                     .detailscolor,
                        //                                 fontWeight:
                        //                                     FontWeight.bold),
                        //                           ),
                        //                           SizedBox(
                        //                             height: size.height * 0.01,
                        //                           ),
                        //                           Text(
                        //                             "",
                        //                             style: TextStyle(
                        //                                 color: P_Settings
                        //                                     .detailscolor,
                        //                                 fontSize: 15,
                        //                                 fontWeight:
                        //                                     FontWeight.bold),
                        //                           ),
                        //                           // Text(
                        //                           //   "\u{20B9}${value.sumPrice[0]['S']}",
                        //                           //   style: TextStyle(fontSize: 15),
                        //                           // )
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         Column(
                        //           children: [
                        //             Container(
                        //               color: Colors.white,
                        //               alignment: Alignment.center,
                        //               height: size.height * 0.05,
                        //               width: double.infinity,
                        //               child: Text(
                        //                 "Today Collection",
                        //                 style: TextStyle(
                        //                     fontSize: 20,
                        //                     color: P_Settings.wavecolor,
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //             ),
                        //             Row(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //               children: [
                        //                 Padding(
                        //                   padding: const EdgeInsets.all(10.0),
                        //                   child: Container(
                        //                     decoration: BoxDecoration(
                        //                       borderRadius: BorderRadius.all(
                        //                           Radius.circular(20)),
                        //                       color: P_Settings.dashbordcl1,
                        //                     ),
                        //                     height: size.height * 0.1,
                        //                     width: size.height * 0.2,
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: Column(
                        //                         children: [
                        //                           Text(
                        //                             "Collection",
                        //                             style: TextStyle(
                        //                                 fontSize: 18,
                        //                                 color: P_Settings
                        //                                     .detailscolor,
                        //                                 fontWeight:
                        //                                     FontWeight.bold),
                        //                           ),
                        //                           SizedBox(
                        //                             height: size.height * 0.01,
                        //                           ),
                        //                           Text(
                        //                             "\u{20B9}${value.collectionsumPrice.length != 0 && value.collectionsumPrice[0]['S'] != null && value.collectionsumPrice.isNotEmpty ? value.collectionsumPrice[0]['S'] : "0"}",
                        //                             style: TextStyle(
                        //                                 color: P_Settings
                        //                                     .detailscolor,
                        //                                 fontSize: 15),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Padding(
                        //                   padding: const EdgeInsets.all(10.0),
                        //                   child: Container(
                        //                     decoration: BoxDecoration(
                        //                       borderRadius: BorderRadius.all(
                        //                           Radius.circular(20)),
                        //                       color: P_Settings.dashbordcl3,
                        //                     ),
                        //                     height: size.height * 0.1,
                        //                     width: size.height * 0.2,
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: Column(
                        //                         children: [
                        //                           Text(
                        //                             "Orders",
                        //                             style: TextStyle(
                        //                                 fontSize: 18,
                        //                                 color: P_Settings
                        //                                     .detailscolor,
                        //                                 fontWeight:
                        //                                     FontWeight.bold),
                        //                           ),
                        //                           SizedBox(
                        //                             height: size.height * 0.01,
                        //                           ),
                        //                           Text(
                        //                             "\u{20B9}${value.sumPrice.length != 0 && value.sumPrice[0]['s'] != null && value.sumPrice.isNotEmpty ? value.sumPrice[0]['s'] : "0"}",
                        //                             style: TextStyle(
                        //                                 color: P_Settings
                        //                                     .detailscolor,
                        //                                 fontSize: 15),
                        //                           ),
                        //                           // Text(
                        //                           //   "\u{20B9}${value.sumPrice[0]['S']}",
                        //                           //   style: TextStyle(fontSize: 15),
                        //                           // )
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //             SizedBox(
                        //               height: size.height * 0.01,
                        //             ),
                        //             Row(
                        //               children: [
                        //                 Flexible(
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.all(10.0),
                        //                     child: Container(
                        //                       decoration: BoxDecoration(
                        //                         borderRadius: BorderRadius.all(
                        //                             Radius.circular(20)),
                        //                         color: P_Settings.dashbordcl2,
                        //                       ),
                        //                       height: size.height * 0.1,
                        //                       width: size.height * 0.2,
                        //                       child: Padding(
                        //                         padding:
                        //                             const EdgeInsets.all(8.0),
                        //                         child: Column(
                        //                           children: [
                        //                             Text(
                        //                               "Sales",
                        //                               style: TextStyle(
                        //                                   fontSize: 18,
                        //                                   color: P_Settings
                        //                                       .detailscolor,
                        //                                   fontWeight:
                        //                                       FontWeight.bold),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Padding(
                        //                   padding: const EdgeInsets.all(10.0),
                        //                   child: Container(
                        //                     decoration: BoxDecoration(
                        //                       borderRadius: BorderRadius.all(
                        //                           Radius.circular(20)),
                        //                       color: P_Settings.dashbordcl1,
                        //                     ),
                        //                     height: size.height * 0.1,
                        //                     width: size.height * 0.2,
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: Column(
                        //                         children: [
                        //                           Text(
                        //                             "Return",
                        //                             style: TextStyle(
                        //                                 fontSize: 18,
                        //                                 color: P_Settings
                        //                                     .detailscolor,
                        //                                 fontWeight:
                        //                                     FontWeight.bold),
                        //                           ),
                        //                           SizedBox(
                        //                             height: size.height * 0.01,
                        //                           ),
                        //                           Text(
                        //                             "",
                        //                             style: TextStyle(
                        //                                 color: P_Settings
                        //                                     .detailscolor,
                        //                                 fontSize: 15),
                        //                           ),
                        //                           // Text(
                        //                           //   "\u{20B9}${value.sumPrice[0]['S']}",
                        //                           //   style: TextStyle(fontSize: 15),
                        //                           // )
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //             SizedBox(
                        //               height: size.height * 0.01,
                        //             ),
                        //             Row(
                        //               children: [
                        //                 Flexible(
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.all(10.0),
                        //                     child: Container(
                        //                       decoration: BoxDecoration(
                        //                         borderRadius: BorderRadius.all(
                        //                             Radius.circular(20)),
                        //                         color: P_Settings.dashbordcl3,
                        //                       ),
                        //                       height: size.height * 0.1,
                        //                       width: size.height * 0.2,
                        //                       child: Padding(
                        //                         padding:
                        //                             const EdgeInsets.all(8.0),
                        //                         child: Column(
                        //                           children: [
                        //                             Text(
                        //                               "Shop Visited",
                        //                               style: TextStyle(
                        //                                   fontSize: 18,
                        //                                   color: P_Settings
                        //                                       .detailscolor,
                        //                                   fontWeight:
                        //                                       FontWeight.bold),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Padding(
                        //                   padding: const EdgeInsets.all(10.0),
                        //                   child: Container(
                        //                     decoration: BoxDecoration(
                        //                       borderRadius: BorderRadius.all(
                        //                           Radius.circular(20)),
                        //                       color: P_Settings.dashbordcl2,
                        //                     ),
                        //                     height: size.height * 0.1,
                        //                     width: size.height * 0.2,
                        //                     child: Padding(
                        //                       padding:
                        //                           const EdgeInsets.all(8.0),
                        //                       child: Column(
                        //                         children: [
                        //                           Text(
                        //                             "",
                        //                             style: TextStyle(
                        //                                 fontSize: 18,
                        //                                 color: P_Settings
                        //                                     .detailscolor,
                        //                                 fontWeight:
                        //                                     FontWeight.bold),
                        //                           ),
                        //                           SizedBox(
                        //                             height: size.height * 0.01,
                        //                           ),
                        //                           Text(
                        //                             "",
                        //                             style: TextStyle(
                        //                                 color: P_Settings
                        //                                     .extracolor,
                        //                                 fontSize: 18),
                        //                           ),
                        //                           // Text(
                        //                           //   "\u{20B9}${value.sumPrice[0]['S']}",
                        //                           //   style: TextStyle(fontSize: 15),
                        //                           // )
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
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

  //////////////////////////////////////////////////////////////////////
  Widget customcard(
    Size size,
    String title,
    String value,
  ) {
    return Container(
      height: size.height * 0.2,
      width: size.width * 0.45,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        color: title == "Orders"
            ? P_Settings.dashbordcl1
            : title == "Collection"
                ? P_Settings.dashbordcl2
                : title == "Sales"
                    ? P_Settings.dashbordcl3
                    : title == "Return"
                        ? P_Settings.dashbordcl4
                        : title == "Shops visited"
                            ? P_Settings.dashbordcl5
                            : title == "No shop visited"
                                ? P_Settings.dashbordcl6
                                : Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title.toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(value.toString(),
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
