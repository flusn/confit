/*import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import "package:flutter/foundation.dart";

class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/assets/jsonData/allUsers.json');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();
      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }

  readFilesFromCustomDevicePath() async {
    // Retrieve "External Storage Directory" for Android and "NSApplicationSupportDirectory" for iOS
    Directory directory;
    if (Platform.isAndroid) {
      directory = (await getExternalStorageDirectory())!;
    } else if (Platform.isIOS) {
      directory = await getApplicationSupportDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    // Create a new file. You can create any kind of file like txt, doc , json etc.
    File file =
        await File("${directory.path}/assets/jsonData/allUsers.json").create();

    // Read the file content
    String fileContent = await file.readAsString();
    print("fileContent : ${fileContent}");
  }

  writeFilesToCustomDevicePath() async {
    // Retrieve "External Storage Directory" for Android and "NSApplicationSupportDirectory" for iOS
    Directory directory;
    if (Platform.isAndroid) {
      directory = (await getExternalStorageDirectory())!;
    } else if (Platform.isIOS) {
      directory = await getApplicationSupportDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    // Create a new file. You can create any kind of file like txt, doc , json etc.
    File file =
        await File("${directory.path}/assets/jsonData/allUsers.json").create();

    // Convert json object to String data using json.encode() method
    String fileContent = json.encode({
      "Website": {
        "Name": "Toastguyz",
        "Description": "Programming Tutorials",
      },
    });
  }
}
*/