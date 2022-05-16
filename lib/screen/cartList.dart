import 'package:flutter/material.dart';
import 'package:orderapp/components/commoncolor.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:provider/provider.dart';

class CartList extends StatefulWidget {
  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List<TextEditingController> _controller = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var length =
        Provider.of<Controller>(context, listen: false).listWidget.length;
    _controller = List.generate(length, (i) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<Controller>(builder: (context, value, child) {
        return SafeArea(
            child: ListView.builder(
          itemCount: value.listWidget.length,
          itemBuilder: (BuildContext context, int index) {
            return listItemFunction(
                value.listWidget[index]["item"],
                value.listWidget[index]["rate1"],
                size,
                _controller[index],
                index);
          },
        ));
      }),
    );
  }

  Widget listItemFunction(String itemName, double rate, Size size,
      TextEditingController _controller, int index) {
    return Container(
      height: size.height * 0.19,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Ink(
          // color: Colors.grey[100],
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            // leading: CircleAvatar(backgroundColor: Colors.green),
            title: Column(
              children: [
                Flexible(
                  child: Text(
                    "${itemName}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: P_Settings.wavecolor),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.001,
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 40,
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                        height: size.height * 0.001,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rate",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Text(
                                    "Qty",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  // Spacer(),
                                  Text(
                                    "Amt",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // SizedBox(
                                  //   height: size.height * 0.02,
                                  // ),
                                  Text(
                                    "\u{20B9}${rate}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Container(
                                      width: size.width * 0.1,
                                      child: TextFormField(
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        keyboardType: TextInputType.number,
                                        // decoration: new InputDecoration(
                                        //   border: InputBorder.none,
                                        // ),
                                        controller: _controller,
                                      )),
                                  Text(
                                    "\u{20B9}${rate}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.009,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              // title: Text("Alert Dialog Box"),
                              content: Text("delete?"),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: P_Settings.wavecolor),
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text("cancel"),
                                    ),
                                    SizedBox(width: size.width*0.01,),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: P_Settings.wavecolor),
                                      onPressed: () {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .deleteListWidget(index);
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
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // trailing: IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.delete),
            // ),
          ),
        ),
      ),
    );
  }

  // Widget listItemFunction(String itemName, double rate, Size size,
  //     TextEditingController _controller) {
  //   return Container(
  //     // decoration: BoxDecoration(
  //     //     // shape: BoxShape.circle,
  //     //     borderRadius: BorderRadius.all(Radius.circular(10))),
  //     height: size.height * 0.14,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Card(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(15.0),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column(
  //               children: [
  //                 Column(),
  //                 Column(
  //                   children: [
  //                     Container(
  //                       height: size.height * 0.03,
  //                       child: Row(
  //                         children: [
  //                           Text(
  //                             "${itemName}",
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold, fontSize: 18),
  //                           ),
  //                           Spacer(),
  //                           IconButton(
  //                               onPressed: () {
  //                                 // widget.listWidget.removeAt(index);
  //                               },
  //                               icon: Icon(Icons.delete))
  //                         ],
  //                       ),
  //                     ),
  //                     Container(
  //                       height: size.height * 0.05,
  //                       child: Row(
  //                         children: [
  //                           // Text(
  //                           //   "Rate  ",
  //                           // ),
  //                           Text(":"),
  //                           Text(
  //                             "${rate}",
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold, fontSize: 18),
  //                           ),
  //                           SizedBox(
  //                             width: size.width * 0.2,
  //                           ),
  //                           // Spacer(),
  //                           Row(
  //                             children: [
  //                               Text("Qty  :"),
  //                               Container(
  //                                   width: size.width * 0.1,
  //                                   child: TextFormField(
  //                                     style: TextStyle(
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: 18),
  //                                     keyboardType: TextInputType.number,
  //                                     // decoration: new InputDecoration(
  //                                     //   border: InputBorder.none,
  //                                     // ),
  //                                     controller: _controller,
  //                                   )),
  //                             ],
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     // Row(
  //                     //   children: [Text("Order No")],
  //                     // )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           )),
  //     ),
  //   );
  // }
}