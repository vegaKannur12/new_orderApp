import 'package:flutter/material.dart';
import 'package:orderapp/db_helper.dart';

class CustomPopup{
  Widget buildPopupDialog(BuildContext context,String content,String type) {
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
        onPressed: () async{
          if(type=="collection"){
            await OrderAppDB.instance.upadteCommonQuery("collectionTable",
              "rec_cancel='1'", "id='${item["id"]}'");
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