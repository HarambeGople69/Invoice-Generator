import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
// import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    print("Inside save mode");
    final bytes = await pdf.save();

    // final dir = await getApplicationDocumentsDirectory();
    final file = File('storage/emulated/0/Invoice Generator/$name');
    await file.writeAsBytes(bytes);
    var status = await Permission.storage.request();
    final path = Directory("storage/emulated/0/Invoice Generator");

    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (status.isPermanentlyDenied) {
      AppSettings.openAppSettings();
      print("=========================");
    }
    if ((await path.exists())) {
      Hive.box<int>("StoragePermission").put("given", 1);
      print("Folder exists");
      await file.writeAsBytes(bytes);

      // return path.path;
    } else {
      path.create();
      print("Folder created");
      await file.writeAsBytes(bytes);

      Hive.box<int>("StoragePermission").put("given", 1);
      // return path.path;
    }
    return file;
  }

  // static Future openFile(File file) async {
  //   final url = file.path;

  //   await OpenFile.open(url);
  // }
}
