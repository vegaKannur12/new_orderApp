import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  DateTime date = DateTime.now();
  String? formattedDate;
  List companyAttributes = [
    "Collection",
    "Orders",
    "Sale",
  ];
  String? sid;
  final _random = Random();
  sharedPref() async {
    print("helooo");
    final prefs = await SharedPreferences.getInstance();
    sid = prefs.getString('sid');
    print("sid ......$sid");
    print("formattedDate...$formattedDate");
    Provider.of<Controller>(context, listen: false).selectTotalPrice(sid!);
    Provider.of<Controller>(context, listen: false)
        .selectCollectionPrice(sid!, formattedDate!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd').format(date);
    sharedPref();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                // bottomLeft: Radius.circular(50),
                // bottomRight: Radius.circular(50),
                ),
            // color: P_Settings.roundedButtonColor
          ),
          alignment: Alignment.center,
          height: size.height * 0.09,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Consumer<Controller>(
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          Text("${value.cname}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: P_Settings.detailscolor)),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text("${value.sname}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: P_Settings.extracolor)),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Consumer<Controller>(
          builder: (context, value, child) {
            return Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(95),
                      topRight: Radius.circular(95),
                    ),
                    color: Colors.white),
                // color: P_Settings.wavecolor,
                // height: size.height*0.6,
                child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Container(
                      height: size.height * 0.4,
                      // color: P_Settings.collection,
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: P_Settings.dashbordcl1,
                                    ),
                                    height: size.height * 0.2,
                                    width: size.height * 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Collection",
                                            style: TextStyle(fontSize: 23),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          // Text(
                                          //   "\u{20B9}${value.collectionsumPrice[0]['S']}",
                                          //   style: TextStyle(fontSize: 15),
                                          // ),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: P_Settings.dashbordcl2,
                                    ),
                                    height: size.height * 0.2,
                                    width: size.height * 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Orders",
                                            style: TextStyle(fontSize: 23),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          // Text(
                                          //   "\u{20B9}${value.sumPrice[0]['S']}",
                                          //   style: TextStyle(fontSize: 15),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
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
                                      height: size.height * 0.2,
                                      width: size.height * 0.2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Sales",
                                              style: TextStyle(fontSize: 23),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          },
        ),
      ],
    );
  }
}
