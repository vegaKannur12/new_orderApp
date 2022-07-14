import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/ORDER/0_splashScreen.dart';
import 'package:orderapp/screen/ORDER/externalDir.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/commoncolor.dart';
import 'package:ota_update/ota_update.dart';
import 'screen/ADMIN_/adminController.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';

void requestPermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  var status1 = await Permission.manageExternalStorage.status;
  if (!status.isGranted) {
    await Permission.manageExternalStorage.request();
    // await Permission.app
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? cid = prefs.getString("company_id");
  requestPermission();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Controller()),
      ChangeNotifierProvider(
        create: (_) => AdminController(),
      ),
    ],
    child: MyApp(),
  ));
}

///////////////////////// background run /////////////////////////////
////////////////////////////////////////////////////////////
class MyApp extends StatelessWidget {
  late OtaEvent currentEvent;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto Mono sample',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // fontFamily: 'OpenSans',
        primaryColor: P_Settings.bodycolor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
        ),
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        // scaffoldBackgroundColor: P_Settings.bodycolor,
        // textTheme: const TextTheme(
        //   headline1: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        //   headline6: TextStyle(
        //     fontSize: 25.0,
        //   ),
        //   bodyText2: TextStyle(
        //     fontSize: 14.0,
        //   ),
        // ),
      ),
      home: SplashScreen(),
      // home: MyWaveClipper(),
    );
  }

  ////////////////////////////////
  // Future<void> tryOtaUpdate() async {
  //   try {
  //     //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
  //     OtaUpdate()
  //         .execute(
  //       'https://internal1.4q.sk/flutter_hello_world.apk',
  //       destinationFilename: 'flutter_hello_world.apk',
  //       //FOR NOW ANDROID ONLY - ABILITY TO VALIDATE CHECKSUM OF FILE:
  //       sha256checksum:
  //           'd6da28451a1e15cf7a75f2c3f151befad3b80ad0bb232ab15c20897e54f21478',
  //     )
  //         .listen(
  //       (OtaEvent event) {
  //         currentEvent = event;
  //         // setState(() => currentEvent = event
  //       },
  //     );
  //     // ignore: avoid_catches_without_on_clauses
  //   } catch (e) {
  //     print('Failed to make OTA update. Details: $e');
  //   }
  // }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
