import "package:flutter/material.dart";

import '../models/allUsers.dart';
import '../templates/readonly.dart';
import "../themes/themes.dart";

class UserData extends StatelessWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userclass = context.dependOnInheritedWidgetOfExactType<AllUsers>();
    final user = userclass!.users[userclass.getCurrentUser()];

    return Scaffold(
      appBar: AppBar(
        title: Text(user!.name, style: const TextStyle(color: AppColors.text)),
        backgroundColor: AppColors.background,
      ),
      backgroundColor: AppColors.background,
      body: Card(
        borderOnForeground: false,
        color: AppColors.cardColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ReadonlyTextField(title: "Alter", value: user!.age.toString()),
              ReadonlyTextField(title: "BMI", value: user!.bmi.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
