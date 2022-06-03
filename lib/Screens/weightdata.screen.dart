import 'package:confit/models/user.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

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
  final userstorage = GetStorage();
  Controller c = Get.find();

  final weightController = TextEditingController();
  final weightChangeController = TextEditingController();
  final weightFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  List<WeightChange> weights = [];
  List<WeightChange> weightsDisplay = [];

  setSublistDisplay() {
    weightsDisplay = weights.sublist(1, 2);
  }

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
                          child: WeightInputField(
                              weightController: weightController,
                              weightFocusNode: weightFocusNode),
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

                                  weightsDisplay = setSublistDisplay();
                                });

                                c.user.value.weightChanges = weights;
                                final userAsNormalMap = c.user.value.toJson();
                                userstorage.write(
                                    c.currentUserId.value.toString(),
                                    userAsNormalMap);
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
                      child: Card(
                        borderOnForeground: false,
                        color: AppColors.cardColor,
                        child: Column(
                          children: [
                            listViewWeights(2),
                            const Divider(color: AppColors.text),
                            if (weights.length > 2)
                              TextButton(
                                child: const Text('Mehr anzeigen',
                                    style: TextStyle(color: AppColors.text)),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(14.0),
                                      ),
                                    ),
                                    //isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.cardColorOverlay,
                                          border: Border.all(
                                              color: AppColors.background),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(14),
                                            topRight: Radius.circular(14),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Text(
                                                  'Gewichtsveränderungen',
                                                  style: TextStyle(
                                                      color: AppColors.text,
                                                      fontSize: 20)),
                                            ),
                                            listViewWeights(weights.length)
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  if (weights.length > 1)
                    Card(
                      borderOnForeground: false,
                      color: AppColors.cardColor,
                      child: SfCartesianChart(
                        title: ChartTitle(
                            text: "BMI",
                            textStyle: TextStyle(color: AppColors.text)),
                        primaryXAxis: CategoryAxis(
                          labelStyle: const TextStyle(color: AppColors.text),
                        ),
                        primaryYAxis: NumericAxis(
                          labelStyle: const TextStyle(color: AppColors.text),
                        ),
                        series: <ChartSeries>[
                          LineSeries<WeightChange, String>(
                            color: AppColors.chartline,
                            dataSource: weights,
                            xValueMapper: (WeightChange weightdata, _) =>
                                DateFormat('dd/MM/yyyy')
                                    .format(weightdata.time!),
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

  ListView listViewWeights(int itemCount) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: itemCount == 2 ? AppColors.text : AppColors.background,
      ),
      //physics: const NeverScrollableScrollPhysics(),
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        final weightData = weights.elementAt(index);
        return Dismissible(
          background: Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    color: Colors.blue.withOpacity(0.5),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.edit, color: AppColors.text),
                    )),
                Container(
                    color: Colors.red.withOpacity(0.5),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.delete, color: AppColors.text),
                    )),
              ],
            ),
          ),
          key: UniqueKey(),
          onDismissed: (direction) {
            bool canceled = false;
            String formattedtimestamp =
                DateFormat('dd-MM-yyyy').format(weightData.time!);
            setState(() {
              if (direction == DismissDirection.startToEnd) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          backgroundColor: AppColors.cardColorOverlay,
                          title: const Text('Gewicht anpassen',
                              style: TextStyle(color: AppColors.text)),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                WeightInputField(
                                    weightController: weightChangeController)
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: const Text('Abbrechen',
                                      style: TextStyle(
                                          color: AppColors.background)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    canceled = true;
                                  },
                                ),
                                TextButton(
                                  child: const Text('Speichern',
                                      style: TextStyle(
                                          color: AppColors.background)),
                                  onPressed: () {
                                    weights.elementAt(index).weight =
                                        double.parse(
                                            weightChangeController.text);
                                    Navigator.of(context).pop();
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Eintrag vom $formattedtimestamp wurde angepasst')));
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ));
              } else if (direction == DismissDirection.endToStart) {
                weights.removeAt(index);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Eintrag vom $formattedtimestamp wurde gelöscht')));
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Datum",
                      style: TextStyle(color: AppColors.text),
                    ),
                    Text(
                      "${weightData.time!.day}.${weightData.time!.month}.${weightData.time!.year}",
                      style: const TextStyle(color: AppColors.text),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Gewicht",
                      style: TextStyle(color: AppColors.text),
                    ),
                    Text(
                      weightData.weight.toString(),
                      style: const TextStyle(color: AppColors.text),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "BMI",
                      style: TextStyle(color: AppColors.text),
                    ),
                    Text(
                      weightData.bmi.toString(),
                      style: const TextStyle(color: AppColors.text),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class WeightInputField extends StatelessWidget {
  const WeightInputField({
    Key? key,
    required this.weightController,
    this.weightFocusNode,
  }) : super(key: key);

  final TextEditingController weightController;
  final FocusNode? weightFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: weightController,
      focusNode: weightFocusNode,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: AppColors.text),
      decoration: inputfieldDecoration("Gewicht", "Gewicht in kg"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Gewicht fehlt";
        } else {
          return null;
        }
      },
    );
  }
}