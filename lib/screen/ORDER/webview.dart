import 'package:flutter/material.dart';
import 'package:orderapp/components/network_connectivity.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTest extends StatefulWidget {
  const WebViewTest({Key? key}) : super(key: key);

  @override
  State<WebViewTest> createState() => _WebViewTestState();
}

class _WebViewTestState extends State<WebViewTest> {
  String url = "http://trafiqerp.in/order/php/";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      body: WebView(
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith("http://trafiqerp.in/order/php/")) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "http://trafiqerp.in/order/php/",
      ),
    );
  }
}
