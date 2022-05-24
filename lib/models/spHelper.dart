import 'package:confit/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SPHelper {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writeUser(User user) async {
    prefs.setString(user.id.toString(), json.encode(user.toJson()));
  }

  User getUser(String key) {
    return User.fromJson(json.decode(prefs.getString(key) ?? ""));
  }

  Map<String, User> getAllUsers() {
    Map<String, User> users = {};
    Set<String> keys = prefs.getKeys();
    for (String key in keys) {
      {
        User user = getUser(key);
        users[key] = user;
      }
    }
    return users;
  }

  Future setCounter() async {
    int counter = prefs.getInt("counter") ?? 0;
    counter++;
    await prefs.setInt("counter", counter);
  }

  int getCounter() {
    return prefs.getInt("counter") ?? 0;
  }
}
