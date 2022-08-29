import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:orderapp/controller/controller.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:image/image.dart' as Imag;
import 'package:provider/provider.dart';

class PrintMainPage extends StatefulWidget {
  const PrintMainPage({Key? key}) : super(key: key);

  @override
  State<PrintMainPage> createState() => _PrintMainPageState();
}

class _PrintMainPageState extends State<PrintMainPage> {
  List<int> widthval = [1, 4, 6];
  int colLength = 3;
  String _info = "";
  String _msj = '';
  bool connected = false;
  List<BluetoothInfo> items = [];
  List<String> _options = [
    "permission bluetooth granted",
    "bluetooth enabled",
    "connection status",
    "update info"
  ];

  String _selectSize = "2";
  final _txtText = TextEditingController(text: "Hello developer");
  bool _connceting = false;
  Future<void> getBluetoots() async {
    final List<BluetoothInfo> listResult =
        await PrintBluetoothThermal.pairedBluetooths;
    if (listResult.length == 0) {
      _msj =
          "There are no bluetoohs linked, go to settings and link the printer";
    } else {
      _msj = "Touch an item in the list to connect";
    }

    setState(() {
      items = listResult;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBluetoots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return ListView.builder(
              itemCount: items.length > 0 ? items.length : 0,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    String mac = items[index].macAdress;
                    this.connect(mac);
                    printTest(value.printSalesData);
                  },
                  title: Text('Name: ${items[index].name}'),
                  subtitle: Text("macAdress: ${items[index].macAdress}"),
                );
              });
        },
      ),
    );
  }

  Future<void> connect(String mac) async {
    setState(() {
      _connceting = true;
    });
    final bool result =
        await PrintBluetoothThermal.connect(macPrinterAddress: mac);
    print("state conected $result");
    if (result) connected = true;
    setState(() {
      _connceting = false;
    });
  }

  Future<void> disconnect() async {
    final bool status = await PrintBluetoothThermal.disconnect;
    setState(() {
      connected = false;
    });
    print("status disconnect $status");
  }

  Future<void> printTest(Map printSalesData) async {
    bool conexionStatus = await PrintBluetoothThermal.connectionStatus;
    if (conexionStatus) {
      List<int> ticket = await testTicket(printSalesData);
      final result = await PrintBluetoothThermal.writeBytes(ticket);
      print("impresion $result");
    } else {
      //no conectado, reconecte
    }
  }

  Future<List<int>> testTicket(
    Map printSalesData,
  ) async {
    print("nkzsnfn------$printSalesData");
    List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    bytes += generator.setGlobalFont(PosFontType.fontA);
    bytes += generator.reset();
    // bytes += generator.qrcode('example.com');
    bytes += generator.row([
      PosColumn(
        text: printSalesData["master"]["cus_name"],
        width: 12,
        styles: PosStyles(align: PosAlign.center, bold: true),
      ),
    ]);
    bytes += generator.feed(1);
    bytes += generator.row([
      PosColumn(
        text: 'Bill No : ${printSalesData["master"]["sale_Num"]}',
        width: 12,
        styles: PosStyles(codeTable: 'CP1252'),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: printSalesData["master"]["Date"],
        width: 12,
        styles: PosStyles(codeTable: 'CP1252'),
      ),
    ]);

    bytes += generator.feed(1);
    bytes += generator.row(
      [
        PosColumn(
          text: 'code',
          width: 2,
          styles: PosStyles(align: PosAlign.left, underline: true),
        ),
        PosColumn(
          text: 'item',
          width: 4,
          styles: PosStyles(align: PosAlign.left, underline: true),
        ),
        PosColumn(
          text: 'qty',
          width: 3,
          styles: PosStyles(align: PosAlign.right, underline: true),
        ),
        PosColumn(
          text: 'rate',
          width: 3,
          styles: PosStyles(align: PosAlign.right, underline: true),
        ),
      ],
    );
    bytes += generator.feed(1);
    for (int i = 0; i < printSalesData["detail"].length; i++) {
      bytes += generator.row(
        [
          PosColumn(
            text: printSalesData["detail"][i]["code"].toString(),
            width: 2,
            styles: PosStyles(
              align: PosAlign.left,
            ),
          ),
          PosColumn(
            text: printSalesData["detail"][i]["item"].toString(),
            width: 4,
            styles: PosStyles(
              align: PosAlign.left,
            ),
          ),
          PosColumn(
            text: printSalesData["detail"][i]["qty"].toString(),
            width: 3,
            styles: PosStyles(
              align: PosAlign.right,
            ),
          ),
          PosColumn(
            text: printSalesData["detail"][i]["rate"].toStringAsFixed(2),
            width: 3,
            styles: PosStyles(
              align: PosAlign.right,
            ),
          ),
        ],
      );
    }
    bytes += generator.feed(1);
    bytes += generator.row(
      [
        PosColumn(
          text: "Item Count :",
          width: 5,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text: printSalesData["master"]["count"].toString(),
          width: 7,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
      ],
    );
    bytes += generator.feed(1);
    bytes += generator.row(
      [
        PosColumn(
          text: "Discount :",
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true),
        ),
        PosColumn(
          text: "${printSalesData["master"]["distot"].toStringAsFixed(2)}",
          width: 6,
          styles: PosStyles(align: PosAlign.right, bold: true),
        ),
      ],
    );
    bytes += generator.row(
      [
        PosColumn(
          text: "Tax :",
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true),
        ),
        PosColumn(
          text: "${printSalesData["master"]["taxtot"].toStringAsFixed(2)}",
          width: 6,
          styles: PosStyles(align: PosAlign.right, bold: true),
        ),
      ],
    );
    bytes += generator.row(
      [
        PosColumn(
          text: "Total :",
          width: 6,
          styles: PosStyles(align: PosAlign.left, bold: true),
        ),
        PosColumn(
          text: "${printSalesData["master"]["net_amt"].toStringAsFixed(2)}",
          width: 6,
          styles: PosStyles(align: PosAlign.right, bold: true),
        ),
      ],
    );
    bytes += generator.cut();

    return bytes;
  }
}

