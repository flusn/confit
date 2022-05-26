// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'user.dart';

class Controller extends GetxController {
  var users = <String, dynamic>{}.obs;
  var user = User().obs;
  var currentUser = 0.obs;

  void setUserData(Map<String, dynamic> userStorage) {
    user.value.age = userStorage["age"];
    user.value.birthday =
        DateFormat('MM-dd-yyyy').parse(userStorage["birthday"]);
    user.value.bmi = userStorage["bmi"];
    user.value.fitnesslevel = userStorage["fitnesslevel"];
    user.value.gender = userStorage["gender"];
    user.value.height = userStorage["height"];
    user.value.id = userStorage["userId"];
    user.value.name = userStorage["name"];
    user.value.points = userStorage["points"];
    user.value.weight = userStorage["weight"];
  }
}
