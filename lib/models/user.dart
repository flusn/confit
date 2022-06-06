import 'dart:math';
import 'package:intl/intl.dart';

enum Gender { male, female }

class WeightChange {
  DateTime? time;
  double? weight;
  double? bmi;

  WeightChange({this.time, this.weight, this.bmi});

  void calculateBMI(double height) {
    bmi =
        double.parse((weight! / (height * height) * 10000).toStringAsFixed(2));
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

  List<Map<String, dynamic>> weightChangesToJson() {
    if (weightChanges != null) {
      return weightChanges!.map((e) => e.toJson()).toList();
    } else {
      return [];
    }
  }

  Map<String, dynamic> toJson() {
    String formattedBirthday = DateFormat('dd-MM-yyyy').format(birthday!);
    return {
      "userId": id,
      "name": name,
      "gender": gender == Gender.male ? 'male' : 'female',
      "birthday": formattedBirthday,
      "height": height,
      "weightChanges": weightChangesToJson(),
      "fitnesslevel": fitnesslevel,
      "age": age,
      "bmi": bmi,
      "points": points
    };
  }
}
