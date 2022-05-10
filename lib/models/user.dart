import "package:flutter/material.dart";

class User {
  String name;
  int gender;
  DateTime birthday;
  int age = 0;
  double weight;
  double height;
  double bmi = 0.0;
  int? fitnesslevel;
  int points = 0;

  User(this.name, this.gender, this.birthday, this.weight, this.height,
      {this.fitnesslevel});

  calculateAge() {}
}
