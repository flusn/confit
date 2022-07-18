import 'package:confit/Screens/ranking.screen.dart';
import 'package:confit/Screens/shop.screen.dart';
import 'package:confit/Screens/trainingsets.screen.dart';
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
      "Training",
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
                screen = const WeightdataScreen();
                break;
              case "Training":
                screen = const TrainingsetsScreen();
                break;
              case "Shop":
                screen = const ShopScreen();
                break;
              case "Rangliste":
                screen = const RankingScreen();
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
