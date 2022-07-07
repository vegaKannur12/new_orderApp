import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Uploaddata extends StatefulWidget {
  String? title;
  String cid;
  String type;
  Uploaddata({required this.cid, required this.type, this.title});

  @override
  State<Uploaddata> createState() => _UploaddataState();
}

class _UploaddataState extends State<Uploaddata> {
  // String? cid;
  List<String> uploadItems = [
    "Upload Orders",
    "Upload Sales",
    "Upload Customer",
    "Upload Stock Return"
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // getCompaniId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   cid=prefs.getString("company_id");
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: widget.type == ""
          ? AppBar(
              backgroundColor: P_Settings.wavecolor,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(6.0),
                child: Consumer<Controller>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        color: P_Settings.wavecolor,

                        // valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                        // value: 0.25,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              // title: Text("Company Details",style: TextStyle(fontSize: 20),),
            )
          : null,
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return Column(
            children: [
              // SizedBox(height: size.height*0.02,),
              // Container(
              //   child: Text(widget.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              //   height: size.height*0.06,
              // ),
              Flexible(
                child: Container(
                  height: size.height * 0.5,
                  child: ListView.builder(
                    itemCount: uploadItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: P_Settings.wavecolor),
                          child: ListTile(
                            trailing: IconButton(
                              onPressed: value.versof == "0"
                                  ? null
                                  : () async {
                                      if (uploadItems[index] ==
                                          "Upload Orders") {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .uploadOrdersData(
                                                widget.cid, context);
                                      }
                                      if (uploadItems[index] ==
                                          "Upload Stock Return") {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .uploadReturnData(
                                                widget.cid, context);
                                      }
                                      if (uploadItems[index] ==
                                          "Upload Sales") {
                                        // Provider.of<Controller>(context, listen: false)
                                        //     .getProductCategory(cid!, "");
                                      }
                                      if (uploadItems[index] ==
                                          "Upload Customer") {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .uploadCustomers(context);
                                        //     .getProductCategory(cid!, "");
                                      }
                                    },
                              icon: Icon(Icons.upload),
                              color: Colors.white,
                            ),
                            title: Center(
                                child: Text(
                              uploadItems[index],
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              value.versof == "0"
                  ? Container(
                      height: size.height * 0.2,
                      child: Text(
                        "Invalid Registration!!!",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    )
                  : Container()
            ],
          );
        },
      ),

      //  Column(
      //   // mainAxisAlignment: MainAxisAlignment.center,
      //   // crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     // Text(widget.cid),
      //     ElevatedButton.icon(
      //         onPressed: () {
      //           Provider.of<Controller>(context, listen: false)
      //               .uploadData(widget.cid, context);
      //         },
      //         icon: Icon(Icons.arrow_upward),
      //         label: Text("Upload"))
      //   ],
      // ),
    );
  }
}
