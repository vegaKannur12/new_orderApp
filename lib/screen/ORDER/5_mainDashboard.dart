import 'dart:async';
import 'dart:math';

import 'package:background_mode_new/background_mode_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/areaPopup.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class MainDashboard extends StatefulWidget {
  BuildContext context;
  MainDashboard({required this.context});

  @override
  State<MainDashboard> createState() => _MainDashboardState();

  static void dispose() {}
}

class _MainDashboardState extends State<MainDashboard> {
  DateTime date = DateTime.now();
  String? formattedDate;
  String? gen_condition;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String? userType;
  String? selected;
  List<String> s = [];
  AreaSelectionPopup popup = AreaSelectionPopup();
  String? sid;

  sharedPref() async {
    formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    s = formattedDate!.split(" ");
    final prefs = await SharedPreferences.getInstance();
    sid = prefs.getString('sid');
    userType = prefs.getString("userType");
    print("sid .sdd.....$sid");

    print("formattedDate...$formattedDate");
    print("sid ......$sid");

    // if (Provider.of<Controller>(context, listen: false).areaId != null) {
    //   Provider.of<Controller>(context, listen: false).dashboardSummery(
    //       sid!,
    //       s[0],
    //       Provider.of<Controller>(context, listen: false).areaId!,
    //       widget.context);
    // } else {
    //   if (userType == "staff") {
    //     Provider.of<Controller>(context, listen: false)
    //         .dashboardSummery(sid!, s[0], "",widget.context);
    //   }
    // }
    // Provider.of<Controller>(context, listen: false).todayOrder(s[0], context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => build(context));
    // initPlatformState();
    print("init");
    sharedPref();

    // String? gen_area = Provider.of<Controller>(context, listen: false).areaId;
    // print("gen area----$gen_area");
    // if (gen_area != null) {
    //   gen_condition = " and accountHeadsTable.area_id=$gen_area";
    // } else {
    //   gen_condition = " ";
    // }
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
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.person,
                              color: P_Settings.wavecolor,
                            ),
                          ),
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text(
                                    "${value.cname}",
                                    style: GoogleFonts.alike(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                        fontSize: 16),
                                  ),
                                  Text(" - ${value.sname?.toUpperCase()}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: P_Settings.collection1,
                                          fontStyle: FontStyle.italic)),
                                  IconButton(
                                      onPressed: () {
                                        buildPopupDialog(context, size);
                                      },
                                      icon: Icon(
                                        Icons.place,
                                        color: Colors.red,
                                      )),
                                  Text(
                                    value.areaSelecton == null
                                        ? ""
                                        : value.areaSelecton!,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Todays  ",
                                style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.headline1,
                                  fontSize: 20,
                                ),
                              ),
                              Text(" -  ${s[0]}",
                                  style: GoogleFonts.alike(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      fontSize: 16,
                                      color: Colors.green))
                            ],
                          ),
                        ),
                        // SizedBox(height: size.height*01,),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Orders",
                                  "${value.orderCount != "null" ? value.orderCount : "0"}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Collection",
                                  "${value.collectionCount != "null" ? value.collectionCount : "0"}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Sales",
                                  "${value.salesCount != "null" ? value.salesCount : "0"}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Return",
                                  "${value.ret_count != "null" ? value.ret_count : "0"}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(
                                size,
                                "Shops visited",
                                "${value.shopVisited != null ? value.shopVisited : "0"}",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Shops Not Visited",
                                  "${value.noshopVisited != null ? value.noshopVisited : "0"}"),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Todays Collection ",
                                      style: GoogleFonts.alike(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                        fontSize: 20,
                                      )),
                                  Text("-  ${s[0]}",
                                      style: GoogleFonts.alike(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          fontSize: 16,
                                          color: Colors.green))
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Orders",
                                  "\u{20B9}${value.ordrAmount == "null" ? "0.0" : value.ordrAmount}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Collection",
                                  "\u{20B9}${value.collectionAmount == "null" ? "0.00" : value.collectionAmount}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Sales",
                                  "\u{20B9}${value.salesAmount == "null" ? "0.0" : value.salesAmount}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Return",
                                  "\u{20B9}${value.returnAmount == "null" ? "0.0" : value.returnAmount}"),
                            ),
                          ],
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
            return AlertDialog(
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
                                        child: Text(
                                          item["aname"].toString(),
                                          style: TextStyle(fontSize: 13),
                                        )),
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
                          onPressed: () async {
                            if (selected != null) {
                              Provider.of<Controller>(context, listen: false)
                                  .areaId = selected;
                              Provider.of<Controller>(context, listen: false)
                                  .areaSelection(selected!);
                              Provider.of<Controller>(context, listen: false)
                                  .dashboardSummery(
                                      sid!, s[0], selected!, context);
                              String? gen_area = Provider.of<Controller>(
                                      context,
                                      listen: false)
                                  .areaidFrompopup;
                              if (gen_area != null) {
                                gen_condition =
                                    " and accountHeadsTable.area_id=$gen_area";
                              } else {
                                gen_condition = " ";
                              }
                              Provider.of<Controller>(context, listen: false)
                                  .todayOrder(s[0], gen_condition!);
                              Provider.of<Controller>(context, listen: false)
                                  .todayCollection(s[0], gen_condition!);
                              Provider.of<Controller>(context, listen: false)
                                  .todaySales(s[0], gen_condition!);
                              Provider.of<Controller>(context, listen: false)
                                  .selectReportFromOrder(
                                      context, sid!, s[0], "");
                            }

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
    print("valuenjn-----$value");
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
                            : title == "Shops Not Visited"
                                ? P_Settings.dashbordcl6
                                : Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: size.height * 0.1,
                width: size.width * 0.12,
                child: title == "Orders"
                    ? Image.asset("asset/3.png")
                    : title == "Collection"
                        ? Image.asset("asset/4.png")
                        : title == "Sales"
                            ? Image.asset("asset/2.png")
                            : title == "Shops visited"
                                ? Image.asset("asset/5.png")
                                : title == "Shops Not Visited"
                                    ? Image.asset("asset/6.png")
                                    : title == "Return"
                                        ? Image.asset("asset/7.png")
                                        : null,
              ),
              Text(title.toString(),
                  style: GoogleFonts.alike(
                    textStyle: Theme.of(context).textTheme.bodyText1,
                    fontSize: 16,
                    color: Colors.white,
                  )),
              Text(value == "null" ? "0" : value.toString(),
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
