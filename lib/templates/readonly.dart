import "package:flutter/material.dart";

import '../themes/themes.dart';

class ReadonlyTextField extends StatelessWidget {
  const ReadonlyTextField({Key? key, required this.title, required this.value})
      : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(AppPaddings.paddingInputFieldsStandard),
        child: Container(
          padding: const EdgeInsets.all(AppPaddings.paddingInputFieldsStandard),
          decoration: BoxDecoration(
              color: AppColors.readonly,
              border: Border.all(color: AppColors.text),
              borderRadius: BorderRadius.circular(AppBorders.radius)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(color: AppColors.text),
              ),
              Text(
                value,
                style: const TextStyle(color: AppColors.text),
              ),
            ],
          ),
        ));
  }
}
