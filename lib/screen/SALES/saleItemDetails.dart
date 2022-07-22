import 'package:flutter/material.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';

class SaleItemDetails {
  showMoadlBottomsheet(int qty, double rate, double dis_per, double dis_amt,
      double tax_per, double net_amt, BuildContext context, Size size) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Consumer<Controller>(
            builder: (context, value, child) {
              return Container(
                height: size.width * 0.6,
                // color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Qty", style: TextStyle(fontSize: 15)),
                          TextField(
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                          Text(" from cart ?", style: TextStyle(fontSize: 15))
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Rate", style: TextStyle(fontSize: 15)),
                          TextField(
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                          Text(" from cart ?", style: TextStyle(fontSize: 15))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tax % ", style: TextStyle(fontSize: 15)),
                          Text(" 12", style: TextStyle(fontSize: 15))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Discount percentage",
                              style: TextStyle(fontSize: 15)),
                          TextField(
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Discount Amount", style: TextStyle(fontSize: 15)),
                          TextField(
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
