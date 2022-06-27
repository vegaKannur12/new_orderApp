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
    print("helooo");
    final prefs = await SharedPreferences.getInstance();
    sid = prefs.getString('sid');
    print("sid ......$sid");
    print("formattedDate...$formattedDate");
    // Future.delayed(const Duration(milliseconds: 1000), () async {
    //   if (!mounted) return;
    //   await Provider.of<Controller>(context, listen: false)
    //       .todayCollection(formattedDate!, context);
    // });
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
                              child: Container(
                                height: size.height * 0.15,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              child: Icon(
                                                Icons.reviews,
                                                size: 13,
                                              ),
                                              backgroundColor:
                                                  P_Settings.roundedButtonColor,
                                            ),
                                            SizedBox(width: size.width * 0.03),
                                            Text(
                                              "${value.todayCollectionList[index]['cus_name'].toString()} ",
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              " - ${value.todayCollectionList[index]['rec_cusid'].toString()}",
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 53),
                                                  child: Text(
                                                    "\u{20B9}${value.todayCollectionList[index]['rec_amount'].toString()}",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                        color: Colors.red,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            // Divider(),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 53),
                                                  child: Text(
                                                    "${value.todayCollectionList[index]['rec_note'].toString()}",
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16,
                                                      // color: P_Settings
                                                      //     .dashbordcl2
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // ListTile(
                              //   leading: CircleAvatar(
                              //     child: Icon(
                              //       Icons.reviews,
                              //       size: 16,
                              //     ),
                              //     backgroundColor:
                              //         P_Settings.roundedButtonColor,
                              //   ),
                              //   title: Text(
                              //     "\u{20B9}${value.collectionList[index]['rec_amount'].toString()}",
                              //     style: TextStyle(fontSize: 16),
                              //   ),
                              //   subtitle: Text(
                              //       "\u{20B9}${value.collectionList[index]['rec_cusid'].toString()} "),
                              // ),
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
