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
    print("formattedDates...$formattedDate");
    Future.delayed(Duration(milliseconds: 1000), () async {
      // await Provider.of<Controller>(context, listen: false)
      //     .selectTotalPrice(sid!, s[0]);
      // await Provider.of<Controller>(context, listen: false)
      //     .selectCollectionPrice(sid!, s[0]);
      // await Provider.of<Controller>(context, listen: false)
      //     .mainDashtileValues(sid!, s[0]);
      // if (!mounted) return;
      // setState(() async {
      //   await Provider.of<Controller>(context, listen: false)
      //       .selectTotalPrice(sid!, s[0]);
      //   await Provider.of<Controller>(context, listen: false)
      //       .selectCollectionPrice(sid!, s[0]);
      //   await Provider.of<Controller>(context, listen: false)
      //       .mainDashtileValues(sid!, s[0]);
      // });
      if (this.mounted) {
        setState(() {

            Provider.of<Controller>(context, listen: false)
                .selectTotalPrice(sid!, s[0]);
            Provider.of<Controller>(context, listen: false)
                .selectCollectionPrice(sid!, s[0]);
            Provider.of<Controller>(context, listen: false)
                .mainDashtileValues(sid!, s[0]);

        });
      }

      // if(mounted)return;
    });
  }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => build(context));

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
    // bool get mounted => _element != null;
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
                          title: Row(
                            children: [
                              Text("${value.cname}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: P_Settings.wavecolor)),
                              Text(" - ${value.sname}",
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
                              Expanded(
                                // scrollDirection: Axis.horizontal,
                                child: Text(
                                  value.areaSelecton == null
                                      ? ""
                                      : value.areaSelecton!,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Todays",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // SizedBox(height: size.height*01,),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Orders",
                                  "${value.orderCount != null && value.orderCount!.isNotEmpty ? value.orderCount : "0"}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "Collection",
                                  "${value.collectionCount != null && value.collectionCount!.isNotEmpty ? value.collectionCount : "0"}"),
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
                              child: customcard(
                                size,
                                "Shops visited",
                                "${value.shopVisited != null ? value.shopVisited : "0"}",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customcard(size, "No shop visited",
                                  "${value.noshopVisited != null ? value.noshopVisited : "0"}"),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Todays Collection",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold),
                              ),
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
                                : title == "No shop visited"
                                    ? Image.asset("asset/6.png")
                                    : title == "Return"
                                        ? Image.asset("asset/7.png")
                                        : null,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Icon(
              //     Icons.person,
              //     color: Colors.white,
              //     size: 50,
              //   ),
              // ),
              Text(title.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text(value.toString(),
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
