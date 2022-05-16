import "package:flutter/material.dart";

class User {
  String username;
  String password;
  int id = 0;
  String name;
  int? gender;
  DateTime? birthday;
  int age = 0;
  double? weight;
  double? height;
  double bmi = 0.0;
  int? fitnesslevel;
  int points = 0;

  User(
      {required this.username,
      required this.password,
      required this.name,
      this.gender,
      this.birthday,
      this.weight,
      this.height,
      this.fitnesslevel});

  void calculateAge() {
    //this.age = TimeOfDay.now() - birthday.year
  }

  calculateBMI() {}
}
