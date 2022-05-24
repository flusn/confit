import 'dart:convert';

import "package:flutter/material.dart";
import "package:confit/themes/themes.dart";
import 'package:confit/Screens/basedata.dart';
import 'package:confit/Screens/home.screen.dart';

import 'package:flutter/services.dart';

import '../models/loginData.dart';
import '../models/spHelper.dart';
import '../models/user.dart';
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
  int currentUser = 0;

  late final AllLoginData _loginData;
  final SPHelper helper = SPHelper();
  Map<String, User>? users;

  @override
  void initState() {
    helper.init().then((_) {
      updateScreen();
    });
    super.initState();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/jsonData/loginData.json');
    final loginDataJson = await json.decode(response);
    setState(() {
      _loginData = AllLoginData(loginDataJson["users"]);
    });
  }

  void updateScreen() {
    users = helper.getAllUsers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                          decoration: inputfieldDecoration("Benutzername",
                              "Gib deinen Firmen Login an (Max.Mustermann)"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Benutzername fehlt";
                            } else if (!_loginData.checkUsername(value)) {
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
                        decoration: inputfieldDecoration(
                            "Passwort", "Gib dein Passwort ein"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Passwort fehlt";
                          } else if (!_loginData.checkPassword(
                            userName.text,
                            value,
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
                            currentUser = _loginData.getUserId(
                              userName.text,
                              password.text,
                            );

                            if (users != null && users!.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(user: users![currentUser]),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UserInputDataScreen(userId: currentUser),
                                ),
                              );
                            }
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
