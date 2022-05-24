//import 'dart:convert';
//import 'package:path_provider/path_provider.dart';
//import 'dart:io';
//import '../models/allUsers.dart';
//import 'package:flutter/services.dart';
//import '../models/storageManagement.dart';
import "package:flutter/material.dart";
import '../models/spHelper.dart';

import '../models/user.dart';
import "../themes/themes.dart";
import "../templates/input.dart";

import 'user.screen.dart';

class BasedataScreen extends StatefulWidget {
  //final Storage storage;
  final int? userId;

  const BasedataScreen({Key? key, /*required this.storage, */ this.userId})
      : super(key: key);

  @override
  State<BasedataScreen> createState() => _BasedataScreenState();
}

enum GenderCharacter { m, w, d, n }

class _BasedataScreenState extends State<BasedataScreen> {
  Map<String, User> users = {};
  late User currentUser = helper.getUser(widget.userId.toString());
  final SPHelper helper = SPHelper();

  /*
  File? jsonFile;
  Directory? dir;
  String filename = "myJsonFile.json";
  bool fileExists = false;
  Map<String, dynamic>? fileContent;
  late Future<Directory?> dirExtern;
  String state = "";
  final File file = File("assets/jsonData/allUsers.json");
  final controller = TextEditingController();
  @override
  void initState() {
    super.initState();

    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir!.path + "/" + filename);

      fileExists = jsonFile!.existsSync();
      if (fileExists) {
        this.setState(
            () => fileContent = json.decode(jsonFile!.readAsStringSync()));
      }
    });
  }
  void createFile(
      Map<String, dynamic> content, Directory dir, String filename) {
    print("Creating a File!");
    File file = new File(dir.path + "/" + filename);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(User user) {
    print("Write to File");
    Map<String, dynamic> content = user.toJson();
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile!.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile!.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does Not exists");
      createFile(content, dir!, filename);
    }
    this.setState(
        () => fileContent = json.decode(jsonFile!.readAsStringSync()));
  }
  Future<File> writeData() async {
    setState(() {
      state = nameController.text;
      nameController.text = "";
    });
    return widget.storage.writeData(state);
  }
  
    Future<void> readJson() async {
    String users = await file.readAsString();
    var jsonResponse = jsonDecode(users);
  }*/

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
  final heightFocusNode = FocusNode();
  final fintnesslevelFocusNode = FocusNode();

  String fitnesslevel = "gar nicht";

  @override
  Future saveUser(User user) async {
    helper.writeUser(user).then((_) {
      setState(() {
        users[widget.userId.toString()] = currentUser;
      });
    });
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
                        leading: Radio<GenderCharacter>(
                          activeColor: AppColors.text,
                          value: GenderCharacter.m,
                          groupValue: genderController,
                          onChanged: (GenderCharacter? value) {
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
                        leading: Radio<GenderCharacter>(
                          activeColor: AppColors.text,
                          value: GenderCharacter.w,
                          groupValue: genderController,
                          onChanged: (GenderCharacter? value) {
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
                              style: const TextStyle(color: AppColors.text),
                              decoration: inputfieldDecoration(
                                  "Gewicht", "Gewicht in kg"),
                              onChanged: (value) {
                                if (double.parse(weightController.text) > 40) {
                                  FocusScope.of(context)
                                      .requestFocus(heightFocusNode);
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
                        ),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(
                                    AppPaddings.paddingInputFieldsStandard),
                                child: TextFormField(
                                    controller: heightController,
                                    focusNode: heightFocusNode,
                                    keyboardType: TextInputType.number,
                                    style:
                                        const TextStyle(color: AppColors.text),
                                    decoration: inputfieldDecoration(
                                        "Größe", "Größe in cm"),
                                    onChanged: (value) {
                                      if (double.parse(heightController.text) >
                                          100) {
                                        FocusScope.of(context).requestFocus(
                                            fintnesslevelFocusNode);
                                      }
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Größe fehlt";
                                      } else {
                                        return null;
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
                  onPressed: () {
                    if (_formKey.currentState != null) {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          currentUser = User(
                              id: widget.userId,
                              name: nameController.text,
                              birthday: DateTime(
                                  int.parse(yearController.text),
                                  int.parse(monthController.text),
                                  int.parse(dayController.text)),
                              height: double.parse(heightController.text),
                              weight: double.parse(weightController.text));
                        });
                        saveUser(currentUser);

                        //readJson();
                        //writeData();
                        //Map<String, dynamic> jsonliste = _userData.toJson();
                        //file.writeAsStringSync(json.encode(jsonliste));

                        //writeToFile(_userData);

                        //widget.storage.writeFilesToCustomDevicePath();

                        //file.writeAsStringSync(json.encode(users));

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserData(),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
