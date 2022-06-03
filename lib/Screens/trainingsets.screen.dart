import "package:flutter/material.dart";

import '../templates/menu.drawer.dart';

class TrainingsetsScreen extends StatelessWidget {
  const TrainingsetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(title: const Text("Trainingssets")),
    );
  }
}
