import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/screen/ORDER/5_dashboard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonPopup {
  String? gen_condition;
  String? sid;
  Widget buildPopupDialog(
    String type,
    BuildContext context,
    String content,
    String areaid,
    String areaname,
    String custmerId,
    String date,
    String time,
  ) {
    return AlertDialog(
      // title: const Text('Popup example'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${content}"),
        ],
      ),
      actions: <Widget>[
        Consumer<Controller>(
          builder: (context, value, child) {
            return ElevatedButton(
              onPressed: () async {
                print("typeee...$type");
                sid = await Provider.of<Controller>(context, listen: false)
                    .setStaffid(value.sname!);
                print("Sid........${value.sname}$sid");
                if (Provider.of<Controller>(context, listen: false)
                        .salebagList
                        .length >
                    0) {
                  final prefs = await SharedPreferences.getInstance();
                  String? sid = await prefs.getString('sid');
                  String? os = await prefs.getString('os');
                  print("order total...${double.parse(value.orderTotal2[0])}");
                  String? gen_area =
                      Provider.of<Controller>(context, listen: false)
                          .areaidFrompopup;
                  if (gen_area != null) {
                    gen_condition = " and accountHeadsTable.area_id=$gen_area";
                  } else {
                    gen_condition = " ";
                  }

                  if (type == "sales") {
                    Provider.of<Controller>(context, listen: false)
                        .insertToSalesbagAndMaster(
                      os!,
                      date,
                      time,
                      custmerId,
                      sid!,
                      areaid,
                      double.parse(value.orderTotal2[0]),
                    );
                    Provider.of<Controller>(context, listen: false)
                        .todaySales(date, gen_condition!);
                  } else if (type == "sale order") {
                    print("inside order.......");
                    Provider.of<Controller>(context, listen: false)
                        .insertToOrderbagAndMaster(
                      os!,
                      date,
                      time,
                      custmerId,
                      sid!,
                      areaid,
                      double.parse(value.orderTotal1!),
                    );

                    Provider.of<Controller>(context, listen: false)
                        .todayOrder(date, gen_condition!);
                  }
                  Provider.of<Controller>(context, listen: false)
                      .clearList(value.areDetails);
                  return showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(Duration(milliseconds: 500), () {
                          Navigator.of(context).pop(true);

                          Navigator.of(context).push(
                            PageRouteBuilder(
                                opaque: false, // set to false
                                pageBuilder: (_, __, ___) =>
                                    Dashboard(type: " ", areaName: areaname)
                                // OrderForm(widget.areaname,"return"),
                                ),
                          );
                        });
                        return AlertDialog(
                            content: Row(
                          children: [
                            Text(
                              '$type  Placed!!!!',
                              style: TextStyle(color: P_Settings.extracolor),
                            ),
                            Icon(
                              Icons.done,
                              color: Colors.green,
                            )
                          ],
                        ));
                      });
                }

                Provider.of<Controller>(context, listen: false).count = "0";

                Navigator.of(context).pop();
              },
              // textColor: Theme.of(context).primaryColor,
              child: Text('Ok'),
            );
          },
        ),
      ],
    );
  }
}
