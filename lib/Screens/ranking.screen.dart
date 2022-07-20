import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/profil_image.dart';
import '../models/user_controller.dart';
import '../templates/menu.drawer.dart';
import '../themes/colors.dart';
import '../themes/textStyles.dart';
import 'dart:io';

class Ranking {
  final String username;
  final double km;
  File? image;

  Ranking({required this.username, this.image, required this.km});
}

class RankingScreen extends StatelessWidget {
  RankingScreen({Key? key}) : super(key: key);

  final userstorage = GetStorage();
  final Controller c = Get.find();

  List<Ranking> getRankinglist() {
    List<Ranking> ranking = [];

    final userId = c.currentUserId;
    for (final user in userstorage.getKeys()) {
      final _userValuesAsMap = userstorage.read(user.toString());
      c.setUserFromStorage(_userValuesAsMap);

      File? image = c.user.value.image;
      if (c.user.value.image != null) {
        ranking.add(Ranking(
          username: c.user.value.name!,
          image: image,
          km: c.user.value.km,
        ));
      } else {
        ranking.add(Ranking(
          username: c.user.value.name!,
          km: c.user.value.km,
        ));
      }
    }
    final _userValuesAsMap = userstorage.read(userId.toString());
    c.setUserFromStorage(_userValuesAsMap);

    ranking.sort((a, b) => b.km.compareTo(a.km));

    return ranking;
  }

  @override
  Widget build(BuildContext context) {
    RxList<Ranking> rankinglist = getRankinglist().obs;

    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("Ranking"),
            ProfilImageInAppBar(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPaddings.paddingInputFieldsStandard),
          child: Obx(
            () => ListView.builder(
              itemCount: rankinglist.length,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final rankinglistEintrag = rankinglist.elementAt(index);
                bool isUserLoggedIn =
                    rankinglistEintrag.username == c.user.value.name;
                return Padding(
                  padding: const EdgeInsets.all(AppPaddings.ranking),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: isUserLoggedIn
                            ? AppColors.rankingHighlight
                            : AppColors.cardColor,
                        borderRadius: BorderRadius.circular(AppBorders.radius)),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          AppPaddings.paddingInputFieldsStandard),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${(index + 1).toString()}. Platz',
                                style: TextStyle(
                                    color: isUserLoggedIn
                                        ? Colors.black
                                        : AppColors.text),
                              ),
                              ProfilImage(
                                image: rankinglistEintrag.image,
                                showInAppBar: false,
                                size: 30,
                              ),
                              Text(
                                rankinglistEintrag.username,
                                style: TextStyle(
                                    color: isUserLoggedIn
                                        ? Colors.black
                                        : AppColors.text),
                              ),
                            ],
                          ),
                          Text(
                            '${rankinglistEintrag.km.toStringAsFixed(2)} Km',
                            style: TextStyle(
                                color: isUserLoggedIn
                                    ? Colors.black
                                    : AppColors.text),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
