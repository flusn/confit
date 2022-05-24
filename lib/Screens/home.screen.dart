import "package:flutter/material.dart";

import '../models/user.dart';
import '../templates/menu.drawer.dart';
import '../themes/textStyles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(user: user),
      appBar: AppBar(title: const Text("Homescreen")),
    );
  }
}
