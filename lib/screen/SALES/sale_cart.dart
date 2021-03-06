import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/common_popup.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/db_helper.dart';
import 'package:orderapp/screen/ORDER/5_dashboard.dart';
import 'package:orderapp/screen/SALES/ordertotal_bottomsheet.dart';
import 'package:orderapp/screen/SALES/saleItemDetails.dart';
import 'package:orderapp/screen/SALES/sale_itemlist.dart';
import 'package:orderapp/service/tableList.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaleCart extends StatefulWidget {
  String custmerId;
  String os;
  String areaId;
  String areaname;
  String type;
  SaleCart({
    required this.areaId,
    required this.custmerId,
    required this.os,
    required this.areaname,
    required this.type,
  });

  @override
  State<SaleCart> createState() => _SaleCartState();
}

class _SaleCartState extends State<SaleCart> {
  CommonPopup salepopup = CommonPopup();
  SaleItemDetails saleDetails = SaleItemDetails();
  SalesBottomSheet sheet = SalesBottomSheet();
  List<String> s = [];
  List rawCalcResult = [];
  String? gen_condition;
  TextEditingController rateController = TextEditingController();
  DateTime now = DateTime.now();
  String? date;
  String? sid;
  int counter = 0;
  bool isAdded = false;
  String? sname;
  @override
  void initState() {
    date = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    s = date!.split(" ");
    Provider.of<Controller>(context, listen: false)
        .calculatesalesTotal(widget.os, widget.custmerId);
    print("jhdjs-----${widget.os}");
//  Provider.of<Controller>(context, listen: false)
//             .getSaleBagDetails(widget.custmerId, widget.os);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.salewaveColor,
        actions: [
          IconButton(
              onPressed: () async {
                await OrderAppDB.instance
                    .deleteFromTableCommonQuery("salesBagTable", "");
              },
              icon: Icon(Icons.delete)),
          IconButton(
            onPressed: () async {
              List<Map<String, dynamic>> list =
                  await OrderAppDB.instance.getListOfTables();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TableList(list: list)),
              );
            },
            icon: Icon(Icons.table_bar),
          ),
        ],
      ),
      body: GestureDetector(onTap: (() {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }), child: Center(
        child: Consumer<Controller>(builder: (context, value, child) {
          if (value.isLoading) {
            return CircularProgressIndicator();
          } else {
            print("value.rateEdit----${value.rateEdit}");
            print("baglist length...........${value.salebagList.length}");

            return Provider.of<Controller>(context, listen: false)
                        .salebagList
                        .length ==
                    0
                ? Container(
                    height: size.height * 0.9,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "asset/cart.png",
                            height: 100,
                            color: Colors.grey[300],
                            width: 100,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text("Your cart is empty "),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false, // set to false
                                    pageBuilder: (_, __, ___) => SalesItem(
                                      areaId: widget.areaId,
                                      customerId: widget.custmerId,
                                      os: widget.os,
                                      areaName: widget.areaname,
                                      type: widget.type,
                                    ),
                                  ),
                                );
                              },
                              child: Text("View products"))
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: value.salebagList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return listItemFunction(
                              value.salebagList[index]["cartrowno"],
                              value.salebagList[index]["itemName"],
                              value.salebagList[index]["hsn"],
                              value.salebagList[index]["rate"].toString(),
                              value.salebagList[index]["discount_per"],
                              value.salebagList[index]["discount_amt"],
                              value.salebagList[index]["ces_per"],
                              value.salebagList[index]["ces_amt"],
                              value.salebagList[index]["net_amt"],
                              double.parse(
                                  value.salebagList[index]["totalamount"]),

                              value.salebagList[index]["qty"],
                              size,
                              value.controller[index],
                              index,
                              value.salebagList[index]["code"],
                              value.salebagList[index]["tax_per"].toString(),
                              value.salebagList[index]["tax_amt"],

                              // value.salebagList[index]["discount"].toString(),
                              // value.salebagList[index]["ces_amt"],
                              // value.salebagList[index]["ces_a"].toString(),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: size.height * 0.07,
                        color: Colors.yellow,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                sheet.sheet(
                                    context,
                                    value.orderTotal2[1]!,
                                    value.orderTotal2[0]!,
                                    value.orderTotal2[3]!,
                                    value.orderTotal2[2]!,
                                    value.orderTotal2[4]!,
                                    value.orderTotal2[5]!);
                              },
                              child: Container(
                                width: size.width * 0.5,
                                height: size.height * 0.07,
                                color: Colors.yellow,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(" Order Total  : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                    Flexible(
                                      child: Text(
                                          "\u{20B9}${value.salesTotal.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (() async {
                                // Provider.of<Controller>(context, listen: false)
                                //         .salesNetamt =
                                //     double.parse(value.orderTotal2[1]!);

                                print("order total.......${value.orderTotal2}");
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      salepopup.buildPopupDialog(
                                    "sales",
                                    context,
                                    "Confirm your sale?",
                                    widget.areaId,
                                    widget.areaname,
                                    widget.custmerId,
                                    s[0],
                                    s[1],
                                  ),
                                );
                                // Provider.of<Controller>(context,listen: false).saveOrderDetails(id, value.cid!, series, orderid,  widget.custmerId, orderdate, staffid, widget.areaId, pcode, qty, rate, context)
                              }),
                              child: Container(
                                width: size.width * 0.5,
                                height: size.height * 0.07,
                                color: P_Settings.roundedButtonColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sale",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.01,
                                    ),
                                    Icon(Icons.shopping_basket)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
          }
        }),
      )),
    );
  }

  Widget listItemFunction(
    int cartrowno,
    String itemName,
    String hsn,
    String rate,
    double disc_per,
    double disc_amt,
    double cess_per,
    double cess_amt,
    double net_amt,
    double gross,
    double qty,
    Size size,
    TextEditingController _controller,
    int index,
    String code,
    String tax,
    double tax_amt,
    // String discount,
  ) {
    print("qty net-------$net_amt...$tax_amt");
    _controller.text = qty.toString();

    return Consumer<Controller>(
      builder: (context, value, child) {
        return Container(
          height: size.height * 0.2,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 2, right: 2, top: 8, bottom: 8),
            child: Ink(
              // color: Colors.grey[100],
              decoration: BoxDecoration(
                color: Colors.grey[100],
                // borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                onTap: () {
                  print("net amount............$net_amt");
                  Provider.of<Controller>(context, listen: false).fromDb = true;
                  value.salesqty[index].text = qty.toStringAsFixed(2);
                  value.discount_prercent[index].text =
                      disc_per.toStringAsFixed(2);
                  value.discount_amount[index].text =
                      disc_amt.toStringAsFixed(2);

                  saleDetails.showsalesMoadlBottomsheet(
                    itemName,
                    code,
                    hsn,
                    qty,
                    double.parse(rate),
                    disc_per,
                    disc_amt,
                    double.parse(tax),
                    tax_amt,
                    cess_per,
                    cess_amt,
                    net_amt,
                    gross,
                    context,
                    size,
                    index,
                    widget.custmerId,
                    widget.os,
                  );
                },
                // leading: CircleAvatar(backgroundColor: Colors.green),
                title: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                            ),
                            child: Container(
                              height: size.height * 0.3,
                              width: size.width * 0.2,
                              child: Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                                fit: BoxFit.cover,
                              ),
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                            height: size.height * 0.001,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      // flex: 5,
                                      child: Text(
                                        "${itemName} ",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: P_Settings.wavecolor),
                                      ),
                                    ),
                                    Flexible(
                                      // flex: 3,
                                      child: Text(
                                        " (${code})",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 4, top: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Rate   :",
                                              style: TextStyle(fontSize: 13),
                                              textAlign: TextAlign.left,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                            Text(
                                              "\u{20B9}${rate}",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ), // Row(

                                        Row(
                                          children: [
                                            Text(
                                              "Discount:",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.03,
                                            ),
                                            Container(
                                              child: Text(
                                                " \u{20B9}${disc_amt.toStringAsFixed(2)}",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        // mainAxisAlignment:
                                        // MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Qty     :",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.02,
                                          ),
                                          Container(
                                            child: Text(
                                              qty.toString(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Tax  :",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.03,
                                          ),
                                          Container(
                                            child:
                                                // tax_amt < 0.00
                                                // ? Text("\u{20B9}0.00",
                                                //     style:
                                                //         TextStyle(fontSize: 13))
                                                // :
                                                Text(
                                              " \u{20B9}${tax_amt.toStringAsFixed(2)}",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       "Discount:",
                                      //       style: TextStyle(fontSize: 13),
                                      //     ),
                                      //     SizedBox(
                                      //       width: size.width * 0.03,
                                      //     ),
                                      //     Container(
                                      //       child: Text(
                                      //         " \u{20B9}${disc_amt.toString()}",
                                      //         style: TextStyle(fontSize: 13),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, top: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Gross:",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.02,
                                          ),
                                          Container(
                                            child: Text(
                                              "\u{20B9}${gross.toStringAsFixed(2)}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Cess :",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.02,
                                          ),
                                          Container(
                                            child: Text(
                                              "\u{20B9}${cess_amt.toStringAsFixed(2)}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 182, 179, 179),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 7,
                      ),
                      child: Container(
                        height: size.height * 0.03,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: Colors.grey[100]),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          content: Text("delete?"),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: P_Settings
                                                              .wavecolor),
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: Text("cancel"),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.01,
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: P_Settings
                                                              .wavecolor),
                                                  onPressed: () async {
                                                    await OrderAppDB.instance
                                                        .deleteFromTableCommonQuery(
                                                            "salesBagTable",
                                                            "customerid='${widget.custmerId}' AND cartrowno=$cartrowno");
                                                    await Provider.of<
                                                                Controller>(
                                                            context,
                                                            listen: false)
                                                        .calculatesalesTotal(
                                                            widget.os,
                                                            widget.custmerId);
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .getSaleBagDetails(
                                                            widget.custmerId,
                                                            widget.os);
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .getSaleProductList(
                                                            widget.custmerId);
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .countFromTable(
                                                      "salesBagTable",
                                                      widget.os,
                                                      widget.custmerId,
                                                    );
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: Text("ok"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: P_Settings.extracolor,
                                    ),
                                    label: Text(
                                      "Remove",
                                      style: TextStyle(color: Colors.black),
                                    ))
                              ],
                            ),
                            Spacer(),
                            Text(
                              "Total price : ",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            double.parse(rate) < disc_amt
                                ? Text(
                                    "0.00",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: P_Settings.extracolor),
                                  )
                                : Text(
                                    "\u{20B9}${net_amt.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: P_Settings.extracolor),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

//////////////////////////////////////////////////////////////////////
  popup(String item, String rate, Size size, int index, int qty) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item,
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
            // title: const Text('Popup example'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  children: [
                    Text("Old rate    :"),
                    Text("   \u{20B9}${rate}"),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  children: [
                    Text("New rate  :"),
                    Container(
                        width: size.width * 0.2,
                        child: TextField(
                          controller: rateController,
                        ))
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<Controller>(context, listen: false)
                          .editRate(rateController.text, index);
                      Provider.of<Controller>(context, listen: false).updateQty(
                          qty.toString(),
                          index + 1,
                          widget.custmerId,
                          rateController.text);
                      Provider.of<Controller>(context, listen: false)
                          .calculatesalesTotal(widget.os, widget.custmerId);
                      rateController.clear();
                      Navigator.of(context).pop();
                    },
                    // textColor: Theme.of(context).primaryColor,
                    child: Text('Save'),
                  ),
                ],
              )
            ],
          );
        });
  }
}
