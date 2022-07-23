import 'package:flutter/material.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';

class SaleItemDetails {
  showsalesMoadlBottomsheet(
      String item,
      String code,
      int qty,
      double rate,
      double dis_per,
      double dis_amt,
      double tax_per,
      double net_amt,
      BuildContext context,
      Size size) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          print("keryy");

          return SingleChildScrollView(
            child: Container(
              // height: double.infinity,
              // color: Colors.amber,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          code,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: size.width * 0.4,
                          alignment: Alignment.topRight,
                          child: Text(
                            "hsn",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          width: size.width * 0.4,
                          child: TextField(
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          alignment: Alignment.topRight,
                          child: Text(
                            "qty",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: size.width * 0.4,
                          child: TextField(
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width * 0.4,
                            alignment: Alignment.topRight,
                            child: Text(
                              "Rate",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Container(
                              alignment: Alignment.center,
                              width: size.width * 0.4,
                              child: Text(rate.toString()))
                          // Container(
                          //   width: size.width * 0.4,
                          //   child: TextField(
                          //     style: TextStyle(color: Colors.red, fontSize: 15),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            width: size.width * 0.4,
                            child: Text(
                              "gross value",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Container(
                              alignment: Alignment.center,
                              width: size.width * 0.4,
                              child: Text(" 12", style: TextStyle(fontSize: 15)))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            width: size.width * 0.4,
                            child: Text(
                              "Tax %",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Container(
                              width: size.width * 0.4,
                              alignment: Alignment.center,
                              child: Text(" 12", style: TextStyle(fontSize: 15)))
                        ],
                      ),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: size.width * 0.4,
                            alignment: Alignment.topRight,
                            child: Text("Discount percentage",
                                style: TextStyle(fontSize: 15))),
                        Container(
                          width: size.width * 0.4,
                          child: TextField(
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: size.width * 0.4,
                            alignment: Alignment.topRight,
                            child: Text("Discount Amount",
                                style: TextStyle(fontSize: 15))),
                        Container(
                          width: size.width * 0.4,
                          child: TextField(
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: size.width * 0.4,
                              alignment: Alignment.topRight,
                              child: Text("Net Amount",
                                  style: TextStyle(fontSize: 15))),
                          Container(
                                width: size.width * 0.4,
                                alignment: Alignment.center,
                                child: Text(" 12", style: TextStyle(fontSize: 15)))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width * 0.4,
                            child: ElevatedButton(onPressed: () {}, child: Text("Apply")))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
