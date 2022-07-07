import 'package:flutter/material.dart';
import 'package:orderapp/screen/ORDER/background_download.dart';
import 'package:workmanager/workmanager.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  
  AutoDownload down=AutoDownload();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Workmanager().registerPeriodicTask("task two", "backup",);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Workmanager().registerOneOffTask("task one", "backup",
                    constraints:
                        Constraints(networkType: NetworkType.connected),
                    initialDelay: Duration(seconds: 5));
              },
              child: Text("Run task"))
        ],
      ),
    );
  }
}
