import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/profil_image.dart';
import '../models/user_controller.dart';
import '../templates/menu.drawer.dart';
import '../themes/colors.dart';
import '../themes/textStyles.dart';

import 'stopwatch.screen.dart';

class TrainingsetsScreen extends StatefulWidget {
  const TrainingsetsScreen({Key? key}) : super(key: key);

  @override
  State<TrainingsetsScreen> createState() => _TrainingsetsScreenState();
}

class _TrainingsetsScreenState extends State<TrainingsetsScreen> {
  final userstorage = GetStorage();

  final Controller c = Get.find();
  List<Trainingsset> _trainingssets = [];
  @override
  void initState() {
    if (c.user.value.trainingssets != null) {
      _trainingssets = c.user.value.trainingssets!;
    }
    super.initState();
  }

  List<Trainingsset> getSortedByDate(List<Trainingsset>? trainingssets) {
    List<Trainingsset> sortedList = [];
    if (trainingssets == null) return sortedList;
    for (var i = trainingssets.length - 1; i >= 0; i--) {
      sortedList.add(trainingssets.elementAt(i));
    }
    return sortedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("Training"),
            ProfilImageInAppBar(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPaddings.paddingInputFieldsStandard),
          child: Column(
            children: [
              Card(
                borderOnForeground: false,
                color: AppColors.cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(
                      AppPaddings.paddingInputFieldsStandard),
                  child: Center(
                    child: ElevatedButton(
                      child: const Text("Training starten"),
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.button,
                          textStyle: const TextStyle(
                              fontSize: AppFontSizes.inputHeader1)),
                      onPressed: () {
                        Get.to(() => const StopwatchScreen());
                      },
                    ),
                  ),
                ),
              ),
              if (_trainingssets.isNotEmpty)
                Card(
                  borderOnForeground: false,
                  color: AppColors.cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(
                        AppPaddings.paddingInputFieldsStandard),
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const Divider(color: AppColors.text),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _trainingssets.length,
                      itemBuilder: (BuildContext context, int index) {
                        final trainingsset =
                            _trainingssets.reversed.toList().elementAt(index);
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Datum",
                                  style: TextStyle(color: AppColors.text),
                                ),
                                Text(
                                  "${trainingsset.time!.day}.${trainingsset.time!.month}.${trainingsset.time!.year}",
                                  style: const TextStyle(color: AppColors.text),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Laufzeit (Minuten)",
                                  style: TextStyle(color: AppColors.text),
                                ),
                                Text(
                                  trainingsset.minutes.toString(),
                                  style: const TextStyle(color: AppColors.text),
                                ),
                              ],
                            ),
                            if (trainingsset.km != null)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Kilometer",
                                    style: TextStyle(color: AppColors.text),
                                  ),
                                  Text(
                                    trainingsset.km!.toStringAsFixed(2),
                                    style:
                                        const TextStyle(color: AppColors.text),
                                  ),
                                ],
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Punkte",
                                  style: TextStyle(color: AppColors.text),
                                ),
                                Text(
                                  trainingsset.points.toString(),
                                  style: const TextStyle(color: AppColors.text),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
