import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:external_path/external_path.dart';

class ExternalDir {
  String? fingerprint;
  Future<void> getPublicDirectoryPath() async {
    // print("fp---------$fp");
    String path;
    String text;

    path = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);

    print("path-----$path"); //
    final File file = File('$path/fdfp.txt');
    String filpath = '$path/fdfp.txt';
    if (await File(filpath).exists()) {
      text = await file.readAsString();
      // fingerprint=text;
      print("file exists---$text");
    } else {
      print("not exist");
      // fingerprint="";
      await file.writeAsString('dzdsz');
      text = await file.readAsString();
      print("file not----$text");
    }
    // await file.writeAsString('1234  5678\n');
    // await file.writeAsString('ghgjg\n');
    // print(await file.readAsString());
  }
}

// class ExternalDir extends StatefulWidget {
//   const ExternalDir({Key? key}) : super(key: key);

//   @override
//   State<ExternalDir> createState() => _ExternalDirState();
// }

// class _ExternalDirState extends State<ExternalDir> {
//   late String attachment;
//   late String appDocumentsPath;

//   Future<void> getPublicDirectoryPath() async {
//     String path;
//     String text;
//     path = await ExternalPath.getExternalStoragePublicDirectory(
//         ExternalPath.DIRECTORY_DOWNLOADS);

//     print("path-----$path"); //
//     final File file = File('$path/hy.txt');
//     // String filpath = '$path/f.txt';
//     if (await File(file.path).exists()) {
//       text = await file.readAsString();
//       print("file exists---$text");
//     } else {
//       print("not exist");
//       await file.writeAsString('hyyyyy\n');
//       text = await file.readAsString();
//       print("file not----$text");
//     }
//     // await file.writeAsString('1234  5678\n');
//   }

//   // Future<void> getStoragePermission() async {
//   //   if (await Permission.manageExternalStorage.request().isGranted) {
//   //     print("haiiii");
//   //     setState(() {});
//   //   } else if (await Permission.storage.request().isPermanentlyDenied) {
//   //     await openAppSettings();
//   //   } else if (await Permission.storage.request().isDenied) {
//   //     setState(() {});
//   //   }
//   // }
//   Future downlod() async {
//     final Directory? _extDocDir = await Directory("/storage/emulated/0");
//     await Permission.storage.request();
//     final Directory directory = Directory('${_extDocDir!.path}/hii');
//     final String path = directory.path;
//     final File file = File('$path/secure-strorage-backup.txt');
//     await file.writeAsString('1234  5678\n');
//     await file.writeAsString('1234  5678\n');
//     print(await file.readAsString());
//   }

//   Future createFolderInAppDocDir(String folderName) async {
//     String filePath;
//     final Directory? _extDocDir = await Directory("/storage/emulated/0");

//     final Directory directory = Directory('${_extDocDir!.path}/$folderName/');
//     // final directory = Directory("/storage/emulated/0");
//     // final newdir = Directory("/storage/emulated/0");
//     print("external directory-----$directory");
//     // File file;

//     if (_extDocDir.existsSync()) {
//       Directory(_extDocDir.path + '/$folderName').create(recursive: true);
//       //  File('$path/file.xlsx').create(recursive: true);
//       File file =
//           await File('/storage/emulated/0/hii.txt').create(recursive: true);
//       // File file = File(_extDocDir.path + '/$folderName/hii.txt');
//       // print('saving to ${file.path}');
//       // file.create(recursive: true);
//       file.writeAsString("jdszd");
//       final contents = await file.readAsString();
//       print("file content----${contents}");
//     }

//     // if (await directory.exists()) {
//     //   print("old---------------${directory.path}");
//     //   appDocumentsPath = directory.path;
//     // } else {
//     //   print("not exists");
//     //   final Directory _appDocDirFolder =
//     //       await directory.create(recursive: true);

//     //   print("_appDocDirFolder---$_appDocDirFolder");

//     //   print("new---------------${_appDocDirFolder.path}");
//     //   appDocumentsPath = _appDocDirFolder.path;
//     // }
//     // String text = "dd";
//     // File file =
//     //     await File('${appDocumentsPath}/test.txt').create(recursive: true);
//     // file.writeAsString(text);
//     // final contents = await file.readAsString();
//     // print("file content----${contents}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: ElevatedButton(
//             child: Text("click"),
//             onPressed: () async {
//               await getPublicDirectoryPath();
//             }),
//       ),
//     );
//   }
// }
