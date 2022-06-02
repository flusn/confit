import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'user.dart';

class Controller extends GetxController {
  final users = <String, User>{}.obs;
  final user = User().obs;
  final currentUserId = 0.obs;

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
  }

  setUserFromStorage(Map<String, dynamic> userMap) {
    String birthdayAsString = userMap['birthday'] ?? '';

    if (birthdayAsString != '') {
      user.value.birthday = DateFormat('dd-MM-yyyy').parse(birthdayAsString);
    }

    final weightChangeList = userMap['weightChanges'];
    user.value.weightChanges = [];
    for (final weightMap in weightChangeList) {
      user.value.weightChanges!.add(WeightChange(
          time: DateFormat('dd-MM-yyyy').parse(weightMap['time']),
          weight: weightMap['weight'],
          bmi: weightMap['bmi']));
    }

    user.value.id = userMap['userid'] ?? 0;
    user.value.name = userMap['name'] ?? '';
    user.value.gender =
        userMap['gender'] == 'male' ? Gender.male : Gender.female;
    //user.value.weightChanges = userMap['weightChanges'].map((e) => e.toJson()).toList() ?? [];
    user.value.height = userMap['height'] ?? 0.0;
    user.value.fitnesslevel = userMap['fitnesslevel'] ?? 0;
    user.value.age = userMap['age'] ?? 0;
    user.value.bmi = userMap['bmi'] ?? 0.0;
    user.value.points = userMap['points'] ?? 0;
  }
}
