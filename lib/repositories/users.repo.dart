//import "package:flutter/material.dart";
import "package:confit/models/user.dart";

class UsersRepo {
  Map<int, User> userRepo = {};

  UsersRepo(this.userRepo);

  User insertUser(User userdata) {
    userRepo[userdata.id] = userdata;
    return userdata;
  }
}
