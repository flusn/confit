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
  late String userName;
  final allUser = AllUser();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ConFit"),
        backgroundColor: AppColors.background,
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(children: [
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
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: AppColors.text),
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.text),
                            labelText: "Benutzername",
                            hintStyle: TextStyle(color: AppColors.text),
                            hintText:
                                "Gib deinen Firmen Login an (Max.Mustermann)",
                          ),
                          validator: (value) {
                            userName = value.toString();
                            if (value == null || value.isEmpty) {
                              return "Benutzername fehlt";
                            } else if (!allUser
                                .checkUsername(value.toString())) {
                              return "Benutzername falsch";
                            }
                            return null;
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.all(
                          AppPaddings.paddingInputFieldsStandard),
                      child: TextFormField(
                        style: const TextStyle(color: AppColors.text),
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.text),
                            labelText: "Passwort",
                            hintStyle: TextStyle(color: AppColors.text),
                            hintText: "Gib dein Passwort ein"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Passwort fehlt";
                          } else if (!allUser.checkPassword(
                              userName, value.toString())) {
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
                                fontSize: AppFontSizes.fontSizeInputHeader1)),
                        onPressed: () {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UserDataScreen()));
                            }
                          }
                        }),
                  ],
                )),
          ]))),
      backgroundColor: AppColors.background,
    );
  }
}
