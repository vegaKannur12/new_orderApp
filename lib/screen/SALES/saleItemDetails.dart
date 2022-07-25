import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:provider/provider.dart';

class SaleItemDetails {
  List rawCalcResult = [];
  showsalesMoadlBottomsheet(
      String item,
      String code,
      String hsn,
      double qty,
      double rate,
      double dis_per,
      double dis_amt,
      double tax_per,
      double tax_amt,
      double net_amt,
      double gross,
      BuildContext context,
      Size size,
      int index) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          print("keryy---$qty");
          // rawCalcResult = Provider.of<Controller>(context,listen: false).rawCalculation(rate,qty.toDouble(), 0.0, 100,tax_per, 0.0, "0", 0);
          return SingleChildScrollView(
            child: Consumer<Controller>(
              builder: (context, value, child) {
                // value.discount_prercent[index].text = dis_per.toString();
                // value.discount_amount[index].text = dis_amt.toString();
                // value.salesqty[index].text = qty.toString();
                return Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
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
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("-"),
                                Text(
                                  code,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  "Hsn",
                                ),
                                Spacer(),
                                Text(
                                  hsn,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  "Qty",
                                ),
                                Spacer(),
                                Container(
                                  width: size.width * 0.2,
                                  child: TextField(
                                    onSubmitted: (values) {
                                      print("values----$values");
                                      double valueqty = double.parse(values);
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .rawCalculation(rate, valueqty, 0.0,
                                              100, tax_per, 0.0, "0", 0, index);
                                    },
                                    textAlign: TextAlign.right,
                                    // decoration: InputDecoration(
                                    //   border: InputBorder.none,
                                    // ),
                                    controller: value.salesqty[index],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  "Rate",
                                ),
                                Spacer(),
                                Text("\u{20B9}${rate.toString()}")
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  "Gross value",
                                ),
                                Spacer(),
                                Text(
                                  "\u{20B9}${value.gross.toString()}",
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  "Discount %",
                                ),
                                Spacer(),
                                Container(
                                  width: size.width * 0.2,
                                  child: TextField(
                                    onSubmitted: (values) {
                                      double valuediscper =
                                          double.parse(values);
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .rawCalculation(
                                              rate,
                                              double.parse(
                                                  value.salesqty[index].text),
                                              valuediscper,
                                              100,
                                              tax_per,
                                              0.0,
                                              "0",
                                              0,
                                              index);
                                    },
                                    controller: value.discount_prercent[index],
                                    textAlign: TextAlign.right,
                                    // decoration: InputDecoration(
                                    //   border: InputBorder.none,
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  "Discount Amount",
                                ),
                                Spacer(),
                                Container(
                                  width: size.width * 0.2,
                                  child: TextField(
                                    onSubmitted: (values) {
                                      // value.discount_amount[index].text=;
                                      double valuediscamt =
                                          double.parse(values);
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .rawCalculation(
                                              rate,
                                              double.parse(
                                                  value.salesqty[index].text),
                                              double.parse(value
                                                  .discount_prercent[index]
                                                  .text),
                                              valuediscamt,
                                              tax_per,
                                              0.0,
                                              "0",
                                              0,
                                              index);
                                    },
                                    controller: value.discount_amount[index],
                                    textAlign: TextAlign.right,
                                    // decoration: InputDecoration(
                                    //   border: InputBorder.none,
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  "Tax %",
                                ),
                                Spacer(),
                                Text(tax_per.toStringAsFixed(2))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  "Tax amount",
                                ),
                                Spacer(),
                                Text(tax_amt.toStringAsFixed(2))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ListTile(
                            title: Row(children: [
                              Text(
                                "Net Amount",
                                style: TextStyle(color: P_Settings.extracolor),
                              ),
                              Spacer(),
                              Text(
                               "\u{20B9}${value.net_amt.toString()}",
                                style: TextStyle(color: P_Settings.extracolor),
                              ),
                            ]),
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
                        ),
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
