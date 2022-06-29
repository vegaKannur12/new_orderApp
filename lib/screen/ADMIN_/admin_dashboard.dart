import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/ADMIN_/adminModel.dart';
import 'package:provider/provider.dart';
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

  // List<String> listHeader = [
  //   'HEADER1',
  //   'HEADER2',
  //   'HEADER3',
  //   'HEADER4',
  //   'HEADER5',
  // ];
  List<String> listTitle = [
    'collection',
    'order',
    'sale',
    'shop visited',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<Controller>(
        builder: (context, value, child) {
          print("haiiii");
          print("length----vvv-${value.adminDashboardList.length}");
          return ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            itemCount: value.adminDashboardList.length,
            itemBuilder: (context, index) {
              return rowChild(value.adminDashboardList[index], size);
            },
          );
        },
      ),
    )
        //
        );
  }

  Widget rowChild(Today list, Size size) {
    print("listtt$list");
    return Column(
      children: [
        Text(list.group.toString()),
        GridView.builder(
            shrinkWrap: true,
            itemCount: list.data!.length,
            // physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemBuilder: (contxt, indx) {
              return Container(
                child: Card(
                  color: P_Settings.roundedButtonColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Text(list.data![indx].caption.toString()),
                      Text(list.data![indx].cvalue.toString()),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
