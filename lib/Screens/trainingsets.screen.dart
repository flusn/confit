import "package:flutter/material.dart";

import '../models/profil_image.dart';
import '../templates/menu.drawer.dart';

class TrainingsetsScreen extends StatelessWidget {
  const TrainingsetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("Trainingssets"),
            ProfilImageInAppBar(),
          ],
        ),
      ),
    );
  }
}
