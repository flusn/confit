import "package:flutter/material.dart";
import "package:confit/themes/colors.dart";

class UserDataSreen extends StatelessWidget {
  const UserDataSreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ConFit"),
          backgroundColor: AppColors.background,
        ),
        body: Container(),
        backgroundColor: AppColors.background);
  }
}
