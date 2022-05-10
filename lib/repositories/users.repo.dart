import "package:flutter/material.dart";
import "package:confit/models/user.dart";

class LoginData {
  String username;
  String password;

  LoginData(this.username, this.password);
}

class AllUserLoginData {
  AllUserLoginData() {
    _users.add(LoginData("philipp.fries", "123456"));
    _users.add(LoginData("sascha.groß", "123456"));
    _users.add(LoginData("manuel.buchmann", "123456"));
    _users.add(LoginData("florian.debus", "123456"));
  }

  final List<LoginData> _users = [];

  bool checkUsername(String username) {
    bool result = false;
    _users.forEach((element) {
      if (element.username == username) {
        result = true;
      }
    });
    return result;
  }

  bool checkLoginData(String username, String password) {
    bool result = false;
    _users.forEach((element) {
      if (element.username == username && element.password == password) {
        result = true;
      }
    });
    return result;
  }
}
