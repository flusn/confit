import 'package:flutter/material.dart';
import 'user.dart';

class AllUsers extends InheritedWidget {
  AllUsers({
    Key? key,
    required this.users,
    required this.currentUser,
    required Widget child,
  }) : super(key: key, child: child);

  Map<int, User> users = {};
  int currentUser;

  int getCurrentUser() {
    return currentUser;
  }

  bool checkUsername(String username) {
    bool result = false;
    users.forEach((key, value) {
      if (value.username == username) {
        result = true;
      }
    });
    return result;
  }

  bool checkPassword(String username, String password) {
    bool result = false;
    users.forEach((key, value) {
      if (value.username == username && value.password == password) {
        result = true;
      }
    });
    return result;
  }

  int getUserId(String username, String password) {
    int result = 0;
    users.forEach((key, value) {
      if (value.username == username && value.password == password) {
        result = key;
      }
    });
    return result;
  }

  User? getUserById(int userId) {
    return users[userId];
  }

  @override
  bool updateShouldNotify(AllUsers oldWidget) {
    return users != oldWidget.users;
  }
}
