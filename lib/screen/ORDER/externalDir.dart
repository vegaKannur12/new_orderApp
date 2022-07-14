import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExternalDir {
  // List<String> result = [];
  // String? fingerprint;

  // Future<String> fileExistsOrNot() async {
  //   String path = await ExternalPath.getExternalStoragePublicDirectory(
  //       ExternalPath.DIRECTORY_DOWNLOADS);

  //   print("path-----$path"); //
  //   final File file = File('$path/fingerprint4.txt');
  //   String filpath = '$path/fingerprint4.txt';
  //   if (await File(filpath).exists()) {
  //     return "exist";
  //   } else {
  //     return "not exist";
  //   }
  // }
  // //////////////////////////////////////////////////////

  // Future<String?> getPublicDirectoryPath() async {
  //   String path;
  //   String? text;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? fp = prefs.getString("fp");
  //   print("fp---------$fp");

  //   path = await ExternalPath.getExternalStoragePublicDirectory(
  //       ExternalPath.DIRECTORY_DOWNLOADS);
  //   print("path-----$path"); //

  //   final File file = File('$path/fingerprint11.txt');
  //   String filpath = '$path/fingerprint11.txt';
  //   // var status = await Permission.storage.status;
  //   // if (!status.isGranted) {

  //   // await Permission.storage.request();
  //   var status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     if (await File(filpath).exists()) {
  //       print("existgfgf");
  //       text = await file.readAsString();
  //       print("file exist----$text");

  //       // return text;
  //     } else {
  //       print("not exist");
  //       await file.writeAsString(fp!);
  //       text = await file.readAsString();

  //       print("file not----$text");
  //     }
  //     // }
  //     return text;
  //   }
  // }

  String? tempFp;

  fileRead() async {
    String path;
    path = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    print("path-----$path"); //

    final File file = File('$path/fingerprint13.txt');
    String filpath = '$path/fingerprint13.txt';
    if (await File(filpath).exists()) {
      print("existgfgf");
      tempFp = await file.readAsString();
      // print("file exist----$tempFp");

      // return text;
    } else {
      tempFp = "";

    }
     print("file exist----$tempFp");
     return tempFp;
  }
///////////////////////////////////////////////////////////////////////////////////
  fileWrite(String fp) async {
    String path;
    print("fpppp====$fp");
    path = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    print("path-----$path"); //

    final File file = File('$path/fingerprint13.txt');
    String filpath = '$path/fingerprint13.txt';
    if (await File(filpath).exists()) {
      print("file exists");
    } else {
      await file.writeAsString(fp);
      // print("file exist----$tempFp");
    }
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
