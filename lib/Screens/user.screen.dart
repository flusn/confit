import "package:flutter/material.dart";

import '../templates/readonly.dart';
import "../themes/themes.dart";

class UserData extends StatelessWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("user!.name", style: TextStyle(color: AppColors.text)),
        backgroundColor: AppColors.background,
      ),
      backgroundColor: AppColors.background,
      body: Card(
        borderOnForeground: false,
        color: AppColors.cardColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ReadonlyTextField(title: "Alter", value: "age"),
              const ReadonlyTextField(title: "BMI", value: "bmi"),
            ],
          ),
        ),
      ),
    );
  }
}
