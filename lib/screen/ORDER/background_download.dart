import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/controller.dart';

class AutoDownload {
  DownloadData(BuildContext context) async {
    String? formattedDate;
    List s = [];
    DateTime date = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    s = formattedDate.split(" ");
    String? cid;
    String? userType;
    String? sid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cid = prefs.getString("cid");
    userType = prefs.getString("userType");
    sid = prefs.getString("sid");
    print("cid.. sid...userType  $cid $userType $sid");
    // Provider.of<Controller>(context, listen: false)
    //     .getaccountHeadsDetails(context, s[0], cid!);
    Future.delayed(const Duration(milliseconds: 500), () {
      print("delay 1 product data..........");
      Provider.of<Controller>(context, listen: false).getProductDetails(cid!);
    });

    // // Provider.of<Controller>(context, listen: false).getProductCategory(cid);
    // // Provider.of<Controller>(context, listen: false).getProductCompany(cid);
    // // Provider.of<Controller>(context, listen: false).getProductDetails(cid);
    Future.delayed(const Duration(milliseconds: 800), () {
      print("delay 2 product data..........");

      Provider.of<Controller>(context, listen: false).getWallet(context);
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      print("delay 2 product data..........");

      Provider.of<Controller>(context, listen: false).getProductCompany(cid!);
    });
  }
}
