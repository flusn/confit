/*
import 'package:confit/models/user.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/userController.dart';
import '../templates/input.dart';
import '../templates/readonly.dart';
import '../themes/themes.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class _WeightChartValues {
  final String date;
  final double bmi;

  _WeightChartValues({required this.date, required this.bmi});
}

class WeightdataScreen extends StatefulWidget {
  const WeightdataScreen({Key? key}) : super(key: key);

  @override
  State<WeightdataScreen> createState() => _WeightdataScreenState();
}

class _WeightdataScreenState extends State<WeightdataScreen> {
  final usersStorage = GetStorage("users");
  Controller c = Get.find();

  final weightController = TextEditingController();
  final weightFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  List<WeightChange> weights = [];

  List<_WeightChartValues> chartValues = [];
  getChartValues(weights) {
    for (var weightdata in weights) {
      String dateAsString =
          "${weightdata.time!.day}.${weightdata.time!.month}.${weightdata.time!.year}";
      chartValues
          .add(_WeightChartValues(date: dateAsString, bmi: weightdata.bmi));
    }
  }

  @override
  void initState() {
    if (c.user.value.weightChanges != null) {
      weights = c.user.value.weightChanges!;
      // chartValues = getChartValues(weights);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Card(
                borderOnForeground: false,
                color: AppColors.cardColor,
                child: Column(
                  children: [
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Gewicht fehlt";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
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
                              weights.add(WeightChange(
                                time: DateTime.now(),
                                weight: double.parse(weightController.text),
                              ));
                              weights[weights.length - 1]
                                  .calculateBMI(c.user.value.height!);
                              //  chartValues = getChartValues(weights);
                            });
                            c.user.value.weightChanges = weights;
                            c.users[c.currentUser.value.toString()] =
                                c.user.value;
                            GetStorage("users").write("users", c.users);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              if (weights.isNotEmpty)
                SingleChildScrollView(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: weights.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        borderOnForeground: false,
                        color: AppColors.cardColor,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Datum",
                                      style: TextStyle(color: AppColors.text),
                                    ),
                                    Text(
                                      "${weights[index].time!.day}.${weights[index].time!.month}.${weights[index].time!.year}",
                                      style: const TextStyle(
                                          color: AppColors.text),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Gewicht",
                                      style: TextStyle(color: AppColors.text),
                                    ),
                                    Text(
                                      weights[index].weight.toString(),
                                      style: const TextStyle(
                                          color: AppColors.text),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "BMI",
                                      style: TextStyle(color: AppColors.text),
                                    ),
                                    Text(
                                      weights[index].bmi.toString(),
                                      style: const TextStyle(
                                          color: AppColors.text),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              /* SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Half yearly sales analysis'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_WeightChartValues, String>>[
                  LineSeries<_WeightChartValues, String>(
                    dataSource: chartValues,
                    xValueMapper: (_WeightChartValues weightData, _) =>
                        weightData.date,
                    yValueMapper: (_WeightChartValues weightData, _) =>
                        weightData.bmi,
                    name: 'BMI-Veränderungen',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  )
                ],
              )*/
            ],
          ),
        ),
      ),
    ));
  }
}
*/