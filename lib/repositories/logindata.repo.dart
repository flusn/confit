import 'dart:html';

import "package:flutter/material.dart";
import "package:confit/models/user.dart";

class AllUserLoginData {
  final Map<int, User> _users = {};
  AllUserLoginData() {
    <int, User>{
      0: User(username: "philipp.fries", password: "123456", name: ""),
      1: User(username: "sascha.groß", password: "123456", name: ""),
      2: User(username: "manuel.buchmann", password: "123456", name: ""),
      3: User(username: "florian.debus", password: "123456", name: ""),
    };
  }

  bool checkUsername(String username) {
    bool result = false;
    _users.forEach((key, value) {
      if (value.username == username) {
        result = true;
      }
    });
    return result;
  }

  bool checkPassword(String username, String password) {
    bool result = false;
    _users.forEach((key, value) {
      if (value.username == username && value.password == password) {
        result = true;
      }
    });
    return result;
  }

  int getUserId(String username, String password) {
    int result = 0;
    _users.forEach((key, value) {
      if (value.username == username && value.password == password) {
        result = key;
      }
    });
    return result;
  }

  User? getUserById(int userId) {
    return _users[userId];
  }
}
