import "package:flutter/material.dart";
import "package:confit/themes/colors.dart";

class TextInput extends StatefulWidget {
  const TextInput({Key? key, required String caption, required String hint})
      : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final TextEditingController input = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: input,
        obscureText: true,
        decoration: const InputDecoration(
          border: const OutlineInputBorder(),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: AppColors.text)),
          labelStyle: TextStyle(color: AppColors.text),
          //labelText: widget.caption,
          hintStyle: TextStyle(color: AppColors.text),
          //hintText: hint),
        ));
  }
}
