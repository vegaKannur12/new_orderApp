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
    String? grossamt,
    String? disamt,
    String? disper,
    String? taxamt,
    String? taxper,
    String? cesamt,
    String? cesper,
    String? netamt,
  ) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${content}"),
        ],
      ),
      actions: [
        Consumer<Controller>(
          builder: (context, value, child) {
            return ElevatedButton(
                onPressed: () async {
                  sid = await Provider.of<Controller>(context, listen: false)
                      .setStaffid(value.sname!);
                  final prefs = await SharedPreferences.getInstance();
                  String? sid1 = await prefs.getString('sid');
                  print("Sid........${value.sname}$sid1");

                  String? os = await prefs.getString('os');
                  String? gen_area =
                      Provider.of<Controller>(context, listen: false)
                          .areaidFrompopup;
                  if (gen_area != null) {
                    gen_condition = " and accountHeadsTable.area_id=$gen_area";
                  } else {
                    gen_condition = " ";
                  }

                  if (type == "sales") {
                    print("sales......${grossamt}...${disamt}...${disper}");
                    if (Provider.of<Controller>(context, listen: false)
                            .salebagList
                            .length >
                        0) {
                      Provider.of<Controller>(context, listen: false)
                          .insertToSalesbagAndMaster(
                              os!,
                              date,
                              time,
                              custmerId,
                              sid1!,
                              areaid,
                              double.parse(value.orderTotal2[0]!),
                              double.parse(grossamt!),
                              disamt.toString(),
                              disper.toString(),
                              taxamt.toString(),
                              taxper.toString(),
                              cesamt.toString(),
                              cesper.toString(),
                              netamt.toString());
                    }
                    Provider.of<Controller>(context, listen: false)
                        .todaySales(date, gen_condition!);
                  } else if (type == "sale order") {
                    print("inside order.......");
                    if (Provider.of<Controller>(context, listen: false)
                            .bagList
                            .length >
                        0) {
                      Provider.of<Controller>(context, listen: false)
                          .insertToOrderbagAndMaster(
                        os!,
                        date,
                        time,
                        custmerId,
                        sid1!,
                        areaid,
                        double.parse(value.orderTotal1!),
                      );
                    }
                    Provider.of<Controller>(context, listen: false)
                        .todayOrder(date, gen_condition!);
                  }

                  Provider.of<Controller>(context, listen: false)
                      .clearList(value.areDetails);

                  // return  showDialog(context: context, builder: builder)

                  return showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(Duration(milliseconds: 500), () {
                          Navigator.of(context).pop(true);

                          Navigator.of(context).push(
                            PageRouteBuilder(
                                opaque: false, // set to false
                                pageBuilder: (_, __, ___) => Dashboard(
                                    type: "return from cartList",
                                    areaName: areaname)
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

                  // Provider.of<Controller>(context, listen: false).count = "0";

                  // Navigator.of(context).pop();
                },
                child: Text("Ok"));
          },
        )
      ],
    );
  }
}
