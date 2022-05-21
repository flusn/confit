import 'dart:convert';

import "package:flutter/material.dart";
import "package:confit/themes/themes.dart";
import 'package:confit/Screens/basedata.dart';
import 'package:flutter/services.dart';

import '../models/allUsers.dart';
import '../models/loginData.dart';
import '../templates/input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userName = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final int currentUser;
  //Map<String, dynamic> _loginData = {};
  List<dynamic> _loginData = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/jsonData/loginData.json');
    final loginDataJson = await json.decode(response);
    setState(() {
      _loginData = loginDataJson["users"];
    });
  }

  bool checkUsername(String username, List<dynamic> loginData) {
    bool result = false;
    for (var element in loginData) {
      if (userName.text == element["username"]) result = true;
    }
    return result;
  }

  bool checkPassword(
      String username, String password, List<dynamic> loginData) {
    bool result = false;
    for (var element in loginData) {
      if (username == element["username"] && element["password"] == password) {
        result = true;
      }
    }
    return result;
  }

  int getUserId(String username, String password, List<dynamic> loginData) {
    int result = 0;
    for (var element in loginData) {
      if (username == element["username"] && element["password"] == password) {
        result = element["userId"];
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final users = context.dependOnInheritedWidgetOfExactType<AllUsers>();
    readJson();
    return Scaffold(
      appBar: AppBar(
        title: const Text("ConFit: Login"),
        backgroundColor: AppColors.background,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(
                      AppPaddings.paddingInputFieldsStandard),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(200)),
                  child: Center(
                    child: Image.asset("assets/images/telekomIcon.png"),
                  )),
              Card(
                borderOnForeground: false,
                color: AppColors.cardColor,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(
                            AppPaddings.paddingInputFieldsStandard),
                        child: TextFormField(
                          controller: userName,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: AppColors.text),
                          decoration: InputfieldDecoration("Benutzername",
                              "Gib deinen Firmen Login an (Max.Mustermann)"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Benutzername fehlt";
                            } else if (!checkUsername(value, _loginData)) {
                              return "Benutzername falsch";
                            }
                            return null;
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.all(
                          AppPaddings.paddingInputFieldsStandard),
                      child: TextFormField(
                        controller: password,
                        style: const TextStyle(color: AppColors.text),
                        obscureText: true,
                        decoration: InputfieldDecoration(
                            "Passwort", "Gib dein Passwort ein"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Passwort fehlt";
                          } else if (!checkPassword(
                            userName.text,
                            value,
                            _loginData,
                          )) {
                            return "Passwort falsch";
                          }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                      child: const Text("Anmelden"),
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.button,
                        textStyle: const TextStyle(
                            fontSize: AppFontSizes.fontSizeInputHeader1),
                      ),
                      onPressed: () {
                        if (_formKey.currentState != null) {
                          if (_formKey.currentState!.validate()) {
                            currentUser = getUserId(
                              userName.text,
                              password.text,
                              _loginData,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserInputDataScreen(userId: currentUser)),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.background,
    );
  }
}
