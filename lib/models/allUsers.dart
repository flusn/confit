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

  User? getUserById(int userId) {
    return users[userId];
  }

  @override
  bool updateShouldNotify(AllUsers oldWidget) {
    return users != oldWidget.users;
  }
}
