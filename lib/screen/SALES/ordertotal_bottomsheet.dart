import 'package:flutter/material.dart';
import 'package:orderapp/components/showMoadal.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

class SalesBottomSheet {
  sheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: size.height * 0.5,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () {
                      Navigator.pop(context);
                    }, icon: Icon(Icons.close))
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.discount),
                  title: Row(
                    children: [
                      Text('Discount : '),
                      Text('436'),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.money),
                  title: Row(
                    children: [
                      Text('Tax : '),
                      Text('1000'),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.money),
                  title: Row(
                    children: [
                      Text('Cess : '),
                      Text('436'),
                    ],
                  ),
                ),
                ListTile(
                  leading: new Icon(Icons.currency_bitcoin),
                  title: Row(
                    children: [
                      Text('Net amount : '),
                      Text('436'),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
