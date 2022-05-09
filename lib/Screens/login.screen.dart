import "package:flutter/material.dart";
import "package:confit/themes/colors.dart";
import "package:confit/repositories/users.repo.dart";
import "package:confit/Screens/user.screen.dart";

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
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
            child: Center(
              child: Image.asset("assets/images/telekomIcon.png"),
            )),
        Card(
            borderOnForeground: false,
            color: Colors.black54,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                        controller: userName,
                        style: const TextStyle(color: AppColors.text),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.text)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.text)),
                            labelStyle: TextStyle(color: AppColors.text),
                            labelText: "Benutzername",
                            hintStyle: TextStyle(color: AppColors.text),
                            hintText:
                                "Gib deinen Firmen Login an (Max.Mustermann)"))),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: password,
                    style: const TextStyle(color: AppColors.text),
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.text)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.text)),
                        labelStyle: TextStyle(color: AppColors.text),
                        labelText: "Passwort",
                        hintStyle: TextStyle(color: AppColors.text),
                        hintText: "Gib dein Passwort ein"),
                  ),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        primary: AppColors.text,
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {
                      if (allUserLogin.checkLoginData(
                          userName.text, password.text.toString())) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserDataSreen()));
                      } else {
                        ErrorWidget(
                            const Text("Benutzername oder Passwort falsch"));
                      }
                    },
                    child: const Text("Anmelden"))
              ],
            )),
      ]),
      backgroundColor: AppColors.background,
    );
  }
}
