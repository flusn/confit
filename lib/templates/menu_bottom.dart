import "package:flutter/material.dart";
import 'package:get/get.dart';

import '../Screens/home.screen.dart';
import '../Screens/shop.screen.dart';
import '../Screens/stopwatch.screen.dart';
import '../themes/colors.dart';

class MenuBottom extends StatelessWidget {
  const MenuBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border:
              Border(top: BorderSide(color: AppColors.cardColor, width: 2.0))),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            switch (index) {
              case 0:
                Get.to(() => const HomeScreen());
                break;
              case 1:
                Get.to(() => const StopwatchScreen());
                break;
              case 2:
                Get.to(() => const ShopScreen());
                break;
            }
          },
          backgroundColor: AppColors.background,
          showUnselectedLabels: true,
          unselectedItemColor: AppColors.icons,
          selectedItemColor: AppColors.icons,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: AppColors.icons,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.directions_run,
                  color: AppColors.icons,
                ),
                label: "Training"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: AppColors.icons,
                ),
                label: "Shop"),
          ]),
    );
  }
}
