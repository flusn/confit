import "package:flutter/material.dart";

import '../models/user.dart';
import '../templates/menu.drawer.dart';
import '../themes/textStyles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(title: const Text("Homescreen")),
    );
  }
}
