import 'package:flutter/material.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';

class SaleItemDetails {
  List rawCalcResult = [];
  showsalesMoadlBottomsheet(
      String item,
      String code,
      String hsn,
      int qty,
      double rate,
      double dis_per,
      double dis_amt,
      double tax_per,
      double net_amt,
      BuildContext context,
      Size size,
      int index) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          print("keryy");
          // rawCalcResult = Provider.of<Controller>(context,listen: false).rawCalculation(rate,qty.toDouble(), 0.0, 100,tax_per, 0.0, "0", 0);
          return SingleChildScrollView(
            child: Consumer<Controller>(
              builder: (context, value, child) {
                return Container(
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
                            ),Text(" - "),
                            Text(
                              code,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
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
                                child: Text(
                                  hsn,
                                ),
                              ),
                            ],
                          ),
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
                              // alignment: Alignment.center,
                              width: size.width * 0.4,
                              child: TextField(
                                onSubmitted: (values) {
                                  double valueqty = double.parse(values);
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .rawCalculation(rate, valueqty, 0.0, 100,
                                          tax_per, 0.0, "0", 0);
                                },
                                // onChanged: (values) {
                                //      print("values-----$values");
                                //     // double valueqty=0.0;
                                //   double valueqty=double.parse(values);
                                //   Provider.of<Controller>(context,
                                //           listen: false)
                                //       .rawCalculation(
                                //           rate,
                                //           valueqty,
                                //           0.0,
                                //           100,
                                //           tax_per,
                                //           0.0,
                                //           "0",
                                //           0);
                                // },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                controller: value.salesqty[index],
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
                                  child: Text(value.gross.toString(),
                                      style: TextStyle(fontSize: 15)))
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
                                  child: Text(tax_per.toString(),
                                      style: TextStyle(fontSize: 15)))
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
                                onSubmitted: (values) {
                                  double valuediscper = double.parse(
                                     values);
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .rawCalculation(rate, double.parse(value.salesqty[index].text), valuediscper,
                                          100, tax_per, 0.0, "0", 0);
                                },
                                controller: value.discount_prercent[index],
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
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
                                onSubmitted: (values) {
                                  // value.discount_amount[index].text=;
                                  double valuediscamt = double.parse(
                                      values);
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .rawCalculation(rate, double.parse(value.salesqty[index].text), double.parse(value.discount_prercent[index].text),
                                          valuediscamt, tax_per, 0.0, "0", 0);
                                },
                                controller: value.discount_amount[index],
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Padding(
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
                                  child: Text(value.net_amt.toString(),
                                      style: TextStyle(fontSize: 15)))
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
                                  child: ElevatedButton(
                                      onPressed: () {}, child: Text("Apply")))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
