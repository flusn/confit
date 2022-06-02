import 'dart:math';
import 'package:intl/intl.dart';

enum Gender { male, female }

class WeightChange {
  DateTime? time;
  double? weight;
  double? bmi;

  WeightChange({this.time, this.weight, this.bmi});

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void calculateBMI(double height) {
    bmi = roundDouble((weight! / (height * height) * 100), 4);
  }

  Map<String, dynamic> toJson() {
    String formattedtime = DateFormat('dd-MM-yyyy').format(time!);
    return {
      "time": formattedtime,
      "weight": weight,
      "bmi": bmi,
    };
  }
}

class User {
  int? id;
  String? name;
  Gender? gender;
  DateTime? birthday;
  List<WeightChange>? weightChanges;
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

  Map<String, double> calculateIdealBMI(int age, Gender gender) {
    double idealBmiMin = 0.0;
    double idealBmiMax = 0.0;
    if (gender == Gender.male) {
      if (age <= 16) {
        idealBmiMin = 19;
        idealBmiMax = 24;
      } else if (age <= 18) {
        idealBmiMin = 20;
        idealBmiMax = 25;
      } else if (age <= 24) {
        idealBmiMin = 21;
        idealBmiMax = 26;
      } else if (age <= 34) {
        idealBmiMin = 22;
        idealBmiMax = 27;
      } else if (age <= 54) {
        idealBmiMin = 23;
        idealBmiMax = 28;
      } else if (age <= 64) {
        idealBmiMin = 24;
        idealBmiMax = 29;
      } else {
        idealBmiMin = 25;
        idealBmiMax = 30;
      }
    } else {
      if (age <= 24) {
        idealBmiMin = 19;
        idealBmiMax = 24;
      } else if (age <= 34) {
        idealBmiMin = 20;
        idealBmiMax = 25;
      } else if (age <= 44) {
        idealBmiMin = 21;
        idealBmiMax = 26;
      } else if (age <= 54) {
        idealBmiMin = 22;
        idealBmiMax = 27;
      } else if (age <= 64) {
        idealBmiMin = 23;
        idealBmiMax = 28;
      } else {
        idealBmiMin = 25;
        idealBmiMax = 30;
      }
    }
    return {"min": idealBmiMin, "max": idealBmiMax};
  }

  Map<String, dynamic> toJson() {
    String formattedBirthday = DateFormat('dd-MM-yyyy').format(birthday!);
    List<Map<String, dynamic>>? weightChangesToJson;
    if (weightChanges != null) {
      weightChangesToJson = weightChanges!.map((e) => e.toJson()).toList();
    }
    return {
      "userId": id,
      "name": name,
      "gender": gender == Gender.male ? 'male' : 'female',
      "birthday": formattedBirthday,
      "height": height,
      "weightChanges": weightChangesToJson ?? [],
      "fitnesslevel": fitnesslevel,
      "age": age,
      "bmi": bmi,
      "points": points
    };
  }
}
