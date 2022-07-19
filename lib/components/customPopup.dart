import 'package:flutter/material.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';

class CustomPopup {
  String? gen_condition;

  Widget buildPopupDialog(BuildContext context, String content, String type,
      int rowNum, String userId, String date, String aid) {
    String? gen_area =
        Provider.of<Controller>(context, listen: false).areaidFrompopup;
    if (gen_area != null) {
      gen_condition = " and accountHeadsTable.area_id=$gen_area";
    } else {
      gen_condition = " ";
    }
    return new AlertDialog(
      // title: const Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${content}"),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () async {
            print("hfzsdhfu----$aid");
            if (type == "collection") {
              await OrderAppDB.instance.upadteCommonQuery(
                  "collectionTable", "rec_cancel='1'", "rec_row_num=$rowNum");
              Provider.of<Controller>(context, listen: false)
                  .dashboardSummery(userId, date, aid, context);
              Provider.of<Controller>(context, listen: false)
                  .todayCollection(date, gen_condition!);
            }
            Navigator.of(context).pop();
          },
          // textColor: Theme.of(context).primaryColor,
          child: Text('Ok'),
        ),
      ],
    );
  }
}
