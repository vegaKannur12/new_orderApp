import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/ADMIN_/adminController.dart';
import 'package:orderapp/screen/ORDER/1_companyRegistrationScreen.dart';
import 'package:orderapp/screen/ORDER/2_companyDetailsscreen.dart';
import 'package:orderapp/screen/ORDER/3_staffLoginScreen.dart';
import 'package:orderapp/screen/ORDER/5_dashboard.dart';
import 'package:orderapp/screen/ORDER/autoDownload.dart';
import 'package:orderapp/screen/ORDER/background_download.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  String? cid;
  String? com_cid;
  bool? isautodownload;
  String? st_uname;
  String? st_pwd;
  String? userType;
  String? firstMenu;
  String? versof;
  bool? continueClicked;
  Example sample = Example();
  // AutoDownload downloaddata = AutoDownload();
  // Future<void> initializeService() async {
  //   print("inside download");

  //   final service = FlutterBackgroundService();
  //   await service.configure(
  //     androidConfiguration: AndroidConfiguration(
  //       // this will be executed when app is in foreground or background in separated isolate
  //       onStart: onStart,

  //       // auto start service
  //       autoStart: true,
  //       isForegroundMode: true,
  //     ),
  //     iosConfiguration: IosConfiguration(
  //       // auto start service
  //       autoStart: true,

  //       // this will be executed when app is in foreground in separated isolate
  //       onForeground: onStart,

  //       // you have to enable background fetch capability on xcode project
  //       onBackground: onIosBackground,
  //     ),
  //   );
  //   service.startService();
  // }

  navigate() async {
    await Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      cid = prefs.getString("company_id");
      userType = prefs.getString("user_type");
      st_uname = prefs.getString("st_username");
      versof = prefs.getString("versof");
      st_pwd = prefs.getString("st_pwd");
      firstMenu = prefs.getString("firstMenu");
      com_cid = prefs.getString("cid");
      isautodownload = prefs.getBool("isautodownload");
      continueClicked = prefs.getBool("continueClicked");
      print("st-----$st_uname---$st_pwd");
      print("continueClicked $continueClicked");

      if (com_cid != null) {
        Provider.of<Controller>(context, listen: false).cid = com_cid;
      }
      if (firstMenu != null) {
        Provider.of<Controller>(context, listen: false).menu_index = firstMenu;
        print(Provider.of<Controller>(context, listen: false).menu_index);
      }
      print("versof----$versof");
      if (versof != "0") {
        Navigator.push(
            context,
            PageRouteBuilder(
                opaque: false, // set to false
                pageBuilder: (_, __, ___) {
                  if (cid != null) {
                    if (continueClicked != null && continueClicked!) {
                      if (st_uname != null && st_pwd != null) {
                        return Dashboard();
                      } else {
                        return StaffLogin();
                      }
                    } else {
                      Provider.of<Controller>(context, listen: false)
                          .getCompanyData();
                      return CompanyDetails(
                        type: "",
                        msg: "",
                      );
                    }
                    // if (st_uname != null && st_pwd != null) {
                    //   return Dashboard();
                    // } else {
                    //   return StaffLogin();
                    // }
                  } else {
                    return RegistrationScreen();
                  }
                })
            // cid != null
            //     ?continueClicked!=null && continueClicked!
            //     ?
            //      st_uname != null && st_pwd != null
            //         ? Dashboard():

            //         StaffLogin()

            //     : RegistrationScreen()),
            );
      }
    });
  }

  shared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    com_cid = prefs.getString("cid");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Example()),
    // );
    if (com_cid != null) {
      Provider.of<AdminController>(context, listen: false)
          .getCategoryReport(com_cid!);
      Provider.of<Controller>(context, listen: false).adminDashboard(com_cid!);
    }
  }

  // versofFun() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   versof = prefs.getString("versof");
  //   print("versof----$versof");
  //   if (versof != null) {
  //     if (versof == "0") {
  //       print("haiiiijhgjhgjj");
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => CompanyDetails()),
  //       );
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false).fetchMenusFromMenuTable();
    Provider.of<Controller>(context, listen: false).verifyRegistration(context);
    // versofFun();
    // print("versof----$versof");

    shared();
    navigate();
  }

  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 2),
  //   vsync: this,
  // )..repeat();
  // late final Animation<double> _animation = CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.bounceInOut,
  // );
  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: P_Settings.wavecolor,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: size.height * 0.4,
            ),
            Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  "asset/logo_black_bg.png",
                )),
          ],
        )),
      ),
    );
  }
}
