import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/showMoadal.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

class SalesBottomSheet {
  sheet(BuildContext context, String itemcount, String grosstot,
      String discount, String tax, String cess, String netAmt) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          print("order total.........$grosstot");
          return Container(
            height: size.height * 0.9,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: P_Settings.extracolor,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.discount,
                          color: P_Settings.salewaveColor,
                        ),
                        title: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Item count : '),
                            Spacer(),
                            Text(
                              '$itemcount',
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.money,
                          color: P_Settings.salewaveColor,
                        ),
                        title: Row(
                          children: [
                            Text('Gross total : '),
                            Spacer(),
                            Text(
                              '${grosstot}',
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.discount,
                          color: P_Settings.salewaveColor,
                        ),
                        title: Row(
                          children: [
                            Text('Discount : '),
                            Spacer(),
                            Text(
                              '0.00',
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.money,
                          color: P_Settings.salewaveColor,
                        ),
                        title: Row(
                          children: [
                            Text('Tax : '),
                            Spacer(),
                            Text(
                              '$tax',
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.money,
                          color: P_Settings.salewaveColor,
                        ),
                        title: Row(
                          children: [
                            Text('Cess : '),
                            Spacer(),
                            Text(
                              '0.00',
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: new Icon(
                          Icons.money,
                          color: P_Settings.salewaveColor,
                        ),
                        title: Row(
                          children: [
                            Text('Net amount : '),
                            Spacer(),
                            Text(
                              '0.00',
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
