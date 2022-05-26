import "package:flutter/material.dart";
import 'package:get/get.dart';
import '../Screens/screens.dart';
import '../themes/textStyles.dart';
import '../themes/themes.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = [
      "Home",
      "Stammdaten",
      "Gewichtsanpassungen",
      "Trainingssets",
      "Shop",
      "Rangliste"
    ];
    List<Widget> menuItems = [];
    menuItems.add(const DrawerHeader(
      child: Text('Menü', style: TextStyles.textnormal),
    ));

    for (String element in menuTitles) {
      Widget screen = Container();
      menuItems.add(
        ListTile(
          title: Text(element, style: TextStyles.textnormal),
          onTap: () {
            switch (element) {
              case "Home":
                screen = const HomeScreen();
                break;
              case "Stammdaten":
                screen = const BasedataScreen();
                break;
              case "Gewichtsanpassungen":
                () {};
                break;
              case "Trainingssets":
                () {};
                break;
              case "Shop":
                () {};
                break;
              case "Rangliste":
                () {};
                break;
            }
            Get.to(screen);
          },
        ),
      );
    }
    return menuItems;
  }
}
