import 'package:flutter/material.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';

class CustomPopup {
  Widget buildPopupDialog(BuildContext context, String content, String type,
      int rowNum, String userId, String date, String aid) {
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
                  .dashboardSummery(userId, date, aid,context);
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
