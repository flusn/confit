import "package:flutter/material.dart";
import "package:confit/themes/colors.dart";

InputDecoration inputfieldDecoration(
    String inputLabelText, String inputHintText) {
  return InputDecoration(
      labelStyle: const TextStyle(color: AppColors.text),
      labelText: inputLabelText,
      hintStyle: const TextStyle(color: AppColors.text),
      hintText: inputHintText);
}
