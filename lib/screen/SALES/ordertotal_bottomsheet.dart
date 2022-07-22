// import 'package:flutter/material.dart';
// import 'package:orderapp/controller/controller.dart';
// import 'package:orderapp/db_helper.dart';
// import 'package:provider/provider.dart';

// class SalesBottomSheet {
//   String? gen_condition;

//   Widget buildbottomsheet(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     showModalBottomSheet<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return Consumer<Controller>(
//           builder: (context, value, child) {
//             return Container(
//               height: size.height * 0.3,
//               color: Colors.white,
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(
//                         height: size.height * 0.01,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.close),
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                           )
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           FloatingActionButton.small(
//                               backgroundColor: Colors.grey,
//                               child: Icon(Icons.remove),
//                               onPressed: () {
//                                 if (value.qtyinc! > 1) {
//                                   value.qtyDecrement();
//                                   value.totalCalculation(rate);
//                                 }
//                               }),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.only(left: 15.0, right: 15),
//                             child: Text(
//                               value.qtyinc.toString(),
//                               style: TextStyle(fontSize: 20),
//                             ),
//                           ),
//                           FloatingActionButton.small(
//                               backgroundColor: Colors.grey,
//                               child: Icon(Icons.add),
//                               onPressed: () {
//                                 value.qtyIncrement();
//                                 value.totalCalculation(rate);
//                               }),
//                         ],
//                       ),
//                       SizedBox(
//                         height: size.height * 0.02,
//                       ),
//                       Divider(
//                         thickness: 1,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8.0, bottom: 8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Total Price :",
//                               style: TextStyle(fontSize: 17),
//                             ),
//                             Flexible(
//                               child: Text(
//                                 "\u{20B9}${value.totalPrice.toString()}",
//                                 style: TextStyle(fontSize: 17),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Divider(
//                         thickness: 1,
//                       ),
//                       SizedBox(
//                         height: size.height * 0.02,
//                       ),
//                       Expanded(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               height: size.height * 0.05,
//                               width: size.width * 0.6,
//                               child: ElevatedButton(
//                                   onPressed: () {
//                                     Provider.of<Controller>(context,
//                                             listen: false)
//                                         .updateQty(value.qtyinc.toString(),
//                                             cartrowno, widget.custmerId, rate);
//                                     Provider.of<Controller>(context,
//                                             listen: false)
//                                         .calculateorderTotal(
//                                             widget.os, widget.custmerId);
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text("continue..")),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
