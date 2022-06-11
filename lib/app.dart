import "package:flutter/material.dart";
import 'package:confit/Screens/login.screen.dart';
import "package:confit/themes/themes.dart";
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appThemes(),
      home: const LoginScreen(),
    );
  }
}
