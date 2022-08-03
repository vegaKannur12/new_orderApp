import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/historydataPopup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodaySale extends StatefulWidget {
  const TodaySale({Key? key}) : super(key: key);

  @override
  State<TodaySale> createState() => _TodaySaleState();
}

class _TodaySaleState extends State<TodaySale> {
  DateTime dateti = DateTime.now();
  HistoryPopup popup = HistoryPopup();
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
    print(
        "todaySalesList----${Provider.of<Controller>(context, listen: false).todaySalesList}");
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
            if (value.todaySalesList.length == 0) {
              return Container(
                height: size.height * 0.7,
                width: double.infinity,
                child: Center(
                    child: Text(
                  "No Sales!!!",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                )),
              );
            } else {
              return ListView.builder(
                itemCount: value.todaySalesList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.16,
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<Controller>(context, listen: false)
                                  .getSaleHistoryData('salesDetailTable',
                                      "sales_id='${value.todaySalesList[index]["sales_id"]}'");
                              popup.buildPopupDialog(
                                  context,
                                  size,
                                  value.todaySalesList[index]["sale_Num"],
                                  value.todaySalesList[index]["Cus_id"],
                                  "sales");
                            },
                            child: Card(
                              color: Colors.grey[100],
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
                                        Flexible(
                                          child: Text(
                                              value.todaySalesList[index]
                                                  ["sale_Num"],
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                        ),
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
                                        RichText(
                                          overflow: TextOverflow.clip,
                                          maxLines: 2,
                                          text: TextSpan(
                                            text:
                                                '${value.todaySalesList[index]["cus_name"]}',
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Text(" - "),
                                        Text(
                                          value.todaySalesList[index]["Cus_id"],
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 14),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    Divider(),
                                    Flexible(
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "No: of Items  :",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                              "${value.todaySalesList[index]["count"].toString()}",
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
                                            "\u{20B9}${value.todaySalesList[index]["net_amt"].toString()}",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
