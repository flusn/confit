import "package:flutter/material.dart";
import "package:confit/themes/colors.dart";
import "package:confit/themes/textStyles.dart";
import "package:confit/models/user.dart";

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({Key? key}) : super(key: key);

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

enum GenderCharacter { m, w, d, n }

class _UserDataScreenState extends State<UserDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  GenderCharacter? genderController = GenderCharacter.m;
  final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  final monthFocusNode = FocusNode();
  final yearFocusNode = FocusNode();
  final weightFocusNode = FocusNode();

  String fitnesslevel = 'keine';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ConFit"),
          backgroundColor: AppColors.background,
        ),
        body: Form(
            key: _formKey,
            child: Card(
              borderOnForeground: false,
              color: AppColors.cardColor,
              child: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(
                          AppPaddings.paddingInputFieldsStandard),
                      child: TextField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: AppColors.text),
                          decoration: const InputDecoration(
                              labelStyle: TextStyle(color: AppColors.text),
                              labelText: "Name",
                              hintStyle: TextStyle(color: AppColors.text),
                              hintText: "Gib deinen Namen an"))),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: ListTile(
                              title: const Text(
                                "männlich",
                                style: const TextStyle(color: AppColors.text),
                              ),
                              leading: Radio<GenderCharacter>(
                                activeColor: AppColors.text,
                                value: GenderCharacter.m,
                                groupValue: genderController,
                                onChanged: (GenderCharacter? value) {
                                  setState(() {
                                    genderController = value;
                                  });
                                },
                              ))),
                      Flexible(
                          child: ListTile(
                              title: const Text(
                                "weiblich",
                                style: const TextStyle(color: AppColors.text),
                              ),
                              leading: Radio<GenderCharacter>(
                                activeColor: AppColors.text,
                                value: GenderCharacter.w,
                                groupValue: genderController,
                                onChanged: (GenderCharacter? value) {
                                  setState(() {
                                    genderController = value;
                                  });
                                },
                              ))),
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                          left: AppPaddings.paddingInputFieldsStandard,
                          right: AppPaddings.paddingInputFieldsStandard,
                          top: AppPaddings.paddingInputFieldsStandard),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Geburtstag",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: AppColors.text)))),
                  Padding(
                      padding: const EdgeInsets.all(
                          AppPaddings.paddingInputFieldsStandard),
                      child: Row(children: [
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
                                  }
                                })),
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
                                  }
                                })),
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
                                  }
                                }))
                      ])),
                  Padding(
                      padding: const EdgeInsets.all(
                          AppPaddings.paddingInputFieldsStandard),
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(
                                      AppPaddings.paddingInputFieldsStandard),
                                  child: TextFormField(
                                      controller: weightController,
                                      focusNode: weightFocusNode,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: AppColors.text),
                                      decoration: const InputDecoration(
                                          labelText: "Gewicht",
                                          labelStyle:
                                              TextStyle(color: AppColors.text),
                                          hintText: "Gewicht in kg",
                                          hintStyle:
                                              TextStyle(color: AppColors.text)),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Gewicht fehlt";
                                        }
                                      }))),
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(
                                      AppPaddings.paddingInputFieldsStandard),
                                  child: TextFormField(
                                      controller: heightController,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(color: AppColors.text),
                                      decoration: const InputDecoration(
                                          labelText: "Größe",
                                          labelStyle:
                                              TextStyle(color: AppColors.text),
                                          hintText: "Größe in cm",
                                          hintStyle:
                                              TextStyle(color: AppColors.text)),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Größe fehlt";
                                        }
                                      }))),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.all(
                          AppPaddings.paddingInputFieldsStandard),
                      child: DropdownButtonFormField<String>(
                          value: fitnesslevel,
                          elevation: 16,
                          style: const TextStyle(color: AppColors.text),
                          dropdownColor: AppColors.cardColorOverlay,
                          decoration: const InputDecoration(
                              labelText: "Sportliche Aktivitäten",
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
                            "keine"
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
                ]),
              ),
            )),
        backgroundColor: AppColors.background);
  }
}
