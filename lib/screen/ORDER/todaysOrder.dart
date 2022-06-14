import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/ORDER/5_mainDashboard.dart';
import 'package:orderapp/screen/historydataPopup.dart';
import 'package:provider/provider.dart';

import '5_mainDashboard.dart';
import 'orderDetailsToday.dart';

class TodaysOrder extends StatefulWidget {
  const TodaysOrder({Key? key}) : super(key: key);

  @override
  State<TodaysOrder> createState() => _TodaysOrderState();
}

class _TodaysOrderState extends State<TodaysOrder> {
  MainDashboard dash = MainDashboard();
  DateTime now = DateTime.now();
  HistoryPopup popup = HistoryPopup();
  List<String> s = [];
  String? result;
  String? date;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    s = date!.split(" ");
    Future.delayed(Duration(milliseconds: 1000), () {
      Provider.of<Controller>(context, listen: false).todayOrder(s[0], context);
    });
    // Future.delayed(Duration(seconds: 1), () {
    //   WidgetsBinding.instance.addPostFrameCallback((_) => build(context));
    // });
  }

  @override
  void dispose() {
    MainDashboard.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return SpinKitFadingCircle(
              color: P_Settings.wavecolor,
            );
          } else {
            if (value.noData) {
              return Container(
                height: size.height * 0.7,
                width: double.infinity,
                child: Center(
                    child: Text(
                  "No Orders!!!",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                )),
              );
            } else {
              return ListView.builder(
                itemCount: value.todayOrderList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.13,
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<Controller>(context, listen: false)
                                  .getHistoryData('orderDetailTable',
                                      "order_id='${value.todayOrderList[index]["order_id"]}'");
                              popup.buildPopupDialog(
                                  context,
                                  size,
                                  value.todayOrderList[index]["Order_Num"],
                                  value.todayOrderList[index]["Cus_id"]);
                              // history["Order_Num"],
                              // history["Cus_id"]);
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        // Icon(Icons),
                                        SizedBox(
                                          width: size.width * 0.02,
                                        ),
                                        Text(
                                            value.todayOrderList[index]
                                                ["Order_Num"],
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Colors.green,
                                        ),
                                        SizedBox(
                                          width: size.width * 0.02,
                                        ),
                                        Text(
                                          value.todayOrderList[index]["Cus_id"],
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        Spacer(),
                                        // IconButton(
                                        //     onPressed: () {
                                        //       Provider.of<Controller>(context,
                                        //               listen: false)
                                        //           .toggleExpansion(index);
                                        //       setState(() {
                                        //         value.isExpanded[index] =
                                        //             !value.isExpanded[index];
                                        //         value.isVisibleTable[index] =
                                        //             !value.isVisibleTable[index];
                                        //       });
                                        //       Provider.of<Controller>(context,
                                        //               listen: false)
                                        //           .getHistoryData('orderDetailTable',
                                        //               "order_id='${value.todayOrderList[index]["order_id"]}'");
                                        //       popup.buildPopupDialog(
                                        //           context,
                                        //           size,"","");
                                        //           // history["Order_Num"],
                                        //           // history["Cus_id"]);
                                        //     },
                                        //     icon: Icon(
                                        //       value.isExpanded[index]
                                        //           ? Icons.arrow_upward
                                        //           : Icons.arrow_downward,
                                        //       size: 20,
                                        //     ))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "No: of Items  :",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                            "${value.todayOrderList[index]["count"].toString()}",
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                        Spacer(),
                                        Text(
                                          "Total  :",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          "\u{20B9}${value.todayOrderList[index]["total_price"].toString()}",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                      ],
                                    ),
                                    // SizedBox(height: size.height * 0.05,),
                                    // Provider.of<Controller>(context, listen: false)
                                    //         .isVisibleTable[index]
                                    //     ? Visibility(
                                    //         visible: value.isVisibleTable[index],
                                    //         child: value.isLoading
                                    //             ? CircularProgressIndicator()
                                    //             : Padding(
                                    //                 padding: const EdgeInsets.only(
                                    //                     left: 5.0, right: 5),
                                    //                 child: Container(
                                    //                     alignment: Alignment.center,
                                    //                     height: size.height * 0.1,
                                    //                     child: OrderDetailsToday()),
                                    //               ))
                                    //     : Container()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Provider.of<Controller>(context, listen: false)
                        //         .isVisibleTable[index]
                        //     ? Visibility(
                        //         visible: value.isVisibleTable[index],
                        //         child: value.isLoading
                        //             ? CircularProgressIndicator()
                        //             : Padding(
                        //                 padding: const EdgeInsets.only(
                        //                     left: 5.0, right: 5),
                        //                 child: Container(
                        //                     alignment: Alignment.center,
                        //                     height: size.height * 0.1,
                        //                     child: OrderDetailsToday()),
                        //               ))
                        //     : Container()
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