////////////////// reference ////////////////////////////
  // Future<List<int>> testTicket() async {
  //   List<int> bytes = [];
  //   // Using default profile
  //   final profile = await CapabilityProfile.load();
  //   final generator = Generator(PaperSize.mm58, profile);
  //   //bytes += generator.setGlobalFont(PosFontType.fontA);
  //   bytes += generator.reset();

  //   final ByteData data = await rootBundle.load('asset/noData1.png');
  //   final Uint8List bytesImg = data.buffer.asUint8List();
  //   final image = Imag.decodeImage(bytesImg);
  //   // Using `ESC *`
  //   bytes += generator.image(image!);

  //   bytes += generator.text('Anusha k', styles: PosStyles());
  //   bytes += generator.text('Special 1: ñÑ àÀ èÈ éÉ üÜ çÇ ôÔ',
  //       styles: PosStyles(codeTable: 'CP1252'));
  //   bytes += generator.text(
  //     'Thottada ',
  //     styles: PosStyles(codeTable: 'CP1252'),
  //   );

  //   bytes += generator.text('Bold text', styles: PosStyles(bold: true));
  //   bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
  //   bytes += generator.text('Underlined text',
  //       styles: PosStyles(underline: true), linesAfter: 1);
  //   bytes +=
  //       generator.text('Align left', styles: PosStyles(align: PosAlign.left));
  //   bytes += generator.text('Align center',
  //       styles: PosStyles(align: PosAlign.center));
  //   bytes += generator.text('Align right',
  //       styles: PosStyles(align: PosAlign.right), linesAfter: 1);

  //   bytes += generator.row(
  //     [
  //       PosColumn(
  //         text: 'col3',
  //         width: 3,
  //         styles: PosStyles(align: PosAlign.center, underline: true),
  //       ),
  //       PosColumn(
  //         text: 'col6',
  //         width: 6,
  //         styles: PosStyles(align: PosAlign.center, underline: true),
  //       ),
  //       PosColumn(
  //         text: 'col3',
  //         width: 3,
  //         styles: PosStyles(align: PosAlign.center, underline: true),
  //       ),
  //     ],
  //   );

  //   final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
  //   bytes += generator.barcode(Barcode.upcA(barData));

  //   //QR code
  //   bytes += generator.qrcode('example.com');

  //   bytes += generator.text(
  //     'Text size 50%',
  //     styles: PosStyles(
  //       fontType: PosFontType.fontB,
  //     ),
  //   );
  //   bytes += generator.text(
  //     'Text size 100%',
  //     styles: PosStyles(
  //       fontType: PosFontType.fontA,
  //     ),
  //   );
  //   bytes += generator.text(
  //     'Text size 200%',
  //     styles: PosStyles(
  //       height: PosTextSize.size2,
  //       width: PosTextSize.size2,
  //     ),
  //   );

  //   bytes += generator.feed(2);
  //   //bytes += generator.cut();
  //   return bytes;
  // }

