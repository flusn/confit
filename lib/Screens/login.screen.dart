import "package:flutter/material.dart";
import "package:confit/themes/colors.dart";
import "package:confit/repositories/users.repo.dart";
import "package:confit/Screens/user.screen.dart";
import "package:confit/themes/textStyles.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController userName = TextEditingController();
  late TextEditingController password = TextEditingController();
  final allUserLogin = AllUserLoginData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ConFit"),
        backgroundColor: AppColors.background,
      ),
      body: Column(children: [
        Container(
            padding:
                const EdgeInsets.all(AppPaddings.paddingInputFieldsStandard),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
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
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.text),
                            labelText: "Benutzername",
                            hintStyle: TextStyle(color: AppColors.text),
                            hintText:
                                "Gib deinen Firmen Login an (Max.Mustermann)"),
                        validator: (value) {
                          if (allUserLogin.checkUsername(value.toString())) {
                            return "Bitte Monat eintragen";
                          }
                        })),
                Padding(
                  padding: const EdgeInsets.all(
                      AppPaddings.paddingInputFieldsStandard),
                  child: TextFormField(
                    controller: password,
                    style: const TextStyle(color: AppColors.text),
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelStyle: TextStyle(color: AppColors.text),
                        labelText: "Passwort",
                        hintStyle: TextStyle(color: AppColors.text),
                        hintText: "Gib dein Passwort ein"),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.button,
                        textStyle: const TextStyle(
                            fontSize: AppFontSizes.fontSizeInputHeader1)),
                    onPressed: () {
                      if (allUserLogin.checkLoginData(
                          userName.text, password.text.toString())) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserDataScreen()));
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext) {
                              return AlertDialog(
                                  title: const Text("Anmeldung fehlgeschlagen!",
                                      style: TextStyle(color: AppColors.text)),
                                  backgroundColor: AppColors.cardColorOverlay,
                                  content: const Text(
                                      "Benutzername oder Passwort falsch.",
                                      style: TextStyle(color: AppColors.text)),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: AppColors.button),
                                      child: const Text("Ok",
                                          style:
                                              TextStyle(color: AppColors.text)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ]);
                            });
                      }
                      ;
                    },
                    child: const Text("Anmelden"))
              ],
            )),
      ]),
      backgroundColor: AppColors.background,
    );
  }
}
