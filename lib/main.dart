import 'package:flutter/material.dart';
import "package:confit/app.dart";
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  //GetStorage().erase();
  runApp(const MyApp());
}
