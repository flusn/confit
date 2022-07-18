import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../models/profil_image.dart';
import '../templates/menu.drawer.dart';
import '../themes/colors.dart';
import '../themes/textStyles.dart';
import '../models/user_controller.dart';

class ShopItem {
  String text;
  int points;
  int? count;

  ShopItem({required this.text, required this.points, this.count});
}

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final List<ShopItem> shopItems = [
    ShopItem(text: '500 MB Datenvolumen', points: 5000),
    ShopItem(text: '1000 MB Datenvolumen', points: 9000),
    ShopItem(text: '1500 MB Datenvolumen', points: 12000),
    ShopItem(text: 'Powerbank', points: 15000, count: 100),
    ShopItem(text: '25€ Hello Fresh Gutschein', points: 18000),
    ShopItem(text: '100€ MyMagenta Shop Gutschein', points: 50000),
    ShopItem(text: '250€ Gutschein', points: 100000, count: 4),
    ShopItem(text: 'Heimkinoanlage', points: 250000, count: 3),
    ShopItem(text: 'Heimkinoanlage', points: 500000, count: 2),
  ];

  @override
  Widget build(BuildContext context) {
    final userstorage = GetStorage();
    Controller c = Get.find();

    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("Shop"),
            ProfilImageInAppBar(),
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemCount: shopItems.length,
        itemBuilder: (BuildContext context, index) {
          return InkWell(
            splashColor: Colors.blue,
            hoverColor: Colors.yellow,
            onTap: () {
              if (c.user.value.points > shopItems.elementAt(index).points) {
                c.user.value.points -= shopItems.elementAt(index).points;

                final userAsNormalMap = c.user.value.toJson();
                userstorage.write(
                    c.currentUserId.value.toString(), userAsNormalMap);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text('${shopItems.elementAt(index).text} gekauft')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Nicht möglich, du hast wenig Punkte!')));
              }
            },
            child: Ink(
              height: 200,
              width: 200,
              color: AppColors.cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(shopItems.elementAt(index).text,
                        style: const TextStyle(
                            color: AppColors.text,
                            fontSize: AppFontSizes.shopItems)),
                    Text(
                        NumberFormat('###.000')
                                .format(
                                    shopItems.elementAt(index).points / 1000)
                                .toString() +
                            " Punkte",
                        style: const TextStyle(color: AppColors.text))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
