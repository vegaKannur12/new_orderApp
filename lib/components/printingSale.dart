// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';

// class PrintMainPage extends StatefulWidget {
//   const PrintMainPage({Key? key}) : super(key: key);

//   @override
//   State<PrintMainPage> createState() => _PrintMainPageState();
// }

// class _PrintMainPageState extends State<PrintMainPage> {
//   PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
//   List<PrinterBluetooth> _devices = [];
//   String? _devicesMsg;
//   BluetoothManager bluetoothManager = BluetoothManager.instance;

//   Future<void> _startPrint(PrinterBluetooth printer) async {
//     _printerManager.selectPrinter(printer);
//     final myTicket = await _ticket(PaperSize.mm58);
//     final result = await _printerManager.printTicket(myTicket);
//     print(result);
//   }



//   _ticket(PaperSize paper) async {
//     Ticket ticket = Ticket(paper);
//     ticket.text("jnxnx");
//     ticket.text("widget.orderNumber");
//     ticket.text("widget.customerName");
//     ticket.text("widget.deliveryTime");
//     ticket.text('widget.instruction');

//     ticket.cut();
//     return ticket;
//   }

//   void initPrinter() {
//     print('init printer');

//     _printerManager.startScan(Duration(seconds: 2));
//     _printerManager.scanResults.listen((event) {
//       if (!mounted) return;
//       setState(() => _devices = event);
//       print(_devices);
//       if (_devices.isEmpty)
//         setState(() {
//           _devicesMsg = 'No devices';
//         });
//     });
//   }

//   void initState() {


//     initPrinter();
//     bluetoothManager.state.listen((val) {
//       print("state = $val");
//       if (!mounted) return;
//       if (val == 12) {
//         print('on');
//         initPrinter();
//       } else if (val == 10) {
//         print('off');
//         setState(() {
//           _devicesMsg = 'Please enable bluetooth to print';
//         });
//       }
//       print('state is $val');
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Printer page"),
//       ),
//       backgroundColor: Colors.grey,
//       body: _devices.isNotEmpty
//           ? ListView.builder(
//               itemBuilder: (context, position) => ListTile(
//                 onTap: () {
//                   //  _startPrint(_devices[position]);
//                 },
//                 leading: Icon(Icons.print),
//                 title: Text(_devices[position].name!),
//                 subtitle: Text(_devices[position].address!),
//               ),
//               itemCount: _devices.length,
//             )
//           : Center(
//               child: Text(
//                 _devicesMsg ?? 'Ops something went wrong!',
//                 style: TextStyle(fontSize: 24),
//               ),
//             ),
//     );
//   }
// }


