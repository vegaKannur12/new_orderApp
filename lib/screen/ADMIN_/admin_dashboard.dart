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
  Color parseColor(String color) {
    print("Colorrrrr...$color");
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }

  final rnd = math.Random();
  List<String> listHeader = [
    'HEADER1',
    'HEADER2',
    'HEADER3',
    'HEADER4',
    'HEADER5',
  ];
  List<String> listTitle = [
    'title1',
    'title2',
    'title3',
    'title4',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: size.height * 0.04,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 15,
                  child: Icon(
                    Icons.person,
                    color: P_Settings.wavecolor,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text("Company Name",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: P_Settings.wavecolor)),
                Text("  - Area",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: P_Settings.collection1,
                        fontStyle: FontStyle.italic)),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          SingleChildScrollView(
            child: Container(
              height: size.height * 0.75,
              child: gridHeader(),
            ),
          ),
        ],
      ),
    )
        //
        );
  }

  Widget gridHeader() {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: listHeader.length,
      itemBuilder: (context, index) {
        return StickyHeader(
          header: Container(
            height: 50.0,
            color: Colors.white,
            padding: EdgeInsets.all(10),
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
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: (contxt, indx) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(4.0),
                  color: P_Settings.roundedButtonColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, top: 6.0, bottom: 2.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            listTitle[indx],
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(137, 146, 6, 6)),
                          ),
                          Text(
                            "5",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
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
