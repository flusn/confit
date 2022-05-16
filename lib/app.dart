import 'package:confit/themes/colors.dart';
import "package:flutter/material.dart";
import 'package:confit/Screens/login.screen.dart';
import "package:confit/themes/colors.dart";
import "package:confit/themes/textStyles.dart";

import 'models/allUsers.dart';
import 'models/user.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AllUsers(
        users: <int, User>{
          0: User(username: "philipp.fries", password: "123456", name: ""),
          1: User(username: "sascha.groß", password: "123456", name: ""),
          2: User(username: "manuel.buchmann", password: "123456", name: ""),
          3: User(username: "florian.debus", password: "123456", name: ""),
        },
        currentUser: 0,
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            //primarySwatch: AppColors.text,
            inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppBorders.radius),
                    borderSide: const BorderSide(color: AppColors.text)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppBorders.radius),
                    borderSide: const BorderSide(color: AppColors.text)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppBorders.radius),
                    borderSide: BorderSide(color: AppColors.error)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppBorders.radius),
                    borderSide: BorderSide(color: AppColors.error))),
            unselectedWidgetColor: AppColors.text,
          ),
          home: const LoginScreen(),
        ));
  }
}
