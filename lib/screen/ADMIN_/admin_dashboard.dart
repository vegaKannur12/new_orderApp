import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'dart:math' as math;

class AdminDashboard extends StatefulWidget {
  // const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final rnd = math.Random();
  List<String> listHeader = [
    'HEADER1',
    'HEADER2',
    'HEADER3',
    'HEADER4',
    'HEADER5',
    'HEADER6',
    'HEADER7',
    'HEADER8',
    'HEADER9',
    'HEADER10',
  ];
  List<String> listTitle = [
    'title1',
    'title2',
    'title3',
    'title4',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Text("Company Name"),
          Text("-Area"),
        ],
      ),
    )
        // gridHeader(),
        );
  }

  Widget gridHeader() {
    return ListView.builder(
      itemCount: listHeader.length,
      itemBuilder: (context, index) {
        return StickyHeader(
          header: Container(
            height: 38.0,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            alignment: Alignment.centerLeft,
            child: Text(
              listHeader[index],
              style: TextStyle(
                  color: P_Settings.wavecolor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Container(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listTitle.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemBuilder: (contxt, indx) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(4.0),
                  color: Color(rnd.nextInt(0x100000000)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, top: 6.0, bottom: 2.0),
                    child: Center(
                        child: Text(
                      listTitle[indx],
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    )),
                  ),
                );
              },
            ),
          ),
        );
      },
      shrinkWrap: true,
    );
  }
}
