import "package:flutter/material.dart";
import '../Screens/screens.dart';
import '../models/user.dart';
import '../themes/textStyles.dart';

class MenuDrawer extends StatelessWidget {
  final User user;

  const MenuDrawer({
    Key? key,
    required this.user,
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
                screen = HomeScreen(user: user);
                break;
              case "Stammdaten":
                screen = BasedataScreen(user: user);
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
            Navigator.of(context).pop();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => screen));
          },
        ),
      );
    }
    return menuItems;
  }
}
