import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/common_popup.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/ORDER/5_dashboard.dart';
import 'package:orderapp/screen/ORDER/7_itemSelection.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReturnCart extends StatefulWidget {
  String custmerId;
  String os;
  String areaId;
  String areaname;
  String type;
  ReturnCart(
      {required this.areaId,
      required this.custmerId,
      required this.os,
      required this.areaname,
      required this.type});

  @override
  State<ReturnCart> createState() => _ReturnCartState();
}

class _ReturnCartState extends State<ReturnCart> {
  List<String> s = [];
  TextEditingController rateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController refController = TextEditingController();
  String reason = "";
  String ref = "";

  DateTime now = DateTime.now();
  String? date;
  String? sid;
  int counter = 0;
  bool isAdded = false;
  String? sname;
  CommonPopup returnPop = CommonPopup();
  @override
  void initState() {
    print("type===${widget.type}");
    date = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    s = date!.split(" ");
    print("widget.hjzjhzjk----${widget.areaname}");
    super.initState();
    Provider.of<Controller>(context, listen: false).calculatereturnTotal();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.returnbuttnColor,
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
            return Provider.of<Controller>(context, listen: false)
                        .returnList
                        .length ==
                    0
                ? Container(
                    height: size.height * 0.9,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "asset/empty.png",
                            height: 80,
                            color: P_Settings.returnbuttnColor,
                            width: 100,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            "Your cart is empty !!!",
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: P_Settings.extracolor,
                                  textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                Navigator.pop(context);
                                // Navigator.of(context).push(
                                //   PageRouteBuilder(
                                //     opaque: false, // set to false
                                //     pageBuilder: (_, __, ___) => ItemSelection(
                                //       areaId: widget.areaId,
                                //       customerId: widget.custmerId,
                                //       os: widget.os,
                                //       areaName: widget.areaname,
                                //       type: widget.type,
                                //     ),
                                //   ),
                                // );
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
                          itemCount: value.returnList.length,
                          itemBuilder: (BuildContext context, int index) {
                            // return Container();
                            return listItemFunction(
                                value.returnList[index]["item"],
                                value.returnList[index]["rate"],
                                value.returnList[index]["total"].toString(),
                                value.returnList[index]["qty"],
                                size,
                                index,
                                value.returnList[index]["code"]);
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
                                showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Container(
                                            height: size.height * 0.3,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(Icons.close))
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Ref. No:",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                          width:
                                                              size.width * 0.5,
                                                          child: TextField(
                                                            controller:
                                                                refController,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Reason:",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                          width:
                                                              size.width * 0.5,
                                                          child: TextField(
                                                            controller:
                                                                reasonController,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.02,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          reason =
                                                              reasonController
                                                                  .text;
                                                          ref = refController
                                                              .text;
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            Text("Return...."))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                  width: size.width * 0.5,
                                  height: size.height * 0.07,
                                  color: Colors.yellow,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Reason",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15))
                                    ],
                                  )
                                  // child: Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Text(" Order Total  : ",
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.bold, fontSize: 15)),
                                  //     Flexible(
                                  //       child: Text("\u{20B9}${value.returnTotal}",
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 16)),
                                  //     )
                                  //   ],
                                  // ),
                                  ),
                            ),
                            GestureDetector(
                              onTap: (() async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      returnPop.buildPopupDialog(
                                          "return",
                                          context,
                                          "Confirm your order?",
                                          widget.areaId,
                                          widget.areaname,
                                          widget.custmerId,
                                          s[0],
                                          s[1],
                                          refController.text,
                                          reasonController.text),
                                );

                                final prefs =
                                    await SharedPreferences.getInstance();
                                String? sid = await prefs.getString('sid');

                                // return showDialog(
                                //     context: context,
                                //     builder: (context) {
                                //       Future.delayed(
                                //           Duration(milliseconds: 500), () {
                                //         Navigator.of(context).pop(true);

                                //         Navigator.of(context).push(
                                //           PageRouteBuilder(
                                //               opaque: false, // set to false
                                //               pageBuilder: (_, __, ___) =>
                                //                   Dashboard(
                                //                       type:
                                //                           "Product return confirmed",
                                //                       areaName:
                                //                           widget.areaname)),
                                //         );
                                //       });
                                //       return AlertDialog(
                                //           content: Row(
                                //         children: [
                                //           Text(
                                //             'Product return confirmed!!!!',
                                //             style: TextStyle(
                                //                 color: P_Settings.extracolor),
                                //           ),
                                //           Icon(
                                //             Icons.done,
                                //             color: Colors.green,
                                //           )
                                //         ],
                                //       ));
                                //     });
                              }),
                              child: Container(
                                width: size.width * 0.5,
                                height: size.height * 0.07,
                                color: P_Settings.roundedButtonColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Return",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.01,
                                    ),
                                    Flexible(
                                      child: Text(
                                          "(\u{20B9}${value.returnTotal.toStringAsFixed(2)})",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                    )
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

  Widget listItemFunction(String itemName, String rate, String totalamount,
      int qty, Size size, int index, String code) {
    print("qty---$qty");
    return Container(
      height: size.height * 0.17,
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, top: 8, bottom: 8),
        child: Ink(
          // color: Colors.grey[100],
          decoration: BoxDecoration(
            color: Colors.grey[100],
            // borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
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
                                  flex: 5,
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
                                  flex: 3,
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
                                padding: const EdgeInsets.only(left: 5, top: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    String item = "${itemName} (${code})";
                                    // Provider.of<Controller>(context,
                                    //             listen: false)
                                    //         .settingsRateOption
                                    //     ? popup(item, rate, size, index, qty)
                                    //     : null;
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Rate :",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Text(
                                        "\u{20B9}${double.parse(rate).toStringAsFixed(2)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.3,
                                      ),
                                      Flexible(
                                        child: IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                content: Text(
                                                    "Do you want to delete ($code) ???"),
                                                actions: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: P_Settings
                                                                    .wavecolor),
                                                        onPressed: () async {
                                                          Provider.of<Controller>(
                                                                  context,
                                                                  listen: false)
                                                              .deleteFromreturnList(
                                                                  index);
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Text("Ok"),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.01,
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: P_Settings
                                                                    .wavecolor),
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Text("Cancel"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 17,
                                          ),
                                          color: P_Settings.extracolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5, top: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .setreturnQty(qty);
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .setreturnAmt(totalamount);
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Consumer<Controller>(
                                          builder: (context, value, child) {
                                            return Container(
                                              height: size.height * 0.4,
                                              color: Colors.white,
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                            icon: Icon(
                                                                Icons.close),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          FloatingActionButton
                                                              .small(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey,
                                                                  child: Icon(Icons
                                                                      .remove),
                                                                  onPressed:
                                                                      () {
                                                                    if (value
                                                                            .returnqtyinc! >
                                                                        1) {
                                                                      value
                                                                          .returnqtyDecrement();
                                                                      value.returntotalCalculation(
                                                                          rate);
                                                                    }
                                                                  }),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 15.0,
                                                                    right: 15),
                                                            child: Text(
                                                              value.returnqtyinc
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          FloatingActionButton
                                                              .small(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey,
                                                                  child: Icon(
                                                                      Icons
                                                                          .add),
                                                                  onPressed:
                                                                      () {
                                                                    value
                                                                        .returnqtyIncrement();
                                                                    value.returntotalCalculation(
                                                                        rate);
                                                                  }),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.02,
                                                      ),
                                                      Divider(
                                                        thickness: 1,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 8.0,
                                                                bottom: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Total Price :",
                                                              style: TextStyle(
                                                                  fontSize: 17),
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                "\u{20B9}${value.priceval}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 1,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.02,
                                                      ),
                                                      Flexible(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height:
                                                                  size.height *
                                                                      0.035,
                                                              width:
                                                                  size.width *
                                                                      0.6,
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Provider.of<Controller>(context, listen: false).updatereturnQty(
                                                                            index,
                                                                            value.returnqtyinc!,
                                                                            value.returntotalPrice!);
                                                                        print(
                                                                            "vlue.retuyrnList----${value.returnList}");
                                                                        Provider.of<Controller>(context,
                                                                                listen: false)
                                                                            .calculatereturnTotal();
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "continue..")),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Qty :",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Container(child: Text(qty.toString())),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Color.fromARGB(255, 182, 179, 179),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Total price : ",
                        style: TextStyle(fontSize: 13),
                      ),
                      Flexible(
                        child: Text(
                          "\u{20B9}${totalamount}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: P_Settings.extracolor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
