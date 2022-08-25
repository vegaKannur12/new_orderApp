import 'dart:math';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_blue/flutter_blue.dart';

class PrintMainPage extends StatefulWidget {
  List<Map<String, dynamic>>? data;
  PrintMainPage({this.data});

  @override
  State<PrintMainPage> createState() => _PrintMainPageState();
}

class _PrintMainPageState extends State<PrintMainPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool _connected = false;
  List<ScanResult>? scanResult;
  List<BluetoothDevice> _device = [];

  String deviceMsg = "";

  Future<void> initPrinter() async {
    print("dszknkdfjs");
    flutterBlue.startScan(timeout: const Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) {
      setState(() {
        scanResult = results;
      });
    });

    print("scanRsult----$scanResult");
    flutterBlue.stopScan();
  }

  void printWithDevice(BluetoothDevice device) async {
    await device.connect();
    final gen = Generator(PaperSize.mm58, await CapabilityProfile.load());
    final printer = BluePrint();
    printer.add(gen.qrcode('https://altospos.com'));
    printer.add(gen.text('Hello'));
    printer.add(gen.text('World', styles: const PosStyles(bold: true)));
    printer.add(gen.feed(1));
    await printer.printData(device);
    device.disconnect();
  }

  void initState() {
    super.initState();
    initPrinter();
    // WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
    //   initPrinter();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Printer page"),
      ),
      backgroundColor: Colors.grey,
      body: scanResult != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(scanResult![index].device.name),
                  subtitle: Text(scanResult![index].device.id.id),
                  onTap: () => printWithDevice(scanResult![index].device),
                );
              },
              itemCount: scanResult?.length ?? 0,
            )
          : Center(
              child: Text(
                deviceMsg.toString(),
                style: TextStyle(fontSize: 24),
              ),
            ),
    );
  }

  // Future<void> _startPrint(BluetoothDevice device) async {
  //   if (device != null && device.address != null) {
  //     await bluetoothPrint.connect(device);
  //     Map<String, dynamic> config = Map();
  //     List<LineText> list = [];
  //     list.add(LineText(
  //         type: LineText.TYPE_TEXT,
  //         content: "App",
  //         weight: 2,
  //         width: 2,
  //         height: 2,
  //         align: LineText.ALIGN_CENTER,
  //         linefeed: 1));

  //     for (int i = 0; i < widget.data!.length; i++) {
  //       list.add(LineText(
  //           type: LineText.TYPE_TEXT,
  //           content: widget.data![i]["title"],
  //           weight: 0,
  //           align: LineText.ALIGN_LEFT,
  //           linefeed: 1));

  //       list.add(LineText(
  //           type: LineText.TYPE_TEXT,
  //           content: widget.data![i]["Price"],
  //           weight: 0,
  //           align: LineText.ALIGN_LEFT,
  //           linefeed: 1));
  //     }
  //   }
  // }
}

//////////////////////////////////////////////////////////////////////////
class BluePrint {
  BluePrint({this.chunkLen = 512});

  final int chunkLen;
  final _data = List<int>.empty(growable: true);

  void add(List<int> data) {
    _data.addAll(data);
  }

  List<List<int>> getChunks() {
    final chunks = List<List<int>>.empty(growable: true);
    for (var i = 0; i < _data.length; i += chunkLen) {
      chunks.add(_data.sublist(i, min(i + chunkLen, _data.length)));
    }
    return chunks;
  }

  Future<void> printData(BluetoothDevice device) async {
    final data = getChunks();
    final characs = await _getCharacteristics(device);
    for (var i = 0; i < characs.length; i++) {
      if (await _tryPrint(characs[i], data)) {
        break;
      }
    }
  }

  Future<bool> _tryPrint(
    BluetoothCharacteristic charac,
    List<List<int>> data,
  ) async {
    for (var i = 0; i < data.length; i++) {
      try {
        await charac.write(data[i]);
      } catch (e) {
        return false;
      }
    }
    return true;
  }

  Future<List<BluetoothCharacteristic>> _getCharacteristics(
    BluetoothDevice device,
  ) async {
    final services = await device.discoverServices();
    final res = List<BluetoothCharacteristic>.empty(growable: true);
    for (var i = 0; i < services.length; i++) {
      res.addAll(services[i].characteristics);
    }
    return res;
  }
}
