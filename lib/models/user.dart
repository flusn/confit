import 'dart:math';
import 'package:intl/intl.dart';

enum Gender { Male, Female }

class WeightChange {
  DateTime? time;
  double? weight;
  double? bmi;

  WeightChange({this.time, this.weight});

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void calculateBMI(double height) {
    bmi = roundDouble((weight! / (height * height) * 100), 4);
  }
}

class User {
  int? id;
  String? name;
  Gender? gender;
  DateTime? birthday;
  List<WeightChange>? weightChanges;
  double? weight;
  double? height;
  int? fitnesslevel;

  int age = 0;
  double bmi = 0.0;
  int points = 0;

  User(
      {this.id,
      this.name,
      this.gender,
      this.birthday,
      this.weightChanges,
      this.weight,
      this.height,
      this.fitnesslevel});

  void calculateAge() {
    DateTime today = DateTime.now();
    age = today.year - birthday!.year;

    if (today.month < birthday!.month) {
      age--;
    } else if (today.month == birthday!.month) {
      if (today.day < birthday!.day) {
        age--;
      }
    }
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void calculateBMI() {
    bmi = roundDouble((weight! / (height! * height!) * 100), 4);
  }

  User.fromJson(Map<String, dynamic> userMap) {
    String birthdayAsString = userMap["birthday"] ?? "";
    if (birthdayAsString != "") {
      birthday = DateFormat('MM-dd-yyyy').parse(birthdayAsString);
    }
    id = userMap["userid"] ?? 0;
    name = userMap["name"] ?? "";
    gender = userMap["gender"] ?? 0;
    weight = userMap["weight"] ?? 0.0;
    height = userMap["height"] ?? 0.0;
    fitnesslevel = userMap["fitnesslevel"] ?? 0;
    age = userMap["age"] ?? 0;
    bmi = userMap["bmi"] ?? 0.0;
    points = userMap["points"] ?? 0;
  }

  Map<String, dynamic> toJson() {
    String formattedDate = DateFormat('MM-dd-yyyy').format(birthday!);

    return {
      "userId": id,
      "name": name,
      "gender": gender,
      "birthday": formattedDate,
      "weight": weight,
      "height": height,
      "fitnesslevel": fitnesslevel,
      "age": age,
      "bmi": bmi,
      "points": points
    };
  }
}
