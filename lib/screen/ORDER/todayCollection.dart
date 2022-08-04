import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodayCollection extends StatefulWidget {
  const TodayCollection({Key? key}) : super(key: key);

  @override
  State<TodayCollection> createState() => _TodayCollectionState();
}

class _TodayCollectionState extends State<TodayCollection> {
  DateTime dateti = DateTime.now();
  String? formattedDate;
  String? sid;
  sharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    sid = prefs.getString('sid');
    print("sid ......$sid");
    print("formattedDate...$formattedDate");
  }

  @override
  void initState() {
    print("Hai");
    formattedDate = DateFormat('yyyy-MM-dd').format(dateti);
    sharedPref();
    // TODO: implement initState
    super.initState();
  }

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
            if (value.todayCollectionList.length == 0) {
              return Container(
                height: size.height * 0.7,
                width: double.infinity,
                child: Center(
                    child: Text(
                  "No Collections!!!",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                )),
              );
            } else {
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Container(
                        // color: P_Settings.collection,
                        height: size.height * 0.7,
                        child: ListView.builder(
                          itemCount: value.todayCollectionList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.grey[100],
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "asset/filledcoll.png",
                                              height: 30,
                                              color: P_Settings.wavecolor,
                                              width: 30,
                                            ),
                                          ],
                                        ),
                                        
                                        // Column(
                                        //   children: [
                                        //     Padding(
                                        //       padding:
                                        //           const EdgeInsets.only(
                                        //               left: 38, top: 5),
                                        //       child: Text(
                                        //         "\u{20B9}${value.todayCollectionList[index]['rec_amount'].toStringAsFixed(2)}",
                                        //         style: TextStyle(
                                        //             fontWeight:
                                        //                 FontWeight.bold,
                                        //             color: Colors.red,
                                        //             fontSize: 16),
                                        //       ),
                                        //     ),
                                        //     SizedBox(
                                        //       height: size.height * 0.01,
                                        //     ),
                                        //     Row(
                                        //       children: [
                                        //         Expanded(
                                        //           child: Padding(
                                        //             padding:
                                        //                 const EdgeInsets
                                        //                     .only(left: 38),
                                        //             child: RichText(
                                        //               overflow: TextOverflow
                                        //                   .ellipsis,
                                        //               text: TextSpan(
                                        //                 text:
                                        //                     '${value.todayCollectionList[index]['rec_note'].toString()}',
                                        //                 style: DefaultTextStyle
                                        //                         .of(context)
                                        //                     .style,
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ],
                                        // ),

                                        // Divider(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
