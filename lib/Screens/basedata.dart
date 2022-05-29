import "package:flutter/material.dart";
import '../models/user.dart';
import '../models/userController.dart';
import "../themes/themes.dart";
import "../templates/input.dart";
import 'package:get/get.dart';
import 'home.screen.dart';
import 'package:get_storage/get_storage.dart';

class BasedataScreen extends StatefulWidget {
  const BasedataScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BasedataScreen> createState() => _BasedataScreenState();
}

class _BasedataScreenState extends State<BasedataScreen> {
  Controller c = Get.find();
  GetStorage userstorage = GetStorage();

  final _formKey = GlobalKey<FormState>();

  bool userdatafistInput = true;
  final nameController = TextEditingController();
  Gender? genderController;
  final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  final monthFocusNode = FocusNode();
  final yearFocusNode = FocusNode();
  final weightFocusNode = FocusNode();

  final heightFocusNode = FocusNode();
  final fintnesslevelFocusNode = FocusNode();

  String fitnesslevel = "gar nicht";

  //Wurde der Benutzer bereits angelegt, werden die Stammdaten aus dem Storage geladen
  @override
  void initState() {
    if (c.user.value.name != null) {
      userdatafistInput = false;
      nameController.text = c.user.value.name.toString();
    }
    if (c.user.value.gender != null) {
      genderController = c.user.value.gender;
      userdatafistInput = false;
    }
    if (c.user.value.birthday != null) {
      dayController.text = c.user.value.birthday!.day.toString();
      monthController.text = c.user.value.birthday!.month.toString();
      yearController.text = c.user.value.birthday!.year.toString();
      userdatafistInput = false;
    }
    if (c.user.value.height != null) {
      heightController.text = c.user.value.height.toString();
      userdatafistInput = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ConFit"),
      ),
      body: Form(
        key: _formKey,
        child: Card(
          borderOnForeground: false,
          color: AppColors.cardColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                      AppPaddings.paddingInputFieldsStandard),
                  child: TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: AppColors.text),
                    decoration:
                        inputfieldDecoration("Name", "Gib deinen Namen an"),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: ListTile(
                        title: const Text(
                          "männlich",
                          style: TextStyle(color: AppColors.text),
                        ),
                        leading: Radio<Gender>(
                          activeColor: AppColors.text,
                          value: Gender.Male,
                          groupValue: genderController,
                          onChanged: (Gender? value) {
                            setState(() {
                              genderController = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: ListTile(
                        title: const Text(
                          "weiblich",
                          style: TextStyle(color: AppColors.text),
                        ),
                        leading: Radio<Gender>(
                          activeColor: AppColors.text,
                          value: Gender.Female,
                          groupValue: genderController,
                          onChanged: (Gender? value) {
                            setState(() {
                              genderController = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(
                      left: AppPaddings.paddingInputFieldsStandard,
                      right: AppPaddings.paddingInputFieldsStandard,
                      top: AppPaddings.paddingInputFieldsStandard),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Geburtstag",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: AppColors.text),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                      AppPaddings.paddingInputFieldsStandard),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: dayController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: AppColors.text),
                          onChanged: (value) {
                            if (dayController.text.length == 2) {
                              FocusScope.of(context)
                                  .requestFocus(monthFocusNode);
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: "Tag",
                            labelStyle: TextStyle(color: AppColors.text),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Tag fehlt";
                            } else if (value.length > 2) {
                              return "Tag zu lnag";
                            } else if (int.parse(value) == 0 ||
                                int.parse(value) > 31) {
                              return "Tag falsch";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                          width: AppPaddings.paddingInputFieldsStandard),
                      Expanded(
                        child: TextFormField(
                          controller: monthController,
                          focusNode: monthFocusNode,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: AppColors.text),
                          onChanged: (value) {
                            if (monthController.text.length == 2) {
                              FocusScope.of(context)
                                  .requestFocus(yearFocusNode);
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: "Monat",
                            labelStyle: TextStyle(color: AppColors.text),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Monat fehlt";
                            } else if (value.length > 2) {
                              return "Monat zu lnag";
                            } else if (int.parse(value) > 12) {
                              return "Monat falsch.";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                          width: AppPaddings.paddingInputFieldsStandard),
                      Expanded(
                        child: TextFormField(
                          controller: yearController,
                          focusNode: yearFocusNode,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: AppColors.text),
                          decoration: const InputDecoration(
                            labelText: "Jahr",
                            labelStyle: TextStyle(color: AppColors.text),
                          ),
                          onChanged: (value) {
                            if (yearController.text.length == 4) {
                              FocusScope.of(context)
                                  .requestFocus(weightFocusNode);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Jahr fehlt";
                            } else if (value.length != 4) {
                              return "Jahr falsch";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (userdatafistInput)
                  Padding(
                    padding: const EdgeInsets.all(
                        AppPaddings.paddingInputFieldsStandard),
                    child: TextFormField(
                      controller: weightController,
                      focusNode: weightFocusNode,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: AppColors.text),
                      decoration:
                          inputfieldDecoration("Gewicht", "Gewicht in kg"),
                      onChanged: (value) {
                        if (double.parse(weightController.text) > 20) {
                          FocusScope.of(context).requestFocus(heightFocusNode);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Gewicht fehlt";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(
                      AppPaddings.paddingInputFieldsStandard),
                  child: TextFormField(
                    controller: heightController,
                    focusNode: heightFocusNode,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: AppColors.text),
                    decoration: inputfieldDecoration("Größe", "Größe in cm"),
                    onChanged: (value) {
                      if (double.parse(heightController.text) > 100) {
                        FocusScope.of(context)
                            .requestFocus(fintnesslevelFocusNode);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Größe fehlt";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(
                        AppPaddings.paddingInputFieldsStandard),
                    child: DropdownButtonFormField<String>(
                        value: fitnesslevel,
                        elevation: 16,
                        focusNode: fintnesslevelFocusNode,
                        style: const TextStyle(color: AppColors.text),
                        dropdownColor: AppColors.cardColorOverlay,
                        decoration: const InputDecoration(
                            labelText: "Sportlich aktiv",
                            labelStyle: TextStyle(color: AppColors.text)),
                        onChanged: (String? newValue) {
                          setState(() {
                            fitnesslevel = newValue!;
                          });
                        },
                        items: <String>[
                          "täglich (3 mal pro Woche)",
                          "wöchentlich (1 mal pro Woche)",
                          "monatlich (1 bis 2 mal im Monat)",
                          "gar nicht"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList())),
                ElevatedButton(
                  child: const Text("Speichern"),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.button,
                      textStyle: const TextStyle(
                          fontSize: AppFontSizes.fontSizeInputHeader1)),
                  onPressed: () async {
                    if (_formKey.currentState != null) {
                      if (_formKey.currentState!.validate()) {
                        c.user.value = User(
                          id: c.currentUser.value,
                          name: nameController.text,
                          gender: genderController,
                          birthday: DateTime(
                              int.parse(yearController.text),
                              int.parse(monthController.text),
                              int.parse(dayController.text)),
                          height: double.parse(heightController.text),
                        );
                        c.user.value.calculateAge();
                        if (userdatafistInput) {
                          c.user.value.weightChanges = [
                            WeightChange(
                                time: DateTime.now(),
                                weight: double.parse(weightController.text))
                          ];
                          c.user.value.weightChanges![0].calculateBMI(
                              double.parse(heightController.text));
                        }

                        c.users[c.currentUser.value.toString()] = c.user.value;
                        await userstorage.write('users', c.users);
                        Get.to(() => const HomeScreen());
                      }
                    }
                  },
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
