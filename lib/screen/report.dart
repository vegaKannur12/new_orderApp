import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';

class ReportApp extends StatefulWidget {
  const ReportApp({Key? key}) : super(key: key);

  @override
  State<ReportApp> createState() => _ReportAppState();
}

class _ReportAppState extends State<ReportApp> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Report'),
      ),
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "Sales Data",
              style: TextStyle(
                  fontSize: 25,
                  color: P_Settings.headingColor,
                  fontWeight: FontWeight.bold),
            ),
            linearProgress2(size),
          ],
        ),
      ),
    );
  }

  Widget linearProgress2(Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.035,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      width: size.width * 0.035,
                    ),
                    Text(
                      "Report",
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      width: size.width * 0.035,
                    ),
                    Text(
                      "Count",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
              ],
            ),
          ),
          Container(
            height: size.height * 0.5,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "650.00",
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.035,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "head",
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[500]),
                        ),
                        Container(
                          width: size.width * 0.5,
                          height: size.height * 0.008,
                          child: LinearProgressIndicator(
                              value: 0.3,
                              minHeight: 4,
                              valueColor:
                                  new AlwaysStoppedAnimation<Color>(Colors.red),
                              color: Colors.red
                              // valueColor :
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("34"),
                      ],
                    ),
                    // list[index]['rpt']=='ServiceGroupWise Billing'?Text(list[index]['bills_total'].toString()):Text(''),
                  ],
                ));
              },
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
