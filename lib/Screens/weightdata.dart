import 'package:confit/models/user.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_controller.dart';
import '../templates/input.dart';
import '../templates/menu.drawer.dart';
import '../themes/themes.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

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

  @override
  void initState() {
    if (c.user.value.weightChanges != null) {
      weights = c.user.value.weightChanges!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Gewichtsänderungen"),
          ),
          drawer: const MenuDrawer(),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                            decoration: inputfieldDecoration(
                                "Gewicht", "Gewicht in kg"),
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
                                  weights
                                      .lastWhere(
                                          (element) => element.bmi == null)
                                      .calculateBMI(c.user.value.height!);
                                });

                                c.user.value.weightChanges = weights;
                                c.users[c.currentUserId.value.toString()] =
                                    c.user.value;
                                GetStorage("users").write("users", c.users);
                              }
                            }
                          },
                        ),
                        const SizedBox(
                            height: AppPaddings.paddingInputFieldsStandard)
                      ],
                    ),
                  ),
                  if (weights.isNotEmpty)
                    SingleChildScrollView(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: weights.length,
                        itemBuilder: (BuildContext context, int index) {
                          final weightData = weights.elementAt(index);
                          return Dismissible(
                            background: Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Container(
                                  alignment: AlignmentDirectional.centerEnd,
                                  color: Colors.red,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.delete,
                                        color: AppColors.text),
                                  )),
                            ),
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              setState(() {
                                weights.removeAt(index);
                              });

                              // Then show a snackbar.
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Eintrag vom ${weightData.time!.day}.${weightData.time!.month}.${weightData.time!.year} gelöscht')));
                            },
                            child: Card(
                              borderOnForeground: false,
                              color: AppColors.cardColor,
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
                                          style:
                                              TextStyle(color: AppColors.text),
                                        ),
                                        Text(
                                          "${weightData.time!.day}.${weightData.time!.month}.${weightData.time!.year}",
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
                                          style:
                                              TextStyle(color: AppColors.text),
                                        ),
                                        Text(
                                          weightData.weight.toString(),
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
                                          style:
                                              TextStyle(color: AppColors.text),
                                        ),
                                        Text(
                                          weightData.bmi.toString(),
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
                  if (weights.isNotEmpty)
                    Card(
                      borderOnForeground: false,
                      color: AppColors.cardColor,
                      child: SfCartesianChart(
                        borderColor: AppColors.text,
                        primaryXAxis: DateTimeCategoryAxis(
                          axisLine: const AxisLine(
                              color: Colors.deepOrange,
                              width: 5,
                              dashArray: <double>[5, 5]),
                          labelStyle: const TextStyle(color: AppColors.text),
                        ),
                        primaryYAxis: NumericAxis(
                          labelStyle: const TextStyle(color: AppColors.text),
                        ),

                        //maximum: DateTime.now(),
                        // rangePadding: ChartRangePadding.round,

                        //intervalType: DateTimeIntervalType.days,
                        //),
                        series: <ChartSeries>[
                          LineSeries<WeightChange, DateTime>(
                            color: AppColors.background,
                            dataSource: weights,
                            xValueMapper: (WeightChange weightdata, _) =>
                                weightdata.time,
                            //'${weightdata.time!.day}.${weightdata.time!.month}.${weightdata.time!.year}',
                            yValueMapper: (WeightChange weightdata, _) =>
                                weightdata.bmi,
                            xAxisName: "Monat",
                            yAxisName: "BMI",
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
          )),
    );
  }
}
