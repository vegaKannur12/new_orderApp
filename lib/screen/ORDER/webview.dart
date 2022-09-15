import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTest extends StatefulWidget {
  const WebViewTest({Key? key}) : super(key: key);

  @override
  State<WebViewTest> createState() => _WebViewTestState();
}

class _WebViewTestState extends State<WebViewTest> {
  String? company_code;
  String? fp;
  String? cid;
  String? os;
  String? userType;
  String? staff_id;

  // String url = "http://trafiqerp.in/order/php/index.php?fp=&company_code=";
  // @override
  // void initState() {

  //   getCompaniId();
  //   // TODO: implement initState
  //   super.initState();
  // }

  getCompaniId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    company_code = prefs.getString("company_id");
    fp = prefs.getString("fp");
    cid = prefs.getString("cid");
    os = prefs.getString("os");
    staff_id = await prefs.getString('sid');
    userType = prefs.getString("userType");
    // urllink =
    //       "http://trafiqerp.in/order/php/index.php?fp=$fp&company_code=$company_code&company_id=$cid&c_type=$userType&order_series=$os&staff_id=$sid1";
    print(
        "webview   company code.finger..........$staff_id.....$company_code.......$fp........$os..$cid......$userType");
    print(
        "http://trafiqerp.in/order/php/index.php?fp=$fp&company_code=$company_code&company_id=$cid&c_type=$userType&order_series=$os&staff_id=$staff_id");
  }

  @override
  Widget build(BuildContext context) {
    getCompaniId();
    return Scaffold(
      // appBar: ,
      body: WebView(
        // navigationDelegate: (NavigationRequest request) {
        //   if (request.url.startsWith("http://trafiqerp.in/order/php/")) {
        //     return NavigationDecision.prevent;
        //   }
        //   return NavigationDecision.navigate;
        // },
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            "http://trafiqerp.in/order/php/index.php?fp=fp&company_code=company_code&company_id=cid&c_type=userType&order_series=os&staff_id=staff_id",
        // initialUrl:
        //     "http://trafiqerp.in/order/php/index.php?fp=$fp&company_code=2Z1KOED1AXVO&company_id=CO1002&c_type=staff&order_series=DV&staff_id=VGMHD1",
      ),
    );
  }
}
