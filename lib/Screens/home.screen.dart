import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, this.userId}) : super(key: key);

  final int? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Homescreen")),
    );
  }
}
