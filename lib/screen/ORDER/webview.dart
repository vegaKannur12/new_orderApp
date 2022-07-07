import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTest extends StatefulWidget {
  const WebViewTest({Key? key}) : super(key: key);

  @override
  State<WebViewTest> createState() => _WebViewTestState();
}

class _WebViewTestState extends State<WebViewTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      body: WebView(
        javascriptMode:JavascriptMode.unrestricted,
        initialUrl: "http://aiwasilks.in/reports/",
          
        
      ),
    );
  }
}