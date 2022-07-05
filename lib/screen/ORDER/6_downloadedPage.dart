import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class DownloadedPage extends StatefulWidget {
  String? type;
  String? title;
  DownloadedPage({this.type, this.title});

  @override
  State<DownloadedPage> createState() => _DownloadedPageState();
}

class _DownloadedPageState extends State<DownloadedPage> {
  String? cid;
  String? sid;
  String? userType;
  String? formattedDate;
  List s = [];
  DateTime date = DateTime.now();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  List<String> downloadItems = [
    "Account Heads",
    "Product Details",
    "Product category",
    "Company",
    "Wallet",
    "Images"
  ];

  @override
  void initState() {
    // Workmanager().registerPeriodicTask(
    //   "Download task 2",
    //   "backup",
    //   existingWorkPolicy: ExistingWorkPolicy.append,
    //   frequency: Duration(seconds: 2),
    //   initialDelay: Duration(seconds: 10),
    // );
    print("background data download");

    // TODO: implement initState
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    s = formattedDate!.split(" ");
    getCid();
  }

  getCid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cid = prefs.getString("cid");
    userType = prefs.getString("userType");
    sid = prefs.getString("sid");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      appBar: widget.type == ""
          ? AppBar(
              backgroundColor: P_Settings.wavecolor,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(6.0),
                child: Consumer<Controller>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        color: P_Settings.wavecolor,

                        // valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                        // value: 0.25,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              // title: Text("Company Details",style: TextStyle(fontSize: 20),),
            )
          : null,
      body: Consumer<Controller>(
        builder: (context, value, child) {
          print("value.sof-----${value.sof}");
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    print("data download ");
                    Workmanager().registerPeriodicTask(
                      "Task",
                      "excecuted",
                      initialDelay: Duration(seconds: 5),
                    );
                    // Workmanager().cancelByUniqueName("Task");
                  },
                  child: Text("Download all")),
              Flexible(
                child: Container(
                  height: size.height * 0.9,
                  child: ListView.builder(
                    itemCount: downloadItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: P_Settings.wavecolor),
                          child: ListTile(
                            trailing: IconButton(
                              onPressed: value.versof == "0"
                                  ? null
                                  : () async {
                                      if (downloadItems[index] ==
                                          "Account Heads") {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getaccountHeadsDetails(
                                                context, s[0], cid!);
                                      }
                                      if (downloadItems[index] ==
                                          "Product category") {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getProductCategory(cid!);
                                      }
                                      if (downloadItems[index] == "Company") {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getProductCompany(cid!);
                                      }
                                      if (downloadItems[index] ==
                                          "Product Details") {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getProductDetails(cid!);
                                      }
                                      if (downloadItems[index] == "Wallet") {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getWallet(context);
                                      }
                                    },
                              icon: Icon(Icons.download),
                              color: Colors.white,
                            ),
                            title: Center(
                                child: Text(
                              downloadItems[index],
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
