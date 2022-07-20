import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../models/profil_image.dart';
import '../models/user_controller.dart';
import '../templates/menu.drawer.dart';
import '../themes/colors.dart';
import '../themes/textStyles.dart';
import 'trainingsets.screen.dart';

class Trainingsset {
  DateTime? time;
  int? minutes;
  int? seconds;
  int? points;
  double? km;

  Trainingsset({this.time, this.minutes, this.seconds, this.points, this.km});

  Map<String, dynamic> toJson() {
    String formattedtime = DateFormat('dd-MM-yyyy').format(time!);
    return {
      "time": formattedtime,
      "minutes": minutes,
      "seconds": seconds,
      "points": points,
      "km": km,
    };
  }
}

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({Key? key}) : super(key: key);

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  final userstorage = GetStorage();
  Controller c = Get.find();
  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  int getPoints({required int minutes, required int seconds}) {
    double points = seconds / 6;
    return points.toInt();
  }

  double getkm(int minutes) {
    double km = 0.0;
    if (minutes != 0) {
      km = minutes / 60 * 12;
    }
    return km;
  }

  int getPointsSum(List<Trainingsset> trainingssets) {
    int pointsSum = 0;
    for (final trainingsset in trainingssets) {
      pointsSum += trainingsset.points!;
    }
    return pointsSum;
  }

  double getkmSum(List<Trainingsset> trainingssets) {
    double km = 0;
    for (final trainingsset in trainingssets) {
      if (trainingsset.minutes != null && trainingsset.minutes! > 0) {
        km = trainingsset.minutes! / 60 * 12;
      }
    }
    return km;
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
            Text("Trainingssets"),
            ProfilImageInAppBar(),
          ],
        ),
      ),
      body: Card(
        borderOnForeground: false,
        color: AppColors.cardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snapshot) {
                final value = snapshot.data;
                final displyTime =
                    StopWatchTimer.getDisplayTime(value!, milliSecond: false);
                StopWatchTimer.getRawMinute(value);

                return Text(
                  displyTime,
                  style: const TextStyle(
                      color: AppColors.text, fontSize: AppFontSizes.stopWatch),
                );
              },
            ),
            const SizedBox(height: AppPaddings.paddingInputFieldsStandard),
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                          color: AppColors.startButton,
                          onPress: () => _stopWatchTimer.onExecute
                              .add(StopWatchExecute.start),
                          label: "Start"),
                      const SizedBox(
                          height: AppPaddings.paddingInputFieldsStandard),
                      CustomButton(
                          color: AppColors.stopButton,
                          onPress: () => _stopWatchTimer.onExecute
                              .add(StopWatchExecute.stop),
                          label: "Stop"),
                    ]),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: AppColors.button),
                  onPressed: () {
                    c.user.value.trainingssets ??= [];
                    final minutes = _stopWatchTimer.minuteTime.value;
                    final seconds = _stopWatchTimer.secondTime.value;
                    c.user.value.trainingssets!.add(Trainingsset(
                        time: DateTime.now(),
                        minutes: minutes,
                        seconds: seconds,
                        km: getkm(minutes),
                        points: getPoints(minutes: minutes, seconds: seconds)));

                    c.user.value.points =
                        getPointsSum(c.user.value.trainingssets!);
                    c.user.value.km = getkmSum(c.user.value.trainingssets!);

                    final userAsNormalMap = c.user.value.toJson();
                    userstorage.write(
                        c.currentUserId.value.toString(), userAsNormalMap);

                    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                    Get.to(const TrainingsetsScreen());
                  },
                  child: Column(
                    children: const [
                      SizedBox(height: 20),
                      Text("Training Abschließen"),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPress;
  final String label;
  const CustomButton(
      {Key? key,
      required this.color,
      required this.onPress,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: color),
        onPressed: onPress,
        child: Text(label));
  }
}
