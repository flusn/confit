import 'dart:convert';

import "package:flutter/material.dart";
import "package:confit/themes/themes.dart";
import 'package:confit/Screens/basedata.dart';
import 'package:confit/Screens/home.screen.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import '../models/loginData.dart';
import '../models/user_controller.dart';
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

  final usersStorage = GetStorage();
  final Controller c = Get.put(Controller());

  AllLoginData _loginData = AllLoginData([]);

  bool displayPassword = false;
  String textPasswordTooltip = "Passwort anzeigen";

  void showPassword() {
    if (displayPassword) {
      textPasswordTooltip = "Passwort anzeigen";
    } else {
      textPasswordTooltip = "Passwort verbergen";
    }
    displayPassword = !displayPassword;

    setState(() {});
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/jsonData/loginData.json');
    final loginDataJson = await json.decode(response);
    setState(() {
      _loginData = AllLoginData(loginDataJson["users"]);
    });
  }

  void loadUserStorage(String userId) {
    if (usersStorage.read(userId) != null) {
      final _userValuesAsMap = usersStorage.read(userId);
      c.setUserFromStorage(_userValuesAsMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    return Scaffold(
      appBar: AppBar(
        title: const Text("ConFit: Login"),
      ),
      body: SafeArea(
        child: Form(
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
                            cursorColor: AppColors.background,
                            keyboardType: TextInputType.text,
                            style: TextStyles.textnormal,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: password,
                              cursorColor: AppColors.background,
                              style: TextStyles.textnormal,
                              obscureText: displayPassword ? false : true,
                              decoration: inputfieldDecoration(
                                      "Passwort", "Gib dein Passwort ein")
                                  .copyWith(
                                suffixIcon: IconButton(
                                    tooltip: textPasswordTooltip,
                                    color: AppColors.text,
                                    icon: displayPassword
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                    onPressed: showPassword),
                              ),
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
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  alignment: Alignment.centerLeft,
                                  minimumSize: const Size(50, 30),
                                  padding:
                                      const EdgeInsets.only(top: -4, left: 8),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap),
                              child: Text(
                                "Passwort vergessen",
                                style: TextStyles.textnormal
                                    .copyWith(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        child: const Text("Anmelden"),
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.button,
                          textStyle: const TextStyle(
                              fontSize: AppFontSizes.inputHeader1),
                        ),
                        onPressed: () {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate()) {
                              c.currentUserId.value = _loginData.getUserId(
                                userName.text,
                                password.text,
                              );
                              loadUserStorage(c.currentUserId.value.toString());
                              if (c.user.value.name != null) {
                                Get.to(() => const HomeScreen());
                              } else {
                                Get.to(() => const BasedataScreen());
                              }
                            }
                          }
                        },
                      ),
                      const SizedBox(
                          height: AppPaddings.paddingInputFieldsStandard)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
