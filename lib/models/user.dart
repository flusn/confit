import 'dart:math';

class User {
  final int id = 0;
  final String? name;
  final int? gender;
  final DateTime? birthday;
  final double? weight;
  final double? height;
  final int? fitnesslevel;

  int age = 0;
  double bmi = 0.0;
  int points = 0;

  User(
      {this.name,
      this.gender,
      this.birthday,
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
}
