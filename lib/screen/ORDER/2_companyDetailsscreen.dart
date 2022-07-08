import 'dart:io';
import 'dart:ui';

import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/customSnackbar.dart';
import 'package:orderapp/components/file_creation.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/ADMIN_/adminController.dart';
import 'package:path_provider/path_provider.dart';
import 'package:orderapp/screen/ORDER/3_staffLoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyDetails extends StatefulWidget {
  String? type;
  String? msg;

  CompanyDetails({this.type, this.msg});
  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  String? cid;
  String? firstMenu;
  String? versof;
  String? vermsg;
  String? data;
  String? fingerprint;

  CustomSnackbar _snackbar = CustomSnackbar();
  // Future<Directory?> get _localPath async {
  //   final directory = await getExternalStorageDirectory();
  //   print("directory.path...${directory}");
  //   return directory;
  // }

  // Future<File> get _localFile async {
  //   final path = await _localPath;
  //   print("path...${path}");
  //   return File('$path/fingerPrint.txt');
  // }

  // Future<String> readContent() async {
  //   try {
  //     final file = await _localFile;
  //     // Read the file
  //     String contents = await file.readAsString();
  //     // Returning the contents of the file
  //     return contents;
  //   } catch (e) {
  //     // If encountering an error, return
  //     return 'Error!';
  //   }
  // }

  // Future<File> writeContent(String fp) async {
  //   final file = await _localFile;
  //   print("fp.........$fp");
  //   return file.writeAsString(fp);
  // }

  // fetchFileData() async {
  //   String response;
  //   final path = await _localPath;
  //   response = await rootBundle.loadString('$path/fingerPrint.txt');
  //   return response.split('\n');
  // }

  // Future<List<String>> getFileLines() async {
  //   final path = await _localPath;
  //   final data = await rootBundle.load('$path/fingerPrint.txt');
  //   final directory = (await getTemporaryDirectory()).path;
  //   final file = await writeContent('{$directory/bot.txt}');
  //   print("file.......$file");
  //   return await file.readAsLines();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCid();
    // Provider.of<Controller>(context, listen: false).getCompanyData(cid!);
  }

  getCid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cid = prefs.getString("cid");
    versof = prefs.getString("versof");
    vermsg = prefs.getString("vermsg");
    fingerprint = prefs.getString("fp");
    print("fingerprint-----$fingerprint");
    if (cid != null) {
      Provider.of<AdminController>(context, listen: false)
          .getCategoryReport(cid!);
    }
    // writeContent(fingerprint!);
    // readContent().then((String value) {
    //   setState(() {
    //     data = value;
    //   });
    //   print("data...$data");
    // });
    final FileSystem fs = MemoryFileSystem();
    final Directory tmp = await fs.systemTempDirectory.createTemp('orderApp');
    final File outputFile = tmp.childFile('fingerprint');
    print("directory............$outputFile");

    await outputFile.writeAsString(fingerprint!);
    print("output..${outputFile.readAsStringSync()}");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: P_Settings.detailscolor,
      appBar: widget.type == ""
          ? AppBar(
              backgroundColor: P_Settings.wavecolor,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(6.0),
                child: Center(
                    child: Text(
                  " ",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                )),
              ),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Company Details",
                  style: TextStyle(
                      fontSize: 20,
                      color: P_Settings.headingColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Consumer<Controller>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return Container(
                        height: size.height * 0.9,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      if (value.companyList.length > 0) {
                        return FittedBox(
                          child: Container(
                            height: size.height * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height * 0.04,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.business),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Container(
                                      width: size.width * 0.3,
                                      child: Text("company name "),
                                    ),
                                    Text(
                                        ": ${(value.companyList[0]["cnme"] == null) && (value.companyList[0]["cnme"].isEmpty) ? "" : value.companyList[0]["cnme"]}"),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.business),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Container(
                                      width: size.width * 0.3,
                                      child: Text("company id"),
                                    ),
                                    Text(
                                        ": ${(value.companyList[0]["cid"] == null) && (value.companyList[0]["cid"].isEmpty) ? "" : value.companyList[0]["cid"]}"),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.numbers_rounded),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Container(
                                      width: size.width * 0.3,
                                      child: Text("Order Series"),
                                    ),
                                    Text(
                                        ": ${(value.companyList[0]["os"] == null) && (value.companyList[0]["os"].isEmpty) ? "" : value.companyList[0]["os"]}"),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.fingerprint),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Container(
                                      width: size.width * 0.3,
                                      child: Text("fingerprint"),
                                    ),
                                    Text(
                                        ": ${(value.companyList[0]["fp"] == null) && (value.companyList[0]["fp"].isEmpty) ? "" : value.companyList[0]["fp"]}"),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.book),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Container(
                                      width: size.width * 0.3,
                                      child: Text("Address1"),
                                    ),
                                    Text(
                                      ": ${value.companyList[0]['ad1']}",
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.book),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Container(
                                      width: size.width * 0.3,
                                      child: Text("Address2"),
                                    ),
                                    Text(
                                      ": ${value.companyList[0]['ad2']}",
                                      // value.reportList![index]['filter_names'],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.pin),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Container(
                                      width: size.width * 0.3,
                                      child: Text("PinCode"),
                                    ),
                                    Text(
                                      ": ",
                                      // value.reportList![index]['filter_names'],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.business),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Container(
                                      width: size.width * 0.3,
                                      child: Text("CompanyPrefix"),
                                    ),
                                    Text(
                                      ": ${value.companyList[0]["cpre"]}",
                                      // value.reportList![index]['filter_names'],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.landscape),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Container(
                                      width: size.width * 0.3,
                                      child: Text("Land"),
                                    ),
                                    Text(
                                      ": ${value.companyList[0]["land"]}",
                                      // value.reportList![index]['filter_names'],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.phone),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Container(
                                      width: size.width * 0.3,
                                      child: Text("Mobile"),
                                    ),
                                    Text(
                                      ": ${value.companyList[0]["mob"]}",
                                      // value.reportList![index]['filter_names'],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.design_services),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Container(
                                      width: size.width * 0.3,
                                      child: Text("GST"),
                                    ),
                                    Text(
                                      ": ${value.companyList[0]["gst"]}",
                                      // value.reportList![index]['filter_names'],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.copy_rounded),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    Container(
                                      width: size.width * 0.3,
                                      child: Text("Country Code     "),
                                    ),
                                    Text(
                                      ": ${value.companyList[0]["ccode"]}",
                                      // value.reportList![index]['filter_names'],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.04,
                                ),
                                widget.type == "drawer call"
                                    ? Container()
                                    : Text(
                                        widget.msg != ""
                                            ? widget.msg.toString()
                                            : "Company Registration Successfull",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 17),
                                      ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                widget.type == "drawer call" || widget.msg != ""
                                    ? Container()
                                    : ElevatedButton(
                                        onPressed: () async {
                                          // Provider.of<Controller>(context,
                                          //         listen: false)
                                          //     .continueClicked = true;
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.setBool(
                                              "continueClicked", true);
                                          String? userType =
                                              prefs.getString("userType");
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .fetchMenusFromMenuTable();
                                          firstMenu =
                                              prefs.getString("firstMenu");
                                          print("first---------$firstMenu");

                                          if (firstMenu != null) {
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .menu_index = firstMenu;

                                            print(Provider.of<Controller>(
                                                    context,
                                                    listen: false)
                                                .menu_index);
                                          }
                                          String? cid = prefs.getString("cid");

                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .getAreaDetails(cid!);
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .cid = cid;
                                          print("cid-----${cid}");

                                          // prefs.setString("cid", cid);
                                          // prefs.setString(
                                          //     "cname", value.cname!);
                                          // Provider.of<Controller>(context,
                                          //         listen: false)
                                          //     .setCname();

                                          if (userType == "staff") {
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .getStaffDetails(cid);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      StaffLogin()),
                                            );
                                          } else if (userType == "admin") {
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .getUserType();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      StaffLogin()),
                                            );
                                          }

                                          // _snackbar.showSnackbar(context,"Staff Details Saved");
                                        },
                                        child: Text("Continue"),
                                      ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          child: Column(children: [Text("")]),
                        );
                      }
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
