import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/components/customAppbar.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:orderapp/screen/staffLoginScreen.dart';
import 'package:provider/provider.dart';

class CompanyDetails extends StatefulWidget {
  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: P_Settings.detailscolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppbar(title: "Order App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "Company Details",
              style: TextStyle(fontSize: 20, color: P_Settings.headingColor),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Consumer<Controller>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return Container(
                        height: size.height * 0.9,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Container(
                        height: size.height * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text("company name : ${value.c_d[0].cnme}"),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.book),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "Address1           : ${value.c_d[0].ad1}",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.book),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "Address2            : ${value.c_d[0].ad2}",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.pin),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "PinCode              : ",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.business),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "CompanyPrefix  : ${value.c_d[0].cpre}",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.landscape),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "Land                    : ${value.c_d[0].land}",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "Mobile                 : ${value.c_d[0].mob}",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.design_services),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "GST                      : ${value.c_d[0].gst}",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.copy_rounded),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  "Country Code     : ${value.c_d[0].ccode}",
                                  // value.reportList![index]['filter_names'],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<Controller>(context, listen: false)
                                    .postRegistration("RONPBQ9AD5D");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StaffLogin()),
                                );
                              },
                              child: Text("Download Data"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}