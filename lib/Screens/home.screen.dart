import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/profil_image.dart';
import '../models/user_controller.dart';
import '../templates/menu.drawer.dart';
import '../templates/menu_bottom.dart';
import '../themes/colors.dart';
import '../themes/textStyles.dart';
import 'stopwatch.screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("Homescreen"),
            ProfilImageInAppBar(),
          ],
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Row(
              children: [
                ProfilStatus(c: c),
                Flexible(child: HomeStats(c: c)),
              ],
            ),
          ),
          const Flexible(flex: 3, child: News()),
        ],
      ),
      bottomNavigationBar: const MenuBottom(),
    );
  }
}

class News extends StatelessWidget {
  const News({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColorOverlay,
        border: Border.all(color: AppColors.background),
        borderRadius:
            const BorderRadius.all(Radius.circular(AppBorders.radius)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.paddingInputFieldsStandard),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Neuigkeiten:",
              style: TextStyle(
                  color: AppColors.text, fontSize: AppFontSizes.textHome),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              DateFormat('dd.MM.yyyy').format(DateTime.now()),
              style: const TextStyle(
                  color: Colors.grey, fontSize: AppFontSizes.textHome),
            ),
            const Text(
              'Dein Freund Daniel hat einen Lauf abgeschlossen und ist jetzt 110 Punkte vor dir.',
              style: TextStyle(
                  color: AppColors.text, fontSize: AppFontSizes.textHome),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Ereignis:",
              style: TextStyle(
                  color: AppColors.text, fontSize: AppFontSizes.textHome),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              DateFormat('dd.MM.yyyy').format(DateTime.now()),
              style: const TextStyle(
                  color: Colors.grey, fontSize: AppFontSizes.textHome),
            ),
            const Text(
              'Am 30.7. erhaltet ihr für jeden gelaufenen Kilometer doppelte Punkte.',
              style: TextStyle(
                  color: AppColors.text, fontSize: AppFontSizes.textHome),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeStats extends StatelessWidget {
  const HomeStats({
    Key? key,
    required this.c,
  }) : super(key: key);

  double getkmSum(List<Trainingsset> trainingssets) {
    double km = 0;
    for (final trainingsset in trainingssets) {
      if (trainingsset.km != null) {
        km += trainingsset.km!.toInt();
      }
    }
    return km;
  }

  initState() {
    c.user.value.km = getkmSum(c.user.value.trainingssets!);
  }

  final Controller c;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColorOverlay,
        border: Border.all(color: AppColors.background),
        borderRadius:
            const BorderRadius.all(Radius.circular(AppBorders.radius)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.paddingInputFieldsStandard),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Deine Statistik",
                style: TextStyle(
                    color: AppColors.text, fontSize: AppFontSizes.textHome),
              ),
            ),
            const SizedBox(height: AppPaddings.paddingInputFieldsStandard),
            const Text(
              "Kilometer gesamt:",
              style: TextStyle(
                  color: AppColors.text, fontSize: AppFontSizes.textHome),
            ),
            Text(
              '${c.user.value.km.toStringAsFixed(2)} km',
              style: const TextStyle(
                  color: AppColors.text, fontSize: AppFontSizes.textHome),
            ),
            const SizedBox(height: AppPaddings.homeStats),
            const Text(
              "letzter Lauf:",
              style: TextStyle(
                  color: AppColors.text, fontSize: AppFontSizes.textHome),
            ),
            Text(
              (c.user.value.trainingssets != null &&
                      c.user.value.trainingssets!.isNotEmpty)
                  ? DateFormat('dd.MM.yyyy')
                      .format(c.user.value.trainingssets!.last.time!)
                  : "-",
              style: const TextStyle(
                  color: AppColors.text, fontSize: AppFontSizes.textHome),
            ),
            const SizedBox(height: AppPaddings.homeStats),
            const Text(
              "Bmi:",
              style: TextStyle(
                  color: AppColors.text, fontSize: AppFontSizes.textHome),
            ),
            Text(
              c.user.value.bmi != 0.0 ? c.user.value.bmi.toString() : "-",
              style: const TextStyle(
                  color: AppColors.text, fontSize: AppFontSizes.textHome),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilStatus extends StatelessWidget {
  const ProfilStatus({
    Key? key,
    required this.c,
  }) : super(key: key);

  final Controller c;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColorOverlay,
        border: Border.all(color: AppColors.background),
        borderRadius:
            const BorderRadius.all(Radius.circular(AppBorders.radius)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.paddingInputFieldsStandard),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfilImage(
                  image: c.user.value.image,
                  showInAppBar: false,
                  size: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Punktestand",
                      style: TextStyle(
                          color: AppColors.text,
                          fontSize: AppFontSizes.textHome),
                    ),
                    Text(
                      c.user.value.points.toString(),
                      style: const TextStyle(
                          color: AppColors.text,
                          fontSize: AppFontSizes.textHome),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppPaddings.paddingInputFieldsStandard),
            Text(
              'Willkommen zurück\n ${c.user.value.name}',
              style: const TextStyle(
                  color: AppColors.text, fontSize: AppFontSizes.textHome),
            ),
          ],
        ),
      ),
    );
  }
}
