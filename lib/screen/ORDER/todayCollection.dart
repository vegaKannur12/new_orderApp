import 'package:flutter/material.dart';
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
    Future.delayed(const Duration(milliseconds: 500), () async {
      await Provider.of<Controller>(context, listen: false)
          .fetchtotalcollectionFromTable(sid!, formattedDate!);
    });
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
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Container(
                    // color: P_Settings.collection,
                    height: size.height * 0.7,
                    child: ListView.builder(
                      itemCount: value.collectionList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.reviews,
                                size: 16,
                              ),
                              backgroundColor: P_Settings.roundedButtonColor,
                            ),
                            title: Text(
                              "\u{20B9}${value.collectionList[index]['rec_amount'].toString()}",
                              style: TextStyle(fontSize: 16),
                            ),
                            subtitle: Text(
                                "\u{20B9}${value.collectionList[index]['rec_cusid'].toString()}"),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TodayCollectionPage {
  Widget collectionPage(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<Controller>(
      builder: (context, value, child) {
        return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Container(
                  // color: P_Settings.collection,
                  height: size.height * 0.7,
                  child: ListView.builder(
                    itemCount: value.collectionList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.reviews,
                              size: 16,
                            ),
                            backgroundColor: P_Settings.roundedButtonColor,
                          ),
                          title: Text(
                            "\u{20B9}${value.collectionList[index]['rec_amount'].toString()}",
                            style: TextStyle(fontSize: 16),
                          ),
                          subtitle: Text(
                              "\u{20B9}${value.collectionList[index]['rec_cusid'].toString()}"),
                        ),
                      );
                    },
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
