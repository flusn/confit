import 'dart:io';

import 'package:confit/Screens/stopwatch.screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'user.dart';

class Controller extends GetxController {
  final users = <String, User>{}.obs;
  final user = User().obs;
  final currentUserId = 0.obs;
  final allUserIds = [];

  void setUserData(User userStorage) {
    user.value.age = userStorage.age;
    user.value.birthday = userStorage.birthday;
    user.value.bmi = userStorage.bmi;
    user.value.fitnesslevel = userStorage.fitnesslevel;
    user.value.gender = userStorage.gender;
    user.value.height = userStorage.height;
    user.value.id = userStorage.id;
    user.value.name = userStorage.name;
    user.value.points = userStorage.points;
    user.value.weightChanges = userStorage.weightChanges;
    user.value.trainingssets = userStorage.trainingssets;
  }

  setUserFromStorage(Map<String, dynamic> userMap) {
    String birthdayAsString = userMap['birthday'] ?? '';
    if (birthdayAsString != '') {
      user.value.birthday = DateFormat('dd-MM-yyyy').parse(birthdayAsString);
    }

    user.value.weightChanges = [];
    for (final weightMap in userMap['weightChanges']) {
      WeightChange weightChange = WeightChange(
          time: DateFormat('dd-MM-yyyy').parse(weightMap['time']),
          weight: weightMap['weight'],
          bmi: weightMap['bmi']);

      if (user.value.weightChanges == null) {
        user.value.weightChanges = [weightChange];
      } else {
        user.value.weightChanges!.add(weightChange);
      }
    }

    if (userMap['trainingssets'] != null) {
      user.value.trainingssets = [];
      for (final trainingMap in userMap['trainingssets']) {
        Trainingsset trainingsset = Trainingsset(
            time: DateFormat('dd-MM-yyyy').parse(trainingMap['time']),
            minutes: trainingMap['minutes'],
            seconds: trainingMap['seconds'],
            points: trainingMap['points']);

        if (user.value.trainingssets == null) {
          user.value.trainingssets = [trainingsset];
        } else {
          user.value.trainingssets!.add(trainingsset);
        }
      }
    }

    user.value.id = userMap['userid'] ?? 0;
    user.value.name = userMap['name'] ?? '';
    user.value.imagePath = userMap['imagePath'] ?? '';

    if (user.value.imagePath != null && user.value.imagePath != '') {
      user.value.image = File(user.value.imagePath!);
    }

    user.value.gender =
        userMap['gender'] == 'male' ? Gender.male : Gender.female;
    user.value.height = userMap['height'] ?? 0.0;
    user.value.fitnesslevel = userMap['fitnesslevel'] ?? 0;
    user.value.age = userMap['age'] ?? 0;
    user.value.bmi = userMap['bmi'] ?? 0.0;
    user.value.points = userMap['points'] ?? 0;
    user.value.km = userMap['km'] ?? 0;
  }
}
